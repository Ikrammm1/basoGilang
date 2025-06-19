<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Customer;
class CustomerController extends Controller
{
    public function index()
    {
       // Ambil semua data provinsi
    $responseProv = $this->getProvinces();
    $listProv = collect($responseProv->getData()->data);

    // Ambil semua customer
    $data = Customer::with('Ongkir')->get();

    // Inisialisasi cache kabupaten dan kecamatan per provinsi
    $kabCache = [];
    $kecCache = [];

    foreach ($data as $a) {
        // 🔸 Ambil nama provinsi
        $provName = $listProv->first(function ($item) use ($a) {
            return $item->code == $a->prov;
        });
        $a->prov_name = $provName->name ?? null;

        // 🔸 Ambil data kabupaten (cache per provinsi)
        if (!isset($kabCache[$a->prov])) {
            $responseKab = $this->getRegencies($a->prov);
            $kabCache[$a->prov] = collect($responseKab->getData()->data);
        }

        // 🔸 Ambil nama kabupaten
        $kabName = $kabCache[$a->prov]->first(function ($item) use ($a) {
            return $item->code == $a->kab;
        });
        $a->kab_name = $kabName->name ?? null;

        // 🔸 Ambil data kecamatan (cache per kabupaten)
        if (!isset($kecCache[$a->kab])) {
            $responseKec = $this->getKec($a->kab);
            $kecCache[$a->kab] = collect($responseKec->getData()->data);
        }

        // 🔸 Ambil nama kecamatan
        $kecName = $kecCache[$a->kab]->first(function ($item) use ($a) {
            return $item->code == $a->kec;
        });
        $a->kec_name = $kecName->name ?? null;
    }

    // return response()->json([
    //     'success' => true,
    //     'data' => $data
    // ]);
        return $data;
        // return 
    }
    public function getProvinces()
    {
        $response = Http::withoutVerifying()->get('https://wilayah.id/api/provinces.json');

        if ($response->successful()) {
            return response()->json([
                'success' => true,
                'data' => $response->json('data'),
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Gagal mengambil data dari API',
        ], $response->status());
    }
    public function getRegencies($codeProv)
    {
        $response = Http::withoutVerifying()->get("https://wilayah.id/api/regencies/$codeProv.json");

        if ($response->successful()) {
            return response()->json([
                'success' => true,
                'data' => $response->json('data'),
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Gagal mengambil data dari API',
        ], $response->status());
    }
    public function getKec($codeKab)
    {
        $response = Http::withoutVerifying()->get("https://wilayah.id/api/districts/$codeKab.json");

        if ($response->successful()) {
            return response()->json([
                'success' => true,
                'data' => $response->json('data'),
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Gagal mengambil data dari API',
        ], $response->status());
    }

    public function store(Request $request)
{
    $request->validate([
        'name'     => 'required|string',
        'category' => 'required|string',
        'telp'     => 'required|string',
        'prov'     => 'required|string',
        'kab'      => 'required|string',
        'kec'      => 'required|string',
        'address'  => 'required|string',
        'radius'   => 'required|string',
    ]);

    $new = Customer::create([
        'name'      => $request->name,
        'telp'      => $request->telp,
        'category'  => $request->category,
        'prov'      => $request->prov,
        'kab'       => $request->kab,
        'kec'       => $request->kec,
        'address'   => $request->address,
        'mark'      => $request->mark ?? null,
        'radius_id' => $request->radius,
    ]);

    $new->load('Ongkir');

    // 🔹 Ambil nama provinsi
    $responseProv = $this->getProvinces();
    $listProv = collect($responseProv->getData()->data);
    $prov = $listProv->first(function ($item) use ($new) {
        return $item->code == $new->prov;
    });
    $new->prov_name = $prov->name ?? null;

    // 🔹 Ambil nama kabupaten (menggunakan provinsi terkait)
    $responseKab = $this->getRegencies($new->prov);
    $listKab = collect($responseKab->getData()->data);
    $kab = $listKab->first(function ($item) use ($new) {
        return $item->code == $new->kab;
    });
    $new->kab_name = $kab->name ?? null;

    // 🔹 Ambil nama kecamatan berdasarkan kabupaten
    $responseKec = $this->getKec($new->kab);
    $listKec = collect($responseKec->getData()->data);
    $kec = $listKec->first(function ($item) use ($new) {
        return $item->code == $new->kec;
    });
    $new->kec_name = $kec->name ?? null;

    return response()->json([
        'success' => true,
        'message' => 'Data berhasil ditambahkan.',
        'datas'   => $new,
    ]);
}


    public function update(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'category' => 'required|string',
            'telp' => 'required|string',
            'kab' => 'required|string',
            'kec' => 'required|string',
            'address' => 'required|string',
            'radius' => 'required|string',
        ]);

        // Cari customer, atau gagal 404 kalau tidak ada
        $customer = Customer::findOrFail($request->id);

        // Update data
        $customer->update([
            'name' => $request->name,
            'telp' => $request->telp,
            'category' => $request->category,
            'kab' => $request->kab,
            'kec' => $request->kec,
            'address' => $request->address,
            'mark' => $request->mark ?? null,
            'radius_id' => $request->radius,
        ]);

        // Load relasi radius
        $customer->load('Ongkir');

        // Ambil kabupaten
        $responseKab = $this->getRegencies();
        $listKab = collect($responseKab->getData()->data);
        $kab = $listKab->first(fn($item) => $item->code == $customer->kab);
        $customer->kab_name = $kab->name ?? null;

        // Ambil kecamatan
        $responseKec = $this->getKec($customer->kab);
        $listKec = collect($responseKec->getData()->data);
        $kec = $listKec->first(fn($item) => $item->code == $customer->kec);
        $customer->kec_name = $kec->name ?? null;

        return response()->json([
            'success' => true,
            'message' => 'Update data berhasil.',
            'datas' => $customer
        ]);
    }

    public function delete($id){
        Customer::find($id)->delete();

        return response()->json([
            'success' => true,
            'message' => 'Data berhasil dihapus'
        ]);
        

    }


}
