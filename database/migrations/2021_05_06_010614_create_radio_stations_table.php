<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRadioStationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('radio_stations', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->json('cover');
            $table->string('endpoint');
            $table->boolean('highlight')->default(0);
            $table->string('metadata_types');
            $table->bigInteger('icy_detection_timeout');
            $table->bigInteger('retry_timeout');
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
        Schema::dropIfExists('radio_stations');
    }
}
