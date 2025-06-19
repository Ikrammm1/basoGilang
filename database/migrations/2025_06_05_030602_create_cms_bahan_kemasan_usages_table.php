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
        Schema::create('cms_bahan_kemasan_usages', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->bigInteger('baku_id');
            $table->integer('restock_log_id');
            $table->integer('used_log_id');
            $table->integer('qty');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cms_bahan_kemasan_usages');
    }
};
