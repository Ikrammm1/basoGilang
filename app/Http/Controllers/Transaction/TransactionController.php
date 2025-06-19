<?php

namespace App\Http\Controllers\Transaction;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Customer;
use App\Models\Transaction;
use App\Models\DetailTransaction;
use App\Models\TransactionPackage;
use App\Models\Stock;
use App\Models\StockLog;
use App\Models\BahanKemasanStock;
use App\Models\BahanKemasanLog;
use App\Models\BahanKemasanStockUsage;
use DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;

class TransactionController extends Controller
{

    public function showNew($param)
    {
        // Cache provinsi
        $provinces = Cache::remember('provinces', now()->addDay(), function () {
            $response = Http::withoutVerifying()->get('https://wilayah.id/api/provinces.json');
            return $response->successful() ? collect($response->json('data')) : collect();
        });

        // Ambil semua transaksi
        $query = Transaction::with([
            'DetailTransaction.Product.Stock',
            'Customer.Ongkir',
            'packages.details.Product',
            'packages.kemasan',
        ])->orderBy('id', 'DESC');

        if ($param !== 'all') {
            $query->where('id', $param);
        }

        $transactions = $query->get();

        $data = $transactions->map(function ($trx) use ($provinces) {
            $customer = $trx->customer;

            $customerData = null;
            if ($customer) {
                $kodeProv = $customer->prov;
                $kodeKab = $customer->kab;
                $kodeKec = $customer->kec;

                // Ambil nama provinsi
                $prov = $provinces->firstWhere('code', $kodeProv);
                $namaProv = $prov['name'] ?? '-';

                // Ambil data kabupaten dari cache per provinsi
                $regencies = Cache::remember("regencies_{$kodeProv}", now()->addDay(), function () use ($kodeProv) {
                    $response = Http::withoutVerifying()->get("https://wilayah.id/api/regencies/{$kodeProv}.json");
                    return $response->successful() ? collect($response->json('data')) : collect();
                });

                // Ambil nama kabupaten
                $kab = $regencies->firstWhere('code', $kodeKab);
                $namaKab = $kab['name'] ?? '-';

                // Ambil nama kecamatan dari cache per kabupaten
                $districts = Cache::remember("districts_{$kodeKab}", now()->addDay(), function () use ($kodeKab) {
                    $response = Http::withoutVerifying()->get("https://wilayah.id/api/districts/{$kodeKab}.json");
                    return $response->successful() ? collect($response->json('data')) : collect();
                });

                $kec = $districts->firstWhere('code', $kodeKec);
                $namaKec = $kec['name'] ?? '-';

                $customerData = [
                    'id' => $customer->id,
                    'name' => $customer->name,
                    'phone' => $customer->phone,
                    'address' => $customer->address,
                    'mark' => $customer->mark,
                    'prov' => $kodeProv,
                    'kab' => $kodeKab,
                    'kec' => $kodeKec,
                    'nama_prov' => $namaProv,
                    'nama_kab' => $namaKab,
                    'nama_kec' => $namaKec,
                    'ongkir' => $customer->Ongkir,
                ];
            }

            return [
                'id' => $trx->id,
                'created_at' => $trx->updated_at? $trx->updated_at : $trx->created_at ,
                'customer_id' => $trx->customer_id,
                'delivery_status' => $trx->delivery_status,
                'delivery_date' => $trx->delivery_date,
                'delivery_time' => $trx->delivery_time,
                'payment_status' => $trx->status,
                'packStatus' => $trx->pack_status,
                'total_order' => $trx->qty,
                'total_price' => $trx->total_price,

                // Customer
                'customer' => $customerData,

                // Detail transaksi (produk terpisah, bukan dari package)
                'transaction_details' => $trx->detailTransaction->map(function ($detail) {
                    return [
                        'product_id' => $detail->product_id,
                        'product_name' => optional($detail->product)->name,
                        'category' => $detail->category,
                        'qty' => $detail->qty,
                        'unit_price' => $detail->unit_price,
                        'total_price' => $detail->total_price,
                        'stock' => optional($detail->product->stock),
                        'satuan' => 'pcs',
                    ];
                }),

                // Packages
                'packages' => $trx->packages->map(function ($pkg) {
                    return [
                        'packaging' => intval($pkg->packaging),
                        // 'packagingName' => $pkg->packaging,
                        'jumlahPack' => $pkg->jumlah_pack,
                        'totalPrice' => $pkg->total_price,
                         // ✅ info kemasan
                        'kemasan' => $pkg->kemasan ? [
                            'id' => $pkg->kemasan->id,
                            'nama' => $pkg->kemasan->name,
                            'satuan' => $pkg->kemasan->satuan ?? null,
                            'harga' => $pkg->kemasan->harga ?? null,
                        ] : null,
                        'products' => $pkg->details->map(function ($d) {
                            return [
                                'category' => $d->category,
                                'product' => intval($d->product_id),
                                'product_id' => $d->product_id,
                                'product_name' => optional($d->product)->name,
                                'product_code' => optional($d->product)->code,
                                'product_image' => optional($d->product)->image,
                                'jumlah' => $d->qty,
                                'satuan' => 'pcs',
                                'unit_price' => $d->unit_price,
                                'total_price' => $d->total_price,
                            ];
                        }),
                    ];
                }),
            ];
        });

        return response()->json($data);
    }
    public function index()
    {
        return $this->showNew('all');
        // Ambil data kabupaten dari API dan simpan ke cache
        // $regencies = Cache::remember('regencies_32', now()->addDay(), function () {
        //     $response = Http::withoutVerifying()->get('https://wilayah.id/api/regencies/32.json');
        //     return $response->successful() ? collect($response->json('data')) : collect();
        // });

        // // Ambil semua transaksi dengan relasi
        // $transactions = Transaction::with([
        //     'DetailTransaction.Product'=>function($query){
        //         $query->with('Stock');
        //     },
        //     // 'DetailTransaction.Packaging',
        //     'Customer.Ongkir',
        // ])
        // ->orderBy('id','DESC')
        // ->get();

        // // Ubah hasil ke array
        // $transactions = $transactions->map(function ($trx) use ($regencies) {
        //     $trxArray = $trx->toArray(); // konversi satu transaksi ke array

        //     $customer = $trx->customer;
        //     if ($customer) {
        //         $kodeKab = $customer->kab;
        //         $kodeKec = $customer->kec;

        //         $kab = $regencies->firstWhere('code', $kodeKab);
        //         $namaKab = $kab['name'] ?? '-';

        //         $districts = Cache::remember("districts_{$kodeKab}", now()->addDay(), function () use ($kodeKab) {
        //             $response = Http::withoutVerifying()->get("https://wilayah.id/api/districts/{$kodeKab}.json");
        //             return $response->successful() ? collect($response->json('data')) : collect();
        //         });

        //         $kec = $districts->firstWhere('code', $kodeKec);
        //         $namaKec = $kec['name'] ?? '-';

        //         // Inject nama kab dan kec ke dalam customer array-nya
        //         $trxArray['customer']['nama_kab'] = $namaKab;
        //         $trxArray['customer']['nama_kec'] = $namaKec;
        //     }

        //     return $trxArray;
        // });
        // return $transactions;
    }
    public function todayList()
    {
        $today = Carbon::today();
        $yesterday = Carbon::yesterday();

        // Semua transaksi (tanpa filter status)
        $todayData = Transaction::selectRaw('SUM(qty) as total_qty, SUM(total_price) as total_price')
            ->whereDate('updated_at', $today)
            ->first();

        $yesterdayData = Transaction::selectRaw('SUM(qty) as total_qty, SUM(total_price) as total_price')
            ->whereDate('updated_at', $yesterday)
            ->first();

        // Transaksi UNPAID
        $todayUnpaid = Transaction::selectRaw('SUM(qty) as total_qty, SUM(total_price) as total_price')
            ->whereDate('updated_at', $today)
            ->where('status', 'unpaid')
            ->first();

        $yesterdayUnpaid = Transaction::selectRaw('SUM(qty) as total_qty, SUM(total_price) as total_price')
            ->whereDate('updated_at', $yesterday)
            ->where('status', 'unpaid')
            ->first();

        // Transaksi PAID
        $todayPaid = Transaction::selectRaw('SUM(qty) as total_qty, SUM(total_price) as total_price')
            ->whereDate('updated_at', $today)
            ->where('status', 'paid')
            ->first();

        $yesterdayPaid = Transaction::selectRaw('SUM(qty) as total_qty, SUM(total_price) as total_price')
            ->whereDate('updated_at', $yesterday)
            ->where('status', 'paid')
            ->first();

        // Fungsi bantu untuk hitung persentase perubahan
        $calculatePercentageChange = function ($todayValue, $yesterdayValue) {
            if ($yesterdayValue == 0) {
                return $todayValue > 0 ? 100 : 0;
            }
            return (($todayValue - $yesterdayValue) / $yesterdayValue) * 100;
        };

        // Hitung semua persen
        return response()->json([
            'success' => true,
            'summary' => [
                // Semua transaksi
                'qty_today' => (int) $todayData->total_qty,
                'qty_yesterday' => (int) $yesterdayData->total_qty,
                'qty_change_percent' => round($calculatePercentageChange($todayData->total_qty ?? 0, $yesterdayData->total_qty ?? 0), 2),

                'price_today' => (int) $todayData->total_price,
                'price_yesterday' => (int) $yesterdayData->total_price,
                'price_change_percent' => round($calculatePercentageChange($todayData->total_price ?? 0, $yesterdayData->total_price ?? 0), 2),

                // Unpaid
                'unpaid_qty_today' => (int) $todayUnpaid->total_qty,
                'unpaid_qty_yesterday' => (int) $yesterdayUnpaid->total_qty,
                'unpaid_qty_change_percent' => round($calculatePercentageChange($todayUnpaid->total_qty ?? 0, $yesterdayUnpaid->total_qty ?? 0), 2),

                'unpaid_price_today' => (int) $todayUnpaid->total_price,
                'unpaid_price_yesterday' => (int) $yesterdayUnpaid->total_price,
                'unpaid_price_change_percent' => round($calculatePercentageChange($todayUnpaid->total_price ?? 0, $yesterdayUnpaid->total_price ?? 0), 2),

                // Paid
                'paid_qty_today' => (int) $todayPaid->total_qty,
                'paid_qty_yesterday' => (int) $yesterdayPaid->total_qty,
                'paid_qty_change_percent' => round($calculatePercentageChange($todayPaid->total_qty ?? 0, $yesterdayPaid->total_qty ?? 0), 2),

                'paid_price_today' => (int) $todayPaid->total_price,
                'paid_price_yesterday' => (int) $yesterdayPaid->total_price,
                'paid_price_change_percent' => round($calculatePercentageChange($todayPaid->total_price ?? 0, $yesterdayPaid->total_price ?? 0), 2),
            ]
        ]);
    }
    public function pendingList()
    {
        // Ambil data kabupaten dari API dan simpan ke cache
        $regencies = Cache::remember('regencies_32', now()->addDay(), function () {
            $response = Http::withoutVerifying()->get('https://wilayah.id/api/regencies/32.json');
            return $response->successful() ? collect($response->json('data')) : collect();
        });

        // Ambil semua transaksi dengan relasi
        $transactions = Transaction::with([
            'DetailTransaction.Product'=>function($query){
                $query->with('Stock');
            },
            // 'DetailTransaction.Packaging',
            'Customer.Ongkir',
        ])
        // ->whereDate('created_at', Carbon::now()->toDateString())
        ->where('delivery_status', 'Pending')
        ->orderBy('id','DESC')
        ->get();

        // Ubah hasil ke array
        $transactions = $transactions->map(function ($trx) use ($regencies) {
            $trxArray = $trx->toArray(); // konversi satu transaksi ke array

            $customer = $trx->customer;
            if ($customer) {
                $kodeKab = $customer->kab;
                $kodeKec = $customer->kec;

                $kab = $regencies->firstWhere('code', $kodeKab);
                $namaKab = $kab['name'] ?? '-';

                $districts = Cache::remember("districts_{$kodeKab}", now()->addDay(), function () use ($kodeKab) {
                    $response = Http::withoutVerifying()->get("https://wilayah.id/api/districts/{$kodeKab}.json");
                    return $response->successful() ? collect($response->json('data')) : collect();
                });

                $kec = $districts->firstWhere('code', $kodeKec);
                $namaKec = $kec['name'] ?? '-';

                // Inject nama kab dan kec ke dalam customer array-nya
                $trxArray['customer']['nama_kab'] = $namaKab;
                $trxArray['customer']['nama_kec'] = $namaKec;
            }

            return $trxArray;
        });
        return $transactions;
    }

