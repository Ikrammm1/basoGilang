<?php

namespace App\Http\Controllers\AuthorizationsGroup;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\AuthorizationGroup;
use App\Models\MenuAuthGroup;
use App\Models\UserAuthGroup;
use Illuminate\Support\Facades\DB;
use Throwable;

class AuthorizationsController extends Controller
{
    public function index()
    {
        $data = AuthorizationGroup::with('Menus', 'Users')->get();

        return response()->json(['success' => true, 'datas' => $data], 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'string|required',
            'desc' => 'string|nullable',
        ]);

        // dd($request->userId);
        $menus = explode(',', $request->menus);
        $users = explode(',', $request->users);
        $new = null;
        try {
            DB::transaction(function () use ($request, &$new, &$menus, &$users) {

                $new = AuthorizationGroup::create([
                    'name' => $request->name,
                    'description' => $request->desc,
                    'userId' => $request->userId,
                ]);

                foreach ($menus as $menu) {
                    MenuAuthGroup::create([
                        'menu_id' => $menu,
                        'group_id' => $new->id,
                    ]);
                }
                foreach ($users as $user) {
                    UserAuthGroup::create([
                        'user_id' => $user,
                        'group_id' => $new->id,
                    ]);
                }
            });
            $data = AuthorizationGroup::with('Menus', 'Users')->whereId($new->id)->first();

            return response()->json(['success' => true, 'datas' => $data], 200);
        } catch (Throwable $e) {
            return response()->json(['success' => false, 'message' => $e], 500);
        }
    }

    public function update(Request $request)
    {
        $request->validate([
            'id' => 'required',
            'name' => 'string|required',
            'desc' => 'string|nullable',
        ]);
        $menus = explode(',', $request->menus);
        $users = explode(',', $request->users);
        $update = null;
        try {
            DB::transaction(function () use ($request, &$update, &$menus, &$users) {

                $update = AuthorizationGroup::whereId($request->id)->update([
                    'name' => $request->name,
                    'description' => $request->desc,
                    'userId' => $request->userId,
                ]);

                MenuAuthGroup::where('group_id', $request->id)->delete();
                foreach ($menus as $menu) {
                    MenuAuthGroup::create([
                        'menu_id' => $menu,
                        'group_id' => $request->id,
                    ]);
                }

                UserAuthGroup::where('group_id', $request->id)->delete();
                foreach ($users as $user) {
                    UserAuthGroup::create([
                        'user_id' => $user,
                        'group_id' => $request->id,
                    ]);
                }
            });
            $data = AuthorizationGroup::with('Menus', 'Users')->whereId($request->id)->first();

            return response()->json(['success' => true, 'datas' => $data], 200);
        } catch (Throwable $e) {
            return response()->json(['success' => false, 'message' => $e], 500);
        }
    }

    public function delete(Request $request)
    {
        $idGroup = $request->id;
        MenuAuthGroup::where('group_id', $idGroup)->delete();
        UserAuthGroup::where('group_id', $idGroup)->delete();
        AuthorizationGroup::whereId($idGroup)->delete();

        return response()->json(['success' => true], 200);
    }
}
