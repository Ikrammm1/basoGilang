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
        Schema::create('cms_bahan_baku_logs', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('baku_id');
            $table->date('inDate')->nullable();
            $table->date('outDate')->nullable();
            $table->integer('jumlah');
            $table->string('satuan');
            $table->double('harga_satuan')->nullable();
            $table->double('total_harga')->nullable();
            $table->string('category');
            $table->string('vendor_id',10);
          
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cms_bahan_baku_logs');
    }
};
