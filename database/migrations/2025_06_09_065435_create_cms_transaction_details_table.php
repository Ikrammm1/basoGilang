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
        Schema::create('cms_transaction_details', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('trans_id');
            $table->string('unit_price');
            $table->double('total_price');
            $table->integer('qty');
            $table->string('product_id');
            $table->string('packaging');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cms_transaction_details');
    }
};
