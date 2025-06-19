<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailTransaction extends Model
{
    use HasFactory;

    protected $table = 'cms_transaction_details';
    protected $guarded = [];


    public function Product(){
        return $this->belongsTo('App\Models\Product', 'product_id', 'id');
    }
    public function Packaging(){
        return $this->belongsTo('App\Models\Packaging', 'packaging', 'id');
    }
    public function Transaction(){
        return $this->belongsTo('App\Models\Transaction', 'trans_id', 'id');
    }
    public function package() {
        return $this->belongsTo(TransactionPackage::class, 'transaction_package_id');
    }

}