    public function show($id)
    {
        // Ambil data kabupaten dari cache atau API
        $regencies = Cache::remember('regencies_32', now()->addDay(), function () {
            $response = Http::withoutVerifying()->get('https://wilayah.id/api/regencies/32.json');
            return $response->successful() ? collect($response->json('data')) : collect();
        });

        // Ambil transaksi berdasarkan ID + relasi lengkap
        $trx = Transaction::with([
            'DetailTransaction.Product' => function ($query) {
                $query->with('Stock');
            },
            'DetailTransaction.Packaging',
            'Customer.Ongkir',
        ])->findOrFail($id);

        // Konversi ke array
        $trxArray = $trx->toArray();

        // Tambah nama kabupaten & kecamatan
        $customer = $trx->customer;
        if ($customer) {
            $kodeKab = $customer->kab;
            $kodeKec = $customer->kec;

            $kab = $regencies->firstWhere('code', $kodeKab);
            $namaKab = $kab['name'] ?? '-';

            $districts = Cache::remember("districts_{$kodeKab}", now()->addDay(), function () use ($kodeKab) {
                $response = Http::withoutVerifying()->get("https://wilayah.id/api/districts/{$kodeKab}.json");
                return $response->successful() ? collect($response->json('data')) : collect();
            });

            $kec = $districts->firstWhere('code', $kodeKec);
            $namaKec = $kec['name'] ?? '-';

            $trxArray['customer']['nama_kab'] = $namaKab;
            $trxArray['customer']['nama_kec'] = $namaKec;
        }

        return $trxArray;
    }




