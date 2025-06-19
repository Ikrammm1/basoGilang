<?php

namespace App\Http\Controllers\Ongkir;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Ongkir;

class OngkirController extends Controller
{
    public function index()
    {
        return Ongkir::all();
    }

    public function store(Request $request)
    {
        $validate = $request->validate([
            'radius' => 'required|string',
            'price' => 'required',
            'desc'=>'nullable',
        ]);

        $new = Ongkir::create($validate);

        return response()->json(['success'=>true, 'datas'=>$new],200);
    }
    public function update(Request $request)
    {
        $validate = $request->validate([
            'radius' => 'required|string',
            'price' => 'required',
            'desc'=>'nullable',

        ]);

        Ongkir::whereId($request->id)->update($validate);

        $update = Ongkir::whereId($request->id)->first();


        return response()->json(['success'=>true, 'datas'=>$update],200);
    }

    public function delete($id){
        
        Ongkir::whereId($id)->delete();

        return response()->json(['success'=>true, 'message'=>'Data berhasil dihapus']);
    }
}
