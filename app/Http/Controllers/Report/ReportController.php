<?php

namespace App\Http\Controllers\Report;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;

class ReportController extends Controller
{
    public function getReport(Request $request)
    {
        $data = [];

        if($request->jenisReport == '1'){
            $query = DB::table('cms_transactions as a')
                ->join('cms_transaction_details as b', 'b.trans_id', '=', 'a.id')
                ->join('cms_products as c', 'c.id', '=', 'b.product_id')
                ->select(
                    'b.product_id',
                    'c.code',
                    'c.name',
                    'b.category',
                    DB::raw('SUM(a.qty) as total_qty'),
                    DB::raw('SUM((b.total_price*(b.jumlah_pack))) as total_price')
                );

            // Filter berdasarkan jenisFilter
            switch ($request->jenisFilter) {
                case '1': // Filter per tahun
                    $query->whereYear('a.updated_at', $request->tahun);
                    break;

                case '2': // Filter per bulan
                    $tahun = Carbon::now()->format('Y');
                    $query->whereYear('a.updated_at', $tahun);
                    $query->whereMonth('a.updated_at', $request->bulan);
                    break;

                case '3': // Filter per tanggal antara startDate dan endDate
                    $query->whereBetween('a.updated_at', [$request->startDate, $request->endDate]);
                    break;

                case '4': // Filter hari ini
                    $query->whereDate('a.updated_at', Carbon::now()->toDateString());
                    break;
            }

            // Grouping
            $query->groupBy('b.product_id', 'b.category', 'c.name');
            $query->orderByRaw('SUM(a.qty) DESC');

            // Eksekusi dan ambil data
            $data = $query->get();
        }elseif($request->jenisReport == '2'){
             $query = DB::table('cms_transactions as a')
                ->selectRaw('
                    a.customer_id,
                    b.name as customer_name,
                    b.category as customer_category,
                    b.telp,
                    b.prov,
                    b.kab,
                    b.kec,
                    b.address,
                    SUM(a.qty) as total_order,
                    SUM(a.total_price) as total_price
                ')
                ->leftJoin('cms_customers as b', 'a.customer_id', '=', 'b.id');

            // Filter waktu
             switch ($request->jenisFilter) {
                case '1': // Filter per tahun
                    $query->whereYear('a.updated_at', $request->tahun);
                    break;

                case '2': // Filter per bulan
                    $tahun = Carbon::now()->format('Y');
                    $query->whereYear('a.updated_at', $tahun);
                    $query->whereMonth('a.updated_at', $request->bulan);
                    break;

                case '3': // Filter per tanggal antara startDate dan endDate
                    $query->whereBetween('a.updated_at', [$request->startDate, $request->endDate]);
                    break;

                case '4': // Filter hari ini
                    $query->whereDate('a.updated_at', Carbon::now()->toDateString());
                    break;
            }
            $query
                ->groupBy(
                    'a.customer_id',
                    'b.name',
                    'b.category',
                    'b.telp',
                    'b.prov',
                    'b.kab',
                    'b.kec',
                    'b.address'
                );
            $query->orderByRaw('SUM(a.qty) DESC');


            $data = $query->get();

            $provinces = Cache::remember('provinces', now()->addDay(), function () {
                $response = Http::withoutVerifying()->get('https://wilayah.id/api/provinces.json');
                return $response->successful() ? collect($response->json('data')) : collect();
            });

            

            foreach ($data as $dt) {
                // Temukan provinsi berdasarkan kode
                $provinsi = $provinces->firstWhere('code', $dt->prov);
                $codeProv = $dt->prov;
                $kodeKab = $dt->kab;
                $kodeKec = $dt->kec;
                $regencies = Cache::remember("regencies_{$codeProv}", now()->addDay(), function () use ($codeProv) {
                    $response = Http::withoutVerifying()->get("https://wilayah.id/api/regencies/{$codeProv}.json");
                    return $response->successful() ? collect($response->json('data')) : collect();
                });
                 // Ambil nama kabupaten
                $kab = $regencies->firstWhere('code', $kodeKab);
                $dt->kab_name = $kab['name'] ?? '-';

                // Ambil nama kecamatan dari cache per kabupaten
                $districts = Cache::remember("districts_{$kodeKab}", now()->addDay(), function () use ($kodeKab) {
                    $response = Http::withoutVerifying()->get("https://wilayah.id/api/districts/{$kodeKab}.json");
                    return $response->successful() ? collect($response->json('data')) : collect();
                });

                $kec = $districts->firstWhere('code', $kodeKec);
                $dt->kec_name = $kec['name'] ?? '-';

                $dt->prov_name = $provinsi['name'] ?? '-'; // default '-' jika tidak ditemukan
            }

        }else{
            return [];
        }

        return $data;
    }

    public function getExpenses(Request $request){

        // dd($request);
        if(!$request->jenisFilter){
            return [];
        }
       // Query 1: Bahan Baku
        $query1 = DB::table('cms_bahan_baku_logs as a')
            ->selectRaw("
                a.inDate,
                a.jumlah,
                a.satuan,
                a.category,
                NULL as vendor_id,
                a.total_harga,
                'Bahan Baku' as jenis,
                b.name as bahan_name,
                NULL as vendor_name
            ")
            ->leftJoin('cms_bahan_baku as b', 'b.id', '=', 'a.baku_id')
            ->where('a.category', 'Restock');

        // Query 2: Bahan Kemasan
        $query2 = DB::table('cms_bahan_kemasan_logs as b')
            ->selectRaw("
                b.inDate,
                b.jumlah,
                b.satuan,
                b.category,
                b.vendor_id,
                (b.harga) as total_harga,
                'Kemasan/Packaging' as jenis,
                c.name as bahan_name,
                d.name as vendor_name
            ")
            ->leftJoin('cms_bahan_kemasans as c', 'b.kemasan_id', '=', 'c.id')
            ->leftJoin('cms_vendors as d', 'b.vendor_id', '=', 'd.id')
            ->where('b.category', 'Restock');

        // Gunakan switch-case untuk filter waktu
        switch ($request->jenisFilter) {
            case '1': // Tahun
                $query1->whereYear('a.inDate', $request->tahun);
                $query2->whereYear('b.inDate', $request->tahun);
                break;

            case '2': // Bulan
                $tahun = Carbon::now()->format('Y');
                $query1->whereYear('a.inDate', $tahun)
                    ->whereMonth('a.inDate', $request->bulan);
                $query2->whereYear('b.inDate', $tahun)
                    ->whereMonth('b.inDate', $request->bulan);
                break;

            case '3': // Antara tanggal
                $query1->whereBetween('a.inDate', [$request->startDate, $request->endDate]);
                $query2->whereBetween('b.inDate', [$request->startDate, $request->endDate]);
                break;

            case '4': // Hari ini
                $today = Carbon::now()->toDateString();
                $query1->whereDate('a.inDate', $today);
                $query2->whereDate('b.inDate', $today);
                break;
        }

        // Gabungkan hasilnya
        $data = $query1->unionAll($query2)->get();

        return $data;

    }
}