    public function store(Request $request)
    {
        $request->validate([
            'customer_id' => 'string',
            'payment_status' => 'string',
            'delivery_date' => 'sometimes|nullable',
            'delivery_time' => 'sometimes|nullable',
            'delivery_status' => 'string'
        ]);

        $transaction = \App\Services\TransactionService::beginTransaction($request);

        $response = $this->showNew($transaction->id);
        $data = $response->getData(true);

        return response()->json([
            'success' => true,
            'datas' => $data[0] ?? $data
        ]);
    }





    // public function store(Request $request)
    // {
    //     $request->validate([
    //         'customer_id'=>'string',
    //         'payment_status'=>'string',
    //         'delivery_date'=>'sometimes|nullable',
    //         'delivery_time'=>'sometimes|nullable',
    //         'delivery_status'=>'string'
    //     ]);

    //     // Ambil ongkir dari relasi Customer
    //     $customer = Customer::with('Ongkir')->where('id', $request->customer_id)->first();
    //     $ongkir = $customer->Ongkir->price ?? 0;

    //     // Hitung total qty dan total_price dari packages
    //     $qty = 0;
    //     $total_price = 0;

    //     foreach ($request->packages as $package) {
    //         $total_price += $package['totalPrice'];
    //         $sum_jumlah = array_sum(array_column($package['products'], 'jumlah'));
    //         $qty += $package['jumlahPack'] * $sum_jumlah;
    //     }

