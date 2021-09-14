import Vue from "vue";
import VueRouter from "vue-router";
import VueMeta from "vue-meta";

Vue.use(VueMeta, {
    refreshOnceOnNavigation: true
});

Vue.use(VueRouter);

///// ALL THE ROUTES

// landing
import LandingPage from "./components/Landing.vue";

// login
import Login from "./components/authentication/Login.vue";
import Register from "./components/authentication/Register.vue";
import CompleteSignup from "./components/authentication/CompleteSignup.vue";
import ResetPassword from "./components/authentication/ResetPassword.vue";
import ForgotPassword from "./components/authentication/ForgotPassword.vue";

// upgrade - subscribe
import Subscription from "./components/subscription/Index.vue";

// admin
import AdminMaster from "./components/admin/layout/Master.vue";
import Users from "./components/admin/pages/Users.vue";
import Songs from "./components/admin/pages/Songs.vue";
import RadioStations from "./components/admin/pages/RadioStations.vue";
import Albums from "./components/admin/pages/Albums.vue";

import Appearance from "./components/admin/pages/appearance/Index.vue";
import AppearanceGeneral from "./components/admin/pages/appearance/general.vue";
import AppearanceLanding from "./components/admin/pages/appearance/Landing.vue";
import AppearanceNavigation from "./components/admin/pages/appearance/Navigation.vue";
import AppearancePreview from "./components/admin/pages/appearance/Preview.vue";
import AppearanceThemes from "./components/admin/pages/appearance/Themes.vue";

import Settings from "./components/admin/pages/settings/Index.vue";
import SettingsAuth from "./components/admin/pages/settings/Authentification.vue";
import SettingsMail from "./components/admin/pages/settings/Mail.vue";
import SettingsStorage from "./components/admin/pages/settings/Storage.vue";
import SettingsGeneral from "./components/admin/pages/settings/General.vue";
import SettingsBilling from "./components/admin/pages/settings/Billing.vue";
import SettingsSeo from "./components/admin/pages/settings/Seo.vue";

import Advertising from "./components/admin/pages/Advertising.vue";
import Subscriptions from "./components/admin/pages/Subscriptions.vue";
import Plans from "./components/admin/pages/Plans.vue";

import Translations from "./components/admin/pages/Translations.vue";

import Roles from "./components/admin/pages/Roles.vue";
import Pages from "./components/admin/pages/Pages.vue";
import AdminAnalytics from "./components/admin/pages/Analytics.vue";
import Podcasts_admin from "./components/admin/pages/Podcasts.vue";
import Artists_admin from "./components/admin/pages/Artists.vue";
import Playlists_admin from "./components/admin/pages/Playlists.vue";
import Genres_admin from "./components/admin/pages/Genres.vue";
import PodcastGenres_admin from "./components/admin/pages/PodcastGenres.vue";

// artist
import ArtistMaster from "./components/artist/layout/Master.vue";
import ArtistAnalytics from "./components/artist/pages/Analytics.vue";
import PersonalInformations from "./components/artist/pages/PersonalInformations.vue";
import Songs_artist from "./components/artist/pages/songs.vue";
import Albums_artist from "./components/artist/pages/Albums.vue";
import Podcasts_artist from "./components/artist/pages/Podcasts.vue";

// player main comp
import PlayerMaster from "./components/player/layout/Master.vue";

// custom page
import CustomPage from "./components/player/pages/CustomPage.vue";

// browse page routes
import browseIndex from "./components/player/pages/browse/Index.vue";
import browseGenres from "./components/player/pages/browse/Genres.vue";
import browseGenreSongs from "./components/player/pages/browse/GenreSongs.vue";
import browseCharts from "./components/player/pages/browse/Charts.vue";

// podcast page routes
import PodcastIndex from "./components/player/pages/podcast/Index.vue";
import GenrePodcasts from "./components/player/pages/podcast/GenrePodcasts.vue";

// user library
import LibraryIndex from "./components/player/pages/library/Index.vue";
import LibraryPlaylists from "./components/player/pages/library/pages/Playlists.vue";
import LibraryArtists from "./components/player/pages/library/pages/Artists.vue";
import LibrarySongs from "./components/player/pages/library/pages/songs.vue";
import LibraryAlbums from "./components/player/pages/library/pages/Albums.vue";
import LibraryPodcasts from "./components/player/pages/library/pages/Podcasts.vue";
import LibraryLikes from "./components/player/pages/library/pages/Likes.vue";
import LibraryRecents from "./components/player/pages/library/pages/Recents.vue";

///// PAGES ROUTES

// user
import UserProfile from "./components/player/pages/UserProfile.vue";

