<?php

namespace App\Http\Controllers\UserApp;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\MasPositions;
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
}
