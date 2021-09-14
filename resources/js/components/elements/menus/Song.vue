<template>
    <div>
        <ul class="abs-menu-container__list">
            <li
                @click.stop="
                    $store.commit('setAddSongToPlaylist', song.id);
                    $emit('close');
                "
            >
                <v-icon>mdi-playlist-music</v-icon> {{$t('Add To Playlist')}}
            </li>
            <li
                @click.stop="
                    $store.dispatch('playSong', { song, reset: false });
                    $emit('close');
                "
            >
                <v-icon>mdi-playlist-music</v-icon> {{$t('Add To Queue')}}
            </li>
            <li v-if="song.artist">
                <div
                    @click.stop="
                        $router.push({
                            name: 'artist',
                            params: { id: song.artist.id }
                        });
                        $emit('close');
                        $emit('goToArtist')
                    "
                >
                    <v-icon>mdi-account-music</v-icon>
                    {{$t('Go To Artist')}}
                </div>
            </li>
            <li @click="showSharingDialog">
                <div>
                    <v-icon>mdi-share</v-icon>
                    {{$t('Share')}}
                </div>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    props: ["song"],
    computed: {
        getSongUrl() {
            const appUrl = this.$store.getters.getSettings.appUrl;
            if (!this.song.podcast) {
                return (
                    appUrl +
                    (appUrl.substring(appUrl.length - 1) === "/"
                        ? "song/"
                        : "/song/") +
                    this.song.id
                );
            } else {
                return (
                    appUrl +
                    (appUrl.substring(appUrl.length - 1) === "/"
                        ? "episode/"
                        : "/episode/") +
                    this.song.podcast.id
                );
            }
        }
    },
    methods: {
        showSharingDialog() {
            this.$store.commit('showSharingDialog', this.getSongUrl)
        }
    }
};
</script>
