<?php

namespace App\Traits;


use App\Http\Resources\AlbumResource;
use App\Http\Resources\SongResource;
use App\Http\Resources\PodcastResource;

trait SectionContentTrait
{

    /**
     * Get the most liked songs.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionMostLikedSongs($nb_rows)
    {
        return SongResource::collection(\App\Song::withCount('likes')->where('public', 1)->having('likes_count', '>', 0)->orderBy('likes_count', 'desc')->take($nb_rows)->get());
    }

    /**
     * Get the new released songs.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionNewReleases($nb_rows)
    {
        return SongResource::collection(\App\Song::where('public', 1)->orderBy('created_at', 'desc')->take($nb_rows)->get());
    }

    /**
     * Get the most popular songs ( most played ).
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionPopularSongs($nb_rows)
    {
        return SongResource::collection(\App\Song::withCount('plays')->where('public', 1)->orderBy('plays_count', 'desc')->take($nb_rows)->get());;
    }

    /**
     * Get the most popular albums ( most played ).
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionPopularAlbums($nb_rows)
    {
        return AlbumResource::collection(\App\Album::withCount('likes')->orderBy('likes_count', 'desc')->take($nb_rows)->get());;
    }

    /**
     * Get the latest released albums.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionLatestAlbums($nb_rows)
    {
        return AlbumResource::collection(\App\Album::orderBy('created_at', 'desc')->take($nb_rows)->get());;
    }

    /**
     * Get the most popular podcasts.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionPopularPodcasts($nb_rows)
    {
        return PodcastResource::collection(\App\Podcast::withCount('follows')->orderBy('follows_count', 'desc')->take($nb_rows)->get());;
    }

    /**
     * Get the latest released podcasts.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function sectionLatestPodcasts($nb_rows)
    {
        return PodcastResource::collection(\App\Podcast::orderBy('created_at', 'desc')->take($nb_rows)->get());;
    }
}
