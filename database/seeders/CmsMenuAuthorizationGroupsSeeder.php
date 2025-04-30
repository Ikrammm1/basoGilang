<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CmsMenuAuthorizationGroupsSeeder extends Seeder
{
    public function run()
    {
        DB::table('cms_authorization_groups')->insert([
            'name' => 'Super Admin',
            'description' => 'Full access rights',
            'userId' => 1, // Sesuaikan ID user
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
