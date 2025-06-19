<?php

namespace App\Http\Controllers\Produksi;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Stock;
use App\Models\BahanBakuLog;
use App\Models\StockLog;
use App\Models\BahanBakuStock;
use App\Models\BahanBakuStockUsage;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ProduksiController extends Controller
{
    public function index()
    {
        $data = StockLog::where('category', '1')->with([
            'Product' => function ($query) {
            $query->with('Category');
        }, 'BahanBakuLog'
        ])
        ->orderBy('product_id')
        ->get();

        return $data;
    }

    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|string',
            'qty' => 'required',
            'satuanProduk' => 'required|string',
            'totalHarga' => 'required',
        ]);

        DB::beginTransaction();
        try {
            $new = StockLog::create([
            'product_id' => $request->product_id,
            'qty' => $request->qty,
            'satuan' => $request->satuanProduk,
            'total_harga' => $request->totalHarga,
            'category' => 1,
        ]);

        Stock::create([
            'product_id'=>$request->product_id,
            'qty'=>$request->qty,
            'log_id'=>$new->id,
        ]);

        $bakuIds = explode(',',$request->baku_ids);    
        $vendorIds = explode(',',$request->vendor_ids);    
        $jumlahs = explode(',',$request->jumlahs);    
        $satuans = explode(',',$request->satuans);    
        if(intval($request->bahanBaku) != 0){
            for ($i = 0; $i < count($bakuIds); $i++) {
                $stokTersedia = BahanBakuStock::where('baku_id', $bakuIds[$i])
                    ->where('qty', '>', 0)
                    ->orderBy('created_at', 'asc')
                    ->get();

                $logUsage = [];
                $jumlahDigunakan = $jumlahs[$i];

                foreach ($stokTersedia as $stok) {
                    if ($jumlahDigunakan <= 0) break;

                    $tersedia = $stok->qty;

                    if ($tersedia >= $jumlahDigunakan) {
                        $stok->update(['qty' => $tersedia - $jumlahDigunakan]);
                        $logUsage[] = [
                            'baku_id' => $bakuIds[$i],
                            'restock_log_id' => $stok->restock_log_id,
                            'qty' => $jumlahDigunakan,
                        ];
                        $jumlahDigunakan = 0;
                    } else {
                        $stok->update(['qty' => 0]);
                        $logUsage[] = [
                            'baku_id' => $bakuIds[$i],
                            'restock_log_id' => $stok->restock_log_id,
                            'qty' => $tersedia,
                        ];
                        $jumlahDigunakan -= $tersedia;
                    }
                }

                $newLog = BahanBakuLog::create([
                    'baku_id'      => $bakuIds[$i],
                    'vendor_id'    => $vendorIds[$i],
                    'jumlah'       => $jumlahs[$i],
                    'satuan'       => $satuans[$i],
                    'outDate'      => Carbon::now()->format('Y-m-d'),
                    'harga_satuan' => 0,
                    'total_harga'  => 0,
                    'category'     => 'Used',
                    'produksi_id'  => $new->id,
                ]);

                foreach ($logUsage as $item) {
                    BahanBakuStockUsage::create([
                        'baku_id' => $item['baku_id'],
                        'restock_log_id' => $item['restock_log_id'],
                        'used_log_id' => $newLog->id,
                        'qty' => $item['qty'],
                    ]);
                }
            }
        }

        $data = StockLog::where('category', '1')->with([
            'Product' => function ($query) {
            $query->with('Category');
        }, 'BahanBakuLog'
        ])->whereId($new->id)->first();

        DB::commit();
        return response()->json(['success' => true, 'datas'=>$data],200);
        } catch (\Throwable $th) {
            DB::rollback();
            return response()->json(['success' => false, 'message'=>$th],400);

        }
        
    }


    public function delete($id)
    {
        // Cari data StockLog berdasarkan ID
        $stockLog = StockLog::find($id);

        if (!$stockLog) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        // // Hapus log bahan baku yang terkait dengan produksi ID ini
        // BahanBakuLog::where('produksi_id', $id)->delete();


         // Temukan log restock berdasarkan ID
        $bahanBaku = BahanBakuLog::where('produksi_id', $id)->get();

        if ($bahanBaku->isEmpty()) {
            return response()->json(['message' => 'Log tidak ditemukan'], 404);
        }

        // Cek apakah restock ini sudah pernah digunakan
        
        foreach($bahanBaku as $baku){
            $bahanBakuUsed = BahanBakuStockUsage::where('used_log_id', $baku->id)->get();
            // dd($bahanBakuUsed);
            
            foreach($bahanBakuUsed as $used){
                $bahanBakuStock = BahanBakuStock::where('logs_id', $used->restock_log_id)->first();

                // Jika belum digunakan, maka kurangi stok
                if ($bahanBakuStock) {
                    $stokSaatIni = $bahanBakuStock->qty;
                    $qtyRestock = $used->qty;

                    // Kurangi stok dengan jumlah restock
                    $bahanBakuStock->qty = $stokSaatIni + $qtyRestock;
                    $bahanBakuStock->save();

                    // Hapus data stok dan log restock
                }
                $used->delete();
            }
        
            // Hapus log
            $baku->delete();
        }



        // Kurangi stok produk
        $stock = Stock::where('log_id', $id)->delete();

        // Hapus data StockLog
        $stockLog->delete();

        // Respon sukses
        return response()->json(['message' => 'Data berhasil dihapus'], 200);
    }

    public function update(Request $request){
        $this->delete($request->id);
        return  $this->store($request);
    }
}
