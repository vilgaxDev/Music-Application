<?php

use Illuminate\Support\Facades\Route;



// single page application main route

Route::get('{any}', "HomeController@SPA")->where('any', '^(?!api).*$');


