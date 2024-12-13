<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Menu;
use App\Models\MenuAuthGroup;
use App\Models\AuthorizationGroup;
use App\Models\UserAuthGroup;

class AuthController extends Controller
{
    public function login(Request $request){
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json([
                'message' => 'Invalid email and password'
            ], 401);
        }

        $user = User::where('email', $request->email)->with('userPosition')->firstOrFail();
        $userAuth = User::with(['Authorizations.headerMenus', 'Authorizations.Items','Authorizations.Submenu'])->find($user->id);

        // Mengumpulkan semua menu header
        $headerMenus = $userAuth->Authorizations->flatMap(function ($authorization) {
            return $authorization->headerMenus;
        })->unique('id');

        // Mengumpulkan semua menu parent
        $parentMenus = $userAuth->Authorizations->flatMap(function ($authorization) {
            return $authorization->Items;
        })->unique('id');

        $subMenus = $userAuth->Authorizations->flatMap(function ($authorization) {
            return $authorization->Submenu;
        })->unique('id');

        // Strukturkan data menu header dengan items berisi menu parent dan submenu
        $menuData = $headerMenus->map(function ($headerMenu) use ($parentMenus, $subMenus) {
            return [
                'id' => $headerMenu->id,
                "name"=> $headerMenu->name,
                "url"=> $headerMenu->url,
                "sort_order"=> $headerMenu->sort_order,
                "icon"=> $headerMenu->icon,
                "category"=> $headerMenu->category,
                'items' => $parentMenus->where('parent_id', $headerMenu->id)->map(function ($parentMenu) use ($subMenus) {
                    return [
                        'id' => $parentMenu->id,
                        "name"=> $parentMenu->name,
                        "url"=> $parentMenu->url,
                        "sort_order"=> $parentMenu->sort_order,
                        "icon"=> $parentMenu->icon,
                        "category"=> $parentMenu->category,
                        'submenu' => $subMenus->where('parent_id', $parentMenu->id)->map(function ($subMenu) {
                            return $subMenu;
                        })
                    ];
                })->values()
            ];
        });

        // return response()->json([
        //     'users' => $user,
        //     'menus' => $menuData
        // ]);
        // $auth = AuthorizationGroup::with('Menu');

        // $user = MenuAuthGroup::where('email', $request->email)->with(['AuthorizationGroup' => function($query){
        //     $query->whereHas
        // }]);

        // return $user;
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'token' => $token,
            'datas' => $user,
            'menus' => $menuData
            
        ]);
        // return response()->json([
        //     'access_token' => $token,
        //     'token_type' => 'Bearer',
        // ]);
    }

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'phone' => $request->phone,
            'photo' => $request->photo,
            'active' => $request->active,
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
        ],200);
    }

    public function logout(Request $request){
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'success logged out'
        ],200);
    }

}
