<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNumberClientsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('number_clients', function (Blueprint $table) {
            $table->increments('id');
            $table->string('number')->nullable();
            $table->string('state');
            $table->unsignedInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('clients');
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
        Schema::dropIfExists('number_clients');
    }
}
