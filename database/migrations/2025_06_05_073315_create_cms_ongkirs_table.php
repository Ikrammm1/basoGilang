<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cms_ongkirs', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('radius');
            $table->integer('price');
            $table->longText('desc');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cms_ongkirs');
    }
};
