<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vendor extends Model
{
    use HasFactory;
    protected $table = 'cms_vendors';
    // protected $fillable = [
    //     'name',
    //     'desc',
    // ];
        protected $guarded =[];
}
