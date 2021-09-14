<?php

namespace App\Http\Resources;
use App\Helpers\FileManager;
use App\Http\Resources\ArtistResource;
use Illuminate\Http\Resources\Json\JsonResource;

class SongResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'artists' => $this->artists,
            'description' => $this->description,
            'duration' => $this->duration,
            'source_format' => $this->source_format,
            'file_name' => $this->file_name,
            'source' =>  $this->source_format === 'file' ? FileManager::asset_path($this->source): json_decode($this->source),
            'cover' => FileManager::asset_path($this->cover), 
            'genres' => $this->genres,
            'public' => $this->public,
            'nb_likes' => $this->likes->count(),            
            'nb_plays' => $this->plays->count(),           
            'nb_downloads' => $this->download_count,           
            $this->mergeWhen($this->artist_id,[
                'artist' => new ArtistResource($this->artist),
            ]),
            $this->mergeWhen($this->album_id,[
                'album' => $this->album()->select('title','id')->first()
            ]),
            $this->mergeWhen(\Auth::user() && \Auth::user()->isAdmin(), [
                'user' => new UserResource($this->user),
                'created_at' => $this->created_at,
                'updated_at' => $this->updated_at,
            ])
        ];
    }
}