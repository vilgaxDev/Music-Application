<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Podcast extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = [ 'title','cover','description','artist_id','genre_id'];

    public function artist()
    {
        return $this->belongsTo('App\Artist');
    }
    public function episodes()
    {
        return $this->hasMany('App\Episode');
    }
    public function genres()
    {
        return $this->belongsToMany('App\PodcastGenre','genre_podcast','podcast_id','genre_id');
    }
    public function follows()
    {
        return $this->hasMany('App\PodcastFollow');
    }
    public function plays()
    {
        return $this->hasMany('App\Play', 'content_id')->where('plays.content_type', '=', 'podcast');
    }
    public static function boot() {
        parent::boot();
        static::deleting(function($model) { 
            // delete the podcast data after deletion         
            \App\Helpers\FileManager::delete($model->cover);
            $model->episodes()->delete();
            $model->follows()->delete();
        });
    }
}
