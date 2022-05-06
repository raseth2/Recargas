<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;




class SocialNetworkSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('social_networks')->insert([
            'name' => 'WhatsApp'                     
        ]);
        DB::table('social_networks')->insert([
            'name' => 'Telegram'                     
        ]);
    }
}
