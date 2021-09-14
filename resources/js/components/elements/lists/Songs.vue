<template>
    <div class="content-list-wrapper">
        <ul v-if="songs">
            <li v-if="headers">
                <div class="rank" v-if="ranked">
                    #
                </div>

                <div class="" v-if="songs.length">
                    {{$t('Title')}}
                </div>
            </li>
            <li
                v-for="(song, i) in songs"
                :key="i"
                class="relative"
                @contextmenu.prevent.stop="
                    $store.commit('setSongContextMenu', compid + i)
                "
                @click="$store.dispatch('playSong', { song, reset: true })"
            >
                <abs-menu
                    v-if="$store.getters.getSongContextMenu == compid + i"
                    :style="{ top: '24px', right: 0 }"
                >
                    <song-menu
                        :song="song"
                        @close="$store.commit('setSongContextMenu', null)"
                    ></song-menu>
                </abs-menu>
                <div class="rank" v-if="ranked">
                    <v-icon class="play-icon" small>mdi-play</v-icon>
                    <span class="rank__rank">{{ i + 1 }}</span>
                </div>

                <div class="item-cover">
                    <v-img :src="song.cover" class="img" aspect-ratio="1">
                        <template v-slot:placeholder>
                            <v-row
                                class="fill-height ma-0"
                                align="center"
                                justify="center"
                            >
                                <content-placeholders
                                    :rounded="true"
                                    style="width: 100%"
                                >
                                    <content-placeholders-img />
                                </content-placeholders>
                            </v-row>
                        </template>
                    </v-img>
                </div>

                <div class="item-info relative">
                    <div
                        class="song-title router-link  text-overflow-ellipsis pointer"
                        @click.stop="
                            $router.push({
                                name: 'song',
                                params: { id: song.id }
                            })
                        "
                    >
                        {{ song.title }}
                        <v-icon
                            small
                            v-if="
                                song.youtube_id &&
                                    $store.getters.getSettings.allowVideos
                            "
                            >mdi-youtube</v-icon
                        >
                    </div>
                    <div
                        class="epico_music-is-playing-container absolute"
                        style="right: 0"
                        v-if="
                            $store.getters.getCurrentAudio &&
                                $store.getters.getCurrentAudio.id == song.id
                        "
                    >
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <div class="item-artist">
                    <router-link
                        class="router-link"
                        :to="{ name: 'artist', params: { id: song.artist_id } }"
                        v-if="song.artist_id"
                    >
                        {{ song.artist_name }}
                    </router-link>
                    <span v-else>{{ song.artist_name }}</span>
                </div>
                <div class="options">
                    <template v-if="!customOptions">
                        <div class="like-button">
                            <div
                                class="button-svg-container"
                                v-if="isLiked(song.id)"
                                @click.stop="like(song.id)"
                            >
                                <v-icon color="primary" class="pointer" small
                                    >mdi-heart</v-icon
                                >
                            </div>
                            <div
                                class="button-svg-container"
                                v-else
                                @click.stop="like(song.id)"
                            >
                                <v-icon class="pointer" small
                                    >mdi-heart-outline</v-icon
                                >
                            </div>
                        </div>
                    </template>
                    <template v-else>
                        <div class="custom-options">
                            <div
                                v-if="hasPermission('Publish songs')"
                                class="private"
                                @click.stop="changePrivacy(song)"
                            >
                                <button
                                    class="button-with-img-inside warning"
                                    v-if="!song.public"
                                    :title="$t('Make Public')"
                                >
                                    <div class="image">
                                        <img
                                            src="/svg/lock-rounded.svg"
                                            alt=""
                                            class="svg-image"
                                        />
                                    </div>
                                    <div class="content-text">
                                        {{$t('Private')}}
                                    </div>
                                </button>
                                <button
                                    class="button-with-img-inside success"
                                    :title="$t('Make Private')"
                                    v-else
                                >
                                    <div class="image">
                                        <img
                                            src="/svg/lock-rounded-open.svg"
                                            alt=""
                                            class="svg-image"
                                        />
                                    </div>
                                    <div class="content-text">
                                        {{$t('Public')}}
                                    </div>
                                </button>
                            </div>
                            <div
                                v-if="
                                    hasPermission('Download songs') &&
                                    song.source_format === 'file' &&
                                    $store.getters.getSettings.downloadButton
                                "
                                class="download"
                                @click.stop="download(song)"
                            >
                                <button
                                    class="button-with-img-inside primary"
                                    :disabled="isLoading === song.id"
                                >
                                    <div class="image">
                                        <v-progress-circular
                                            indeterminate
                                            :size="15"
                                            class="progress-circle"
                                            :width="3"
                                            color="primary"
                                            v-if="isLoading === song.id"
                                        ></v-progress-circular>
                                        <img
                                            v-else
                                            src="/svg/download.svg"
                                            alt=""
                                            class="svg-image"
                                        />
                                    </div>
                                    <div class="content-text">
                                        {{$t('Download')}}
                                    </div>
                                </button>
                            </div>
                            <div
                                class="delete-button"
                                @click.stop="deleteSong(song.id, song.title)"
                            >
                                <button class="button-with-img-inside danger">
                                    <div class="image">
                                        <img
                                            src="/svg/trash-can.svg"
                                            alt=""
                                            class="svg-image"
                                        />
                                    </div>
                                    <div class="content-text">
                                        {{$t('Delete')}}
                                    </div>
                                </button>
                            </div>
                        </div>
                    </template>
                </div>
            </li>
        </ul>
        <ul class="skeleton-list" v-else>
            <div class="skeleton" v-for="n in 7" :key="n">
                <content-placeholders :rounded="true">
                    <content-placeholders-img />
                </content-placeholders>
                <content-placeholders :rounded="true">
                    <content-placeholders-img />
                </content-placeholders>
            </div>
        </ul>
    </div>
