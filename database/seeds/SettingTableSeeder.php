<?php

use Illuminate\Database\Seeder;
use App\Setting;

class SettingTableSeeder extends Seeder
{

    public function run()
    {
        Setting::truncate();

        // the default SEO settings
        $seo_defaults =
            [
                'siteTitle' => '%site_name — Play Music Anywhere & Anytime',
                'siteDescription' => '%site_name — Play Music Anywhere & Anytime',
                'homePageTitle' => 'Explore & listen | %site_name',
                'homePageDescription' => 'Explore & start listening to pure music on %site_name',
                'browsePageTitle' => 'Browse & discover music | %site_name',
                'browsePageDescription' => 'Discover & enjoy listening to pure music on %site_name',
                'podcastsPageTitle' => 'Podcasts | %site_name',
                'podcastsPageDescription' => 'Discover & enjoy listening to podcasts on %site_name',
                'artistPageDescription' => 'Enjoy hearing %artist_name  on %site_name for free',
                'artistPageTitle' => '%artist_name | Play on %site_name',
                'songPageTitle' => '%song_title — %artist_name | Play On %site_name',
                'songPageDescription' => '%creation_date — Play %song_name on %site_name for free',
                'albumPageTitle' => '%artist_name — %album_title | Play on %site_name',
                'albumPageDescription' => 'Play & enjoy %album_title album by %artist_name on %site_name',
                'podcastPageTitle' => '%artist_name — %podcast_title | Play on %site_name',
                'podcastPageDescription' => 'Play & enjoy %podcast_title podcast by %artist_name on %site_name',
                'playlistPageTitle' => '%playlist_title | Play on %site_name',
                'playlistPageDescription' => 'Play & enjoy %playlist_title playlist by %user_name on %site_name',
                'genrePageTitle' => 'Top %genre_name music | Play on %site_name',
                'genrePageDescription' => 'Play & enjoy %genre_name music on %site_name',
                'podcastGenrePageTitle' => 'Top %podcast-genre_name podcasts | Play on %site_name',
                'podcastGenrePageDescription' => 'Play & enjoy %podcast-genre_name podcasts on %site_name',
                'userProfilePageTitle' => '%user_name | %site_name',
                'userProfilePageDescription' => 'Check %user_name profile on %site_name'
            ];
        // Seeding the app default settings
        Setting::create([
            'key' => 'appName',
            'value' => config('app.name'),
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'locale',
            'value' => 'en',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'appUrl',
            'value' => config('app.url'),
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'appLogoLight',
            'value' => '/storage/defaults/images/logo_light.png',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'appLogoDark',
            'value' => '/storage/defaults/images/logo_dark.png',
            'public' => 1,
        ]);
        // Setting::create([
        //     'key' => 'appFavicon',
        //     'value' => '/storage/defaults/images/favicon.png',
        //     'public' => 1,
        // ]);
        Setting::create([
            'key' => 'allowThemeChange',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableLandingPage',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enablePodcasts',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableBrowse',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableAds',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'allowArtistAccountRequests',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'requireAuth',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'disableRegistration',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'allowVideos',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'hideRightSidebar',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'playerVolume',
            'value' => 50,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'aboutUs',
            'value' => '',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'requireEmailConfirmation',
            'value' => 0,
            'public' => 1,
        ]);

        Setting::create([
            'key' => 'enableGoogleLogin',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'google_oauth_client_id',
            'value' => '',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableFacebookLogin',
            'value' => 0,
            'public' => 1,
        ]);

        Setting::create([
            'key' => 'allowUserDownloads',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'downloadButton',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'allowUserUploads',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableFriendshipSystem',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableRealtime',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'pusherAppId',
            'value' => '',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'pusherKey',
            'value' => '',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'pusherCluster',
            'value' => '',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'pusherSecret',
            'value' => '',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableChat',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableMail',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'enableCharts',
            'public' => 1,
            'value' => 1,
        ]);
        Setting::create([
            'key' => 'defaultTheme',
            'value' => 'Light',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'square_ad',
            'value' => json_encode([
                'code' =>'',
                'position' => 'trs' 
            ]),
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'rect_ad',
            'value' => json_encode([
                'code' =>'',
                'position' => 'tcp' 
            ]),
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'paypalSandboxMode',
            'value' => 1,
            'public' => 0,
        ]);
        Setting::create([
            'key' => 'themes',
            'public' => 1,
            'value' => json_encode((object) array([
                'primary' =>  "#4245a8",
                'secondary' =>  "#8C366C",
                'dark' =>  [
                    'background' =>  "#010d1f",
                    'text' =>  "#ebebeb",
                    'panel' =>  "#182131",
                ],
                'light' =>  [
                    'background' =>  "#ffffff",
                    'text' =>  "#09021d",
                    'panel' =>  "#f7f7f7",
                ],
            ])[0]),
        ]);
        Setting::create([
            'key' => 'landingPage',
            'public' => 1,
            'value' => json_encode((object) array([
                'sections' => [
                    0 => [
                        'title' => 'Explore & listen',
                        'description' => 'You can discover a variety of music & podcast genres, the artists you like, the music you vibe with, and more.',
                        'background' => '/storage/defaults/images/landing/explore_and_listen.png'
                    ],
                    1 => [
                        'title' => 'Listen with friends',
                        'description' => "You can invite your friends to muzzie, chat with them and hear the same song at the same time. Cool isn't it?",
                        'background' => '/storage/defaults/images/landing/listen_with_friends.png'
                    ],
                    2 => [
                        'title' => 'Create your library',
                        'description' => "You can upload your own beloved songs, create your best playlists, follow your favored artists, and more.",
                        'background' => '/storage/defaults/images/landing/create_your_library.png'
                    ]
                ],
                'callToAction' => 'Play now',
                'showContactUs' => 1,
                'headerTitle' => 'Welcome to ' . config('app.name'),
                'headerDescription' => 'Listen to music anytime & anywhere',
                'headerBackground' => '/images/landing-background.jpg',
                'headerBackgroundLayerColor' => '#9B79135E',
                'customLandingPageHeader' => 1,
                'footerTitle' => 'Are you an Artist and you want to share your content ?',
                'footerDescription' => 'Sign up on Muzzie now and request an Artist account, get up to 500 MB of free space and more!',
                'footerBackground' =>  '/images/landing-background.jpg'
            ])[0]),
        ]);

        Setting::create([
            'key' => 'subscriptionButtonColor',
            'value' => '#FF8F00',
            'public' => 1,
        ]);

        Setting::create([
            'key' => 'subscriptionButtonText',
            'value' => 'upgrade',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'subscriptionButtonOutlined',
            'value' => 1,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'subscriptionButtonIcon',
            'value' => 'star',
            'public' => 1,
        ]);
        // Setting::create([
        //     'key' => 'subscriptionButtonPositions',
        //     'value' => "['Navbar']",
        //     'public' => 1,
        // ]);
        Setting::create([
            'key' => 'enableBilling',
            'value' => 0,
            'public' => 1,
        ]);

        Setting::create([
            'key' => 'stripeGateway',
            'value' => 0,
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'paypalGateway',
            'value' => 0,
            'public' => 1,
        ]);
        
        Setting::create([
            'key' => 'storageDisk',
            'value' => json_encode([
                'name' => 'Local Storage',
                'disk' => 'public'
            ]),
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'playerLanding',
            'value' => '/home',
            'public' => 1,
        ]);
        Setting::create([
            'key' => 'availableUserDiskSpace',
            'public' => 1,
            'value' => 10,
        ]);
        Setting::create([
            'key' => 'availableArtistDiskSpace',
            'public' => 1,
            'value' => 500,
        ]);
        Setting::create([
            'key' => 'maxFileSize',
            'public' => 1,
            'value' => 5,
        ]);
        Setting::create([
            'key' => 'maxImageSize',
            'public' => 1,
            'value' => 2,
        ]);

        // reset the default SEO settings
        foreach ($seo_defaults as $key => $value) {
            Setting::set($key, $value, 1);
        }
    }
}
