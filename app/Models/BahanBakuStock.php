<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BahanBakuStock extends Model
{
    use HasFactory;
    protected $table='cms_bahan_baku_stocks';
    protected $guarded =[];
}
