<?php


use Illuminate\Support\Facades\Route;

// this file contains all the artist routes


//Route::group(['middleware' => 'demo'], function() {});


Route::apiResources(
    [
        'albums' => AlbumController::class,
        'songs' => SongController::class,
        'podcasts' => PodcastController::class,
        'episodes' => EpisodeController::class,
    ],
    [
        'except' => ['index']
    ]
);


// shared routes
Route::post('/attach-to-album', 'AlbumController@attachSong');
Route::post('/detach-from-album', 'AlbumController@detachSong');



// exclusive routes
Route::group(['prefix' => 'artist'], function () {

    Route::post('/save-personal-infos', 'ArtistController@savePersonalInfos');
    Route::get('/analytics', 'AnalyticsController@artistIndex');
    Route::get('/plays/{duration}', 'AnalyticsController@getArtistPlays');
    Route::get('/', 'ArtistController@account');
    Route::get('/match-songs/{keyword}', 'SongController@matchArtistSongs');
    Route::get('songs', 'SongController@artistIndex');
    Route::get('albums', 'AlbumController@artistIndex');
    Route::get('podcasts', 'PodcastController@artistIndex');
    Route::get('episodes', 'EpisodeController@artistIndex');
});
