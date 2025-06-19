<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BahanBakuLog extends Model
{
    use HasFactory;
    protected $table='cms_bahan_baku_logs';
    protected $guarded = [];

    public function BahanBaku(){
        return $this->belongsTo('App\Models\BahanBaku', 'baku_id', 'id');
    }
    public function Vendor(){
        return $this->belongsTo('App\Models\Vendor', 'vendor_id', 'id');
    }
}
