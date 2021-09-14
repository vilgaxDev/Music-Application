<?php

namespace App\Http\Controllers;

use App\Album;
use App\Song;

use FileManager;

use App\Http\Resources\AlbumResource;

use Illuminate\Http\Request;

class AlbumController extends Controller
{

    /**
     * Get all the albums.
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        return AlbumResource::collection(\App\Album::orderBy('created_at', 'desc')->get());
    }

    /**
     * Get all the current logged artist albums.
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function artistIndex()
    {
        return AlbumResource::collection(\Auth::user()->artist->albums()->orderBy('created_at', 'desc')->get());
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Album  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $album = Album::find($id);
        if ($album) {
            return new AlbumResource($album);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }

    /**
     * Matches the albums based on the given keyword.
     *
     * @param  $keyword
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function matchAlbums($keyword)
    {
        return AlbumResource::collection(Album::where('title', 'like', '%' . $keyword . '%')->get());
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
            'artist_id' => 'required',
            'release_date' => 'required',
            'cover' => 'required'
        ]);

        $cover = FileManager::store($request, '/covers/albums/', 'cover');

        Album::create([
            'title' => $request->title,
            'release_date' => $request->release_date,
            'artist_id' => $request->artist_id,
            'created_by' => $request->created_by,
            'cover' => $cover,
        ]);

        return response()->json(null, 202);
    }
    
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Album  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|max:255',
            'release_date' => 'required',
            'artist_id' => 'required'
        ]);

        $album = Album::find($id);

        if ($request->file('cover')) {
            $album->cover = FileManager::update($request->file('cover'), $album->cover, '/covers/albums/');
        }

        $album->title = $request->title;
        $album->release_date = $request->release_date;
        $album->artist_id = $request->artist_id;

        foreach ($album->songs as $song) {
            if (strpos($song->cover, '/covers/albums')) {
                $song->cover = $album->cover;
                $song->save();
            }
        }
        $rank = 0;
        foreach (json_decode($request->songs) as $unranked_song) {
            $song = \App\Song::find($unranked_song);
            if ($song) {
                $song->rank_on_album = $rank;
                $song->save();
                $rank = $rank + 1;
            }
        }

        $album->save();
        return response()->json(null, 202);
    }

    /**
     * Detach a specific song from an album.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function detachSong(Request $request)
    {
        $song  = Song::find($request->song_id);
        $song->album_id = null;
        $song->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }

    /**
     * Attach a specific song from an album.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function attachSong(Request $request)
    {
        $song  = Song::find($request->song_id);
        $song->album_id = $request->album_id;
        $song->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Album  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $album = Album::find($id);
        $album->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
