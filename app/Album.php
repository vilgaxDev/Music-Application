<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Album extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['artist_id','release_date','cover','featured','title','created_by'];
    public function artist()
    {
        return $this->belongsTo('App\Artist');
    }
    public function songs()
    {
        return $this->hasMany('App\Song');
    }
    public function likes()
    {
        return $this->hasMany('App\AlbumLike');
    }
    public function plays()
    {
        return $this->hasMany('App\Play', 'content_id')->where('plays.content_type', '=', 'album');
    }
    public static function boot() {
        parent::boot();
        static::deleting(function($model) { 
             // delete the album data after deletion
            \App\Helpers\FileManager::delete($model->cover);
            $model->likes()->delete();
            $model->songs()->delete();
        });
    }
}
