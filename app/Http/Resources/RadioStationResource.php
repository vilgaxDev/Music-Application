<?php

namespace App\Http\Resources;

use App\Helpers\FileManager;
use Illuminate\Http\Resources\Json\JsonResource;

class RadioStationResource extends JsonResource
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
            'name' => $this->name,
            'endpoint' => $this->endpoint,
            'icy_detection_timeout' => $this->icy_detection_timeout,
            'retry_timeout' => $this->retry_timeout,
            'highlight' => $this->highlight,
            'cover' => FileManager::asset_path($this->cover),
            'metadata_types' => json_decode($this->metadata_types),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
