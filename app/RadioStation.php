<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class RadioStation extends Model
{
    protected $fillable = [
        'name',
        'cover',
        'endpoint',
        'metadata_types',
        'icy_metadata_interval',
        'icy_detection_timeout',
        'retry_timeout',
        'highlight'
    ];

    public function plays()
    {
        return $this->hasMany('App\Play', 'content_id')->where('plays.content_type', '=', 'radio-station');
    }
}
