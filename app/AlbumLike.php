<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AlbumLike extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['album_id','user_id'];
    
    public function user()
    {
        return $this->belongsTo('App\User');
    }
    public function album()
    {
        return $this->belongsTo('App\Album');
    }
}
