<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Stock extends Model
{
    use HasFactory;

    protected $table = 'cms_stocks';
    protected $guarded=[];
    
    public function Product()
    {
        return $this->belongsTo('App\Models\Product', 'product_id', 'id');
    }
}
