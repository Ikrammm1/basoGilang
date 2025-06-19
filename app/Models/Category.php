<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $table = 'cms_categories';
    // protected $fillable = [
    //     'name',
    //     'desc',
    //     'icon',
    // ];
        protected $guarded =[];
}
