<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Section extends Model
{
    protected $fillable= ['title','content','endpoint','page_id','nb_labels','rank','content_type'];
    
    public function page()
    {
        return $this->belongsTo('App\Page');
    }
}
