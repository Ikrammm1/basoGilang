<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
     public function up(): void
    {
        Schema::dropIfExists('cms_bahan_baku_stocks_table');
    }

    public function down(): void
    {
        // Optional: bisa dibiarkan kosong atau isi untuk membuat kembali tabel
    }
};
