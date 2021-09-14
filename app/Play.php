<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Play extends Model
{
    protected $fillable = ['content_type', 'content_id', 'user_id'];

}
