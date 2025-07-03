<?php

namespace App\Http\Controllers\BahanKemasan;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\BahanKemasan;
use App\Models\BahanKemasanLog;
use App\Models\BahanKemasanStock;
use App\Models\BahanKemasanStockUsage;
use Carbon\Carbon;
use DB;

class BahanKemasanController extends Controller
{
        public function index() 
    {
        $data = BahanKemasan::all();
        return response()->json($data);
    }

    public function store(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga' => 'required|string',
        ]);
        $validate['category'] = ($request->category);

        $new = BahanKemasan::create($validate);

        return response()->json(['success' => true, 'datas'=>$new],200);
    }

    public function update(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga' => 'required|string',
        ]);
        $validate['category'] = ($request->category);
        // dd($request->id);
        BahanKemasan::whereId($request->id)->update($validate);
        $dataUpdate = BahanKemasan::whereId($request->id)->first();

        // dd($dataUpdate);

        return response()->json(['success' => true, 'datas'=>$dataUpdate],200);

    }

    public function delete($id)
    {
       // Temukan kategori berdasarkan ID
        $BahanKemasan = BahanKemasan::find($id);

        // Hapus kategori dari database
        $BahanKemasan->delete();

        // Return response
        return response()->json(['message' => 'data deleted successfully'], 200);
    }

    public function listLogs(Request $request)
    {
        $datas = BahanKemasanLog::with(['BahanKemasan','Vendor'])
            ->orderBy('created_at', 'ASC')
            ->orderBy('kemasan_id', 'ASC')
            ->get();

        return response()->json($datas);
    }

    private function createBahanKemasanLog(array $validate): BahanKemasanLog
    {
        if ($validate['category'] === 'Restock') {
            $validate['inDate'] = now();
            $new = BahanKemasanLog::create($validate);

            BahanKemasanStock::create([
                'kemasan_id' => $validate['kemasan_id'],
                'logs_id' => $new->id,
                'restock_log_id' => $new->id,
                'qty' => $validate['jumlah'],
            ]);
        } else {
            $validate['outDate'] = now();
            $jumlahDigunakan = $validate['jumlah'];

            $stokTersedia = BahanKemasanStock::where('kemasan_id', $validate['kemasan_id'])
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
                        'kemasan_id' => $validate['kemasan_id'],
                        'restock_log_id' => $stok->restock_log_id,
                        'qty' => $jumlahDigunakan,
                    ];
                    $jumlahDigunakan = 0;
                } else {
                    $stok->update(['qty' => 0]);
                    $logUsage[] = [
                        'kemasan_id' => $validate['kemasan_id'],
                        'restock_log_id' => $stok->restock_log_id,
                        'qty' => $tersedia,
                    ];
                    $jumlahDigunakan -= $tersedia;
                }
            }

            $new = BahanKemasanLog::create($validate);

            foreach ($logUsage as $item) {
                BahanKemasanStockUsage::create([
                    'kemasan_id' => $item['kemasan_id'],
                    'restock_log_id' => $item['restock_log_id'],
                    'used_log_id' => $new->id,
                    'qty' => $item['qty'],
                ]);
            }
        }

        return $new;
    }

    public function addLog(Request $request)
    {
        $validate = $request->validate([
            'kemasan_id' => 'required|string',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga' => 'required',
            'category' => 'required|string',
            'vendor_id' => 'required|string',

        ]);
        $dateNow = Carbon::now()->format('Y-m-d');
        if($request->category == 'Restock'){
            $validate['inDate'] = $dateNow;
        }else{
            $validate['outDate'] = $dateNow;
        }
        // dd($validate);

        $new = $this->createBahanKemasanLog($validate);
        $data = BahanKemasanLog::with(['BahanKemasan','Vendor'])->whereId($new->id)->first();

        return response()->json(['success' => true, 'datas'=>$data],200);
    }

    public function updateLog(Request $request)
    {
        $validate = $request->validate([
            'kemasan_id' => 'required',
            'jumlah' => 'required|string',
            'satuan' => 'required|string',
            'harga' => 'required',
            'category' => 'required|string',
            'vendor_id' => 'required',

        ]);

        $log = BahanKemasanLog::findOrFail($request->id);

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
                $stock = BahanKemasanStock::where('restock_log_id', $log->id)->first();
                
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
            $dataUpdate = BahanKemasanLog::with(['BahanKemasan', 'Vendor'])->whereId($log->id)->first();
            }
            
            if ($log->category === 'Used') {
                // Cek apakah restock ini sudah pernah digunakan
                $bahanKemasanUsed = BahanKemasanStockUsage::where('used_log_id', $log->id)->get();
                
                foreach($bahanKemasanUsed as $used){
                    // dd($used->used_log_id);
                    $this->deleteLog($used->used_log_id);
                    
                }
                $newLog = $this->createBahanKemasanLog($request->all()); // RETURN-NYA OBJEK
                $logId = $newLog->id;
                $dataUpdate = BahanKemasanLog::with(['BahanKemasan','Vendor'])->find($logId);

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
            $bahanKemasan = BahanKemasanLog::find($id);

            if (!$bahanKemasan) {
                return response()->json(['message' => 'Log tidak ditemukan'], 404);
            }

            // Cek apakah log tersebut adalah kategori 'Restock'
            if ($bahanKemasan->category == 'Restock') {
                // Ambil data stok terkait restock log ini
                $bahanKemasanStock = BahanKemasanStock::where('logs_id', $id)->first();

                // Cek apakah restock ini sudah pernah digunakan
                $bahanKemasanUsed = BahanKemasanStockUsage::where('restock_log_id', $id)->exists();

                if ($bahanKemasanUsed) {
                    return response()->json(['message' => 'Stock ini sudah digunakan dan tidak bisa dihapus.'], 400);
                }

                // Jika belum digunakan, maka kurangi stok
                if ($bahanKemasanStock) {
                    $stokSaatIni = $bahanKemasanStock->qty;
                    $qtyRestock = $bahanKemasan->jumlah;

                    // Kurangi stok dengan jumlah restock
                    $bahanKemasanStock->qty = $stokSaatIni - $qtyRestock;
                    $bahanKemasanStock->save();

                    // Hapus data stok dan log restock
                    $bahanKemasanStock->delete(); // Jika ingin hapus data stoknya juga
                }
            }else{
                
                // Cek apakah restock ini sudah pernah digunakan
                $bahanKemasanUsed = BahanKemasanStockUsage::where('used_log_id', $id)->get();
                
                foreach($bahanKemasanUsed as $used){
                    $bahanKemasanStock = BahanKemasanStock::where('logs_id', $used->restock_log_id)->first();

                    // Jika belum digunakan, maka kurangi stok
                    if ($bahanKemasanStock) {
                        $stokSaatIni = $bahanKemasanStock->qty;
                        $qtyRestock = $used->qty;

                        // Kurangi stok dengan jumlah restock
                        $bahanKemasanStock->qty = $stokSaatIni + $qtyRestock;
                        $bahanKemasanStock->save();

                        // Hapus data stok dan log restock
                    }
                    $used->delete();
                }
            
            }

            // Hapus log restock
            $bahanKemasan->delete();
            // DB::commit();
            return response()->json(['success' => 'Data berhasil dihapus.']);

        } catch (\Throwable $th) {
            // DB::rollBack();
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    public function getAllStock()
    {
        $data = BahanKemasanLog::with(['BahanKemasan','Vendor'])->get()
            ->groupBy(function ($item) {
                return $item->kemasan_id . '-' . $item->vendor_id;
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
                'kemasan_id' => $group->first()->kemasan_id,
                'bahan_kemasan' => $group->first()->BahanKemasan,
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
        $data = DB::table('cms_bahan_kemasan_stocks as a')
            ->selectRaw('
                MIN(a.id) as id,
                a.restock_log_id,
                d.category,
                d.id as kemasan_id,
                d.harga as price,
                MAX(d.name) as bahan_kemasan,
                MAX(e.name) as vendor_name,
                MAX(b.inDate) as tanggal_masuk,
                MAX(b.satuan) as satuan,
                MIN(b.jumlah) as masuk,
                SUM(IFNULL(c.qty, 0)) as keluar,
                MAX(a.qty) as sisa_stock
            ')
            ->join('cms_bahan_kemasan_logs as b', 'b.id', '=', 'a.restock_log_id')
            ->leftJoin('cms_bahan_kemasan_usages as c', 'a.restock_log_id', '=', 'c.restock_log_id')
            ->join('cms_bahan_kemasans as d', 'b.kemasan_id', '=', 'd.id')
            ->join('cms_vendors as e', 'b.vendor_id', '=', 'e.id')
            ->where('a.qty','>',0)
            ->groupBy('a.restock_log_id','d.category','d.id','d.harga')
            ->orderBy('tanggal_masuk', 'asc')
            ->get();

        return $data;
    }

    public function getNeedRestock(){
        $data = DB::table('cms_bahan_kemasan_stocks as a')
        ->select(
            'a.kemasan_id',
            'b.name as nama_bahan',
            'b.jumlah',
            'b.satuan',
            'b.category',
            'b.harga',
            DB::raw('SUM(a.qty) as total_qty')
        )
        ->leftJoin('cms_bahan_kemasans as b', 'a.kemasan_id', '=', 'b.id')
        ->groupBy('a.kemasan_id', 'b.name', 'b.jumlah', 'b.satuan', 'b.harga')
        ->having('total_qty', '>=', 0)
        ->having('total_qty', '<', DB::raw('b.jumlah'))
        ->get();

        return $data;
    }
}
