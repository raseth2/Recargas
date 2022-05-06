<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class CreateTipeUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('type_users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->timestamps();
        });

        Schema::create('document_types', function (Blueprint $table) {
            $table->string('id')->index();
            $table->boolean('active');
            $table->string('description');
        });

        DB::table('document_types')->insert([        
            ['id' => '1', 'active' => true,  'description' => 'DNI'],         
            ['id' => '6', 'active' => true,  'description' => 'RUC']    
        ]);

        Schema::create('banks', function (Blueprint $table) {
            $table->increments('id');
            $table->boolean('active');
            $table->string('description');
            $table->timestamps();
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tipe_users');
    }
}
