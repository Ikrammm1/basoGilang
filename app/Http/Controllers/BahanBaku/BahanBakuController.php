<?php

namespace App\Http\Controllers\BahanBaku;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\BahanBaku;
use App\Models\BahanBakuLog;
use App\Models\BahanBakuStock;
use App\Models\BahanBakuStockUsage;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class BahanBakuController extends Controller
{
    public function index()
    {
        $data = BahanBaku::all();
        return response()->json($data);
    }

    public function store(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga_satuan' => 'required|string',
        ]);

        $new = BahanBaku::create($validate);

        return response()->json(['success' => true, 'datas'=>$new],200);
    }

    public function update(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga_satuan' => 'required|string',
        ]);

        BahanBaku::whereId($request->id)->update($validate);
        $dataUpdate = BahanBaku::whereId($request->id)->first();

        return response()->json(['success' => true, 'datas'=>$dataUpdate],200);

    }

    public function delete($id)
    {
       // Temukan kategori berdasarkan ID
        $bahanBaku = BahanBaku::find($id);

        // Hapus kategori dari database
        $bahanBaku->delete();

        // Return response
        return response()->json(['message' => 'data deleted successfully'], 200);
    }

    public function listLogs(Request $request)
    {
        $datas = BahanBakuLog::with(['BahanBaku','Vendor'])
            ->orderBy('created_at', 'ASC')
            ->orderBy('baku_id', 'ASC')
            ->get();

        return response()->json($datas);
    }
    private function createBahanBakuLog(array $validate): BahanBakuLog
    {
        if ($validate['category'] === 'Restock') {
            $validate['inDate'] = now();
            $new = BahanBakuLog::create($validate);

            BahanBakuStock::create([
                'baku_id' => $validate['baku_id'],
                'logs_id' => $new->id,
                'restock_log_id' => $new->id,
                'qty' => $validate['jumlah'],
            ]);
        } else {
            $validate['outDate'] = now();
            $jumlahDigunakan = $validate['jumlah'];

            $stokTersedia = BahanBakuStock::where('baku_id', $validate['baku_id'])
                ->where('qty', '>', 0)
                ->orderBy('created_at', 'asc')
                ->get();

            $logUsage = [];
            foreach ($stokTersedia as $stok) {
                if ($jumlahDigunakan <= 0) break;

                $tersedia = $stok->qty;

                if ($tersedia >= $jumlahDigunakan) {
                    $stok->update(['qty' => $tersedia - $jumlahDigunakan]);
                    $logUsage[] = [
                        'baku_id' => $validate['baku_id'],
                        'restock_log_id' => $stok->restock_log_id,
                        'qty' => $jumlahDigunakan,
                    ];
                    $jumlahDigunakan = 0;
                } else {
                    $stok->update(['qty' => 0]);
                    $logUsage[] = [
                        'baku_id' => $validate['baku_id'],
                        'restock_log_id' => $stok->restock_log_id,
                        'qty' => $tersedia,
                    ];
                    $jumlahDigunakan -= $tersedia;
                }
            }

            $new = BahanBakuLog::create($validate);

            foreach ($logUsage as $item) {
                BahanBakuStockUsage::create([
                    'baku_id' => $item['baku_id'],
                    'restock_log_id' => $item['restock_log_id'],
                    'used_log_id' => $new->id,
                    'qty' => $item['qty'],
                ]);
            }
        }

        return $new;
    }


    // public function addLog(Request $request)
    // {
    //     $validate = $request->validate([
    //         'baku_id' => 'required|string',
    //         'jumlah' => 'required|string',
    //         'satuan' => 'required|string',
    //         'harga_satuan' => 'required',
    //         'total_harga' => 'required',
    //         'category' => 'required|string',
    //         'vendor_id' => 'required|string',

    //     ]);
    //     $dateNow = Carbon::now()->format('Y-m-d');
    //     if ($request->category == 'Restock') {
    //         $validate['inDate'] = now(); // pakai helper Laravel
    //         $new = BahanBakuLog::create($validate);

    //         BahanBakuStock::create([
    //             'baku_id' => $validate['baku_id'],
    //             'logs_id' => $new->id,
    //             'restock_log_id' => $new->id,
    //             'qty' => $validate['jumlah'], // stok penuh dari restock
    //         ]);

    //     } else {
    //         $validate['outDate'] = now();
    //         $jumlahDigunakan = $validate['jumlah'];

    //         // Ambil stok yang masih tersedia (FIFO)
    //         $stokTersedia = BahanBakuStock::where('baku_id', $validate['baku_id'])
    //             ->where('qty', '>', 0)
    //             ->orderBy('created_at', 'asc')
    //             ->get();

    //         $logUsage = []; // untuk mencatat detail penggunaan
    //         foreach ($stokTersedia as $stok) {
    //             if ($jumlahDigunakan <= 0) break;

    //             $tersedia = $stok->qty;

    //             if ($tersedia >= $jumlahDigunakan) {
    //                 $stok->update(['qty' => $tersedia - $jumlahDigunakan]);

    //                 $logUsage[] = [
    //                     'baku_id' => $validate['baku_id'],
    //                     'restock_log_id' => $stok->restock_log_id,
    //                     'qty' => $jumlahDigunakan,
    //                 ];

    //                 $jumlahDigunakan = 0;
    //             } else {
    //                 $stok->update(['qty' => 0]);

    //                 $logUsage[] = [
    //                     'baku_id' => $validate['baku_id'],
    //                     'restock_log_id' => $stok->restock_log_id,
    //                     'qty' => $tersedia,
    //                 ];

    //                 $jumlahDigunakan -= $tersedia;
    //             }
    //         }

    //         // Simpan log penggunaan (utama)
    //         $new = BahanBakuLog::create($validate);

    //         // Simpan pemetaan penggunaan ke restock (detail)
    //         foreach ($logUsage as $item) {
    //             BahanBakuStockUsage::create([
    //                 'baku_id' => $item['baku_id'],
    //                 'restock_log_id' => $item['restock_log_id'],
    //                 'used_log_id' => $new->id,
    //                 'qty' => $item['qty'],
    //             ]);
    //         }
    //     }

    //     // dd($validate);
    //     // $new = BahanBakuLog::create($validate);
        

    //     $data = BahanBakuLog::with(['BahanBaku','Vendor'])->whereId($new->id)->first();

    //     return response()->json(['success' => true, 'datas'=>$data],200);
    // }

    public function addLog(Request $request)
    {
        $validate = $request->validate([
            'baku_id' => 'required|string',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga_satuan' => 'required',
            'total_harga' => 'required',
            'category' => 'required|string',
            'vendor_id' => 'required|string',
        ]);

        $new = $this->createBahanBakuLog($validate);
        $data = BahanBakuLog::with(['BahanBaku','Vendor'])->find($new->id);

        return response()->json(['success' => true, 'datas' => $data], 200);
    }


   public function updateLog(Request $request)
{
    $validate = $request->validate([
        'baku_id' => 'required',
        'jumlah' => 'required|numeric',
        'satuan' => 'required|string',
        'harga_satuan' => 'required|numeric',
        'total_harga' => 'required|numeric',
        'category' => 'required|string|in:Restock,Used',
        'vendor_id' => 'required',
    ]);

    $log = BahanBakuLog::findOrFail($request->id);

    if (!in_array($log->category, ['Restock', 'Used'])) {
        return response()->json([
            'success' => false,
            'message' => 'Hanya log dengan kategori Restock atau Used yang bisa di-update.'
        ], 400);
    }

    // DB::beginTransaction();
    try {
        $jumlahLama = $log->jumlah;
        $jumlahBaru = $validate['jumlah'];
        $selisih = $jumlahBaru - $jumlahLama;
        if ($log->category === 'Restock') {
            $stock = BahanBakuStock::where('restock_log_id', $log->id)->first();
            
            if (!$stock) {
                return response()->json(['success' => false, 'message' => 'Stock tidak ditemukan.'], 404);
            }
            
            $qtySekarang = $stock->qty;
            $sudahDipakai = $jumlahLama - $qtySekarang;
            
            if ($jumlahBaru < $sudahDipakai) {
                return response()->json([
                    'success' => false,
                    'message' => "Jumlah baru tidak boleh lebih kecil dari jumlah yang sudah dipakai ($sudahDipakai)."
                ], 422);
            }
            
            $stock->qty = $qtySekarang + $selisih;
            $stock->save();
         $log->update($validate);
         $dataUpdate = BahanBakuLog::with(['BahanBaku', 'Vendor'])->whereId($log->id)->first();
        }
        
        if ($log->category === 'Used') {
            // Cek apakah restock ini sudah pernah digunakan
            $bahanBakuUsed = BahanBakuStockUsage::where('used_log_id', $log->id)->get();
            
            foreach($bahanBakuUsed as $used){
                // dd($used->used_log_id);
                $this->deleteLog($used->used_log_id);
                
            }
            $newLog = $this->createBahanBakuLog($request->all()); // RETURN-NYA OBJEK
            $logId = $newLog->id;
            $dataUpdate = BahanBakuLog::with(['BahanBaku','Vendor'])->find($logId);

        }
        
        return response()->json(['success' => true, 'datas' => $dataUpdate], 200);

    } catch (\Exception $e) {
        // DB::rollBack();
        return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
    }
}




    public function deleteLog($id)
    {
        // DB::beginTransaction();
        try {
            // Temukan log restock berdasarkan ID
            $bahanBaku = BahanBakuLog::find($id);

            if (!$bahanBaku) {
                return response()->json(['message' => 'Log tidak ditemukan'], 404);
            }

            // Cek apakah log tersebut adalah kategori 'Restock'
            if ($bahanBaku->category == 'Restock') {
                // Ambil data stok terkait restock log ini
                $bahanBakuStock = BahanBakuStock::where('logs_id', $id)->first();

                // Cek apakah restock ini sudah pernah digunakan
                $bahanBakuUsed = BahanBakuStockUsage::where('restock_log_id', $id)->exists();

                if ($bahanBakuUsed) {
                    return response()->json(['message' => 'Stock ini sudah digunakan dan tidak bisa dihapus.'], 400);
                }

                // Jika belum digunakan, maka kurangi stok
                if ($bahanBakuStock) {
                    $stokSaatIni = $bahanBakuStock->qty;
                    $qtyRestock = $bahanBaku->jumlah;

                    // Kurangi stok dengan jumlah restock
                    $bahanBakuStock->qty = $stokSaatIni - $qtyRestock;
                    $bahanBakuStock->save();

                    // Hapus data stok dan log restock
                    $bahanBakuStock->delete(); // Jika ingin hapus data stoknya juga
                }
            }else{
                
                // Cek apakah restock ini sudah pernah digunakan
                $bahanBakuUsed = BahanBakuStockUsage::where('used_log_id', $id)->get();
                
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
            
            }

            // Hapus log restock
            $bahanBaku->delete();
            // DB::commit();
            return response()->json(['success' => 'Data berhasil dihapus.']);

        } catch (\Throwable $th) {
            // DB::rollBack();
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
       

    }


    public function getAllStock()
    {

        $data = BahanBakuLog::with(['BahanBaku','Vendor'])->get()
            ->groupBy(function ($item) {
                return $item->baku_id . '-' . $item->vendor_id;
            });
        // return($data);
        $result = [];
    
        foreach ($data as $group) {
            $stock = 0;
            $used = 0;
    
            foreach ($group as $item) {
                if ($item->category == 'Restock') {
                    $stock += $item->jumlah;
                } elseif ($item->category == 'Used') {
                    $used += $item->jumlah;
                }
            }
    
            $result[] = [
                'id' => $group->first()->id,
                'baku_id' => $group->first()->baku_id,
                'bahan_baku' => $group->first()->BahanBaku,
                'vendor_id' => $group->first()->vendor_id,
                'vendor' => $group->first()->vendor,
                'satuan' => $group->first()->satuan,
                'used' => $used,
                'restock' => $stock,
                'total_stock' => $stock - $used,
            ];
        }
    
        return $result;
    }

    public function getStock()
    {
        $data = DB::table('cms_bahan_baku_stocks as a')
            ->selectRaw('
                MIN(a.id) as id,
                a.restock_log_id,
                MAX(d.name) as bahan_baku,
                MAX(e.name) as vendor_name,
                MAX(b.inDate) as tanggal_masuk,
                MAX(b.satuan) as satuan,
                MIN(b.jumlah) as masuk,
                SUM(IFNULL(c.qty, 0)) as keluar,
                MAX(a.qty) as sisa_stock
            ')
            ->join('cms_bahan_baku_logs as b', 'b.id', '=', 'a.restock_log_id')
            ->leftJoin('cms_bahan_baku_usages as c', 'a.restock_log_id', '=', 'c.restock_log_id')
            ->join('cms_bahan_baku as d', 'b.baku_id', '=', 'd.id')
            ->join('cms_vendors as e', 'b.vendor_id', '=', 'e.id')
            ->where('a.qty', '>', 0)
            ->groupBy('a.restock_log_id')
            ->orderBy('tanggal_masuk', 'asc')
            ->get();

        return $data;
    }

    public function getNeedRestock(){
        $data = DB::table('cms_bahan_baku_stocks as a')
        ->select(
            'a.baku_id',
            'b.name as nama_bahan',
            'b.jumlah',
            'b.satuan',
            'b.harga_satuan',
            DB::raw('SUM(a.qty) as total_qty')
        )
        ->leftJoin('cms_bahan_baku as b', 'a.baku_id', '=', 'b.id')
        ->groupBy('a.baku_id', 'b.name', 'b.jumlah', 'b.satuan', 'b.harga_satuan')
        ->having('total_qty', '>=', 0)
        ->having('total_qty', '<', DB::raw('b.jumlah'))
        ->get();

        return $data;
    }


}
