<?php

namespace App\Http\Controllers\Packaging;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Packaging;
class PackagingController extends Controller
{
    public function index(){
        return Packaging::all();
    }

    public function store(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'price' => 'required',
            'desc'=>'nullable',
        ]);

        $new = Packaging::create($validate);

        return response()->json(['success'=>true, 'datas'=>$new],200);
    }
    public function update(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'price' => 'required',
            'desc'=>'nullable',
        ]);

        Packaging::whereId($request->id)->update($validate);

        $update = Packaging::whereId($request->id)->first();


        return response()->json(['success'=>true, 'datas'=>$update],200);
    }

    public function delete($id){
        
        Packaging::whereId($id)->delete();

        return response()->json(['success'=>true, 'message'=>'Data berhasil dihapus']);
    }
}
