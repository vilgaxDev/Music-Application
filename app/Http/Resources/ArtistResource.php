<?php

namespace App\Http\Resources;
use App\Helpers\FileManager;

use Illuminate\Http\Resources\Json\JsonResource;

class ArtistResource extends JsonResource
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
            'displayname' => $this->displayname,
            'avatar' => FileManager::asset_path($this->avatar),
            'available_disk_space' => $this->available_disk_space,
            'used_disk_space' => $this->used_disk_space(),
            'nb_followers' => $this->followers()->count(),
            'nb_albums' => $this->albums->count(),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'firstname' => $this->firstname,
            'lastname' => $this->lastname,
            $this->mergeWhen(\Auth::user() && \Auth::user()->isAdmin(), [
                'user' => new UserResource($this->user),
                'created_at' => $this->created_at,
                'updated_at' => $this->updated_at,
            ])
        ];
    }
}
