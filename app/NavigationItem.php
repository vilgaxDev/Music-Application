<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class NavigationItem extends Model {

    /**
    * the attributes that are mass assignable.
    * @var array
    */ 
    protected $fillable = ['name','icon','visibility','custom','rank','path','page_id','navigatesTo'];

    public function page()
    {
        return $this->belongsTo('App\Page');
    }
}
