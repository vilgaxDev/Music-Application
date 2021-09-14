<template>
    <fixed-left v-if="album">
        <template v-slot:img>
            <div class="img-cover">
                <v-img :src="album.cover" class="img" aspect-ratio="1">
                    <template v-slot:placeholder>
                        <div class="fixed-area__image-skeleton">
                            <content-placeholders :rounded="true">
                                <content-placeholders-img />
                            </content-placeholders>
                        </div>
                    </template>
                </v-img>
            </div>
        </template>
        <template v-slot:infos>
            <div class="info-wrapper">
                <div class="title">
                    <div class="info-badge">{{ $t('Album') }}</div>
                    <div class="title__title">{{ album.title }}</div>
                    <div class="sub">
                        <router-link
                            :to="{
                                name: 'artist',
                                params: { id: album.artist.id }
                            }"
                        >
                            {{ album.artist.displayname }}
                        </router-link>
                        <div class="separator"></div>
                        <span class="bold album-release-date">{{
                            moment(album.release_date).format("ll")
                        }}</span>
                        <div class="separator"></div>
                        <span>{{ album.songs.length }} {{$t('Tracks')}}</span>
                    </div>
                </div>
            </div>
        </template>
        <template v-slot:buttons>
            <div class="buttons">
                <div class="btn-container">
                    <v-btn
                        class="play primary"
                        rounded
                        small
                        @click="$store.dispatch('playAlbum', {album})"
                        >{{ $t('Play') }}</v-btn
                    >
                </div>
                <div class="btn-container">
                    <v-btn
                        class="secondary"
                        rounded
                        small
                        @click="likeAlbum"
                        v-if="!isLiked"
                        >{{$t('Like')}}</v-btn
                    >
                    <v-btn
                        class="primary"
                        rounded
                        small
                        @click="likeAlbum"
                        v-else
                        >{{$t('Dislike')}}</v-btn
                    >
                </div>
            </div>
        </template>
        <template v-slot:main>
            <div
                class="songs-container"
                v-if="album.songs && album.songs.length"
            >
                <song-list
                    :songs="album.songs"
                    class="song-list"
                    headers="true"
                    ranked="true"
                />
            </div>
            <empty-page
                img="peep-68.png"
                :headline="$t('No Songs!')"
                :sub="$t('This album is empty.')"
                v-else
            >
            </empty-page>
        </template>
    </fixed-left>
    <empty-page
        v-else-if="!album && errorStatus == 404"
        :headline="$t('Not Available!')"
        :sub="$t('Album') + ' ' + $t('does not exist.')"
        img="peep-68.png"
    >
        <template v-slot:button>
            <v-btn class="primary" small rounded @click="$router.go(-1)">
               {{ $t('Go back') }}
            </v-btn>
        </template>
    </empty-page>
    <empty-page
        v-else-if="!album && errorStatus"
        :headline="$t('Something wrong happend!')"
        :sub="$t('Some server error has occurred. Try again later.')"
        img="peep-68.png"
    >
        <template v-slot:button>
            <v-btn class="primary" small rounded @click="$router.go(-1)">
               {{ $t('Go back') }}
            </v-btn>
        </template>
    </empty-page>
    <page-loading v-else />
</template>
<script>
export default {
    metaInfo() {
        return {
            title: this.generateMetaInfos(
                this.album,
                this.$store.getters.getSettings.albumPageTitle,
                "album"
            ),
            meta: [
                {
                    name: "description",
                    content: this.generateMetaInfos(
                        this.album,
                        this.$store.getters.getSettings.albumPageDescription,
                        "album"
                    )
                }
            ]
        };
    },
    created() {
        this.fetchAlbum();
    },
    data() {
        return {
            album: null,
            errorStatus: null
        };
    },
    computed: {
        isLiked() {
            return (this.$store.getters.getLikedAlbums || []).some(
                album => album.id === this.album.id
            );
        }
    },
    methods: {
        fetchAlbum() {
            axios
                .get("/api/album/" + this.$route.params.id)
                .then(res => (this.album = res.data))
                .catch(e => (this.errorStatus = e.response.status));
        },
        likeAlbum() {
            if (!this.isLiked) {
                this.$store
                    .dispatch("likeAlbum", this.album.id)
                    .catch(() => {});
            } else {
                this.$store
                    .dispatch("dislikeAlbum", this.album.id)
                    .catch(() => {});
            }
        }
    }
};
</script>
