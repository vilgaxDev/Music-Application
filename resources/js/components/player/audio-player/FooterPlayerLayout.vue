<template>
    <div
        class="epico_footer-layout"
        id="player-wrapper"
        :style="{
            transform: !getUp
                ? 'translateY(120px)'
                : fullScreenPlayer
                ? 'translateY(-50px)'
                : 'translateY(0px)',
            opacity: fullScreenPlayer ? 0.5 : 1
        }"
    >
        <div class="epico_player-main-container">
            <div class="epico_audio-info epico_audio-info-u500h">
                <div
                    class="plus-container"
                    @click="showAddMenu = !showAddMenu"
                    v-if="!isPodcastEpisode && !isRadioStation"
                >
                    <v-icon color="textContMedium" class="pointer" size="28"
                        >mdi-plus</v-icon
                    >
                    <abs-menu
                        v-show="showAddMenu"
                        :style="{ bottom: '100%', left: '30%' }"
                    >
                        <song-menu
                            :song="currentAudio"
                            @close="showAddMenu = false"
                        ></song-menu>
                    </abs-menu>
                </div>
                <div
                    class="chevron-up-container px-3 pb-1"
                    @click="fullScreenPlayer = true"
                >
                    <v-icon class="pointer">mdi-chevron-up</v-icon>
                </div>
                <v-card class="song-img transparent ml-2" elevation="0">
                    <v-img
                        :src="currentAudio.cover"
                        class="img"
                        aspect-ratio="1"
                    >
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
                </v-card>
                <div class="infos">
                    <div class="current-info" v-if="!isRadioStation">
                        <div class="audio-album" v-if="currentAudio.album">
                            <router-link
                                class="router-link"
                                :to="{
                                    name: 'album',
                                    params: { id: currentAudio.album.id }
                                }"
                            >
                                {{ currentAudio.album.title }}
                            </router-link>
                        </div>
                        <div
                            class="audio-album max-1-lines"
                            v-else-if="currentAudio.podcast"
                        >
                            <router-link
                                class="router-link"
                                :to="{
                                    name: 'podcast',
                                    params: { id: currentAudio.podcast.id }
                                }"
                            >
                                {{ currentAudio.podcast.title }}
                            </router-link>
                        </div>
                        <div class="audio-title max-1-lines">
                            <router-link
                                v-if="!isPodcastEpisode"
                                :to="{
                                    name: 'song',
                                    params: { id: currentAudio.id }
                                }"
                                class="router-link"
                                >{{ currentAudio.title }}</router-link
                            >
                            <template v-else>{{ currentAudio.title }}</template>
                        </div>
                        <div
                            class="audio-artists max-1-lines"
                            v-if="!isPodcastEpisode"
                        >
                            {{ getArtists(currentAudio.artists) }}
                        </div>
                    </div>
                    <div class="current-info" v-else>
                        <div class="now-playing">
                            <template v-if="isLoading">
                                {{ $t("Loading") }}...
                            </template>
                            <template v-if="!isLoading && currentAudio.title">
                                {{ $t("Now Playing") }}
                            </template>
                        </div>
                        <div class="live-stream-title-container">
                            <div class="hiding-box-left"></div>
                            <div class="live-stream-title" id="live-stream-title" :class="{ slideAnimation: currentAudio.title && currentAudio.title.length > 25 }">
                                {{ currentAudio.title || currentAudio.name }}
                            </div>
                            <div class="hiding-box-right"></div>
                        </div>
                        <div
                            class="audio-artists max-1-lines"
                            v-if="currentAudio.artist"
                        >
                            {{ currentAudio.artist }}
                        </div>
                    </div>
                    <template v-if="!isRadioStation">
                        <v-btn
                            v-if="isLiked"
                            icon
                            @click="$emit('like', currentAudio.id)"
                            class="align-center ml-2"
                            small
                        >
                            <v-icon small color="primary" :title="$t('Dislike')"
                                >mdi-heart</v-icon
                            >
                        </v-btn>
                        <v-btn
                            class="align-center ml-2"
                            icon
                            small
                            @click="$emit('like', currentAudio.id)"
                            v-else
                        >
                            <v-icon :title="$t('Play')" small
                                >mdi-heart-outline</v-icon
                            >
                        </v-btn>
                    </template>
                </div>
            </div>
            <div class="epico_main-control-section">
                <div class="epico_progressbar-container">
                    <div
                        class="epico_progressbar epico_progressbar-u500h"
                        id="progress-bar"
                        v-if="!isRadioStation"
                        @click="$emit('updateProgress', $event)"
                    >
                        <div
                            class="epico_progressbar-inner"
                            :style="{ width: currentAudio.progress + '%' }"
                        >
                            <span class="epico_progress-circle"></span>
                        </div>
                    </div>
                    <div
                        class="epico_progressbar epico_progressbar-u500h"
                        id="progress-bar"
                        v-else
                        @click="$emit('updateProgress', $event)"
                    >
                        <div
                            class="epico_progressbar-inner"
                            :style="{ width: '100%' }"
                        ></div>
                    </div>
                    <span
                        class="epico_loading-circle"
                        style="opacity: 0"
                    ></span>
                    <div class="times">
                        <span class="current-audio-time">
                            {{ currentAudio.currentTime }}
                        </span>
                        <span
                            class="current-audio-duration"
                            v-if="!isRadioStation"
                        >
                            {{ currentAudio.duration }}
                        </span>
                        <div class="live-animation" v-else>
                            <div class="align-center">
                                <svg height="20" width="13" class="blinking">
                                    <circle
                                        cx="5"
                                        cy="10"
                                        r="3"
                                        fill="red"
                                    ></circle>
                                </svg>
                                {{ $t("Live") }}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="play-next-previous-container">
                    <template v-if="!isRadioStation">
                        <button
                            class="repeat-button"
                            @click="$emit('loopAudio')"
                            :class="{ activeButton: buttons.loop }"
                            v-if="!isPodcastEpisode"
                            :title="$t('Loop')"
                        >
                            <v-icon
                                :color="
                                    buttons.loop ? 'primary' : 'textContMedium'
                                "
                                >mdi-refresh</v-icon
                            >
                        </button>
                        <button
                            v-else
                            class="random-button"
                            :disabled="playlist.length <= 1"
                            @click="buttons.shuffle = !buttons.shuffle"
                            :class="{ activeButton: buttons.shuffle }"
                            :title="$t('Shuffle')"
                        >
                            <v-icon
                                :color="
                                    buttons.shuffle
                                        ? 'primary'
                                        : 'textContMedium'
                                "
                                >mdi-shuffle-variant</v-icon
                            >
                        </button>
                        <button
                            class="previous-button"
                            @click="$emit('goPrevious')"
                            v-if="!isPodcastEpisode"
                            :title="$t('Previous')"
                            :disabled="!playlist[currentAudio.index - 1]"
                        >
                            <v-icon color="textContMedium"
                                >mdi-skip-previous</v-icon
                            >
                        </button>
                        <button
                            v-else
                            :title="$t('Rewind')"
                            class="epico_previous-button epico_rewind-button"
                            @click="$emit('rewindAudio', -10)"
                        >
                            <v-icon color="textContMedium"
                                >mdi-rewind-10</v-icon
                            >
                        </button>
                    </template>
                    <template v-if="isLoading">
                        <v-progress-circular
                            :size="38"
                            :width="5"
                            color="primary"
                            indeterminate
                            style="margin: 0.45em 1em"
                        ></v-progress-circular>
                    </template>
                    <template v-else>
                        <button
                            class="play-button"
                            @click="$emit('playPause')"
                            :title="$t('Play') + '/' + $t('Pause')"
                            v-if="!currentAudio.isPlaying"
                        >
                            <v-icon
                                size="49"
                                large
                                :color="
                                    $vuetify.theme.dark
                                        ? 'textContMedium'
                                        : 'primary'
                                "
                                >mdi-play-circle</v-icon
                            >
                        </button>
                        <button
                            class="play-button"
                            @click="$emit('playPause')"
                            v-else
                        >
                            <v-icon
                                size="49"
                                large
                                :color="
                                    $vuetify.theme.dark
                                        ? 'textContMedium'
                                        : 'primary'
                                "
                                >mdi-pause-circle</v-icon
                            >
                        </button>
                    </template>

                    <template v-if="!isRadioStation">
                        <button
                            class="next-button"
                            @click="$emit('goNext')"
                            :title="$t('Next')"
                            :disabled="!playlist[currentAudio.index + 1]"
                            v-if="!isPodcastEpisode"
                        >
                            <v-icon color="textContMedium"
                                >mdi-skip-next</v-icon
                            >
                        </button>
                        <button
                            v-else
                            class="epico_next-button epico_forwrad-button"
                            @click="$emit('rewindAudio', +30)"
                            :title="$t('Rewind')"
                        >
                            <v-icon color="textContMedium"
                                >mdi-fast-forward-30</v-icon
                            >
                        </button>
                        <button
                            v-if="!isPodcastEpisode"
                            class="random-button"
                            :disabled="playlist.length <= 1"
                            @click="buttons.shuffle = !buttons.shuffle"
                            :class="{ activeButton: buttons.shuffle }"
                        >
                            <v-icon
                                :title="$t('Shuffle')"
                                :color="
                                    buttons.shuffle
                                        ? 'primary'
                                        : 'textContMedium'
                                "
                                >mdi-shuffle-variant</v-icon
                            >
                        </button>
                        <button
                            class="playback_rate__button"
                            @click="$emit('adjustPlayspeed')"
                            :title="$t('Play Speed')"
                            v-else
                        >
                            <span
                                class="playback_rate"
                                :color="
                                    playbackRate > 1
                                        ? 'primary'
                                        : 'textContMedium'
                                "
                                >{{ playbackRate }}x</span
                            >
                        </button>
                    </template>
                </div>
            </div>
            <div class="epico_option-section epico_option-section-u500h">
                <div class="epico_option-section__group">
                    <div class="btn-group d-flex align-center">
                        <div
                            class="download-button"
                            v-if="
                                
                                currentAudio.source_format === 'file' &&
                                $store.getters.getSettings.downloadButton
                            "
                        >
                            <v-btn
                                x-small
                                :title="$t('Download')"
                                color="primary"
                                class="mr-2"
                                :disabled="downloadLoading"
                                fab
                                :loading="downloadLoading"
                                dense
                                @click="$emit('downloadAudio')"
                            >

                                <v-icon>mdi-download-circle</v-icon>
                            </v-btn>
                        </div>
                        <v-chip
                            v-if="playlist.length > 1"
                            @click="showPlaylist = !showPlaylist"
                            class="ma-2"
                            outlined
                            small
                        >
                            <v-icon left color="textContMedium"
                                >mdi-playlist-music</v-icon
                            >
                            <span v-if="$store.getters.getScreenWidth > 900">{{
                                $t("Queue")
                            }}</span>
                            <v-icon
                                :style="{
                                    transform: showPlaylist
                                        ? 'rotate(0deg)'
                                        : 'rotate(180deg)'
                                }"
                                >mdi-chevron-up</v-icon
                            >
                        </v-chip>
                    </div>
                </div>
                <div class="epico_volume-button-container">
                    <v-btn @click="$emit('mute', $event)" icon small>
                        <v-icon color="textContMedium"
                            >mdi-{{ volumeButton }}</v-icon
                        >
                    </v-btn>
                    <div
                        class="epico_volumebar-container epico_volumebar-container-u500h"
                    >
                        <v-slider
                            v-model="vol"
                            @change="$emit('volume', vol)"
                            thumb-color="primary"
                            tick-size="50"
                            thumb-size="22"
                            hide-details=""
                            :thumb-label="true"
                        ></v-slider>
                    </div>
                </div>
            </div>
            <div class="epico_play-circle-phone-layout">
                <button
                    class="play-button"
                    :title="$t('Play') + '/' + $t('Pause')"
                    @click="$emit('playPause')"
                    v-if="!currentAudio.isPlaying"
                >
                    <v-progress-circular
                        :rotate="-90"
                        :size="36"
                        class="progress-circle"
                        :width="5"
                        :value="isRadioStation ? 100 : currentAudio.progress"
                        color="primary"
                    ></v-progress-circular>
                    <div>
                        <v-icon
                            size="50"
                            large
                            :color="
                                $vuetify.theme.dark
                                    ? 'textContMedium'
                                    : 'primary'
                            "
                            >mdi-play-circle</v-icon
                        >
                    </div>
                </button>
                <button class="play-button" @click="$emit('playPause')" v-else>
                    <v-progress-circular
                        :rotate="-90"
                        :size="36"
                        class="progress-circle"
                        :width="5"
                        :value="isRadioStation ? 100 : currentAudio.progress"
                        color="primary"
                    ></v-progress-circular>
                    <div>
                        <v-icon
                            size="50"
                            large
                            :color="
                                $vuetify.theme.dark
                                    ? 'textContMedium'
                                    : 'primary'
                            "
                            >mdi-pause-circle</v-icon
                        >
                    </div>
                </button>
            </div>
        </div>
        <div class="epico_playlist-container" v-if="playlist.length > 1">
            <div
                class="epico_playlist-ul-wrapper"
                :style="{
                    transform: showPlaylist
                        ? 'translateY(0em)'
                        : 'translateY(100%) '
                }"
            >
                <ul class="epico_playlist-ul">
                    <li
                        class="epico_playlist-audio"
                        v-for="(audio, i) in playlist"
                        :key="i"
                        @click="$emit('updateCurrentAudio', [i, true])"
                        :class="{ 'active-Song': currentAudio.index == i }"
                    >
                        <div class="audio-cover">
                            <v-img :src="audio.cover" class="img">
                                <template v-slot:placeholder>
                                    <div class="fill-height">
                                        <content-placeholders :rounded="true">
                                            <content-placeholders-img />
                                        </content-placeholders>
                                    </div>
                                </template>
                            </v-img>
                        </div>
                        <div class="audio-title">{{ audio.title }}</div>
                        <div class="audio-artist">
                            <router-link
                                class="router-link"
                                :to="{
                                    name: 'artist',
                                    params: { id: audio.artist_id }
                                }"
                                v-if="audio.artist_id"
                                >{{ audio.artist_name }}</router-link
                            >
                            <span v-else>{{ audio.artist_name }}</span>
                        </div>
                        <div
                            class="epico_music-is-playing-container"
                            v-if="
                                currentAudio.index == i &&
                                    currentAudio.isPlaying
                            "
                        >
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            showAddMenu: false,
            showPlaylist: false,
            vol: this.volume
            // isTextOverflowed: false,
        };
    },
    computed: {
        fullScreenPlayer: {
            get() {
                return this.fullScreenPlayerProp;
            },
            set() {
                this.$emit("fullScreenPlayer");
            }
        },
        currentTitle() {
            return this.currentAudio.title;
        }
    },
    // watch: {
    //     currentTitle() {
    //         return true
    //         // let element = document.getElementById('live-stream-title');
    //         // if( element ) {
    //         //     let elementWidth = element.clientWidth;
    //         //     if( elementWidth > 300 ) {
    //         //         this.isTextOverflowed =  true;
    //         //     } else {
    //         //         this.isTextOverflowed =  false;
    //         //     }
    //         // }
    //     }
    // },
    props: [
        "playlist",
        "currentAudio",
        "fullScreenPlayerProp",
        "getUp",
        "isLoading",
        "downloadLoading",
        "buttons",
        "volumebarInnerWidth",
        "playbackRate",
        "volumeButton",
        "isLiked",
        "isArtistFollowed",
        "isPodcastEpisode",
        "isRadioStation",
        "volumeButton",
        "volume"
    ]
};
</script>
