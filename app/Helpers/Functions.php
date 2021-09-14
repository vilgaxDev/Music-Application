<?php

namespace App\Helpers;

use App\Http\Resources\EpisodeResource;
use App\Http\Resources\SongResource;
use App\Song;
use App\Episode;
use App\Http\Resources\RadioStationResource;
use App\RadioStation;

class Functions
{
    static public function whatIsBeingPlayed($type, $id)
    {
        if ($type === 'song') {
            $song = new SongResource(Song::find($id));
            $id = $song->id;
            $title = $song->title;
            $parent_title = $song->album ? $song->album->title : null;
            $artists = json_decode($song->artists) ? $song->artists : null;
        } else if ($type === 'episode') {
            $episode = new EpisodeResource(Episode::find($id));
            $id = $episode->id;
            $title = $episode->title;
            $parent_title = $episode->podcast ? $episode->podcast->title : null;
            $artists = null;
        } else if ($type === 'radio-station') {
            $radioStation = new RadioStationResource(RadioStation::find($id));
            $id = $radioStation->id;
            $title = $radioStation->name;
            $parent_title = null;
            $artists = null;
        }
        return (object) [
            'id' => $id,
            'title' => $title,
            'parent_title' => $parent_title,
            'artists' => $artists,
            'type' => $type,
        ];
    }
    public static function getWhatIsHePlaying($is_playing)
    {
        $is_playing = json_decode($is_playing);
        if (!$is_playing) {
            return null;
        }
        if ($is_playing->type === 'episode') {
            $content_item = new EpisodeResource(Episode::find($is_playing->id));
        } else if ($is_playing->type === 'song') {
            $content_item = new SongResource(Song::find($is_playing->id));
        } else if ($is_playing->type === 'radio-station') {
            $content_item = new RadioStationResource(RadioStation::find($is_playing->id));
        }
        return [
            'content_item' => $content_item,
            'title' => $is_playing->title,
            'artists' => $is_playing->artists,
            'parent_title' => $is_playing->parent_title
        ];
    }
}
