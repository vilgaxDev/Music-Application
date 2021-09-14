<?php

namespace App\Http\Controllers;

use App\Episode;
use Illuminate\Http\Request;
use App\Http\Resources\SongResource;
use App\Song;
use FileManager;
use App\SongPlay;
use App\EpisodePlay;
use App\Events\HearingEvent;
use App\Exceptions\FEException;
use App\Helpers\Functions;
use App\Play;
use App\Setting;

class SongController extends Controller
{
    /**
     * Get all the songs.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return SongResource::collection(\App\Song::orderBy('created_at', 'desc')->get());
    }
    /**
     * Get all the songs for the current logged artist.
     *
     * @return \Illuminate\Http\Response
     */
    public function artistIndex()
    {
        return SongResource::collection(auth()->user()->artist->songs);
    }
    /**
     * Get all the songs for the current logged user.
     *
     * @return \Illuminate\Http\Response
     */
    public function userIndex()
    {
        return SongResource::collection(Song::where('user_id', auth()->id())->where('uploaded_by', 'user')->orderBy('created_at', 'desc')->get());
    }
    /**
     * Matches the songs based on the given keyword.
     *
     * @param  $keyword
     * @return \Illuminate\Http\Response
     */
    public function matchSongs($keyword)
    {
        return SongResource::collection(Song::where('title', 'like', '%' . $keyword . '%')->where('public', 1)->get());
    }
    /**
     * Matches the songs based on the given keyword for a certain artist.
     *
     * @param  $keyword
     * @return \Illuminate\Http\Response
     */
    public function matchArtistSongs($keyword)
    {
        return SongResource::collection(Song::where('title', 'like', '%' . $keyword . '%')->where('public', 1)->where('artist_id', auth()->user()->artist->id)->get());
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
            'title' => 'required|max:255|min:1|string',
        ]);
        if( $request->uploaded_by  === 'artist' ) {
            $available_space = auth()->user()->artist->available_disk_space;
            $used_space = auth()->user()->artist->used_disk_space();
            if (($request->file_size || 0) + $used_space > ($available_space * 1024 * 1024)) {
                throw new FEException('You have exceeded your space limit', '', 400);        
            }
        } else if ( $request->uploaded_by  === 'user' ) {
            $used_space = auth()->user()->used_disk_space();
            // checking the storage space given by the plan
            if ($sub = auth()->user()->active_subscription()->first()) {
                $user_plan = $sub->plan;
            }
            if (isSet($user_plan)) {
                $available_space = auth()->user()->available_disk_space > $user_plan->storage_space  ? auth()->user()->available_disk_space : $user_plan->storage_space;
            } else {
                $available_space = auth()->user()->available_disk_space;
            }
            if (($request->file_size || 0) + $used_space > ($available_space * 1024 * 1024)) {
                throw new FEException('You have exceeded your space limit', '', 400);        
            }
        }

        $song = new Song();
        $cover =  FileManager::store($request, '/covers/songs/', 'cover');
        if ($request->source_format === 'file') {
            if ($request->file('source')) {
                $file_name = $request->file('source')->getClientOriginalName();
                $file_size = $request->file_size;
                $source = FileManager::store($request, '/audios/songs/', 'source');
            } else {
                $request->validate([
                    'source' => 'required',
                ]);
            }
        } else if ($request->source_format === 'yt_video') {
            if ($request->source) {
                $source = json_encode($request->source);
                $file_name = null;
                $file_size = null;
            } else {
                $request->validate([
                    'source' => 'required',
                ]);
            }
        }

        $song->title = $request->title;
        $song->uploaded_by = $request->uploaded_by;
        $song->public = $request->public;
        $song->artist_id = $request->artist_id;
        $song->user_id = auth()->user()->id;
        $song->album_id = $request->album_id;
        $song->source_format = $request->source_format;
        $song->file_name = $file_name;
        $song->source = $source;
        $song->cover = $cover;
        $song->file_size = $file_size;
        $song->duration = $request->duration;
        $song->artists = $request->artists;

        $song->save();

        if (isset($request->genres)) {
            foreach (json_decode($request->genres) as $genre) {
                $song->genres()->attach($genre->id);
            }
        }
        return response()->json(new SongResource($song), 201);
    }
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Song  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|max:255',
        ]);
        $song = Song::find($id);
        if ($request->file('cover')) {
            $song->cover = FileManager::update($request->file('cover'), $song->cover, '/covers/songs/');
        }

        if ($request->source_format === 'file') {
            if ($request->file('source')) {
                $source = FileManager::update($request->file('source'), $song->source, '/audios/songs/');
                $file_name = $request->file('source')->getClientOriginalName();
                $file_size = $request->file_size;
                $song->file_size = $file_size;
                $song->file_name = $file_name;
                $song->source = $source;
            } else if( !$song->source ) {
                $request->validate([
                    'source' => 'required',
                ]);
            }
        } else if ($request->source_format === 'yt_video') {
            if ($request->source) {
                // delete audio file if it exists
                if ($song->source_format === 'file') {
                    FileManager::delete($song->source);
                }
                $source = json_encode($request->source);
                $file_name = null;
                $file_size = null;
                $song->file_name = $file_name;
                $song->file_size = $file_size;
                $song->source = $source;
            } else if(!$song->source ){
                $request->validate([
                    'source' => 'required',
                ]);
            }
        }

        $song->title = $request->title;
        $song->public = $request->public;
        $song->source_format = $request->source_format;
        $song->duration = $request->duration;
        $song->artist_id = $request->artist_id;
        $song->artists = $request->artists;
        $song->save();
        // reset genres
        \DB::table('genre_song')->where('song_id', $song->id)->delete();
        if (isset($request->genres)) {
            foreach (json_decode($request->genres) as $genre) {
                $song->genres()->attach($genre->id);
            }
        }
        return response()->json(new SongResource($song), 200);
    }
    /**
     * Display the specified resource (fetch the data for the frontend).
     *
     * @param  \App\Song  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $song = Song::find($id);
        if ($song) {
            return new SongResource($song);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }
    /**
     * Download a song.
     *
     * @param  \App\Song  $id
     * @return \Illuminate\Http\Response
     */
    function download($id)
    {
        $song = Song::find($id);
        $file = FileManager::download($song);
        $song->download_count++;
        $song->save();
        return $file;
    }
    /**
     * Make the given song public.
     *
     * @param  \App\Song  $id
     * @return \Illuminate\Http\Response
     */
    public function makePublic($id)
    {
        $song = Song::find($id);
        $song->public = 1;
        $song->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Make the given song private.
     *
     * @param  \App\Song  $id
     * @return \Illuminate\Http\Response
     */
    public function makePrivate($id)
    {
        $song = Song::find($id);
        if ($song->user_id == auth()->id()) {
            $song->public = 0;
            $song->save();
            return response()->json(['message' => 'SUCCESS'], 200);
        } else {
            return response()->json(null, 403);
        }
    }
    /**
     * Get the liked songs by the current logged user.
     *
     * @return \Illuminate\Http\Response
     */
    public function songsLikedByUser()
    {
        $likes = \App\SongLike::where('user_id', \Auth::user()->id)->with('song')->get()->pluck('song');
        return $likes;
    }
    /**
     * Get more songs from a certain artist.
     * @param $artist_id
     * @return \Illuminate\Http\Response
     */
    public function moreFromArtist($artist_id)
    {
        return SongResource::collection(\App\Artist::find($artist_id)->songs()->orderBy('created_at')->get());
    }
    /**
     * Get more songs from a certain album.
     * @param $album_id
     * @return \Illuminate\Http\Response
     */
    public function moreFromAlbum($album_id)
    {
        return SongResource::collection(\App\Album::find($album_id)->songs()->orderBy('created_at')->get());
    }
    /**
     * Get more songs from a certain genre.
     * @param $genre_id
     * @return \Illuminate\Http\Response
     */
    public function moreFromGenre($genre_id)
    {
        return SongResource::collection(\App\Genre::find($genre_id)->songs()->orderBy('created_at')->where('public', 1)->get());
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Song  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $song = Song::find($id);
        $song->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
