<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWalletsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wallets', function (Blueprint $table) {
            $table->increments('id');
            $table->decimal('total', 12, 2)->default(0);
            $table->string('type_currency')->nullable();
            $table->char('state', 2); 
            $table->date('last_recharge')->nullable(); 
            $table->timestamps();

            $table->unsignedInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('clients');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wallets');
    }
}
