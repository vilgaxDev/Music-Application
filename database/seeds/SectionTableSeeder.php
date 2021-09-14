<?php

use Illuminate\Database\Seeder;

use App\Section;

class SectionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Section::truncate();
        // seeding the default sections of the charts page ( charts id = 1)
        Section::create([
            'title' => 'Most played songs',
            'endpoint' => 'popular-songs',
            'content_type' => 'songs',
            'nb_labels' => 6,
            'page_id' => 1,
            'rank' => 0
        ]);
        Section::create([
            'title' => 'New Releases',
            'endpoint' => 'new-releases',
            'content_type' => 'songs',
            'nb_labels' => 6,
            'page_id' => 1,
            'rank' => 1
        ]);
        Section::create([
            'title' => 'Most liked songs',
            'endpoint' => 'most-liked-songs',
            'content_type' => 'songs',
            'nb_labels' => 6,
            'page_id' => 1,
            'rank' => 2
        ]);
        Section::create([
            'title' => 'Latest Albums',
            'endpoint' => 'latest-albums',
            'content_type' => 'albums',
            'nb_labels' => 6,
            'page_id' => 1,
            'rank' => 3
        ]);
        Section::create([
            'title' => 'Popular Podcasts',
            'endpoint' => 'popular-podcasts',
            'content_type' => 'podcasts',
            'nb_labels' => 6,
            'page_id' => 1,
            'rank' => 3
        ]);
        Section::create([
            'title' => 'Latest Podcasts',
            'endpoint' => 'latest-podcasts',
            'content_type' => 'podcasts',
            'nb_labels' => 6,
            'page_id' => 1,
            'rank' => 3
        ]);
    }
}
