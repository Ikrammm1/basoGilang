<?php

namespace App\Http\Controllers\VendorManagement;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Vendor;

class VendorController extends Controller
{
    public function index()
    {
        $datas = Vendor::all();
        return response()->json($datas, 200);
    }

    public function store(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'desc' => 'nullable|string',
        ]);

        $new = Vendor::create($validate);

        return response()->json(['success' => true, 'datas'=>$new],200);
    }

    public function update(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'desc' => 'nullable|string',
        ]);

        Vendor::whereId($request->id)->update($validate);
        $dataUpdate = Vendor::find($request->id)->first();

        return response()->json(['success' => true, 'datas'=>$dataUpdate],200);

    }

    public function delete($id)
    {
       // Temukan kategori berdasarkan ID
        $vendor = Vendor::find($id);

        // Hapus kategori dari database
        $vendor->delete();

        // Return response
        return response()->json(['message' => 'vendor deleted successfully'], 200);
    }

}
 