    //     // Simpan transaksi utama
    //     $transaction = Transaction::create([
    //         'customer_id' => $request->customer_id,
    //         'delivery_date' => $request->delivery_date,
    //         'delivery_time' => $request->delivery_time,
    //         'delivery_status' => $request->delivery_status,
    //         'pack_status' => $request->packStatus,
    //         'status' => $request->payment_status,
    //         'qty' => $qty,
    //         'total_price' => $total_price + intval($ongkir),
    //     ]);

    //     // Simpan tiap paket ke transaction_packages
    //     foreach ($request->packages as $package) {
    //         $transactionPackage = TransactionPackage::create([
    //             'transaction_id' => $transaction->id,
    //             'packaging' => $package['packaging'],
    //             'jumlah_pack' => $package['jumlahPack'],
    //             'total_price' => $package['totalPrice'],
    //         ]);

    //         //create log Kemasan
    //             // $validate['outDate'] = now();
    //             $jumlahDigunakan = $package['jumlahPack'];

    //             $stokTersedia = BahanKemasanStock::where('kemasan_id', $package['packaging'])
    //                 ->where('qty', '>', 0)
    //                 ->orderBy('created_at', 'asc')
    //                 ->get();

    //             $logUsage = [];
    //             foreach ($stokTersedia as $stok) {
    //                 if ($jumlahDigunakan <= 0) break;

