<template>
    <div class="album-template-container content-item" v-if="album">
        <div class="content-item__header" @click="playAlbum(album)">
            <div class="control-layer">
                <div class="buttons">
                    <button
                        class="button button-play mx-3"
                        @click="playAlbum(album)"
                    >
                        <img
                            src="/svg/play-round.svg"
                            alt="next"
                            class="svg-image"
                        />
                    </button>
                </div>
            </div>
            <div class="cover-layer">
                <v-img :src="album.cover" class="img" aspect-ratio="1">
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
                :to="{ name: 'album', params: { id: album.id } }"
            >
                <div class="content-item__body__type">
                    {{$t('Album')}}
                </div>
                <div class="content-item__body__title max-2-lines">
                    {{ album.title }}
                </div>
            </router-link>
            <div class="content-item__body__sub artist" v-if="album.artist">
                <router-link
                    :key="album.artist.id"
                    :to="{ name: 'artist', params: { id: album.artist.id } }"
                >
                    {{ album.artist.displayname }}
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
import addToPlaylist from "../../dialogs/Playlists";
export default {
    props: ["album"],
    components: {
        addToPlaylist
    },
    data() {
        return {
            showMenu: false,
            addToPlaylist: false
        };
    },
    computed: {
        isLiked() {
            return this.$store.getters.isLiked(this.album.id);
        }
    },
    methods: {
        playAlbum() {
            this.$store.dispatch('playAlbum', { album: this.album });
        },
        like(album_id) {
            if (this.isLiked) {
                this.$store.dispatch("dislike", album_id);
            } else {
                this.$store.dispatch("like", album_id);
            }
        }
    }
};
</script>
