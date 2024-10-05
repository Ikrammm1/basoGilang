<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $table = 'cms_menus';
    protected $fillable = [
        'name', 'url', 'parent_id', 'sort_order', 'userId', 'icon','category'
    ];
    public function Items()
    {
        return $this->hasMany(static::class, 'parent_id')->where('category', 'parent')->orderBy('sort_order', 'asc');
    }

    public function Parent()
    {
        return $this->belongsTo(static::class, 'parent_id');
    }

    public function Submenu()
    {
        return $this->hasMany(static::class, 'parent_id')->where('category', 'Submenu')->orderBy('sort_order', 'asc')->with('Submenu');
    }

    public function MenuAuthGroup()
    {
        return $this->hasMany('App\Models\MenuAuthGroup','menu_id','id');
    }
}