    //                 $tersedia = $stok->qty;

    //                 if ($tersedia >= $jumlahDigunakan) {
    //                     $stok->update(['qty' => $tersedia - $jumlahDigunakan]);
    //                     $logUsage[] = [
    //                         'kemasan_id' => $package['packaging'],
    //                         'restock_log_id' => $stok->restock_log_id,
    //                         'qty' => $jumlahDigunakan,
    //                     ];
    //                     $jumlahDigunakan = 0;
    //                 } else {
    //                     $stok->update(['qty' => 0]);
    //                     $logUsage[] = [
    //                         'kemasan_id' => $package['packaging'],
    //                         'restock_log_id' => $stok->restock_log_id,
    //                         'qty' => $tersedia,
    //                     ];
    //                     $jumlahDigunakan -= $tersedia;
    //                 }
    //             }

    //             $getKemasanDataLog =  BahanKemasanLog::whereId($stokTersedia[0]->restock_log_id)->first();
    //             $newLogKemasan = BahanKemasanLog::create([
    //                 'kemasan_id' =>$package['packaging'],
    //                 'outDate' => Carbon::now()->format('Y-m-d'),
    //                 'jumlah' => $package['jumlahPack'],
    //                 'satuan' => $getKemasanDataLog->satuan,
    //                 'vendor_id' => $getKemasanDataLog->vendor_id,
    //                 'category' => 'Used',
    //                 'harga' => 0,
    //             ]);

    //             foreach ($logUsage as $item) {
    //                 BahanKemasanStockUsage::create([
    //                     'kemasan_id' => $item['kemasan_id'],
    //                     'restock_log_id' => $item['restock_log_id'],
    //                     'used_log_id' => $newLogKemasan->id,
    //                     'qty' => $item['qty'],
    //                 ]);
    //             }


    //         // Simpan produk dalam paket ke detail_transactions
    //         foreach ($package['products'] as $product) {
    //             $detailTrans = DetailTransaction::create([
    //                 'trans_id' => $transaction->id,
    //                 'transaction_package_id' => $transactionPackage->id,
    //                 'unit_price' => $product['unit_price'],
    //                 'total_price' => $product['total_price'],
    //                 'qty' => $product['jumlah'],
    //                 'product_id' => $product['product_id'],
    //                 'category' => $product['category'],
    //             ]);

    //             // 🔸 Logika pengurangan stok
    //             $used = $product['jumlah'];
    //             $category = $product['category'];
    //             $productId = $product['product_id'];

    //             // 🚫 Skip jika packStatus = Unpack dan kategori = Fresh
    //             if ($request->packStatus === 'Unpack' && $category === 'Fresh') {
    //                 continue;
    //             }

