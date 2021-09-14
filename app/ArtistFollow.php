<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ArtistFollow extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['user_id','artist_id'];
    
    public function user()
    {
        return $this->belongsTo('App\User');
    }
    public function artist()
    {
        return $this->belongsTo('App\Artist');
    }
}
