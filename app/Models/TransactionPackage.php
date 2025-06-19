<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionPackage extends Model
{
    use HasFactory;
    protected $table = 'cms_transaction_packages';
    protected $guarded = [];

    public function details() {
    return $this->hasMany(DetailTransaction::class, 'transaction_package_id');
    }

    public function transaction() {
        return $this->belongsTo(Transaction::class);
    }
    
    public function kemasan() {
        return $this->belongsTo('App\Models\BahanKemasan', 'packaging', 'id');

    }

    
}
