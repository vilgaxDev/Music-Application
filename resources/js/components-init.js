// This file includes the declaration of all the components

import Vue from 'vue';
import vSelect from "vue-select";
import { VSelect as VeutifySelect } from "vuetify/lib";
import VueConfirmDialog from "vue-confirm-dialog";
import VueContentPlaceholders from "vue-content-placeholders";
import Notifications from "vue-notification";
import VueChatScroll from "vue-chat-scroll";

Vue.use(VueChatScroll);
Vue.use(Notifications);
Vue.use(VueContentPlaceholders);
Vue.use(VueConfirmDialog);

Vue.component(
    "page-loading",
    require("./components/elements/single-items/PageLoading.vue").default
);

Vue.component("v-select", vSelect);

Vue.component("veutify-select", VeutifySelect);

Vue.component("vue-confirm-dialog", VueConfirmDialog.default);

// App container comp
Vue.component("Master", require("./components/Master.vue").default);

///////// dialogs
Vue.component(
    "dialog-wrapper",
    require("./components/dialogs/Index.vue").default
);
Vue.component(
    "playlists-dialog",
    require("./components/dialogs/Playlists.vue").default
);

//////// templates
Vue.component(
    "empty-page",
    require("./components/templates/EmptyPage.vue").default
);
Vue.component(
    "disabled-page",
    require("./components/templates/DisabledPageLayer.vue").default
);
Vue.component(
    "edit-dialog",
    require("./components/templates/EditDialog.vue").default
);
Vue.component(
    "fixed-left",
    require("./components/templates/Fixed-left.vue").default
);

Vue.component(
    "abs-menu",
    require("./components/templates/AbsMenu.vue").default
);
Vue.component(
    "notifications-box",
    require("./components/notifications/Index.vue").default
);

//////// chat

Vue.component(
    "chat-component",
    require("./components/player/Chat/Chat.vue").default
);

Vue.component(
    "friend-list",
    require("./components/player/chat/FriendList.vue").default
);

//////// elements

// lists
Vue.component(
    "song-list",
    require("./components/elements/lists/songs.vue").default
);
Vue.component(
    "album-list",
    require("./components/elements/lists/Albums.vue").default
);
Vue.component(
    "podcast-list",
    require("./components/elements/lists/Podcasts.vue").default
);

// single-items
Vue.component(
    "loading-circle",
    require("./components/elements/single-items/LoadingCircle.vue").default
);
Vue.component(
    "ad",
    require("./components/elements/single-items/Ad.vue").default
);
Vue.component(
    "song-expo",
    require("./components/elements/single-items/SongExpo.vue").default
);
Vue.component(
    "radio-station",
    require("./components/elements/single-items/RadioStation.vue").default
);
Vue.component(
    "song-encap",
    require("./components/elements/single-items/SongEncap.vue").default
);
Vue.component(
    "podcast-box",
    require("./components/elements/single-items/Podcast.vue").default
);
Vue.component(
    "album-expo",
    require("./components/elements/single-items/AlbumExpo.vue").default
);
Vue.component(
    "playlist-expo",
    require("./components/elements/single-items/Playlist.vue").default
);
Vue.component(
    "artist",
    require("./components/elements/single-items/Artist.vue").default
);

// sections
Vue.component(
    "swiper-section",
    require("./components/elements/sections/SwiperSection.vue").default
);
Vue.component(
    "songs-grid",
    require("./components/elements/sections/songsGrid.vue").default
);
Vue.component(
    "podcast-genres",
    require("./components/elements/sections/PodcastGenres.vue").default
);

//upload
Vue.component(
    "upload-image",
    require("./components/elements/upload/UploadImage.vue").default
);

//audio-player
Vue.component(
    "player",
    require("./components/player/audio-player/Index.vue").default
);



// menus
Vue.component(
    "song-menu",
    require("./components/elements/menus/Song.vue").default
);
Vue.component(
    "user-menu",
    require("./components/elements/menus/User.vue").default
);


