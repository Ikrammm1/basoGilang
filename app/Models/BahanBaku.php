<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BahanBaku extends Model
{
    use HasFactory;
    protected $table='cms_bahan_baku';
    // protected $fillable = [
    //     'name',
    //     'jumlah',
    //     'satuan',
    //     'harga_satuan',
    // ];
        protected $guarded =[];
}
