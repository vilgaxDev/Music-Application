<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\URL;
use Illuminate\Support\Str;

use Carbon\Carbon;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    // get the base url of the app
    public function getUrl()
    {
        return URL::to('/');
    }
    // get the current admin user notifications
    public function notifications()
    {
        return auth()->user()->notifications()->where('type', 'App\\Notifications\\ArtistRequest')->get();
    }
    // generate sitemap for the website
    public function  generateSitemap()
    {
        // create new sitemap object
        $sitemap = \App::make("sitemap");

        // add items to the sitemap (url, date, priority, freq)
        $sitemap->add(URL::to('/'), Carbon::now(), '0.8', 'monthly');
        $sitemap->add(URL::to('/login'),  Carbon::now(), '0.3', 'monthly');
        $sitemap->add(URL::to('/register'),  Carbon::now(), '0.3', 'monthly');

        $sitemap->add(URL::to('/browse'), Carbon::now(), '0.8', 'monthly');

        if (\App\Setting::get('enableCharts')) {
            $sitemap->add(URL::to('/browse/charts'),  Carbon::now(), '0.5', 'monthly');
        }
        if (\App\Setting::get('enablePodcasts')) {
            $sitemap->add(URL::to('/podcasts'),  Carbon::now(), '0.9', 'monthly');
        }

        $pages = \App\Page::all();
        $songs = \App\Song::where('public', 1)->get();
        $playlists = \App\Playlist::where('public', 1)->get();
        $artists = \App\Artist::all();
        $genres = \App\Genre::all();
        $podcastGenres = \App\PodcastGenre::all();
        $albums = \App\Album::all();
        $podcasts = \App\Podcast::all();
        $users = \App\User::all();

        // generate a URL for each row
        foreach ($pages as $page) {
            $sitemap->add(URL::to('/') . $page->path, $page->updated_at, '0.9', 'daily');
        }
        foreach ($songs as $song) {
            $sitemap->add(URL::to('/') . '/song/' .  $song->id, $song->updated_at, '0.5', 'monthly');
        }
        foreach ($genres as $genre) {
            $sitemap->add(URL::to('/') . '/browse/genre/' .  Str::slug($genre->name), Carbon::now(), '0.8', 'daily');
        }
        foreach ($podcastGenres as $genre) {
            $sitemap->add(URL::to('/') . '/podcasts/' . Str::slug($genre->name), Carbon::now(), '0.9', 'daily');
        }
        foreach ($albums as $album) {
            $sitemap->add(URL::to('/') . '/album/' .  $album->id, $album->updated_at, '0.7', 'daily');
        }
        foreach ($podcasts as $podcast) {
            $sitemap->add(URL::to('/') . '/podcast/' .  $podcast->id, $podcast->updated_at, '0.7', 'daily');
        }
        foreach ($artists as $artist) {
            $sitemap->add(URL::to('/') . '/artist/' .  $artist->id, $artist->updated_at, '0.7', 'daily');
        }
        foreach ($playlists as $playlist) {
            $sitemap->add(URL::to('/') . '/playlist/' .  $playlist->id, $playlist->updated_at, '0.6', 'daily');
        }
        foreach ($users as $user) {
            $sitemap->add(URL::to('/') . '/profile/' .  $user->id, $user->updated_at, '0.5', 'daily');
        }
        // generate your sitemap (format, filename)
        return $sitemap->store('xml', 'sitemap');
    }
}
