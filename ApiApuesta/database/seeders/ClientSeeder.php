<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

use Illuminate\Support\Facades\Hash;


class ClientSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('clients')->insert([
            'email' => 'cliente@gmail.com',
            'name' => 'Cesar',
            'last_name' => 'Condori',
            'number' => '45713875',
            'player_id' => '45713875AC',
            'document_type_id' => 1,
            'state' => 1,
            'password' => Hash::make('123456'),
            'api_token' =>  Str::random(60),                 
        ]);

        DB::table('clients')->insert([
            'email' => 'cliente2@gmail.com',
            'name' => 'Andres',
            'last_name' => 'Carrilo castillo',
            'number' => '14789632',
            'player_id' => '14789632AC',
            'document_type_id' => 1,
            'state' => 1,
            'password' => Hash::make('123456'),
            'api_token' =>  Str::random(60),                 
        ]);
        
        
    }
}
