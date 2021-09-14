<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SongLike extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['song_id','user_id'];
    
    public function user()
    {
        return $this->belongsTo('App\User', 'user_id');
    }
    public function song()
    {
        return $this->belongsTo('App\Song', 'song_id');
    }
}
