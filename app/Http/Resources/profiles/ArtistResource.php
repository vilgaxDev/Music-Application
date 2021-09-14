<?php

namespace App\Http\Resources\profiles;

use App\Http\Resources\SongResource;
use App\Http\Resources\AlbumResource;
use Illuminate\Http\Resources\Json\JsonResource;
use App\Helpers\FileManager;
class ArtistResource extends JsonResource
{

    public function toArray($request)
    {
        return [
        'id' => $this->id,
        'displayname' => $this->displayname,
        'avatar' => FileManager::asset_path($this->avatar),
        'nb_albums' => $this->albums->count(),
        'latest'  => new SongResource ($this->songs()->orderBy('created_at')->first()),
        'popular'  => SongResource::collection($this->songs()->withCount('plays')->orderBy('plays_count','desc')->take(5)->get()),
        'songs'  => SongResource::collection($this->songs),
        'plays'  => $this->songs()->with('plays')->get()->pluck('plays')->collapse()->count(),
        'albums'  => AlbumResource::collection($this->albums),
        'nb_followers' => $this->followers()->count(),
        ];
    }
}
