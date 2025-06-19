<?php

namespace App\Http\Controllers\UserApp;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\MasPositions;
use App\Models\UserAuthGroup;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;


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
                $password = $request->password 
                ? Hash::make($request->password) 
                : Hash::make('Password123');
                $new = User::create([
                    'name'=>$request->name,
                    'email'=>$request->email,
                    'password'=>$password,
                    'phone'=>$request->phone,
                    'active'=>1,
                    'position_code'=>$request->position,
                ]);
        
                UserAuthGroup::create([
                    'user_id' =>$new->id,
                    'group_id' =>$request->groupId ? $request->groupId : 5,
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
                if($request->image){
                    $update = User::whereId($request->id)->update([
                        'photo'=>$request->image
                    ]);
                }
        
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

    public function newPass(Request $request)
    {
        // Get currently authenticated user
        $user = User::whereId($request->id)->first();
        // dd($user);
        // Validate request
        $validator = Validator::make($request->all(), [
            'current_password' => ['required', 'string'],
            'new_password' => ['required'],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 400);
        }

        // Check if the current password is correct
        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Current password is incorrect.'
            ], 400);
        }

        // Update the user's password
        $user->password = Hash::make($request->new_password);
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Password updated successfully.'
        ]);
            
    }

    public function upload(Request $request)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpg,jpeg,png,gif|max:800',
        ]);
        
        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $fileName = $file->getClientOriginalName();
            $fileNameOld = $request->input('imageOld'); // <-- perbaikan
        
            $pathFile = public_path('images/avatars/');
        
            // Hapus file baru jika sudah ada (jarang terjadi tapi aman)
            if (File::exists($pathFile . $fileName)) {
                File::delete($pathFile . $fileName);
            }
        
            // Hapus file lama jika bukan default
            if ($fileNameOld && $fileNameOld != 'profilephoto.png') {
                File::delete($pathFile . $fileNameOld);
            }
        
            // Pindahkan file baru ke folder public
            $file->move($pathFile, $fileName);
        
            return response()->json([
                'success' => true,
                'imageUrl' => $fileName,
            ]);
        }

        // Jika tidak ada file yang diupload
        return response()->json([
            'success' => false,
            'message' => 'No image uploaded.',
        ], 400);
    }
}
