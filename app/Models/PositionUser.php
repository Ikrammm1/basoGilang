<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PositionUser extends Model
{
    use HasFactory;
    protected $table = 'cms_mas_positions';
    // protected $fillable = [
    //     'mp_code',
    //     'mp_name',
    //     'mp_desc',
    // ];
        protected $guarded =[];
}
