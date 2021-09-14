<?php

use Illuminate\Database\Seeder;

use App\Page;
class PageTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Page::truncate();
        // seeding the default Pages
        Page::create([
            'name' => 'charts',
            'title' => 'Charts',
            'description' => '',
            'icon' => '',
            'path' => '/browse/charts',
        ]);
        Page::create([
            'name' => 'home',
            'title' => 'Explore',
            'description' => 'Explore & enjoy listening to music',
            'icon' => 'home',
            'path' => '/home',
        ]);
    }
}
