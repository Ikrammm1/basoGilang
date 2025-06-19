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
        Schema::create('cms_transactions', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('category');
            $table->integer('qty');
            $table->string('status');
            $table->double('total_price');
            $table->string('customer_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cms_transactions');
    }
};
