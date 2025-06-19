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
        Schema::create('cms_bahan_kemasan_stocks', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('baku_id',10);
            $table->string('logs_id',10);
            $table->integer('qty');
            $table->string('restock_log_id',10);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cms_bahan_kemasan_stocks');
    }
};
