<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CmsUserAuthGroupsSeeder extends Seeder
{
    public function run()
    {
        DB::table('cms_user_auth_groups')->insert([
            'user_id' => 1, // Sesuaikan ID user
            'group_id' => 1, // Sesuaikan ID group
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
