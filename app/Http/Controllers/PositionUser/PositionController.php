<?php

namespace App\Http\Controllers\PositionUser;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PositionUser;
use Illuminate\Support\Facades\DB;

class PositionController extends Controller
{
    public function index(){
        $data = PositionUser::all();

        return response()->json($data, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'code' => 'string|required',
            'name' => 'string|required',
        ]);

        $checkCode = PositionUser::whereMpCode($request->code)->first();
        if($checkCode){
           return response()->json(['success' => false, 'message'=>'Kode posisi sudah ada'],400);
                
        }
        $newData = PositionUser::create([
            'mp_code' => $request->code,
            'mp_name' => $request->name,
            'mp_desc' => $request->desc,
        ]);

        return response()->json(['success' => true, 'datas'=>$newData],200);
    }

    public function update(Request $request)
    {
        $request->validate([
            'code' => 'string|required',
            'name' => 'string|required',
        ]);

        $checkCode = PositionUser::whereMpCode($request->code)->first();
        if($checkCode && $checkCode->mp_code != $request->oldCode){
            
           return response()->json(['success' => false, 'message'=>'Kode posisi sudah ada'],400);
                
        }
        // dd($request->oldCode);
        PositionUser::whereMpCode($request->oldCode)->update([
            'mp_code' => $request->code,
            'mp_name' => $request->name,
            'mp_desc' => $request->desc,
        ]);
        
        $updatedData = PositionUser::whereMpCode($request->code)->first();

        return response()->json(['success' => true, 'datas'=>$updatedData],200);
    }

    public function delete($id)
    {
        PositionUser::where('id', $id)->delete();

        return response()->json(['success'=>true], 200);
    }
}
