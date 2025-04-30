<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cms_mas_positions', function (Blueprint $table) {
            $table->id();
            $table->string('mp_code');  // Kode posisi
            $table->string('mp_name');  // Nama posisi
            $table->string('mp_desc')->nullable();  // Deskripsi posisi
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_mas_positions');
    }
};
