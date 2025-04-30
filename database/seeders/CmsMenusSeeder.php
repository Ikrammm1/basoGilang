<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CmsMenusSeeder extends Seeder
{
    public function run()
    {
        DB::table('cms_menus')->insert([
            [
                'name' => 'Dashboard',
                'url' => '/dashboard',
                'icon' => 'home',
                'created_at' => now(),
                'updated_at' => now(),
                'userId' => 1,
            ],
            [
                'name' => 'Users',
                'url' => '/users',
                'icon' => 'users',
                'created_at' => now(),
                'updated_at' => now(),
                'userId' => 1,
            ],
        ]);
    }
}
