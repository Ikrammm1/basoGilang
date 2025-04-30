<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        $this->call([
            // CmsUsersSeeder::class,
            CmsMasPositionsSeeder::class,
            CmsMenusSeeder::class,
            CmsMenuAuthorizationGroupsSeeder::class,
            CmsMenuAuthGroupsSeeder::class,
            CmsUserAuthGroupsSeeder::class,
        ]);
    }
}
