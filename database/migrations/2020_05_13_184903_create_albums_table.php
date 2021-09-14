<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAlbumsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('albums', function (Blueprint $table) {
            $table->increments('id');
            $table->string('title');
            $table->string('cover');
            $table->date('release_date');
            $table->string('artist_id');
            $table->string('created_by');
            $table->string('genre_id')->nullable();
            $table->timestamps();
        });
        \DB::statement("ALTER TABLE albums AUTO_INCREMENT = 68789;");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('albums');
    }
}
