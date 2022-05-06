<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;




class BanksSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('banks')->insert([
            'active' => '1',
            'description' => 'Banco de Credito',

        ]);
        DB::table('banks')->insert([
            'active' => '1',
            'description' => 'Banco de Interbank',

        ]);
    }
}
