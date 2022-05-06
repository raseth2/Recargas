<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('api_token')->unique()->nullable();
            $table->rememberToken();
            $table->timestamps();

            $table->unsignedInteger('type_user_id');
            $table->foreign('type_user_id')->references('id')->on('type_users');
            
        });
    }
  
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