    //             // Ambil stok berdasarkan kategori
    //             $stocks = Stock::where('product_id', $productId)
    //                 ->where(function ($q) use ($category) {
    //                     if ($category === 'Fresh') {
    //                         $q->where('qty', '>', 0);
    //                     } else {
    //                         $q->where('qty_frozen', '>', 0);
    //                     }
    //                 })
    //                 ->orderBy('id') // FIFO
    //                 ->get();

    //             foreach ($stocks as $stock) {
    //                 if ($used <= 0) break;

    //                 if ($category === 'Fresh') {
    //                     $available = $stock->qty;
    //                     if ($available <= 0) continue;

    //                     $toReduce = min($available, $used);
    //                     $stock->update([
    //                         'qty' => $available - $toReduce,
    //                     ]);

    //                     StockLog::create([
    //                         'product_id' => $productId,
    //                         'qty' => -$toReduce,
    //                         'satuan' => $product['satuan'],
    //                         'total_harga' => 0,
    //                         'category' => 0,
    //                         'trans_id' => $detailTrans->id,
    //                         'stock_id' => $stock->id,
    //                     ]);
    //                 } else {
    //                     $available = $stock->qty_frozen;
    //                     if ($available <= 0) continue;

    //                     $toReduce = min($available, $used);
    //                     $stock->update([
    //                         'qty_frozen' => $available - $toReduce,
    //                     ]);

    //                     StockLog::create([
    //                         'product_id' => $productId,
    //                         'qty' => -$toReduce,
    //                         'satuan' => $product['satuan'],
    //                         'total_harga' => 0,
    //                         'category' => 0,
    //                         'trans_id' => $detailTrans->id,
    //                         'stock_id' => $stock->id,
    //                     ]);
    //                 }

    //                 $used -= $toReduce;
    //             }

    //             // ❗Jika masih ada sisa kebutuhan, artinya stok tidak cukup
    //             if ($used > 0) {
    //                 throw new \Exception("Stok tidak mencukupi untuk produk ID: $productId");
    //             }
                
    //         }
    //     }

    //     $response = $this->showNew($transaction->id);
    //     $data = $response->getData(true); // true = ambil sebagai associative array

    //     // $original = $data['original']; // baru ini aman
    //     return response()->json([
    //         'success' => true,
    //         'datas' => $data[0]
    //     ], 200);

     
        

    // }

    public function delete($id)
{
    DB::beginTransaction();

    try {
        $transaction = Transaction::with([
            'DetailTransaction',
            'packages'
        ])->findOrFail($id);

        // 1. Rollback stok dari produk
        foreach ($transaction->DetailTransaction as $detail) {
            $logs = StockLog::where('trans_id', $detail->id)->get();

            foreach ($logs as $log) {
                $stock = Stock::find($log->stock_id);
                if (!$stock) continue;

                $isFrozen = strtolower($detail->category) === 'frozen';

                if ($isFrozen) {
                    $stock->qty_frozen += abs($log->qty);
                } else {
                    $stock->qty += abs($log->qty);
                }

                $stock->save();

                // Tambah log rollback (optional)
                StockLog::create([
                    'product_id' => $log->product_id,
                    'stock_id' => $stock->id,
                    'qty' => abs($log->qty),
                    'satuan' => $log->satuan,
                    'total_harga' => 0,
                    'category' => 0,
                    'trans_id' => $detail->id
                ]);
            }
        }

        // 2. Rollback Kemasan
        foreach ($transaction->packages as $package) {
            // Cari log pemakaian kemasan (BahanKemasanLog)
            $usedLog = BahanKemasanLog::where([
                'kemasan_id' => $package->packaging,
                'category' => 'Used',
            ])
            ->whereDate('outDate', $transaction->created_at->format('Y-m-d'))
            ->first();

            if ($usedLog) {
                $usages = BahanKemasanStockUsage::where('used_log_id', $usedLog->id)->get();

                foreach ($usages as $usage) {
                    $stock = BahanKemasanStock::where('kemasan_id', $usage->kemasan_id)
                        ->where('restock_log_id', $usage->restock_log_id)
                        ->first();

                    if ($stock) {
                        $stock->qty += $usage->qty;
                        $stock->save();
                    }

                    $usage->delete();
                }

                $usedLog->delete();
            }
        }

        // 3. Hapus data
        DetailTransaction::where('trans_id', $id)->delete();
        TransactionPackage::where('transaction_id', $id)->delete();
        $transaction->delete();

        DB::commit();

        return response()->json([
            'success' => true,
            'message' => 'Transaksi & seluruh relasinya berhasil dihapus, stok produk & kemasan dikembalikan.'
        ], 200);

    } catch (\Exception $e) {
        DB::rollBack();

        return response()->json([
            'success' => false,
            'message' => 'Gagal menghapus transaksi: ' . $e->getMessage()
        ], 500);
    }
}


