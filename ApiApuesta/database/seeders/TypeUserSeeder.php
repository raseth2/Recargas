<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;




class TypeUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('type_users')->insert([
            'name' => 'Promotor'                     
        ]);
        DB::table('type_users')->insert([
            'name' => 'Administrador'                     
        ]);
    }
}
