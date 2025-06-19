<?php
namespace App\Services;

use App\Models\{Customer, Transaction, TransactionPackage, BahanKemasanStock, BahanKemasanLog, BahanKemasanStockUsage, DetailTransaction, Stock, StockLog};
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\DB;

class TransactionService
{
    public static function beginTransaction($request)
    {
        return DB::transaction(function () use ($request) {
            $customer = Customer::with('Ongkir')->find($request->customer_id);
            $ongkir = $customer->Ongkir->price ?? 0;

            $qty = 0;
            $total_price = 0;

            foreach ($request->packages as $package) {
                $total_price += $package['totalPrice'];
                $sum_jumlah = array_sum(array_column($package['products'], 'jumlah'));
                $qty += $package['jumlahPack'] * $sum_jumlah;
            }

            $transaction = Transaction::create([
                'customer_id' => $request->customer_id,
                'delivery_date' => $request->delivery_date,
                'delivery_time' => $request->delivery_time,
                'delivery_status' => $request->delivery_status,
                'pack_status' => $request->packStatus,
                'status' => $request->payment_status,
                'qty' => $qty,
                'total_price' => $total_price + intval($ongkir),
            ]);

            foreach ($request->packages as $package) {
                $transactionPackage = TransactionPackage::create([
                    'transaction_id' => $transaction->id,
                    'packaging' => $package['packaging'],
                    'jumlah_pack' => $package['jumlahPack'],
                    'total_price' => $package['totalPrice'],
                ]);

                // Bahan kemasan
                self::logKemasan($package, $transactionPackage);

                // Detail produk
                foreach ($package['products'] as $product) {
                    $detailTrans = DetailTransaction::create([
                        'trans_id' => $transaction->id,
                        'transaction_package_id' => $transactionPackage->id,
                        'unit_price' => $product['unit_price'],
                        'total_price' => ($product['total_price']),
                        'qty' => $product['jumlah'],
                        'jumlah_pack' => $package['jumlahPack'],
                        'product_id' => $product['product_id'],
                        'category' => $product['category'],
                    ]);

                    self::updateStock($product, $request->packStatus, $detailTrans->id,$package['jumlahPack']);
                }
            }

            return $transaction;
        });
    }

    protected static function logKemasan($package, $transactionPackage)
    {
        $jumlahDigunakan = $package['jumlahPack'];
        $stokTersedia = BahanKemasanStock::where('kemasan_id', $package['packaging'])
            ->where('qty', '>', 0)
            ->orderBy('created_at', 'asc')
            ->get();

        $logUsage = [];

        foreach ($stokTersedia as $stok) {
            if ($jumlahDigunakan <= 0) break;

            $tersedia = $stok->qty;

            if ($tersedia >= $jumlahDigunakan) {
                $stok->decrement('qty', $jumlahDigunakan);
                $logUsage[] = [
                    'kemasan_id' => $package['packaging'],
                    'restock_log_id' => $stok->restock_log_id,
                    'qty' => $jumlahDigunakan,
                ];
                $jumlahDigunakan = 0;
            } else {
                $stok->update(['qty' => 0]);
                $logUsage[] = [
                    'kemasan_id' => $package['packaging'],
                    'restock_log_id' => $stok->restock_log_id,
                    'qty' => $tersedia,
                ];
                $jumlahDigunakan -= $tersedia;
            }
        }

        $getKemasanDataLog = BahanKemasanLog::find($stokTersedia[0]->restock_log_id);
        $newLog = BahanKemasanLog::create([
            'kemasan_id' => $package['packaging'],
            'outDate' => Carbon::now()->format('Y-m-d'),
            'jumlah' => $package['jumlahPack'],
            'satuan' => $getKemasanDataLog->satuan ?? '',
            'vendor_id' => $getKemasanDataLog->vendor_id ?? null,
            'category' => 'Used',
            'harga' => 0,
        ]);

        foreach ($logUsage as $item) {
            BahanKemasanStockUsage::create([
                'kemasan_id' => $item['kemasan_id'],
                'restock_log_id' => $item['restock_log_id'],
                'used_log_id' => $newLog->id,
                'qty' => $item['qty'],
            ]);
        }
    }

    protected static function updateStock($product, $packStatus, $detailTransId, $jumlahPack)
    {
        $used = intval($product['jumlah'] * $jumlahPack);
        $category = $product['category'];
        $productId = $product['product_id'];

        // skip jika Unpack & Fresh
        if ($packStatus === 'Unpack' && $category === 'Fresh') return;

        $stocks = Stock::where('product_id', $productId)
            ->where(function ($q) use ($category) {
                if ($category === 'Fresh') {
                    $q->where('qty', '>', 0);
                } else {
                    $q->where('qty_frozen', '>', 0);
                }
            })
            ->orderBy('id')
            ->get();

        foreach ($stocks as $stock) {
            if ($used <= 0) break;

            if ($category === 'Fresh') {
                $available = $stock->qty;
                if ($available <= 0) continue;

                $toReduce = min($available, $used);
                $stock->decrement('qty', $toReduce);
            } else {
                $available = $stock->qty_frozen;
                if ($available <= 0) continue;

                $toReduce = min($available, $used);
                $stock->decrement('qty_frozen', $toReduce);
            }

            StockLog::create([
                'product_id' => $productId,
                'qty' => -$toReduce,
                'satuan' => $product['satuan'],
                'total_harga' => 0,
                'category' => 0,
                'trans_id' => $detailTransId,
                'stock_id' => $stock->id,
            ]);

            $used -= $toReduce;
        }

        if ($used > 0) {
            throw new Exception("Stok tidak mencukupi untuk produk ID: $productId");
        }
    }
}
