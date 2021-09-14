<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\PodcastResource;
use App\Podcast;
use FileManager;

class PodcastController extends Controller
{
    /**
     * Display the specified resource (fetch the needed data for the frontend).
     *
     * @param  \App\Podcast  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $podcast = Podcast::find($id);
        if ($podcast) {
            return new PodcastResource($podcast);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return PodcastResource::collection(\App\Podcast::orderBy('created_at', 'desc')->get());
    }
    /**
     * Display a listing of the resource for the current logged artist.
     *
     * @return \Illuminate\Http\Response
     */
    public function artistIndex()
    {
        return PodcastResource::collection(\Auth::user()->artist->podcasts()->orderBy('created_at', 'desc')->get());
    }
    /**
     * Matches the podcasts based on the given keyword.
     *
     * @param  $keyword
     * @return \Illuminate\Http\Response
     */
    public function matchPodcasts($keyword)
    {
        return PodcastResource::collection(Podcast::where('title', 'like', '%' . $keyword . '%')->get());
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Podcast  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $podcast = Podcast::find($id);
        $podcast->delete();
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
            'title' => 'required|max:255'
        ]);
        $cover = FileManager::store($request, '/covers/podcasts/', 'cover');
        $podcast = Podcast::create([
            'title' => $request->title,
            'description' => isset($request->description) ? $request->description : '',
            'artist_id' => $request->artist_id ? $request->artist_id : null,
            'cover' => $cover
        ]);
        if (json_decode($request->genres)) {
            foreach (json_decode($request->genres) as $genre) {
                $podcast->genres()->attach($genre->id);
            }
        }
        return response()->json(null, 202);
    }
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Podcast  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|max:255'
        ]);
        
        $podcast = Podcast::find($id);
        if ($request->file('cover')) {
            $podcast->cover = FileManager::update($request->file('cover'), $podcast->cover, '/covers/podcasts/');
        }
        $podcast->title = $request->title;
        $podcast->artist_id = $request->artist_id ? $request->artist_id : null;
        $podcast->description = isset($request->description) ? $request->description : '';
        $podcast->save();
        // reset genres
        \DB::table('genre_podcast')->where('podcast_id', $podcast->id)->delete();
        if (json_decode($request->genres)) {
            foreach (json_decode($request->genres) as $genre) {
                $podcast->genres()->attach($genre->id);
            }
        }
        return response()->json(null, 202);
    }
}
