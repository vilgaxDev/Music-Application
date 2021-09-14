<?php

namespace App\Http\Controllers;

use App\Playlist;
use FileManager;
use App\Http\Resources\PlaylistResource;
use Illuminate\Http\Request;

class PlaylistController extends Controller
{
    /**
     * Matches the playlists based on the given keyword.
     *
     * @param  $keyword
     * @return \Illuminate\Http\Response
     */
    public function matchPlaylists($keyword)
    {
        return PlaylistResource::collection(Playlist::where('title', 'like', '%' . $keyword . '%')->get());
    }
    /**
     * Get all the playlists.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return PlaylistResource::collection(\App\Playlist::orderBy('created_at', 'desc')->get());
    }
    /**
     * Display the specified resource (fetch the data for the frontend).
     *
     * @param  \App\Playlist  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $playlist = Playlist::find($id);
        if ($playlist) {
            return new PlaylistResource($playlist);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }
    /**
     * Detach a specific song from a playlist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function detachSong(Request $request)
    {
        $playlist = Playlist::find($request->playlist_id);
        $playlist->songs()->detach($request->song_id);
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Attach a specific song from a playlist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function attachSong(Request $request)
    {
        $playlist = Playlist::find($request->playlist_id);
        $playlist->songs()->attach($request->song_id);
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * store the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|max:255',
        ]);
        $user = \Auth::user();

        $cover = FileManager::store($request, '/covers/playlists/', 'cover');

        $playlist = Playlist::create([
            'title' => $request->title,
            'created_by' => $request->created_by,
            'user_id' => $user->id,
            'public' => $request->public,
            'cover' => $cover,
        ]);

        return response()->json(['id' => $playlist->id], 201);
    }
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Playlist  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $request->validate([
            'title' => 'required|max:255',
        ]);
        
        $playlist = Playlist::find($request->playlist_id);

        if ($request->file('cover')) {
            $playlist->cover = FileManager::update($request->file('cover'), $playlist->cover, '/covers/playlists/');
        }

        $playlist->title = $request->title;
        $playlist->public = $request->public;
        $playlist->save();

        return response()->json(null, 200);
    }
    /**
     * Make the given playlist public.
     *
     * @param  \App\Playlist  $id
     * @return \Illuminate\Http\Response
     */
    public function makePublic($id)
    {
        $playlist = playlist::find($id);
        if ($playlist->user_id == auth()->id()) {
            $playlist->public = 1;
            $playlist->save();
            return response()->json(null, 200);
        } else {
            return response()->json(null, 403);
        }
    }
    /**
     * Make the given playlist private.
     *
     * @param  \App\Playlist  $id
     * @return \Illuminate\Http\Response
     */
    public function makePrivate($id)
    {
        $playlist = playlist::find($id);
        $playlist->public = 0;
        $playlist->save();
        return response()->json(null, 200);
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Playlist  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $playlist = Playlist::find($id);
        $playlist->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
