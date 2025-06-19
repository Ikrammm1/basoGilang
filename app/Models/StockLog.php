<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockLog extends Model
{
    use HasFactory;

    protected $table = 'cms_stock_logs';
    protected $guarded=[];

    public function Product(){
        return $this->belongsTo('App\Models\Product', 'product_id', 'id');
    }

    public function BahanBakuLog(){
        return $this->hasMany('App\Models\BahanBakuLog', 'produksi_id', 'id');
    }
}
