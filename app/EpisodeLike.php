<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EpisodeLike extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['episode_id','user_id'];
    
    public function user()
    {
        return $this->belongsTo('App\User');
    }
    public function episode()
    {
        return $this->belongsTo('App\Episode');
    }
}
