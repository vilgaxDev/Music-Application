<template>
    <fixed-left class="artist" v-if="artist">
        <template v-slot:img>
            <div class="img-cover">
                <v-img :src="artist.avatar" class="img" aspect-ratio="1">
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
                    <div class="info-badge">{{ $t('ARTIST') }}</div>
                    <div>{{ artist.displayname }}</div>
                </div>
            </div>
            <div class="stats">
                <span class="followers"
                    >{{ artist.nb_followers }} {{$t('Followers')}}
                </span>
                <span class="sep"></span>
                <span class="plays"> {{ artist.plays }} {{$t('Plays')}}</span>
            </div>
        </template>
        <template v-slot:buttons>
            <div class="buttons">
                <div class="follow-button" v-if="isFollowed !== null">
                    <v-btn
                        class="secondary"
                        rounded
                        small
                        @click="follow()"
                        v-if="isFollowed"
                    >
                        {{ $t('Following') }}
                    </v-btn>
                    <v-btn
                        class="primary"
                        rounded
                        small
                        @click="follow()"
                        v-else
                    >
                        {{ $t('Follow') }}
                    </v-btn>
                </div>
                <div class="play-button">
                    <v-btn
                        class="primary"
                        rounded
                        small
                        @click="$store.dispatch('updateQueue', { content: artist.popular, reset: true})"
                    >
                     {{ $t('Play') }}
                    </v-btn>
                </div>
            </div>
        </template>
        <template v-slot:main>
            <div
                class="profile-main-content"
                v-if="
                    artist.popular.length ||
                        (artist.latest && artist.latest.length) ||
                        artist.albums.length ||
                        artist.songs.length
                "
            >
                <div class="latest" v-if="artist.latest">
                    <div class="card-title-medium">
                        {{$t('Latest Song')}}
                    </div>
                    <div class="content">
                        <song-encap
                            :song="artist.latest"
                            @song="$store.commit('updatePlaylist', [$event])"
                        ></song-encap>
                    </div>
                </div>
                <div class="popular-songs" v-if="artist.popular.length">
                    <div class="card-title-medium">
                        {{$t('Popular Songs')}}
                    </div>
                    <song-list :songs="popularSpliced"></song-list>
                    <div class="more-or-less">
                        <div
                            class="more"
                            @click="nPopular += 5"
                            v-if="nPopular < artist.popular.length"
                        >
                            {{$t('More')}}
                        </div>
                    </div>
                </div>
                <div class="albums" v-if="artist.albums.length">
                    <div class="card-title-medium">
                        {{$t('Albums')}}
                    </div>
                    <div class="content">
                        <div
                            class="album-container"
                            v-for="album in artist.albums"
                            :key="album.id"
                        >
                            <album-expo :album="album" />
                        </div>
                    </div>
                </div>
                <div class="singles" v-if="artist.songs.length">
                    <div class="card-title-medium">
                        {{$t('Singles')}}
                    </div>
                    <div class="content">
                        <song-list :songs="singlesSpliced"></song-list>
                    </div>
                    <div class="more-or-less">
                        <div
                            class="more"
                            @click="nSingles += 5"
                            v-if="nSingles < artist.songs.length"
                        >
                            {{$t('More')}}
                        </div>
                    </div>
                </div>
            </div>
            <template v-else>
                <empty-page
                    img="peep-68.png"
                    :headline="$t('This artist profile is empty.')"
                    :sub="$t('Looks like this account is still new!')"
                >
                </empty-page>
            </template>
        </template>
    </fixed-left>
    <empty-page
        v-else-if="!artist && errorStatus == 404"
        :headline="$t('Not Available!')"
        sub="Artist does not exist!"
        img="peep-68.png"
    >
        <template v-slot:button>
            <v-btn class="primary" small rounded @click="$router.go(-1)">
               {{ $t('Go back') }}
            </v-btn>
        </template>
    </empty-page>
    <empty-page
        v-else-if="!artist && errorStatus"
        :headline="$t('Something wrong happend!')"
        :sub="$t('Some server error has occurred. Try again later.')"
        img="peep-68.png"
    >
        <template v-slot:button>
            <v-btn class="primary" rounded small @click="$router.go(-1)"
                >{{$t('Go Back')}}</v-btn
            >
        </template>
    </empty-page>
    <page-loading v-else />
</template>
<script>
export default {
    metaInfo() {
        return {
            title: this.generateMetaInfos(
                this.artist,
                this.$store.getters.getSettings.artistPageTitle,
                "artist"
            ),
            meta: [
                {
                    name: "description",
                    content: this.generateMetaInfos(
                        this.artist,
                        this.$store.getters.getSettings.artistPageDescription,
                        "artist"
                    )
                }
            ]
        };
    },
    data() {
        return {
            artist: null,
            isFollowed: null,
            nPopular: 5,
            nSingles: 5,
            errorStatus: null
        };
    },
    computed: {
        popularSpliced() {
            if (this.artist.popular !== 5) {
                return this.artist.popular.slice(0, this.nPopular);
            } else {
                return this.artist.popular;
            }
        },
        singlesSpliced() {
            if (this.artist.songs !== 5) {
                return this.artist.songs.slice(0, this.nSingles);
            } else {
                return this.artist.songs;
            }
        }
    },
    created() {
        axios
            .get("/api/artist/" + this.$route.params.id)
            .then(res => (this.artist = res.data))
            .then(() => {
                this.$store
                    .dispatch("isArtistFollowed", this.artist.id)
                    .then(res => (this.isFollowed = res));
            })
            .catch(e => (this.errorStatus = e.response.status));
    },
    methods: {
        follow() {
            if (this.isFollowed) {
                this.$store
                    .dispatch("unfollowArtist", this.artist.id)
                    .then(() => {
                        this.isFollowed = false;
                        this.artist.nb_followers--;
                    })
                    .catch(() => {});
            } else {
                this.$store
                    .dispatch("followArtist", this.artist.id)
                    .then(() => {
                        this.isFollowed = true;
                        this.artist.nb_followers++;
                    })
                    .catch(() => {});
            }
        }
    }
};
</script>
<style lang="scss">
.singles img {
    max-width: 50px;
}
.latest > * {
    max-width: 11rem;
}

.singles,
.latest,
.popular-songs,
.albums {
    margin-bottom: 2rem;
}
.albums {
    .content {
        display: flex;
        .album-container {
            max-width: 13em;
            min-width: 11em;
        }
    }
}
</style>
