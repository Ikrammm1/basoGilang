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
        Schema::create('cms_transaction_packages', function (Blueprint $table) {
            $table->id();
            $table->integer('transaction_id');
            $table->string('packaging');
            $table->integer('jumlah_pack');
            $table->integer('total_price');
            $table->timestamps();
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaction_packages');
    }
};
