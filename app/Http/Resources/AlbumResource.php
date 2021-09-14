<?php

namespace App\Http\Resources;
use App\Helpers\FileManager;

use Illuminate\Http\Resources\Json\JsonResource;

class AlbumResource extends JsonResource
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
            'description' => $this->description,
            'songs' => SongResource::collection($this->songs()->orderBy('rank_on_album')->get()),
            'cover' => FileManager::asset_path($this->cover), 
            'release_date' => $this->release_date,
            'artist'=>new ArtistResource($this->artist),
            $this->mergeWhen(\Auth::user() && \Auth::user()->isAdmin(), [
                'user' => $this->user,
                'created_at' => $this->created_at,
                'updated_at' => $this->updated_at,
            ])
        ];
    }
}