// artist
import Artist from "./components/player/pages/Artist.vue";

// album
import Album from "./components/player/pages/Album.vue";

// Song
import Song from "./components/player/pages/song.vue";

// podcast
import Podcast from "./components/player/pages/Podcast.vue";

// playlist
import Playlist from "./components/player/pages/Playlist.vue";

// Account settings
import AccountSettings from "./components/player/pages/AccountSettings.vue";

import store from "./store/index.js";

const router = new VueRouter({
    mode: "history",
    routes: [
        {
            path: "/",
            component: LandingPage,
            name: "landing"
        },
        {
            path: "/login",
            component: Login,
            name: "login"
        },
        {
            path: "/subscription",
            component: Subscription,
            name: "subscription"
        },
        {
            path: "/register/complete",
            component: CompleteSignup,
            name: "complete_signup",
            props: true
        },
        {
            path: "/register",
            component: Register,
            name: "register"
        },
        {
            path: "/password/forgot",
            component: ForgotPassword,
            name: "forgot_password"
        },
        {
            path: "/password/reset/:token",
            component: ResetPassword,
            name: "reset_password"
        },
        {
            path: "/admin",
            component: AdminMaster,
            name: "admin",
            meta: {
                requiresAdmin: true
            },
            children: [
                {
                    path: "settings",
                    component: Settings,
                    meta: {
                        requireShowSettingsPermission: true
                    },
                    children: [
                        {
                            path: "",
                            redirect: "general"
                        },
                        {
                            path: "general",
                            component: SettingsGeneral,
                            name: "settings.general",
                            props: true
                        },
                        {
                            path: "billing",
                            component: SettingsBilling,
                            name: "settings.billing",
                            props: true
                        },
                        {
                            path: "storage",
                            component: SettingsStorage,
                            name: "settings.storage",
                            props: true
                        },
                        {
                            path: "seo",
                            component: SettingsSeo,
                            name: "settings.seo",
                            props: true
                        },
                        {
                            path: "mail",
                            component: SettingsMail,
                            name: "settings.mail",
                            props: true
                        },
                        {
                            path: "auth",
                            component: SettingsAuth,
                            name: "settings.auth",
                            props: true
                        }
                    ]
                },
                {
                    path: "pages",
                    component: Pages,
                    name: "admin.pages"
                },
                {
                    path: "roles",
                    component: Roles,
                    name: "admin.roles"
                },
                {
                    path: "users",
                    component: Users,
                    name: "admin.users"
                },
                {
                    path: "analytics",
                    component: AdminAnalytics,
                    name: "admin.analytics"
                },
                {
                    path: "songs",
                    component: Songs,
                    name: "admin.songs"
                },
                {
                    path: "radio-stations",
                    component: RadioStations,
                    name: "admin.radio-stations"
                },
                {
                    path: "albums",
                    component: Albums,
                    name: "admin.albums"
                },
                {
                    path: "podcasts",
                    component: Podcasts_admin,
                    name: "admin.podcasts"
                },
                {
                    path: "playlists",
                    component: Playlists_admin,
                    name: "admin.playlists"
                },
                {
                    path: "genres",
                    component: Genres_admin,
                    name: "admin.genres"
                },
                {
                    path: "podcast-genres",
                    component: PodcastGenres_admin,
                    name: "admin.podcast-genres"
                },
                {
                    path: "appearance",
                    component: Appearance,
                    children: [
                        {
                            path: "",
                            name: "admin.appearance",
                            redirect: "general"
                        },
                        {
                            path: "general",
                            component: AppearanceGeneral,
                            name: "appearance.general"
                        },
                        {
                            path: "landing",
                            component: AppearanceLanding,
                            name: "appearance.landing"
                        },
                        {
                            path: "navigation",
                            component: AppearanceNavigation,
                            name: "appearance.navigation"
                        },
                        {
                            path: "preview",
                            component: AppearancePreview,
                            name: "appearance.preview"
                        },
                        {
                            path: "themes",
                            component: AppearanceThemes,
                            name: "appearance.themes"
                        }
                    ]
                },
                {
                    path: "translations",
                    component: Translations,
                    name: "translations"
                },
                {
                    path: "artists",
                    component: Artists_admin,
                    name: "admin.artists"
                },
                {
                    path: "advertising",
                    component: Advertising,
                    name: "admin.advertising"
                },
                {
                    path: "plans",
                    component: Plans,
                    name: "admin.plans"
                },
                {
                    path: "subscriptions",
                    component: Subscriptions,
                    name: "admin.subscriptions"
                }
            ]
        },
        {
            path: "/artist",
            component: ArtistMaster,
            name: "artist-area",
            meta: {
                requiresArtist: true
            },
            children: [
                {
                    path: "analytics",
                    component: ArtistAnalytics,
                    name: "artist.analytics"
                },
                {
                    path: "songs",
                    component: Songs_artist,
                    name: "artist.songs"
                },
                {
                    path: "albums",
                    component: Albums_artist,
                    name: "artist.albums"
                },
                {
                    path: "podcasts",
                    component: Podcasts_artist,
                    name: "artist.podcasts"
                },
                {
                    path: "personal-informations",
                    component: PersonalInformations,
                    name: "artist.informations"
                }
            ]
        },
        {
            path: "/",
            component: PlayerMaster,
            name: "player",
            meta: {
                player: true
            },
            children: [
                {
                    path: "/account/settings",
                    component: AccountSettings,
                    name: "account-settings",
                    meta: {
                        requiresAuth: true
                    }
                },
                {
                    path: "/browse",
                    component: browseIndex,
                    children: [
                        {
                            path: "",
                            name: "browse",
                            component: browseGenres
                        },
                        {
                            path: "charts",
                            component: browseCharts,
                            name: "browse.charts"
                        }
                    ]
                },
                {
                    path: "podcast/:id",
                    name: "podcast",
                    component: Podcast,
                    meta: {
                        podcastRelated: true
                    }
                },
                {
                    path: "browse/genre/:genre_name",
                    name: "genre-page",
                    component: browseGenreSongs,
                    props: true
                },
                {
                    path: "/podcasts",
                    name: "podcasts",
                    component: PodcastIndex,
                    meta: {
                        podcastRelated: true
                    }
                },
                {
                    path: "podcasts/:genre",
                    name: "podcasts.genre",
                    component: GenrePodcasts,
                    meta: {
                        podcastRelated: true
                    }
                },
                {
                    path: "artist/:id(\\d+)",
                    component: Artist,
                    name: "artist"
                },
                {
                    path: "song/:id",
                    component: Song,
                    name: "song"
                },
                {
                    path: "album/:id",
                    component: Album,
                    name: "album"
                },
                {
                    path: "playlist/:id",
                    component: Playlist,
                    name: "playlist"
                },
                {
                    path: "profile/:id",
                    component: UserProfile,
                    name: "profile"
                },
                {
                    path: "library",
                    component: LibraryIndex,
                    meta: {
                        requiresAuth: true
                    },
                    children: [
                        {
                            path: "playlists",
                            component: LibraryPlaylists,
                            name: "library.playlists",
                            props: true
                        },
                        {
                            path: "artists",
                            component: LibraryArtists,
                            name: "library.artists"
                        },
                        {
                            path: "my-songs",
                            component: LibrarySongs,
                            name: "library.my-songs"
                        },
                        {
                            path: "recent",
                            component: LibraryRecents,
                            name: "library.recent"
                        },
                        {
                            path: "likes",
                            component: LibraryLikes,
                            name: "library.likes"
                        },
                        {
                            path: "podcasts",
                            component: LibraryPodcasts,
                            name: "library.podcasts",
                            meta: {
                                podcastRelated: true
                            }
                        },
                        {
                            path: "albums",
                            component: LibraryAlbums,
                            name: "library.albums"
                        }
                    ]
                },
                {
                    path: "*",
                    component: CustomPage,
                    name: "custom-page"
                }
            ]
        }
    ]
});

