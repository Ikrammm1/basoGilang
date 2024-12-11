<?php

namespace App\Http\Controllers\UserApp;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\MasPositions;
use App\Models\UserAuthGroup;
use Illuminate\Support\Facades\DB;

class UserAppController extends Controller
{
    public function listUser()
    {
        $results = DB::table('users')
            ->join('cms_mas_positions', 'users.position_code', '=', 'cms_mas_positions.mp_code')
            ->select('users.id','users.name', 'users.email','users.phone','users.photo',
                'cms_mas_positions.mp_code',
                'cms_mas_positions.mp_name','cms_mas_positions.mp_desc')
            ->get();
        return $results;
    }

    public function store(Request $request)
    {
        $request->validate([
            'name'=> 'string|required',
            'email'=> 'string|required',
            'position'=> 'string',
        ]);
        $new = null;
        try{
            DB::transaction(function () use($request, &$new){
                $new = User::create([
                    'name'=>$request->name,
                    'email'=>$request->email,
                    'password'=>$request->password ? base64_encode($request->password) : base64_encode('Password123'),
                    'phone'=>$request->phone,
                    'active'=>1,
                    'position_code'=>$request->position,
                ]);
        
                UserAuthGroup::create([
                    'user_id' =>$new->id,
                    'group_id' =>$request->groupId ? $request->groupId : 12,
                ]);
        
            });
            $data =  DB::table('users')
            ->join('cms_mas_positions', 'users.position_code', '=', 'cms_mas_positions.mp_code')
            ->select('users.id','users.name', 'users.email','users.phone','users.photo',
                'cms_mas_positions.mp_code',
                'cms_mas_positions.mp_name','cms_mas_positions.mp_desc')
            ->where('users.id', $new->id)
            ->first();
            return response()->json(['success'=> true, 'datas'=> $data],200);

        }catch(Throweble $e ){
            return response()->json(['success'=>false, 'message'=>$e],500);
        }
        

    }

    public function update(Request $request)
    {
        $request->validate([
            'name'=> 'string|required',
            'email'=> 'string|required',
            'position'=> 'string',
        ]);
        $update = null;
        try{
            DB::transaction(function () use($request, &$update){
                $update = User::whereId($request->id)->update([
                    'name'=>$request->name,
                    'email'=>$request->email,
                    'phone'=>$request->phone,
                    'position_code'=>$request->position,
                ]);
        
            });
            $data =  DB::table('users')
            ->join('cms_mas_positions', 'users.position_code', '=', 'cms_mas_positions.mp_code')
            ->select('users.id','users.name', 'users.email','users.phone','users.photo',
                'cms_mas_positions.mp_code',
                'cms_mas_positions.mp_name','cms_mas_positions.mp_desc')
            ->where('users.id', $request->id)
            ->first();
            return response()->json(['success'=> true, 'datas'=> $data],200);

        }catch(Throweble $e ){
            return response()->json(['success'=>false, 'message'=>$e],500);
        }
        

    }
    

    public function getPositions(){
        return MasPositions::all();
    }

    public function delete($id)
    {
        User::where('id', $id)->delete();
        UserAuthGroup::where('user_id', $id)->delete();

        return response()->json(['success'=>true], 200);
    }
}