</template>

<script>
export default {
    props: ["songs", "customOptions", "ranked", "headers"],
    data() {
        return {
            compid: Math.floor(Math.random(50 * 50) * 5000),
            isLoading: null
        };
    },
    methods: {
        isLiked(song_id) {
            return (this.$store.getters.getLikedSongs || []).some(x =>
                x ? x.id === song_id : false
            );
        },
        like(song_id) {
            if (this.isLiked(song_id)) {
                this.$store.dispatch("dislike", song_id);
            } else {
                this.$store.dispatch("like", song_id);
            }
        },
        download(song) {
            this.isLoading = song.id;
            this.$store
                .dispatch("downloadAudio", { id: song.id, file_name: song.file_name, type: 'song' })
                .finally(() => {
                    this.isLoading = null;
                });
        },
        deleteSong(song_id) {
            this.$confirm({
                message: `${this.$t("Are you sure you wanna delete this") + " " + this.$t("Song") + "?"}`,
                button: {
                    no: this.$t('No'),
                    yes: this.$t("Yes")
                },
                /**
                 * Callback Function
                 * @param {Boolean} confirm
                 */
                callback: confirm => {
                    if (confirm) {
                        this.$store
                            .dispatch("delete_user_song", song_id)
                            .then(res => {
                                this.$notify({
                                    group: "foo",
                                    type: "success",
                                    title: this.$t("Song Deleted"),
                                    text: this.$t("Song has been deleted successfully.")
                                });
                            });
                    }
                }
            });
        },
        changePrivacy(song) {
            if (song.public == 1) {
                this.$confirm({
                    message: `${this.$t("Are you sure you wanna make this song private? This means that it's gonna be visible only for you.")}`,
                    button: {
                        no: this.$t('No'),
                        yes: this.$t("Yes")
                    },
                    /**
                     * Callback Function
                     * @param {Boolean} confirm
                     */
                    callback: confirm => {
                        if (confirm) {
                            this.$store.dispatch("make_song_private", song.id);
                        }
                    }
                });
            } else {
                this.$confirm({
                    message: `${this.$t("Are you sure you wanna make this song public? This means that it's gonna be visible on your profile.")}`,
                    button: {
                        no: this.$t('No'),
                        yes: this.$t("Yes")
                    },
                    /**
                     * Callback Function
                     * @param {Boolean} confirm
                     */
                    callback: confirm => {
                        if (confirm) {
                            this.$store.dispatch("make_song_public", song.id);
                        }
                    }
                });
            }
        }
    }
};
</script>
