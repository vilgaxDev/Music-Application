<?php

use App\Helpers\FileManager;
use Illuminate\Database\Seeder;
use App\PodcastGenre;
class PodcastGenreTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        PodcastGenre::truncate();


        // default podcast genres 
        
        PodcastGenre::create([
            'name' => 'Education',
            'slug' => 'education',
            'cover' => FileManager::generateFileData('/storage/defaults/images/podcast_genres/podcast-education.png'),
        ]);
        PodcastGenre::create([
            'name' => 'Gaming',
            'slug' => 'gaming',
            'cover' => FileManager::generateFileData('/storage/defaults/images/podcast_genres/podcast-gaming.png'),
        ]);
        PodcastGenre::create([
            'name' => 'Comedy',
            'slug' => 'comedy',
            'cover' => FileManager::generateFileData('/storage/defaults/images/podcast_genres/podcast-comedy.png'),
        ]);
        PodcastGenre::create([
            'name' => 'Health',
            'slug' => 'health',
            'cover' => FileManager::generateFileData('/storage/defaults/images/podcast_genres/podcast-health.png'),
        ]);
        PodcastGenre::create([
            'name' => 'Technology',
            'slug' => 'technology',
            'cover' => FileManager::generateFileData('/storage/defaults/images/podcast_genres/podcast-technology.png'),
        ]);
        PodcastGenre::create([
            'name' => 'Arts',
            'slug' => 'arts',
            'cover' => FileManager::generateFileData('/storage/defaults/images/podcast_genres/podcast-art.png'),
        ]);
    }
}
