<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AuthorizationGroup extends Model
{
    protected $table = 'cms_authorization_groups';
    // protected $fillable = [
    //     'name',
    //     'description',
    //     'userId'
    // ];
     protected $guarded =[];

    // public function Menu()
    // {
    //     return $this->belongsToMany(
    //         'App\Models\Menu',
    //         'cms_menu_auth_groups',
    //         'group_-id',
    //         'menu_id'
    //     );
    // }
    public function Menus()
    {
        return $this->belongsToMany(Menu::class, 'cms_menu_auth_groups', 'group_id', 'menu_id');
    }

    public function headerMenus()
    {
        return $this->belongsToMany(Menu::class, 'cms_menu_auth_groups', 'group_id', 'menu_id')
            ->where('cms_menus.category', 'header');
    }

    // Relasi untuk menu kategori 'parent'
    public function Items()
    {
        return $this->belongsToMany(Menu::class, 'cms_menu_auth_groups', 'group_id', 'menu_id')
            ->where('cms_menus.category', 'parent');
    }
    public function Submenu()
    {
        return $this->belongsToMany(Menu::class, 'cms_menu_auth_groups', 'group_id', 'menu_id')
            ->where('cms_menus.category', 'submenu');
    }

    public function Users()
    {
        return $this->belongsToMany(
            User::class,
            'cms_user_auth_groups',
            'group_id',
            'user_id'
        );
    }
}
