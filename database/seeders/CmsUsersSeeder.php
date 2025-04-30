<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class CmsUsersSeeder extends Seeder
{
    public function run()
    {
        DB::table('users')->insert([
            'name' => 'Admin',
            'email' => 'app.basogilang@gmail.com',
            'position_code' => 'MGR',
            'password' => Hash::make('password'), // default password
            'created_at' => now(),
            'updated_at' => now(),

        ]);
    }
}
