<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CmsMasPositionsSeeder extends Seeder
{
    public function run()
    {
        DB::table('cms_mas_positions')->insert([
            ['mp_code' => 'MGR', 'mp_name' => 'Manager', 'created_at' => now(), 'updated_at' => now()],
            ['mp_code' => 'STF', 'mp_name' => 'Staff', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
