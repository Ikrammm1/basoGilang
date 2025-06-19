<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;
    protected $table= 'cms_customers';
    protected $guarded = [];

    public function Ongkir(){
        return $this->belongsTo('App\Models\Ongkir', 'radius_id', 'id');
    }
}
