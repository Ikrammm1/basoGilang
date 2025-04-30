<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cms_menus', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('url');
            $table->unsignedBigInteger('parent_id')->nullable();  // Relasi dengan parent menu
            $table->integer('sort_order')->default(0);  // Urutan menu
            $table->unsignedBigInteger('userId');  // User yang membuat menu
            $table->string('icon')->nullable();  // Ikon menu
            $table->enum('category', ['header', 'parent', 'submenu'])->default('parent');  // Kategori menu
            $table->timestamps();

            $table->foreign('parent_id')->references('id')->on('cms_menus')->onDelete('cascade');  // Relasi ke parent
            $table->foreign('userId')->references('id')->on('users')->onDelete('cascade');  // Relasi ke user
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_menus');
    }
};
