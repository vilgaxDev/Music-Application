import Vue from "vue";
import Vuex from "vuex";
import router from "../router.js";
import helpers from "../helpers";
import { i18n } from "../i18n-setup.js";

Vue.use(Vuex);

/**
 * Checks if a song is playable.
 * @param {*} song
 * @returns {Boolean}
 */
function isPlayable(audio) {
    return (
        (audio.youtube_id && store.getters.getSettings.allowVideos) ||
        audio.source ||
        audio.endpoint
    );
}

export default new Vuex.Store({
    state: {
        user: null,
        artist: null,
        messages: {},
        token: localStorage.getItem("token") || null,
        queue: [],
        playlists: null,
        dialog: null,
        screenWidth: window.innerWidth,
        settings: null,
        searchResultsPanel: false,
        notifications: null,
        plans: null,
        currentAudio: null,
        likedAlbums: null,
        currentPageId: 0,
        songMenu: null,
        // songContextMenu is a value to determine which song dialog should show
        songContextMenu: null,
        ads: null,
        followedPodcasts: null,
        ownSongs: null,
        followedArtists: null,
        followedPlaylists: null,
        openChatWith: null,
        friends: null,
        likedSongs: null,
        recentlyPlayed: null,
        songs: null,
        fbLogoutFunction: null,
        // addSongToPlaylist is a null or an Integer value
        // after the user clicks on 'Add to playlist' on a song dialog
        // this value will receive the ID of the song
        // which will be sent after to the backend to attach
        addSongToPlaylist: null,
        shareContentUrl: null,
        showSharingDialog: false
    },
    mutations: {
        showSharingDialog(state, URL) {
            state.shareContentUrl = URL;
            state.showSharingDialog = true;
        },
        updateQueue(state, songs) {
            state.queue = songs;
        },
        setSongMenu(state, id) {
            state.songMenu == id
                ? (state.songMenu = null)
                : (state.songMenu = id);
        },
        /**
         * this setter makes sure that only one song dialog-box is oppened at a time
         * with the help of the song ID
         * @param {*} state
         * @param {*} id
         */
        setSongContextMenu(state, id) {
            state.songContextMenu == id
                ? // if the ID of the previous dialog is the same as the new one
                  // the value of the variable will be null, hence the dialog will close
                  (state.songContextMenu = null)
                : (state.songContextMenu = id);
        },
        pushIntoQueue(state, songs) {
            songs.map(song => state.queue.push(song));
        },
        setToken(state, token) {
            state.token = token;
        },
        setMessages(state, messages) {
            state.messages = messages;
        },
        setSettings(state, settings) {
            state.settings = settings;
        },
        setFbLogoutFunction(state, fbLogoutFunction) {
            state.fbLogoutFunction = fbLogoutFunction;
        },
        setCurrentPageId(state) {
            state.currentPageId++;
        },
        setSearchResultsPanel(state, value) {
            state.searchResultsPanel = value;
        },
        setPlaylists(state, playlists) {
            state.playlists = playlists;
        },
        setUser(state, user) {
            state.user = user;
        },
        setArtist(state, artist) {
            state.artist = artist;
        },
        setLikes(state, songs) {
            state.likedSongs = songs.filter(song => song);
        },
        setLikedAlbums(state, Albums) {
            state.likedAlbums = Albums;
        },
        setCurrentAudio(state, song) {
            state.currentAudio = song;
        },
        setFollowedPodcasts(state, Podcasts) {
            state.followedPodcasts = Podcasts;
        },
        setRecentlyPlayed(state, Songs) {
            state.recentlyPlayed = Songs.filter(Song => Song);
        },
        setOwnSongs(state, Songs) {
            state.ownSongs = Songs;
        },
        /**
         * Remove a song from the array of liked songs ( by the current logged user)
         * @param {*} state
         * @param {*} param1
         */
        spliceFromLikes(state, { id }) {
            const index = state.likedSongs.findIndex(x => x.id == id);
            state.likedSongs.splice(index, 1);
        },
        pushIntoLikes(state, Song) {
            state.likedSongs.push(Song);
        },
        setDialog(state, value) {
            state.dialog = value;
        },
        setScreenWidth(state, value) {
            state.screenWidth = value;
        },
        setOpenChatWith(state, friend_id) {
            state.openChatWith = friend_id;
        },
        setAddSongToPlaylist(state, song) {
            state.addSongToPlaylist = song;
        },
        setUploadImage(state, img) {
            state.uploadImage = img;
        },
        setFollowedArtists(state, artists) {
            state.followedArtists = artists;
        },
        setFollowedPlaylists(state, playlists) {
            state.followedPlaylists = playlists;
        },
        setFriends(state, users) {
            state.friends = users;
        },
        setAds(state, ads) {
            state.ads = ads;
        },
        setNotifications(state, notifications) {
            state.notifications = notifications;
        },
        setPlans(state, plans) {
            state.plans = plans;
        }
    },
    getters: {
        // getters for the state props.
        getQueue(state) {
            return state.queue;
        },
        getShareContentUrl(state) {
            return state.shareContentUrl;
        },
        getDialog(state) {
            return state.dialog;
        },
        getSettings(state) {
            return state.settings;
        },
        getSongMenu(state) {
            return state.songMenu;
        },
        getSongContextMenu(state) {
            return state.songContextMenu;
        },
        getAds(state) {
            return state.ads;
        },
        getSearchResultsPanel(state) {
            return state.searchResultsPanel;
        },
        getScreenWidth(state) {
            return state.screenWidth;
        },
        isLogged(state) {
            return state.token !== null;
        },
        getToken(state) {
            return state.token;
        },
        getMessages(state) {
            return state.messages;
        },
        getCurrentPageId(state) {
            return state.currentPageId;
        },
        getPlaylists(state) {
            return state.playlists;
        },
        getOwnSongs(state) {
            return state.ownSongs;
        },
        getLikedSongs(state) {
            return state.likedSongs;
        },
        getRecentlyPlayed(state) {
            return state.recentlyPlayed;
        },
        getUser(state) {
            return state.user;
        },
        getArtist(state) {
            return state.artist;
        },
        getCurrentAudio(state) {
            return state.currentAudio;
        },
        getLikes(state) {
            return state.likedSongs;
        },
        getNotifications(state) {
            return state.notifications;
        },
        getPlans(state) {
            return state.plans;
        },
        getLikedAlbums(state) {
            return state.likedAlbums;
        },
        getFollowedPodcasts(state) {
            return state.followedPodcasts;
        },
        getUploadImage(state) {
            return state.uploadImage;
        },
        getAddSongToPlaylist(state) {
            return state.addSongToPlaylist;
        },
        getOpenChatWith(state) {
            return state.openChatWith;
        },
        getFollowedArtists(state) {
            return state.followedArtists;
        },
        getFollowedPlaylists(state) {
            return state.followedPlaylists;
        },
        getFriends(state) {
            return state.friends;
        },
        /**
         * Checks if a user has a certain role.
         * @param {*} state
         * @return {Boolean}
         */
        isUser(state) {
            return function(role) {
                if (role === "admin" && state.user.is_admin) {
                    return true;
                }
                return state.user.roles.some(r => r.name === role);
            };
        },
        /**
         * Checks if a song is already liked by the user.
         * @param {*} state
         * @return {Boolean}
         */
        isLiked(state) {
            return function(song_id) {
                return (state.likedSongs || []).some(x =>
                    x ? x.id === song_id : false
                );
            };
        }
    },
    actions: {
        /**
         * login the user.
         * @param {*} context
         * @param {*} param1
         */
        async login(context, { email, password, driver, profile }) {
            try {
                if (driver === "google") {
                    var res = await axios.post("/api/login/google/callback", {
                        profile
                    });
                } else if (driver === "facebook") {
                    var res = await axios.post("/api/login/facebook/callback", {
                        profile
                    });
                    if (res.data.message === "email required") {
                        // if email was not provide by the OAuth provider
                        router.push({
                            name: "complete_signup",
                            params: { profile: profile, driver: driver }
                        });
                        return;
                    }
                } else {
                    var res = await axios.post("/api/login", {
                        email: email,
                        password: password
                    });
                }
                if (res) {
                    let token = res.data["access_token"];
                    if (token) {
                        context.commit("setToken", token);
                        // save the token at local storage if it exists
                        localStorage.setItem("token", token);
                        axios.defaults.headers.common["Authorization"] =
                            "Bearer " + token;
                        await context.dispatch("fetchUser");
                        router.push({
                            path: "home"
                        });
                        return Promise.resolve();
                    } else {
                        Vue.notify({
                            type: "error",
                            group: "foo",
                            message: "Authentification failed try again!"
                        });
                    }
                }
            } catch (e) {
                throw e;
            }
        },
        /**
         * Logout the user.
         * @param {*} context
         */
        async logout(context) {
            let res = await axios.post("/api/logout");
            if (context.state.fbLogoutFunction) {
                context.state.fbLogoutFunction();
            }
            if (res.status == 200) {
                context.commit("setUser", null);
                localStorage.removeItem("token");
            }
            router.push({
                name: "login"
            });
        },
        /**
         * Get the user notifications.
         * @param {*} context
         */
        fetchNotifications(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/notifications")
                    .then(res => {
                        context.commit("setNotifications", res.data);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Get the user notifications.
         * @param {*} context
         */
        fetchPlans(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/plans")
                    .then(res => {
                        context.commit("setPlans", res.data);
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Get the user playlists.
         * @param {*} context
         */
        async fetchPlaylists(context) {
            try {
                let res = await axios.get("/api/user/playlists");
                let playlists = res.data;
                context.commit("setPlaylists", playlists);
                Promise.resolve();
            } catch (e) {
                Promise.reject(e);
            }
        },
        /**
         * Checks if an artist is followed by the current user.
         * @param {*} context
         * @param {*} artist_id
         */
        async isArtistFollowed(context, artist_id) {
            if (context.getters.getFollowedArtists) {
                let artists = context.getters.getFollowedArtists;
                return artists.some(artist => artist.id === artist_id);
            } else if (context.state.user) {
                await context.dispatch("fetchFollowedArtists");
                context.commit("isArtistFollowed", artist_id);
            } else {
                return false;
            }
        },
        /**
         * Checks if a podcast is followed by the current user.
         * @param {*} context
         * @param {*} podcast_id
         */
        isPodcastFollowed(context, podcast_id) {
            if (context.getters.getFollowedPodcasts) {
                // if the followed podcasts are already fetched
                let podcasts = context.getters.getFollowedPodcasts;
                return podcasts.some(artist => artist.id === podcast_id);
            } else if (context.state.user) {
                return new Promise((resolve, reject) => {
                    context
                        .dispatch("fetchFollowedPodcasts")
                        .then(() => {
                            context
                                .dispatch("isPodcastFollowed", podcast_id)
                                .then(res => {
                                    resolve(res);
                                });
                        })
                        .catch(e => {
                            reject(e);
                        });
                });
            } else {
                return false;
            }
        },
        /**
         * Checks if a friend is a friend with the current user.
         * @param {*} context
         * @param {*} friend_id
         */
        async checkFriendStatus(context, friend_id) {
            var res = await axios.post("/api/check-friendship-status", {
                friend_id,
                user_id: context.getters.getUser.id
            });
            return res.data;
        },
        /**
         * Follow an artist.
         * @param {*} context
         * @param {*} artist_id
         */
        async followArtist(context, artist_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/follow-artist", {
                    user_id: context.getters.getUser.id,
                    artist_id: artist_id
                })
                .then(() => {
                    context.dispatch("fetchFollowedArtists");
                    Promise.resolve();
                })
                .catch(e => Promise.reject(e));
        },
        /**
         * Unfollow an aritst.
         * @param {*} context
         * @param {*} artist_id
         */
        async unfollowArtist(context, artist_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/unfollow-artist", {
                    user_id: context.getters.getUser.id,
                    artist_id: artist_id
                })
                .then(() => {
                    context.dispatch("fetchFollowedArtists");
                    Promise.resolve();
                })
                .catch(e => Promise.reject(e));
        },
        /**
         * Get the current logged user data.
         * @param {*} context
         */
        fetchUser(context) {
            return new Promise((res, rej) => {
                axios
                    .get("/api/user")
                    .then(result => {
                        context.commit("setUser", result.data);
                        context.dispatch("likedSongs");
                        context.dispatch("fetchFriends");
                        context.dispatch("fetchPlaylists");
                        context.dispatch("fetchFollowedArtists");
                        context.dispatch("fetchNotifications");
                        res(result.data);
                    })
                    .catch(() => {
                        context.commit("setUser", null);
                        rej();
                    });
            });
        },
        /**
         * Get the current logged artist data.
         * @param {*} context
         */
        async fetchArtist(context) {
            try {
                let res = await axios.get("/api/artist");
                context.commit("setArtist", res.data);
            } catch (e) {
                context.commit("setArtist", {});
            }
        },
        /**
         * Send a friend request to a user.
         * @param {*} context
         * @param {*} user_id
         */
        addFriend(context, user_id) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/add-friend", {
                        user_id
                    })
                    .then(res => {
                        context.dispatch("fetchFriends");
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Remove a friend.
         * @param {*} context
         * @param {*} friend_id
         */
        removeFriend(context, friend_id) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/remove-friend", {
                        friend_id
                    })
                    .then(res => {
                        context.dispatch("fetchFriends");
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Fetch the followed artists by the current logged user.
         * @param {*} context
         */
        fetchFollowedArtists(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/followed-artists")
                    .then(res => {
                        context.commit("setFollowedArtists", res.data);
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Fetch the followed playlists by the current logged user.
         * @param {*} context
         */
        fetchFollowedPlaylists(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/followed-playlists")
                    .then(res => {
                        context.commit("setFollowedPlaylists", res.data);
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Follow a playlist.
         * @param {*} context
         * @param {*} playlist_id
         */
        followPlaylist(context, playlist_id) {
            return new Promise((resolve, reject) => {
                if (!context.getters.isLogged) {
                    // asking the user to login if he is not
                    Vue.$confirm({
                        message: `You need to login to your account`,
                        button: {
                            no: "Cancel",
                            yes: "Login"
                        },
                        callback: confirm => {
                            if (confirm) {
                                next({ name: "login" });
                            }
                        }
                    });
                    reject();
                    return;
                }
                axios
                    .post("/api/follow-playlist", {
                        playlist_id
                    })
                    .then(() => {
                        context.dispatch("fetchFollowedPlaylists");
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Unfollow a playlist.
         * @param {*} context
         * @param {*} playlist_id
         */
        async unFollowPlaylist(context, playlist_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/unfollow-playlist", {
                    playlist_id
                })
                .then(() => {
                    context.dispatch("fetchFollowedPlaylists");
                    Promise.resolve();
                })
                .catch(e => {
                    Promise.reject(e);
                });
        },
        /**
         * Fetch the current logged user friends.
         * @param {*} context
         */
        fetchFriends(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/friends")
                    .then(res => {
                        context.commit("setFriends", res.data);
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Fetch the liked songs by the current logged user.
         * @param {*} context
         */
        async likedSongs(context) {
            try {
                let res = await axios.get("/api/user/liked-songs");
                context.commit("setLikes", res.data);
            } catch (e) {}
        },
        /**
         * Fetch the liked albums by the current logged user.
         * @param {*} context
         */
        likedAlbums(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/liked-albums")
                    .then(res => {
                        context.commit("setLikedAlbums", res.data);
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Fetch the uploaded songs by the current logged user.
         * @param {*} context
         */
        fetchOwnSongs(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/songs")
                    .then(res => {
                        context.commit("setOwnSongs", res.data);
                        resolve();
                    })
                    .catch(e => reject(e));
            });
        },
        /**
         * Update the queue ( playlist ).
         * @param {*} songs
         * @param {*} reset
         */
        updateQueue(context, { content, reset }) {
            console.log(content);
            var newQueue = [];
            if (content.length === 1) {
                if (isPlayable(content[0])) {
                    newQueue = content;
                }
            } else {
                newQueue = content.filter(song => isPlayable(song));
            }
            if (!newQueue.length) {
                return Vue.notify({
                    group: "foo",
                    type: "warning",
                    title: i18n.t("Could not be played!"),
                    text: i18n.t("No streaming source found.")
                });
            }
            context.commit(reset ? "updateQueue" : "pushIntoQueue", newQueue);
        },
        /**
         * Fetch the followed podcasts by the current logged user.
         * @param {*} context
         */
        fetchFollowedPodcasts(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/followed-podcasts")
                    .then(res => {
                        context.commit("setFollowedPodcasts", res.data);
                        resolve();
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Like a song.
         * @param {*} context
         * @param {*} song_id
         */
        async like(context, song_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            try {
                await axios.post("/api/like-song", {
                    id: song_id
                });
                await context.dispatch("likedSongs");
                return Promise.resolve();
            } catch (e) {
                return Promise.reject();
            }
        },
        /**
         * Unlike a song.
         * @param {*} context
         * @param {*} song_id
         */
        async unlike(context, song_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            try {
                await axios.post("/api/unlike-song", {
                    id: song_id
                });
                await context.dispatch("likedSongs");
                return Promise.resolve();
            } catch (e) {
                return Promise.reject();
            }
        },
        /**
         * Register a play on the database for stats.
         * @param {*} context
         * @param {*} id
         */
        fetchMessages(context, locale) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/messages/" + locale)
                    .then(msgs => {
                        const messages = {};
                        messages.en = {};
                        msgs.data.en.forEach(obj => {
                            messages.en[obj.key] = obj.value;
                        });
                        i18n.setLocaleMessage('en', messages.en);
                        if( locale !== 'en' ) {
                            messages[locale] = {};
                            msgs.data[locale].forEach(obj => {
                                messages[locale][obj.key] = obj.value;
                            });
                            i18n.setLocaleMessage(locale, messages[locale]);
                        }
                        context.commit("setMessages", messages);
                    })
                    .then(res => {
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        registerPlay(context, { id, type }) {
            return new Promise((resolve, reject) => {
                axios
                    .post(
                        "/api" +
                            (context.getters.getUser ? "/user" : "") +
                            "/register-play",
                        {
                            id,
                            type
                        }
                    )
                    .then(res => {
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Play an album.
         * @param {*} context
         * @param {*} songs
         */
        playAlbum(context, { album }) {
            context.dispatch("registerPlay", { id: album.id, type: "album" });
            context.dispatch("updateQueue", {
                content: album.songs,
                reset: true
            });
        },
        /**
         * Play a podcast.
         * @param {*} context
         * @param {*} songs
         */
        playPodcast(context, { podcast }) {
            context.dispatch("registerPlay", {
                id: podcast.id,
                type: "podcast"
            });
            context.dispatch("updateQueue", {
                content: podcast.episodes,
                reset: true
            });
        },
        /**
         * Play a playlist.
         * @param {*} context
         * @param {*} songs
         */
        playPlaylist(context, { playlist }) {
            context.dispatch("registerPlay", {
                id: playlist.id,
                type: "playlist"
            });
            context.dispatch("updateQueue", {
                content: playlist.songs,
                reset: true
            });
        },
        /**
         * Play a radio station.
         * @param {*} context
         * @param {*} stream
         */
        playRadioStation(context, { radioStation }) {
            context.dispatch("registerPlay", {
                id: radioStation.id,
                type: "radio-station"
            });
            context.dispatch("updateQueue", {
                content: [radioStation],
                reset: true
            });
        },

        /**
         * Play a radio station.
         * @param {*} context
         * @param {*} stream
         */
        playEpisode(context, { episode, reset }) {
            // registering the plays will take place on the player
            context.dispatch("updateQueue", { content: [episode], reset });
        },
        playSong(context, { song, reset }) {
            // registering the plays will take place on the player
            context.dispatch("updateQueue", { content: [song], reset });
        },
        /**
         * Reset the user status when he compeleted listening to an audio.
         */
        endPlay(context) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/user/end-play")
                    .then(res => {
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Like an album.
         * @param {*} context
         * @param {*} album_id
         */
        async likeAlbum(context, album_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/like-album", {
                    album_id
                })
                .then(res => {
                    context.dispatch("likedAlbums");
                    Promise.resolve(res);
                })
                .catch(e => {
                    Promise.reject(e);
                });
        },
        /**
         * Unlike an album.
         * @param {*} context
         * @param {*} album_id
         */
        async unlikeAlbum(context, album_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/unlike-album", {
                        album_id
                    })
                    .then(res => {
                        context.dispatch("likedAlbums");
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Follow a podcast.
         * @param {*} context
         * @param {*} podcast_id
         */
        async followPodcast(context, podcast_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/follow-podcast", {
                    podcast_id
                })
                .then(res => {
                    context.dispatch("fetchFollowedPodcasts");
                    Promise.resolve(res);
                })
                .catch(e => {
                    Promise.reject(e);
                });
        },
        /**
         * Unfollow a podcast.
         * @param {*} context
         * @param {*} podcast_id
         */
        async unfollowPodcast(context, podcast_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/unfollow-podcast", {
                        podcast_id
                    })
                    .then(res => {
                        context.dispatch("fetchFollowedPodcasts");
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Attach a song to a playlist.
         * @param {*} context
         * @param {*} param1
         */
        attachToPlaylist(context, { playlist_id, song_id }) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/attach-to-playlist", {
                        playlist_id,
                        song_id
                    })
                    .then(res => {
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Detach a song from a playlist.
         * @param {*} context
         * @param {*} param1
         */
        detachFromPlaylist(context, { playlist_id, song_id }) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/detach-from-playlist", {
                        playlist_id,
                        song_id
                    })
                    .then(res => {
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Fetch the recent played songs by the current user.
         * @param {*} context
         */
        fetchRecentPlays(context) {
            return new Promise((resolve, reject) => {
                axios
                    .get("/api/user/recent-plays")
                    .then(res => {
                        var json = res.data;
                        let arr = Object.keys(json).map(key => json[key]);
                        context.commit("setRecentlyPlayed", arr);
                    })
                    .catch(e => {
                        reject();
                    });
            });
        },
        /**
         * Create a playlist.
         * @param {*} context
         * @param {*} data
         */
        createPlaylist(context, data) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/user/playlists", data)
                    .then(res => {
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Delete a song uploaded by the current logged user.
         * @param {*} context
         * @param {*} song_id
         */
        delete_user_song(context, song_id) {
            return new Promise((resolve, reject) => {
                axios
                    .delete("/api/user/songs/" + song_id)
                    .then(res => {
                        context.dispatch("fetchOwnSongs");
                        resolve(res);
                    })
                    .catch(e => reject(e));
            });
        },
        /**
         * Delete a playlist ( created by the current logged user ).
         * @param {*} context
         * @param {*} playlist_id
         */
        delete_user_playlist(context, playlist_id) {
            return new Promise((resolve, reject) => {
                axios
                    .delete("/api/user/playlists/" + playlist_id)
                    .then(res => {
                        context.dispatch("fetchPlaylists");
                        resolve(res);
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Make a song publicly visible.
         * @param {*} context
         * @param {*} song_id
         */
        make_song_public(context, song_id) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/make-song-public/" + song_id)
                    .then(() => {
                        resolve();
                        context.dispatch("fetchOwnSongs");
                    })
                    .catch(e => {
                        reject(e);
                    });
            });
        },
        /**
         * Make a song privatly visible.
         * @param {*} context
         * @param {*} song_id
         */
        make_song_private(context, song_id) {
            return new Promise((resolve, reject) => {
                axios
                    .post("/api/make-song-private/" + song_id)
                    .then(() => {
                        resolve();
                        context.dispatch("fetchOwnSongs");
                    })
                    .catch(e => reject(e));
            });
        },
        /**
         * Make a playlist publicly visible.
         * @param {*} context
         * @param {*} playlist_id
         */
        async make_playlist_public(context, playlist_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/make-playlist-public/" + playlist_id)
                .then(() => {
                    Promise.resolve();
                    context.dispatch("fetchPlaylists");
                })
                .catch(e => {
                    Promise.reject(e);
                });
        },
        /**
         * Make a playlist privatly visible.
         * @param {*} context
         * @param {*} playlist_id
         */
        async make_playlist_private(context, playlist_id) {
            if (!context.getters.isLogged) {
                // if the user is not logged
                await helpers.loginOrCancel();
            }
            axios
                .post("/api/make-playlist-private/" + playlist_id)
                .then(() => {
                    Promise.resolve();
                    context.dispatch("fetchPlaylists");
                })
                .catch(e => {
                    Promise.reject(e);
                });
        },
        /**
         * Download a song.
         * @param {*} context
         * @param {*} param1
         */
        downloadAudio(context, { id, file_name, type }) {
            return new Promise(res => {
                axios
                    .post(
                        "/api/download-" +
                            (type === "episode" ? "episode" : "song") +
                            "/" +
                            id,
                        {
                            responseType: "arraybuffer"
                        }
                    )
                    .then(response => {
                        const url = window.URL.createObjectURL(
                            new Blob([response.data])
                        );
                        // creating an anchor to trigger the URL
                        const link = document.createElement("a");
                        link.href = url;
                        link.setAttribute("download", file_name);
                        document.body.appendChild(link);
                        // Execute the link
                        link.click();
                    })
                    .finally(() => res());
            });
        }
    }
});
