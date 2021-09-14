<?php


use Illuminate\Support\Facades\Route;




// this file contains the routes accessible by logged users


Route::get('/messages', 'ChatController@messages');
Route::get('/plans', 'PlanController@userIndex');
Route::post('/check-friendship-status', 'FriendshipController@checkFriendshipStatus');
Route::post('/sessions/{session}/chats', 'ChatController@chats');
Route::post('/sessions/{session}/read', 'ChatController@read');

Route::post('/subscribe', 'UserController@subscribe');
Route::post('/messages', 'ChatController@sendMessage');
Route::post('/sessions/create', 'SessionController@create');

Route::post('/sessions/{session}/clear', 'ChatController@clear');
Route::post('/sessions/{session}/block', 'BlockController@block');
Route::post('/sessions/{session}/unblock', 'BlockController@unblock');
Route::post('/send/{session}', 'ChatController@send');

Route::post('/add-friend', 'FriendshipController@requestFriendship');
Route::post('/remove-friend', 'FriendshipController@removeFriend');

Route::post('/make-song-public/{id}', 'SongController@makePublic');
Route::post('/make-song-private/{id}', 'SongController@makePrivate');

Route::post('/make-playlist-public/{id}', 'PlaylistController@makePublic');
Route::post('/make-playlist-private/{id}', 'PlaylistController@makePrivate');

Route::post('/attach-to-playlist', 'PlaylistController@attachSong');
Route::post('/detach-from-playlist', 'PlaylistController@detachSong');





Route::group(['prefix' => 'user'], function () {

    Route::get('/', 'UserController@account');
    Route::post('/register-play', 'PlayController@userPlay');
    Route::post('/end-play', 'PlayController@endPLay');
    Route::get('/liked-songs', 'UserController@likedSongs');
    Route::get('/liked-albums', 'UserController@likedAlbums');
    Route::get('/followed-podcasts', 'UserController@followedPodcasts');
    Route::get('/followed-playlists', 'UserController@followedPlaylists');
    Route::get('/playlists', 'UserController@playlists');
    Route::get('/followed-artists', 'UserController@followedArtists');
    Route::get('/recent-plays', 'UserController@recentPlays');
    Route::get('/friends', 'FriendshipController@getFriends');
    Route::get('/notifications', 'UserController@notifications');
    Route::get('songs', 'SongController@userIndex');


    Route::apiResource('songs', SongController::class)->only(['store', 'destroy']);
    Route::apiResource('playlists', PlaylistController::class)->except(['index']);
    Route::post('/save-account-settings', 'UserController@saveAccountSettings');
    Route::post('/cancel-subscritpion', 'UserController@cancelSubscriptionRequest');
    Route::post('/request-artist-account', 'UserController@requestArtistAccount');
    Route::post('/accept-friendship', 'FriendshipController@acceptFriendship');
    Route::post('/reject-friendship', 'FriendshipController@rejectFriendship');
    Route::post('/request-artist', 'UserController@requestArtist');
});

Route::post('/logout', 'AuthController@logout');
