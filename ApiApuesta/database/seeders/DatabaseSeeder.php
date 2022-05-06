<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        
        // $this->call(TypeUserSeeder::class);
        // $this->call(SocialNetworkSeeder::class);
        // $this->call(ClientSeeder::class);
        // $this->call(BanksSeeder::class);

        $this->call(UserSeeder::class);

    }
}
