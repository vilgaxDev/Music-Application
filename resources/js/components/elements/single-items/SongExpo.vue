<template>
    <div class="content-item" v-if="song">
        <div class="content-item__header" @click="playSong(song)">
            <slot name="control-layer"></slot>
            <div
                class="control-layer"
                :class="{
                    'force-appearence': $store.getters.getSongMenu === compid
                }"
                v-if="!admin"
            >
                <div class="buttons">
                    <div
                        class="button-svg-container button-heart"
                        v-if="isLiked"
                        @click.stop="like(song.id)"
                    >
                        <v-btn icon small>
                            <v-icon color="white">mdi-heart</v-icon>
                        </v-btn>
                    </div>
                    <div
                        class="button-svg-container button-heart"
                        v-else
                        @click.stop="like(song.id)"
                    >
                        <v-btn icon small>
                            <v-icon color="white">mdi-heart-outline</v-icon>
                        </v-btn>
                    </div>
                    <button
                        class="button button-play mx-3"
                        @click.stop="playSong(song)"
                    >
                        <img
                            src="/svg/play-round.svg"
                            alt="next"
                            class="svg-image"
                        />
                    </button>
                    <button
                        class="button button-dots"
                        @click.stop="$store.commit('setSongMenu', compid)"
                    >
                        <abs-menu
                            v-if="$store.getters.getSongMenu === compid"
                            :style="{ top: '24px', right: '-3em' }"
                        >
                            <song-menu
                                :song="song"
                                @close="$store.commit('setSongMenu', null)"
                            ></song-menu>
                        </abs-menu>
                        <img src="/svg/dots.svg" alt="next" class="svg-image" />
                    </button>
                    <!-- vuetify icon + menu -->
                     <!-- <v-btn
                        icon
                        class="button button-dots"
                        @click.stop="$store.commit('setSongMenu', compid)"
                    >
                        <abs-menu
                            v-if="$store.getters.getSongMenu === compid"
                            :style="{ top: '24px', right: '-3em' }"
                        >
                            <song-menu
                                :song="song"
                                @close="$store.commit('setSongMenu', null)"
                            ></song-menu>
                        </abs-menu>
                        <v-icon color="white">mdi-dots-horizontal</v-icon>
                    </v-btn> -->
                </div>
            </div>
            <div class="cover-layer">
                <v-img :src="song.cover" class="img" aspect-ratio="1">
                    <template v-slot:placeholder>
                        <div class="song-expo-skeleton fill-height">
                            <content-placeholders :rounded="true">
                                <content-placeholders-img />
                            </content-placeholders>
                        </div>
                    </template>
                </v-img>
            </div>
        </div>
        <div class="content-item__body">
            <router-link
                class="content-item__body__title__container"
                :to="{ name: 'song', params: { id: song.id } }"
            >
                <div class="content-item__body__type">
                    {{$t('Song')}}
                </div>
                <div class="content-item__body__title max-2-lines">
                    {{ song.title }}
                </div>
            </router-link>
            <div class="artist max-1-lines">
                <template v-if="song.artist">
                    <template v-for="artist in JSON.parse(song.artists)">
                        <router-link
                            :key="artist.id"
                            v-if="artist == song.artist.displayname"
                            :to="{
                                name: 'artist',
                                params: { id: song.artist.id }
                            }"
                        >
                            {{ song.artist.displayname }}
                        </router-link>
                        <template v-else> Ft. {{ artist }} </template>
                    </template>
                </template>
                <template v-else>
                    {{ getArtists(song.artists) }}
                </template>
            </div>
        </div>
    </div>
</template>
<script>
import Song from "../../dialogs/edit/Song.vue";
export default {
    components: { Song },
    props: ["song", "admin"],

    data() {
        return {
            showMenu: false,
            compid: Math.random() * Math.floor(500000)
        };
    },
    computed: {
        isLiked() {
            if (!this.admin) {
                if (this.$store.getters.getUser) {
                    return this.$store.getters.isLiked(this.song.id);
                }
                return false;
            }
        },
        isArtistFollowed() {
            if (!this.admin) {
                if (
                    this.$store.getters.getUser &&
                    this.$store.getters.getFollowedArtists
                ) {
                    var song = this.song;
                    return this.$store.getters.getFollowedArtists.some(
                        artist => artist.id === song.artist_id
                    );
                } else {
                    return false;
                }
            }
        }
    },
    methods: {
        playSong(song) {
            this.$store.dispatch('playSong',{ song, reset: true });
        },
        like(song_id) {
            if (this.isLiked) {
                this.$store.dispatch("dislike", song_id);
            } else {
                this.$store.dispatch("like", song_id);
            }
        },
        addSongToPlaylist(song_id) {
            this.$store.commit("setAddSongToPlaylist", song_id);
        }
    }
};
</script>
