<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRechargesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('recharges', function (Blueprint $table) {
            $table->increments('id');
            $table->decimal('amount', 12, 2)->default(0);
            $table->char('state', 2); 
            $table->date('date'); 
            $table->string('photo');
            $table->string('comment')->nullable();
            $table->string('number');

            $table->timestamps();

            $table->unsignedInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('clients');

            $table->unsignedInteger('bank_id');
            $table->foreign('bank_id')->references('id')->on('banks');

            $table->unsignedInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users');


            $table->unsignedInteger('social_id');
            $table->foreign('social_id')->references('id')->on('social_networks');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('recharges');
    }
}
