<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserAuthGroup extends Model
{
    use HasFactory;
    protected $table = 'cms_user_auth_groups';
    // protected $fillable = [
    //     'user_id',
    //     'group_id'
    // ];
        protected $guarded =[];

    public function User()
    {
        return $this->belongsTo('App\Models\User', 'user_id', 'id');
    }
}
