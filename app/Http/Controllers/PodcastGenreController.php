<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\PodcastGenre;
use App\Http\Resources\PodcastGenreResource;
use App\Http\Resources\PodcastResource;
use FileManager;

class PodcastGenreController extends Controller
{
    /**
     * Get all the podcast genres.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return PodcastGenreResource::collection(PodcastGenre::all());
    }
    /**
     * Get all the genre podcasts.
     * @param  $genre_name
     * @return \Illuminate\Http\Response
     */
    public function podcasts($genre_name)
    {
        return PodcastResource::collection(PodcastGenre::where('name', 'like', '%' . \Str::slug($genre_name) . '%')->first()->podcasts);
    }
    /**
     * Display the specified resource (fetch the data for the frontend).
     *
     * @return \Illuminate\Http\Response
     */
    public function show($name)
    {
        $podcastGenre = PodcastGenre::where('name', 'like', '%' . \Str::slug($name) . '%')->first();
        if ($podcastGenre) {
            return new PodcastGenreResource($podcastGenre);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
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
            'name' => 'required|min:1|max:15|string',
            'slug' => 'required|unique:podcast_genres'
        ]);
        $cover = FileManager::store($request, '/covers/podcast-genres/', 'cover');
        PodcastGenre::create([
            'name' => $request->name,
            'cover' => $cover,
            'slug' => $request->slug,
        ]);
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\PodcastGenre  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|min:1|max:15|string',
            'slug' => 'required|unique:podcast_genres,slug,' . $id
        ]);

        $genre = PodcastGenre::find($id);
        if ($request->file('cover')) {
            $genre->cover = FileManager::update($request->file('cover'), $genre->cover, '/covers/podcast-genres/');
        }
        $genre->name = $request->name;
        $genre->slug = $request->slug;
        $genre->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\PodcastGenre  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $genre = PodcastGenre::find($id);
        $genre->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
