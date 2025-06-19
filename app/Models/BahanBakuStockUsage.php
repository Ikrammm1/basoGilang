<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BahanBakuStockUsage extends Model
{
     use HasFactory;
    protected $table='cms_bahan_baku_usages';
    protected $guarded =[];
}