// open in a new window function
VueRouter.prototype.open = function(routeObject) {
    const { href } = this.resolve(routeObject);
    window.open(href, "_blank");
};

// check if the current user has a permission
function hasPermission(permission) {
    return Boolean(
        store.getters.getUser.is_admin ||
            (store.getters.getUser
                ? store.getters.getUser.permissions.some(
                      per => per.name === permission
                  )
                : false)
    );
}

// Check whether the admin has privileges to access a page
function isPageAllowedToAccessByAdmin(to) {
    if (to.matched.some(record => record.meta.requireShowSettingsPermission)) {
        return hasPermission("Edit settings") ? 1 : 0;
    } else if (to.name === "admin.users") {
        return hasPermission("Read users") ? 1 : 0;
    } else if (to.name === "admin.pages") {
        return hasPermission("CED pages") ? 1 : 0;
    } else if (to.name === "admin.artists") {
        return hasPermission("Read artists") ? 1 : 0;
    } else if (to.name === "admin.podcasts") {
        return hasPermission("CED podcasts") ? 1 : 0;
    } else if (to.name === "admin.radio-stations") {
        return hasPermission("CED radio_stations") ? 1 : 0;
    } else if (to.name === "admin.appearance") {
        return hasPermission("Edit appearance") ? 1 : 0;
    } else if (to.name === "admin.albums") {
        return hasPermission("CED albums") ? 1 : 0;
    } else if (to.name === "admin.songs") {
        return hasPermission("CED songs") ? 1 : 0;
    } else if (to.name === "admin.roles") {
        return hasPermission("Read roles") ? 1 : 0;
    } else if (to.name === "admin.playlists") {
        return hasPermission("CED playlists") ? 1 : 0;
    } else if (to.name === "admin.genres") {
        return hasPermission("CED song_genres") ? 1 : 0;
    } else if (to.name === "admin.podcast_genres") {
        return hasPermission("CED podcast_genres") ? 1 : 0;
    } else if (to.name === "admin.translations") {
        return hasPermission("CED translations") ? 1 : 0;
    } else if (to.name === "admin.plans") {
        return hasPermission("CED plans") ? 1 : 0;
    } else if (to.name === "admin.subscriptions") {
        return hasPermission("CED subscriptions") ? 1 : 0;
    } else if (to.name === "admin.advertising") {
        return hasPermission("Edit advertisements") ? 1 : 0;
    } else {
        return 1;
    }
}
router.beforeEach((to, from, next) => {
    // udpate route key: allow component to re-render while visiting the same route
    store.commit("setCurrentPageId");
    // stop playing audios when going outside the player
    if (!to.matched.some(record => record.meta.player)) {
        store.state.queue = [];
    }
    // redirect the user to a 404 page if he visited a page related to podcasts
    // meanwhile it is not allowed to access by the admins
    if (
        to.matched.some(record => record.meta.podcastRelated) &&
        !store.getters.getSettings.enablePodcasts
    ) {
        return next({ path: "/not-found" });
    }
    // if no plans there is no subscription
    if (
        to.name === "subscription" &&
        !(store.getters.getPlans && store.getters.getPlans.filter(plan => plan.active).length > 0)
    ) {
        return next({ path: "/not-found" });
    }

    // redirect to the player if the landing is disabled
    if (to.name === "landing" && !store.getters.getSettings.enableLandingPage) {
        return next({ path: store.getters.getSettings.playerLanding });
    }

    // hide the registration route if the registration is disabled
    if (
        to.name === "register" &&
        store.getters.getSettings.disableRegistration
    ) {
        return next({ path: "/not-found" });
    }

    // redirect the user to the login page if auth is required but he not logged in
    if (
        store.getters.getSettings.requireAuth &&
        !store.getters.getUser &&
        to.name !== "login" &&
        to.name !== "register"
    ) {
        return next({ name: "login" });
    }
    // redirect the user to the player landing page if he is already logged in
    // and visited login or register pages
    if (
        (to.name == "login" || to.name == "register") &&
        store.getters.getUser
    ) {
        return next({ path: store.getters.getSettings.playerLanding });
    }
    // redirect the user to a 404 page if he visited a built-in page `charts`
    //  not allowed to access by the admin
    if (!store.getters.getSettings.enableBrowse && to.name.match(/browse/)) {
        return next({ path: "/not-found" });
    }
    // managing user access to routes that require admin role, artist role ...etc
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (!store.getters.getUser) {
            if (from.path === "/") {
                next({ name: "login" });
            } else {
                Vue.$confirm({
                    message: `You need to login to your account`,
                    button: {
                        no: "Cancel",
                        yes: "Login"
                    },
                    callback: confirm => {
                        if (confirm) {
                            next({ name: "login" });
                        } else {
                            next(false);
                        }
                    }
                });
            }
        } else {
            if (to.path === "/library") {
                return next({ name: "library.my-songs" });
            }
            return next();
        }
    } else if (to.matched.some(record => record.meta.requiresAdmin)) {
        // if the visiting route requires admin priviliges
        var user = store.getters.getUser;
        if (
            user &&
            (user.roles.some(role => role.name === "admin") || user.is_admin)
        ) {
            if (!isPageAllowedToAccessByAdmin(to) || to.path === "/admin") {
                return next({ name: "admin.analytics" });
            } else {
                return next();
            }
        } else {
            return next({ path: "/not-found" });
        }
    } else if (to.matched.some(record => record.meta.requiresArtist)) {
        // if the visiting route requires artist priviliges
        var user = store.getters.getUser;
        if (user && user.roles.some(role => role.name === "artist")) {
            if (to.path === "/artist") {
                next({ name: "artist.analytics" });
                return;
            }
            next();
            return;
        } else {
            next({ path: "/not-found" });
            return;
        }
    } else {
        next();
    }
});
export default router;
