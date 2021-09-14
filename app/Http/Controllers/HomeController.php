<?php

namespace App\Http\Controllers;

use App\Setting;
use Illuminate\Support\Facades\Session;
use Carbon\Carbon;
use Browser;
use Illuminate\Http\Request;
use App\Http\Resources\UserResource;
use App\Http\Resources\ArtistResource;
use App\Http\Resources\PlaylistResource;
use App\Http\Resources\PodcastResource;
use App\Http\Resources\GenreResource;
use App\Http\Resources\SongResource;
use App\Http\Resources\AlbumResource;
use App\Http\Resources\RadioStationResource;
use App\Language;
use App\Mail\contactMail;
use Illuminate\Support\Facades\Mail;

class HomeController extends Controller
{
    /**
     * This the search engine function: search through the database 
     * for all the matching rows based on the given keyword.
     * @param  $keyword
     * @return \Illuminate\Http\Response
     */
    public function search($keyword)
    {
        $results = new \stdClass();
        $users = UserResource::collection(\App\User::where('name', 'like', $keyword . '%')->get());
        $songs = SongResource::collection(\App\Song::where('title', 'like', $keyword . '%')->where('public', 1)->get());
        $radioStations = RadioStationResource::collection(\App\RadioStation::where('name', 'like', $keyword . '%')->get());
        $albums = AlbumResource::collection(\App\Album::where('title', 'like', $keyword . '%')->get());
        $podcasts = PodcastResource::collection(\App\Podcast::where('title', 'like', $keyword . '%')->get());
        $genres = GenreResource::collection(\App\Genre::where('name', 'like', $keyword . '%')->get());
        $artists = ArtistResource::collection(\App\Artist::where('displayname', 'like', $keyword . '%')->get());
        $playlists = PlaylistResource::collection(\App\Playlist::where('title', 'like', $keyword . '%')->where('public', 1)->get());
        $results->users = $users;
        $results->radioStations = $radioStations;
        $results->songs = $songs;
        $results->albums = $albums;
        $results->playlists = $playlists;
        $results->artists = $artists;
        $results->genres = $genres;
        if (Setting::get('enablePodcasts')) {
            $results->podcasts = $podcasts;
        }
        return response()->json($results, 200);
    }
    /**
     * Update the location of the user which is stored on the session.
     * @return \Illuminate\Http\Response
     */
    static function updateLocation()
    {
        $position = \Location::get();
        if ($position) {
            if (\DB::table('visiting_countries')->where('name', $position->countryName)->first()) {
                \DB::table('visiting_countries')->where('name', $position->countryName)->increment('visitors');
            } else {
                \DB::table('visiting_countries')->insert([
                    'name' => $position->countryName ? $position->countryName : '',
                    'visitors' => 1
                ]);
            }
            if (\DB::table('visiting_browsers')->where('name', Browser::browserFamily())->first()) {
                \DB::table('visiting_browsers')->where('name', Browser::browserFamily())->increment('visitors');
            } else {
                \DB::table('visiting_browsers')->insert([
                    'name' => Browser::browserFamily(),
                    'visitors' => 1
                ]);
            }
            Session::put('current_ip', $position->ip);
            Session::put('location_updated_at', Carbon::now()->addMinutes(15));
        }
    }
    /**
     * Checks if session time has exprired ( 15 mins ).
     * @return \Illuminate\Http\Response
     */
    static function checkSessionTime()
    {
        if (Session::get('location_updated_at') <= Carbon::now()) {
            self::updateLocation();
        }
    }
    /**
     * Returns the single page of the application ( check the blade file SPA  )
     *  with the necessary data: app settings, favicon, themes and title of the page.
     * @return \Illuminate\Http\Response
     */
    public function SPA()
    {
        if (!file_exists(storage_path('installed'))) {
            return redirect()->route('LaravelInstaller::welcome');
        }
        if (!Session::get('current_ip')) {
            self::updateLocation();
        } else {
            self::checkSessionTime();
        }

        return view('SPA', [
            'settings' => Setting::getPublicSettings(),
            'title' => str_replace('%site_name', Setting::get('appName'), Setting::get('siteTitle')),
            'themes' => json_decode(Setting::get('themes'), true),
            'locale' => Language::default()
        ]);
    }
    /**
     * Send a contact email from a guest/user.
     * @return \Illuminate\Http\Response
     */
    public function sendContactEmail(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'subject' => 'required|min:4',
            'message' => 'required'
        ]);

        Mail::to(Setting::get('contactEmailAddress'))->send(new contactMail($request->all()));

        return response()->json(['message' => 'SUCCESS'], 200);
    }
    }
