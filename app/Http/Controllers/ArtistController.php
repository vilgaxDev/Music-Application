<?php

namespace App\Http\Controllers;

use App\Artist;
use App\ArtistFollow;
use FileManager;
use Illuminate\Http\Request;

use App\Http\Resources\SongResource;
use App\Http\Resources\ArtistResource;
use App\Http\Resources\profiles\ArtistResource as ArtistProfileResource;
use App\Http\Resources\PodcastResource;

class ArtistController extends Controller
{
    /**
     * Get the artist account informations of the current logged user.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function account(Request $request)
    {
        if ($request->user()->artist) {
            return new ArtistResource($request->user()->artist);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }
    /**
     * Get the artist data to display the profile.
     *
     * @param  \App\Artist  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $artist = Artist::find($id);
        if ($artist) {
            return new ArtistProfileResource($artist);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }
    /**
     * Get all the artists.
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        return ArtistResource::collection(Artist::orderBy('created_at', 'desc')->get());
    }
    /**
     * Get all the Podcasts.
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function podcasts()
    {
        return PodcastResource::collection(\Auth::user()->artist->podcasts);
    }
    /**
     * Match the artists based for the gives keyword ( search ).
     * @param $keyword
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function matchArtists($keyword)
    {
        return ArtistResource::collection(Artist::where('displayname', 'like', '%' . $keyword . '%')->get());
    }
    /**
     * Get the latest songs for the given artist.
     * @param $artist
     * @return \Illuminate\Http\Response
     */
    public function latest($artist)
    {
        return new SongResource($artist->song()->sortByDesc('created_at')->first());
    }
    /**
     * Get the popular songs for the given artist.
     * @param $artist
     * @return \Illuminate\Http\Response
     */
    public function popular($artist)
    {
        $songs = $artist->songs()->withCount('plays')->orderBy('plays_count', 'desc')->take(5)->get();
        return $songs;
    }
    /**
     * Get the most liked songs for the given artist.
     * @param $artist
     * @return \Illuminate\Http\Response
     */
    public function most_liked($artist)
    {
        $songs = $artist->songs()->withCount('likes')->orderBy('likes_count', 'desc')->get();
        return $songs;
    }
    /**
     * Updates the personal informations of the user.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function savePersonalInfos(Request $request)
    {

        if ($id = $request->id) {
            $request->validate([
                'firstname' => 'required|min:3',
                'lastname' => 'required|min:3',
                'displayname' => 'required|min:3|unique:artists,displayname,' . $id
            ]);
            $artist = Artist::find($id);
            if ($request->file('avatar')) {
                $artist->avatar = FileManager::update($request->file('avatar'), $artist->avatar, '/avatars/users/');
            }
            $artist->firstname = $request->firstname;
            $artist->lastname = $request->lastname;
            $artist->displayname = $request->displayname;
            $artist->save();
            return response()->json(null, 202);
        } else {
            $request->validate([
                'firstname' => 'required|min:3',
                'lastname' => 'required|min:3',
                'displayname' => 'required|min:3|unique:artists'
            ]);
            if ($request->avatar) {
                if ($request->file('avatar')) {
                    $avatar = FileManager::store($request, '/avatars/artists/', 'avatar');
                } else {
                    $avatar = FileManager::generateFileData($request->avatar);
                }
            }
            Artist::create([
                'firstname' => $request->firstname,
                'lastname' => $request->lastname,
                'user_id' => \Auth::user()->id,
                'displayname' => $request->displayname,
                'avatar' => $avatar
            ]);
            return response()->json(null, 201);
        }
    }
    /**
     * Checks if the current user followed the corresponding artist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function isArtistFollowed(Request $request)
    {
        $user_id = $request->user_id;
        $artist_id = $request->artist_id;
        $follow = ArtistFollow::where('user_id', $user_id)->where('artist_id', $artist_id)->first();
        if ($follow) {
            return 'true';
        } else {
            return 'false';
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
            'displayname' => 'required|min:2|unique:artists',
        ]);
        $avatar = FileManager::store($request, '/avatars/artists/', 'avatar');
        Artist::create([
            'firstname' =>  $request->firstname,
            'lastname' =>  $request->lastname,
            'displayname' =>  $request->displayname,
            'available_disk_space' => $request->available_disk_space,
            'avatar' => $avatar
        ]);
        return response()->json(null, 201);
    }

    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Artist  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'displayname' => 'required|min:2|unique:artists,displayname,' . $id,
        ]);
        $artist = Artist::find($id);
        if ($request->file('avatar')) {
            $artist->avatar = FileManager::update($request->file('avatar'), $artist->avatar, '/avatars/artists/');
        }
        $artist->firstname = $request->firstname;
        $artist->lastname = $request->lastname;
        $artist->displayname = $request->displayname;
        $artist->available_disk_space = $request->available_disk_space;
        $artist->save();
        return response()->json(null, 202);
    }
    
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Artist  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $artist = Artist::find($id);
        $artist->delete();
        return response()->json(null, 202);
    }
}
