<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BahanKemasanLog extends Model
{
    use HasFactory;
    protected $table='cms_bahan_kemasan_logs';
    protected $guarded =[];

    public function BahanKemasan(){
        return $this->belongsTo('App\Models\BahanKemasan', 'kemasan_id', 'id');
    }
    public function Vendor(){
        return $this->belongsTo('App\Models\Vendor', 'vendor_id', 'id');
    }
}
