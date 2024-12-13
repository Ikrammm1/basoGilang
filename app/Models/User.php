<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'photo',
        'active',
        'position_code',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function AuthorizationGroup()
    {
        return $this->belongsToMany(
            'App\Models\AuthorizationGroup',
            'cms_user_auth_groups',
            'user_id',
            'group_id',
            'id'
        );
    }

    // public function MasPosition()
    // {
    //     return $this->belongsToMany(
    //         'App\Models\MasPosition',
    //         'cms_mas_positions',
    //         'mp_code',
    //         'mp_name',
    //         'mp_desc'
    //     );
    // }
 
    public function UserAuthGroup()
    {
        return $this->hasMany('App\Models\UserAuthGroup', 'user_id', 'id');
    }


    public function Authorizations()
    {
        return $this->belongsToMany(AuthorizationGroup::class, 'cms_user_auth_groups', 'user_id', 'group_id');
    }

    public function userPosition()
    {
        return $this->hasMany('App\Models\MasPositions', 'mp_code', 'position_code');
    }

    
}
