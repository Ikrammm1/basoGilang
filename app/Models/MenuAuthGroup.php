<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MenuAuthGroup extends Model
{
    use HasFactory;
    protected $table = 'cms_menu_auth_groups';
    // protected $fillable = [
    //     'menu_id',
    //     'group_id'
    // ];
        protected $guarded =[];

    public function Menu()
    {
        return $this->belongsTo('App\Models\Menu', 'menu_id', 'id');
    }
}
