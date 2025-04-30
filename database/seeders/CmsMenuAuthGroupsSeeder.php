<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CmsMenuAuthGroupsSeeder extends Seeder
{
    public function run()
    {
        DB::table('cms_menu_auth_groups')->insert([
            'menu_id' => 1, // Sesuaikan ID menu
            'group_id' => 1, // Sesuaikan ID group
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
