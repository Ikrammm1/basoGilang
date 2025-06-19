<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;
    protected $table = 'cms_transactions';
    protected $guarded = [];


    public function Product(){
        return $this->belongsTo('App\Models\Product', 'product_id', 'id');
    }
   
    public function Customer(){
        return $this->belongsTo('App\Models\Customer', 'customer_id', 'id');
    }

    public function DetailTransaction(){
        return $this->hasMany('App\Models\DetailTransaction', 'trans_id', 'id');
    }

    public function packages() {
        return $this->hasMany(TransactionPackage::class);
    }

    
}
