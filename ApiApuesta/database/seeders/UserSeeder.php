<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

use Illuminate\Support\Facades\Hash;


class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // DB::table('users')->insert([
        //     'name' => 'Ussuario 1',    
        //     'email' => 'usuario@gmail.com',
        //     'password' => Hash::make('123456'),
        //     'api_token' =>  Str::random(60),       
        //     'type_user_id' => 1                   
        // ]);
        
        DB::table('users')->insert([
            'name' => 'Administrador',    
            'email' => 'admin@gmail.com',
            'password' => Hash::make('123456'),
            'api_token' =>  Str::random(60),       
            'type_user_id' => 2                   
        ]);
        
    }
}
