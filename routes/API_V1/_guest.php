<?php


use Illuminate\Support\Facades\Route;


Route::get('/languages', 'LanguageController@indexUser');
Route::get('/messages/{locale}', 'LanguageController@appMessages');

// most of these routes are protected by a middlewre (middlewares > Guest.php)
// basically if the app requires the user to authenticate him self, he have to do that otherwise
// these routes are inaccessible.

Route::get('page', 'PageController@showPageByPath');
Route::get('/navigation-items', 'NavigationItemController@index');

Route::get('/search/{keyword}', 'HomeController@search');
Route::get('/podcast-genres', 'PodcastGenreController@index');
Route::get('/genres', 'GenreController@index');

Route::post('/contact-email', 'HomeController@sendContactEmail');
Route::post('/register-play', 'PlayController@anonymousPlay');

Route::get('/highlights', 'RadioStationController@highlights');
Route::get('/new-releases/{nb_rows}', 'SectionController@NewReleases');
Route::get('/more-from-artist/{artist_id}', 'SongController@moreFromArtist');
Route::get('/more-from-album/{album_id}', 'SongController@moreFromAlbum');
Route::get('/more-from-genre/{genre_id}', 'SongController@moreFromGenre');
Route::get('/latest-albums/{nb_rows}', 'SectionController@LatestAlbums');
Route::get('/popular-songs/{nb_rows}', 'SectionController@PopularSongs');
Route::get('/popular-podcasts/{nb_rows}', 'SectionController@PopularPodcasts');
Route::get('/latest-podcasts/{nb_rows}', 'SectionController@LatestPodcasts');
Route::get('/popular-albums/{nb_rows}', 'SectionController@PopularAlbums');
Route::get('/most-liked-songs/{nb_rows}', 'SectionController@MostLikedSongs');
Route::get('/charts', 'SectionController@charts');


Route::get('/match-genres/{keyword}', 'GenreController@matchGenres');
Route::get('/match-artists/{keyword}', 'ArtistController@matchArtists');
Route::get('/match-users/{keyword}', 'UserController@matchUsers');
Route::get('/match-songs/{keyword}', 'SongController@matchSongs');
Route::get('/match-radio-stations/{keyword}', 'RadioStationController@matchRadioStations');
Route::get('/match-albums/{keyword}', 'AlbumController@matchAlbums');
Route::get('/match-podcasts/{keyword}', 'PodcastController@matchPodcasts');
Route::get('/match-playlists/{keyword}', 'PlaylistController@matchPlaylists');

Route::get('/playlist/{id}', 'PlaylistController@show');
Route::get('/genre/{name}', 'GenreController@show');
Route::get('/podcast-genre/{name}', 'PodcastGenreController@show');
Route::get('/song/{id}', 'SongController@show');
Route::get('/podcast/{id}', 'PodcastController@show');
Route::get('/artist/{id}', 'ArtistController@show');
Route::get('/album/{id}', 'AlbumController@show');
Route::get('/profile/{id}', 'UserController@show');


Route::get('/genre-songs/{genre_id}', 'GenreController@songs');
Route::get('/podcast-genre-podcasts/{genre_id}', 'PodcastGenreController@podcasts');




// guests will be asked to login if they want to access these routes
Route::group(['middleware' => ['auth:api']], function () {
    Route::post('/like-song', 'UserController@likeSong');
    Route::post('/unlike-song', 'UserController@unlikeSong');
    Route::post('/follow-playlist', 'UserController@followPlaylist');
    Route::post('/unfollow-playlist', 'UserController@unFollowPlaylist');
    Route::post('/like-album', 'UserController@likeAlbum');
    Route::post('/unlike-album', 'UserController@unlikeAlbum');
    Route::post('/follow-podcast', 'UserController@followPodcast');
    Route::post('/unfollow-podcast', 'UserController@unfollowPodcast');
    Route::post('/follow-artist', 'UserController@followArtist');
    Route::post('/unfollow-artist', 'UserController@unfollowArtist');
    Route::post('/download-song/{id}', 'SongController@download');
    Route::post('/download-episode/{id}', 'EpisodeController@download');
});


