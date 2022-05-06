<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClientesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('clients', function (Blueprint $table) {
            $table->increments('id');
            $table->string('email')->unique();
            $table->string('name');
            $table->string('last_name');
            $table->string('number');
            $table->string('player_id');
            $table->string('document_type_id');         
            $table->integer('state');
            $table->string('password');
            $table->string('api_token')->unique()->nullable();           
            
            $table->foreign('document_type_id')->references('id')->on('document_types');

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
        Schema::dropIfExists('clientes');
    }
}
