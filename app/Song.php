<?php

namespace App;

use App\Helpers\FileManager;

use Illuminate\Database\Eloquent\Model;

class Song extends Model
{
    /**
     * the attributes that are mass assignable.
     * @var array
     */
    protected $fillable = ['title', 'public', 'duration', 'source', 'source_format', 'description', 'cover', 'uploaded_by', 'genres', 'file_size', 'file_name','user_id', 'artist_id', 'youtube_id', 'artists', 'album_id', 'rank_on_album'];

    protected $hidden = [
        'pivot'
    ];

    public function user()
    {
        return $this->belongsTo('App\User', 'user_id');
    }
    public function artist()
    {
        return $this->belongsTo('App\Artist');
    }
    public function playlists()
    {
        return $this->belongsToMany('App\Playlist');
    }
    public function album()
    {
        return $this->belongsTo('App\Album');
    }
    public function plays()
    {
        return $this->hasMany('App\Play', 'content_id')->where('plays.content_type', '=', 'song');
    }
    public function likes()
    {
        return $this->hasMany('App\SongLike');
    }
    public function genres()
    {
        return $this->belongsToMany('App\Genre');
    }
    public static function boot()
    {
        parent::boot();
        static::deleting(function ($song) {
            // delete the song data after deletion
            if( $song->source_format === 'file' ) {
                FileManager::delete($song->source);
            } 
            FileManager::delete($song->cover);
            $song->likes()->delete();
            $song->plays()->delete();
        });
    }
}
