<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHistoryWalletsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('history_wallets', function (Blueprint $table) {
            $table->increments('id');
            $table->decimal('amount', 12, 2)->default(0);
            $table->date('fecha');
            $table->char('state', 2); 
           
            $table->timestamps();

            $table->unsignedInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('clients');


            $table->unsignedInteger('recharge_id');
            $table->foreign('recharge_id')->references('id')->on('recharges');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('history_wallets');
    }
}
