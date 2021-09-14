<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Playlist extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['title','user_id','cover','public','created_by'];
    
    public function user()
    {
        return $this->belongsTo('App\User');
    }
    public function songs()
    {
        return $this->belongsToMany('App\Song');
    }
    public function followers()
    {
        return $this->hasMany('App\PlaylistFollow');
    }
    public function plays()
    {
        return $this->hasMany('App\Play', 'content_id')->where('plays.content_type', '=', 'playlist');
    }
    public static function boot() {
        parent::boot();
        static::deleting(function($model) {
            // delete the playlist data after deletion 
            \App\Helpers\FileManager::delete($model->cover);
        });
    }
}
