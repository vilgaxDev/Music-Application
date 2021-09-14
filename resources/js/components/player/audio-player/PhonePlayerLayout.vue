<template>
  <div class="small-screen-player">
    <div class="epico_phone-layout-full">
      <div class="epico_player-container">
        <div class="epico_playlist-container">
          <ul
            class="epico_playlist-ul"
            :style="{ maxHeight: showPlaylist ? '45vh' : '0px' }"
          >
            <li
              class="epico_playlist-audio"
              @click="$emit('updateCurrentAudio', [i, true])"
              :class="{ 'active-song': currentAudio.index == i }"
              v-for="(audio, i) in playlist"
              :key="i"
            >
              {{ audio }}
              <div class="audio-cover">
                <v-img
                  :src="audio.cover"
                  class="img"
                  max-width="55"
                  aspect-ratio="1"
                >
                  <template v-slot:placeholder>
                    <div class="song-expo-skeleton fill-height">
                      <content-placeholders :rounded="true">
                        <content-placeholders-img />
                      </content-placeholders>
                    </div>
                  </template>
                </v-img>
              </div>
              <div class="audio-info">
                <div class="epico_audio-title">
                  {{ audio.title }}
                </div>
                <div class="audio-artist episode-podcast">
                  <template v-if="audio.podcast">
                    <router-link
                      class="router-link"
                      :to="{
                        name: 'podcast',
                        params: { id: audio.podcast.id },
                      }"
                      >{{ audio.podcast.title }}</router-link
                    >
                  </template>
                  <template v-else-if="audio.artist">
                    <router-link
                      class="router-link"
                      :to="{
                        name: 'artist',
                        params: { id: audio.artist.id },
                      }"
                      >{{ audio.artist.displayname }}</router-link
                    >
                  </template>
                </div>
              </div>
              <div
                class="epico_music-is-playing-container"
                v-if="currentAudio.index == i && currentAudio.isPlaying"
              >
                <span></span>
                <span></span>
                <span></span>
              </div>
              <div class="epico_music-is-playing-container" v-else>
                <v-icon color="primary" :title="$t('Play')">mdi-play</v-icon>
              </div>
            </li>
          </ul>
          <div class="epico_playlist-text-container px-3">
            <button
              class="epico_chevron-down"
              @click="fullScreenPlayer = false"
            >
              <v-icon large>mdi-chevron-down</v-icon>
            </button>
            <div
              class="download-button"
              v-if="
                hasPermission('Download songs') &&
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
            >
              <v-icon left color="textContMedium">mdi-playlist-music</v-icon>
              {{ $t("Queue") }}
              <v-icon
                color="textContMedium"
                :style="{
                  transform: showPlaylist ? 'rotate(0deg)' : 'rotate(180deg)',
                }"
                >mdi-chevron-up</v-icon
              >
            </v-chip>
          </div>
        </div>
        <div class="epico_player-main-container">
          <div
            class="epico_image-section"
            :style="{
              opacity: currentAudio.source_format === 'yt_video' ? 0 : 1,
            }"
          >
            <v-img :src="currentAudio.cover" class="img" aspect-ratio="1">
              <template v-slot:placeholder>
                <v-row class="fill-height ma-0" align="center" justify="center">
                  <content-placeholders :rounded="true" style="width: 100%">
                    <content-placeholders-img />
                  </content-placeholders>
                </v-row>
              </template>
            </v-img>
          </div>
          <div class="epico_details-section">
            <div class="epico_audio-info" v-if="!isRadioStation">
              <p class="epico_audio-album" v-if="currentAudio.album">
                {{ currentAudio.album.title }}
              </p>
              <p class="epico_audio-album" v-if="isPodcastEpisode">
                {{ currentAudio.podcast.title }}
              </p>
              <div @click="$emit('fullScreenPlayer')" class="epico_audio-title">
                <router-link
                  v-if="!isPodcastEpisode"
                  :to="{
                    name: 'song',
                    params: { id: currentAudio.id },
                  }"
                  class="router-link"
                  >{{ currentAudio.title }}</router-link
                >
                <template v-else>{{ currentAudio.title }}</template>
              </div>
              <p class="epico_audio-artist" v-if="!isPodcastEpisode">
                {{ getArtists(currentAudio.artists) }}
              </p>
            </div>
            <div class="epico_audio-info" v-else>
              <div class="now-playing">
                <template v-if="isLoading"> {{ $t("Loading") }}... </template>
                <template v-if="!isLoading && currentAudio.title">
                  {{ $t("Now Playing") }}
                </template>
              </div>
              <div class="live-stream-title-container">
                <div class="hiding-box-left"></div>
                <div
                  class="live-stream-title no-wrap"
                  id="live-stream-title"
                  :class="{
                    slideAnimation:
                      currentAudio.title && currentAudio.title.length > 25,
                  }"
                >
                  {{ currentAudio.title || currentAudio.name }}
                </div>
                <div class="hiding-box-right"></div>
              </div>
              <p class="epico_audio-artist" v-if="currentAudio.artist">
                {{ currentAudio.artist }}
              </p>
            </div>
            <div class="epico_control-section">
              <div class="epico_progressbar-container">
                <div
                  class="epico_progressbar"
                  @click="$emit('updateProgressOnPhone', $event)"
                  id="progress-bar_phone_layout"
                  v-if="!isRadioStation"
                >
                  <div
                    class="epico_progressbar-inner"
                    :style="{
                      width: currentAudio.progress + '%',
                    }"
                  >
                    <span class="epico_progress-circle"></span>
                  </div>
                </div>
                <div
                  class="epico_progressbar"
                  @click="$emit('updateProgressOnPhone', $event)"
                  id="progress-bar_phone_layout"
                  v-else
                >
                  <div
                    class="epico_progressbar-inner"
                    :style="{
                      width: '100%',
                    }"
                  >
                    <span class="epico_progress-circle"></span>
                  </div>
                </div>
                <span class="epico_loading-circle"></span>
                <span class="epico_current-audio-time">{{
                  currentAudio.currentTime
                }}</span>
                <span
                  class="epico_current-audio-duration"
                  v-if="!isRadioStation"
                >
                  {{ currentAudio.duration }}
                </span>
                <span
                  class="live-animation epico_current-audio-duration"
                  v-else
                >
                  <div class="align-center">
                    <svg height="20" width="13" class="blinking">
                      <circle cx="5" cy="10" r="3" fill="red"></circle>
                    </svg>
                    {{ $t("Live") }}
                  </div>
                </span>
              </div>
              <div class="epico_main-control-section">
                <div class="epico_play-next-previous-container">
                  <button
                    v-if="!isPodcastEpisode && !isRadioStation"
                    class="epico_previous-button"
                    @click="$emit('goPrevious')"
                    :disabled="!playlist[currentAudio.index - 1]"
                    :title="$t('Previous')"
                  >
                    <v-icon color="textContMedium">mdi-skip-previous</v-icon>
                  </button>
                  <button
                    v-else-if="isPodcastEpisode"
                    class="epico_previous-button epico_rewind-button"
                    :title="$t('Rewind')"
                    @click="$emit('rewindAudio', -10)"
                  >
                    <v-icon color="textContMedium">mdi-rewind-10</v-icon>
                  </button>
                  <button class="epico_btn epico_play-button epico_no-border">
                    <template v-if="isLoading">
                      <v-progress-circular
                        :size="60"
                        :width="5"
                        color="primary"
                        indeterminate
                        v-if="isLoading"
                      ></v-progress-circular>
                    </template>
                    <template v-else>
                      <button
                        class="play-button"
                        @click="$emit('playPause')"
                        :title="$t('Play')"
                        v-if="!currentAudio.isPlaying"
                      >
                        <v-icon
                          size="60"
                          :color="
                            $vuetify.theme.dark ? 'textContMedium' : 'primary'
                          "
                          >mdi-play-circle</v-icon
                        >
                      </button>
                      <button
                        class="play-button"
                        @click="$emit('playPause')"
                        v-else
                        :title="$t('Pause')"
                      >
                        <v-icon
                          size="60"
                          :color="
                            $vuetify.theme.dark ? 'textContMedium' : 'primary'
                          "
                          >mdi-pause-circle</v-icon
                        >
                      </button>
                    </template>
                  </button>
                  <button
                    v-if="!isPodcastEpisode && !isRadioStation"
                    class="epico_next-button"
                    :disabled="!playlist[currentAudio.index + 1]"
                    @click="$emit('goNext')"
                    :title="$t('Next')"
                  >
                    <v-icon color="textContMedium">mdi-skip-next</v-icon>
                  </button>
                  <button
                    v-else-if="isPodcastEpisode"
                    class="epico_next-button epico_forwrad-button"
                    @click="$emit('rewindAudio', +30)"
                    :title="$t('Rewind')"
                  >
                    <v-icon color="textContMedium">mdi-fast-forward-30</v-icon>
                  </button>
                </div>
              </div>
            </div>
            <div class="epico_option-section">
              <div
                class="plus-container"
                @click="showAddMenu = !showAddMenu"
                v-if="!isPodcastEpisode && !isRadioStation"
              >
                <v-icon color="textContMedium" size="36">mdi-plus</v-icon>
                <abs-menu
                  v-show="showAddMenu"
                  :style="{ bottom: '100%', left: '30%' }"
                >
                  <song-menu
                    :song="currentAudio"
                    @close="showAddMenu = false"
                    @goToArtist="$emit('fullScreenPlayer')"
                  ></song-menu>
                </abs-menu>
              </div>
              <button
                class="epico_shuffle-button"
                v-if="!isPodcastEpisode && !isRadioStation"
              >
                <v-icon
                  :title="$t('Shuffle')"
                  @click="buttons.shuffle = !buttons.shuffle"
                  :color="buttons.shuffle ? 'primary' : 'textContMedium'"
                  >mdi-shuffle-variant</v-icon
                >
              </button>
              <template v-if="!isRadioStation">
                <div
                  class="align-center"
                  v-if="isLiked"
                  @click="$emit('like', currentAudio.id)"
                >
                  <button class="epico_heart-button">
                    <v-icon color="primary">mdi-heart</v-icon>
                  </button>
                </div>
                <div
                  class="align-center"
                  @click="$emit('like', currentAudio.id)"
                  v-else
                >
                  <button class="epico_heart-button">
                    <v-icon>mdi-heart-outline</v-icon>
                  </button>
                </div>
              </template>
              <button
                class="epico_repeat-button"
                v-if="!isPodcastEpisode && !isRadioStation"
              >
                <v-icon
                  :color="buttons.loop ? 'primary' : 'textContMedium'"
                  :title="$t('Loop')"
                  @click="$emit('loopAudio')"
                  >mdi-refresh</v-icon
                >
              </button>
              <div class="epico_volume-button-container">
                <v-btn @click="$emit('mute', $event)" icon small>
                  <v-icon color="textContMedium">mdi-{{ volumeButton }}</v-icon>
                </v-btn>
                <!-- Mute or unmute only-->
                <!-- <div
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
                    </div> -->
              </div>
            </div>
          </div>
        </div>
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
    };
  },
  computed: {
    fullScreenPlayer: {
      get() {
        return this.fullScreenPlayerProp;
      },
      set() {
        this.$emit("fullScreenPlayer");
      },
    },
  },
  props: [
    "playlist",
    "currentAudio",
    "downloadLoading",
    "fullScreenPlayerProp",
    "getUp",
    "isLoading",
    "buttons",
    "volumebarInnerWidth",
    "playbackRate",
    "volumeButton",
    "isLiked",
    "isArtistFollowed",
    "isPodcastEpisode",
    "isRadioStation",
    "volumeButton",
  ],
};
</script>
