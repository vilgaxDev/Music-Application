<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Artist extends Model
{
    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['user_id','avatar','firstname','lastname','displayname'];

    public function user()
    {
        return $this->belongsTo('App\User');
    }
    public function albums()
    {
        return $this->hasMany('App\Album');
    }
    public function podcasts()
    {
        return $this->hasMany('App\Podcast');
    }
    public function followers()
    {
        return $this->hasMany('App\ArtistFollow');
    }
    public function songs()
    {
        return $this->hasMany('App\Song');
    }
    public function used_disk_space() {
        return $this->songs()->where('uploaded_by','=','artist')->sum('file_size');
    }
    public static function boot() {
        parent::boot();
        static::deleting(function($model) { 
            // delete the arist data after deletion
            \App\Helpers\FileManager::delete($model->avatar);
            $model->albums()->delete();
            $model->podcasts()->delete();
        });
    }
}
