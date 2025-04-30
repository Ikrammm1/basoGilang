<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('cms_menu_auth_groups', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('group_id');
            $table->unsignedBigInteger('menu_id');
            $table->string('category');  // header, parent, submenu
            $table->foreign('group_id')->references('id')->on('cms_authorization_groups')->onDelete('cascade');
            $table->foreign('menu_id')->references('id')->on('cms_menus')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cms_menu_auth_groups');
    }
};