    public function update(Request $request)
    {
        $this->delete($request->id);
        return  $this->store($request);
    }

    public function weeklySummary()
    {
        $now = Carbon::now();
        $thisMonth = $now->format('Y-m');
        $lastMonth = $now->copy()->subMonth()->format('Y-m');

        $getData = function ($yearMonth) {
            return DB::table('cms_transactions')
                ->selectRaw('WEEK(updated_at, 3) - WEEK(DATE_FORMAT(updated_at, "%Y-%m-01"), 3) + 1 as week_number, SUM(qty) as total_qty')
                ->whereRaw("DATE_FORMAT(updated_at, '%Y-%m') = ?", [$yearMonth])
                ->groupBy('week_number')
                ->orderBy('week_number')
                ->pluck('total_qty', 'week_number')
                ->toArray();
        };

        $currentMonthData = $getData($thisMonth);
        $previousMonthData = $getData($lastMonth);

        $maxWeeks = max(
            count($currentMonthData),
            count($previousMonthData),
            4 // fallback minimal 4 minggu
        );

        $fillWeeks = function ($data, $maxWeeks) {
            $result = [];
            for ($i = 1; $i <= $maxWeeks; $i++) {
                $result[] = $data[$i] ?? 0;
            }
            return $result;
        };

        return response()->json([
            'series' => [
                [
                    'name' => Carbon::parse($thisMonth)->translatedFormat('F'),
                    'data' => $fillWeeks($currentMonthData, $maxWeeks),
                ],
                [
                    'name' => Carbon::parse($lastMonth)->translatedFormat('F'),
                    'data' => $fillWeeks($previousMonthData, $maxWeeks),
                ],
            ],
            'categories' => array_map(fn ($i) => "Week $i", range(1, $maxWeeks)),
        ]);
    }

   public function weeklyIncomeStats()
{
    $now = \Carbon\Carbon::now();
    $startOfMonth = $now->copy()->startOfMonth();
    $endOfMonth = $now->copy()->endOfMonth();

    $weekly = DB::table('cms_transactions')
        ->selectRaw(
            'WEEK(updated_at, 3) - WEEK("' . $startOfMonth->format('Y-m-d') . '", 3) + 1 AS week_number, SUM(total_price) AS total'
        )
        ->whereBetween('updated_at', [$startOfMonth, $endOfMonth])
        ->groupBy('week_number')
        ->orderBy('week_number')
        ->pluck('total', 'week_number')
        ->toArray();

    $maxWeek = max(array_keys($weekly) ?: [1]);
    $weekTotals = [];
    for ($i = 1; $i <= $maxWeek; $i++) {
        $weekTotals[] = round($weekly[$i] ?? 0, 2);
    }

    $last = $weekTotals[$maxWeek - 1] ?? 0;
    $prev = $weekTotals[$maxWeek - 2] ?? 0;
    // $percent = $prev > 0 ? round((($last - $prev) / $prev) * 100, 1) : 0;
    $percent = $prev == 0
    ? ($last > 0 ? 100 : 0)
    : round((($last - $prev) / $prev) * 100, 1);

    $amount = round(abs($last - $prev), 2);

    return response()->json([
        'series' => [[ 'data' => $weekTotals ]],
        'percentage' => $percent,
        'amount' => $amount,
        'total' => $last,
        'lastWeek' => $prev,
    ]);
}

    
}
