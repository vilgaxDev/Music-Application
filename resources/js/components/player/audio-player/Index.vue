<template>
  <div id="audio-player-container">
    <TV
      class="video-tv"
      :class="{
        'small-screen': smallScreen || fullScreenPlayer,
        'phone-layout': fullScreenPlayer,
      }"
      v-if="$store.getters.getSettings.allowVideos"
      v-show="currentAudio.source_format === 'yt_video'"
      @small-screen="switchScreenToSmall"
      @large-screen="switchScreenToLarge"
    >
      <div
        id="youtube_video_container"
        :class="{ smallScreenVideo: smallScreen }"
      ></div>
    </TV>
    <phone-player-layout
      :currentAudio="currentAudio"
      :playlist="playlist"
      :getUp="getUp"
      :isLoading="isLoading"
      :playbackRate="playbackRate"
      :isLiked="isLiked"
      :isArtistFollowed="isArtistFollowed"
      :isPodcastEpisode="isPodcastEpisode"
      :isRadioStation="isRadioStation"
      :downloadLoading="downloadLoading"
      :volumeButton="volumeButton"
      :buttons="buttons"
      :volume="volume"
      :fullScreenPlayerProp="fullScreenPlayer"
      :style="{
        transform: 'translateY(' + (fullScreenPlayer ? '0%' : '100%') + ')',
      }"
      @updateCurrentAudio="updateCurrentAudio($event[0], $event[1])"
      @playPause="playPause"
      @adjustPlayspeed="adjustPlayspeed"
      @rewindAudio="rewindAudio($event)"
      @fullScreenPlayer="fullScreenPlayer = false"
      @goNext="goNext"
      @goPrevious="goPrevious"
      @like="like"
      @mute="muteAudio"
      @downloadAudio="downloadAudio"
      @addSongToPlaylist="addSongToPlaylist"
      @updateProgressOnPhone="updateProgressOnPhone"
      @loopAudio="loopAudio"
    />
    <footer-player-layout
      :getUp="getUp"
      :playlist="playlist"
      :isLoading="isLoading"
      :playbackRate="playbackRate"
      :isLiked="isLiked"
      :isArtistFollowed="isArtistFollowed"
      :isPodcastEpisode="isPodcastEpisode"
      :isRadioStation="isRadioStation"
      :downloadLoading="downloadLoading"
      :volumeButton="volumeButton"
      :buttons="buttons"
      :volume="volume"
      :fullScreenPlayerProp="fullScreenPlayer"
      :currentAudio="currentAudio"
      @volume="volume = $event"
      @mute="muteAudio"
      @fullScreenPlayer="fullScreenPlayer = true"
      @updateCurrentAudio="updateCurrentAudio($event[0], $event[1])"
      @downloadAudio="downloadAudio"
      @playPause="playPause"
      @adjustPlayspeed="adjustPlayspeed"
      @rewindAudio="rewindAudio($event)"
      @goNext="goNext"
      @goPrevious="goPrevious"
      @like="like"
      @addSongToPlaylist="addSongToPlaylist"
      @updateProgress="updateProgress"
      @loopAudio="loopAudio"
    />
  </div>
</template>

<script>
import TV from "../../elements/single-items/TV";
import FooterPlayerLayout from "./FooterPlayerLayout";
import PhonePlayerLayout from "./PhonePlayerLayout";
import IcecastMetadataPlayer from "icecast-metadata-player";
import IcecastMetadataStats from "icecast-metadata-stats";

export default {
  props: ["playlist"],
  components: {
    TV,
    FooterPlayerLayout,
    PhonePlayerLayout,
  },
  created() {
    this.initPlayer();
    this.startPlayer();
  },
  data() {
    return {
      audioPlayer: null,
      streamPlayer: null,
      streamAudioElement: null,
      streamStats: null,
      downloadLoading: false,
      queue: [],
      retryCount: 0,
      getUp: false,
      fullScreenPlayer: false,
      isLoading: false,
      canPlay: false,
      smallScreen: false,
      playbackRateDirection: "up",
      videoPlayer: null,
      videoStatus: null,
      volumeButton: "volume-medium",
      timeUpdater: null,
      playbackRate: 1,
      currentAudio: {
        source: null,
        source_format: null,
        index: 0,
        title: "",
        album: "",
        artist: "",
        cover: "",
        progress: 0,
        duration: "-:--",
        currentTime: "0:00",
        videoCurrentTime: 0,
        isPlaying: false,
      },
      buttons: {
        shuffle: false,
        loop: false,
      },
    };
  },
  computed: {
    isPodcastEpisode() {
      return Boolean(this.currentAudio.podcast);
    },
    isRadioStation() {
      return Boolean(this.currentAudio.endpoint);
    },
    isLiked() {
      return (this.$store.getters.getLikedSongs || []).some(
        (x) => x.id == this.currentAudio.id
      );
    },
    isArtistFollowed() {
      return (this.$store.getters.getFollowedArtists || []).some(
        (artist) => artist.id === this.currentAudio.artist_id
      );
    },
    volume: {
      set(val) {
        if (this.streamAudioElement) {
          this.streamAudioElement.volume = val / 100;
        } else {
          this.audioPlayer.volume = val / 100;
        }
      },
      get() {
        if (this.streamAudioElement) {
          return Math.round(this.streamAudioElement.volume * 100);
        } else {
          return Math.round(this.audioPlayer.volume * 100);
        }
      },
    },
  },
  methods: {
    initPlayer() {
      this.audioPlayer = new Audio();
      this.volume = this.$store.getters.getSettings.playerVolume || 50;
      this.audioPlayer.preload = "metadata";
      // attaching the events to their handlers
      this.audioPlayer.onloadstart = this.onloadstart;
      this.audioPlayer.onerror = this.onerror;
      this.audioPlayer.onloadedmetadata = this.onloadedmetadata;
      this.audioPlayer.oncanplay = this.oncanplay;
      this.audioPlayer.ontimeupdate = this.ontimeupdate;
      this.audioPlayer.onended = this.ended;
      this.audioPlayer.onwaiting = this.onwaiting;
      this.audioPlayer.oncanplaythrough = this.oncanplay;
      setTimeout(() => {
        this.getUp = true;
      }, 100);
    },
    initStreamPlayer(station) {
      this.canPlay = true;
      this.isLoading = true;
      var timeInterval = 0;
      this.streamStats = new IcecastMetadataStats(station.endpoint, {
        sources: ["icestats", "ogg", "icy"],
        interval: 10,
        onStats: (stats) => {
          this.updateMetaData(stats);
        },
      });
      // creating new audio Element just for the volume since attaching the
      // audioPlayer causes bugs
      var volume = this.volume;
      this.streamAudioElement = new Audio();
      this.volume = volume;
      this.streamPlayer = new IcecastMetadataPlayer(station.endpoint, {
        metadataTypes: station.metadata_types,
        audioElement: this.streamAudioElement,
        onRetry: () => {
          this.retryCount++;
          if (this.retryCount > 10) {
            this.failedToPlay();
          }
        },
        onPlay: () => {
          this.interval = setInterval(() => {
            timeInterval++;
            this.currentAudio.currentTime = this.getTimeFormat(
              timeInterval.toFixed(0)
            );
          }, 1000);
          this.currentAudio.isStopped = false;
          this.currentAudio.isPlaying = true;
        },
        onStreamStart: () => {
          this.isLoading = false;
        },
        onLoading: () => {
          this.isLoading = true;
        },
        onStop: () => {
          clearInterval(this.interval);
          this.currentAudio.isStopped = true;
          this.currentAudio.isPlaying = false;
        },
      });
      this.streamStats.start();
      this.streamPlayer.play();
    },
    onloadstart() {
      this.isLoading = true;
    },
    onerror() {
      if (!this.isRadioStation) {
        this.failedToPlay();
      }
    },
    onwaiting() {
      this.isLoading = true;
    },
    onloadedmetadata() {
      this.currentAudio.currentTime = "0:00";
      this.currentAudio.duration = this.getTimeFormat(
        this.audioPlayer.duration.toFixed(0)
      );
    },
    oncanplay() {
      this.canPlay = true;
      if (this.currentAudio.source_format === "file") {
        this.isLoading = false;
      }
    },
    ontimeupdate() {
      this.updateTime(this.audioPlayer.currentTime, this.audioPlayer.duration);
    },
    notify() {
      this.addToPlaylist = false;
    },
    updateProgress(event) {
      let progressBar = document.getElementById("progress-bar");
      this.audioPlayer.currentTime =
        (event.offsetX * this.audioPlayer.duration) / progressBar.offsetWidth;
    },
    updateMetaData(stats) {
      if (stats) {
        if (
          stats.icestats &&
          stats.icestats.source &&
          stats.icestats.source.title
        ) {
          this.currentAudio.title =
            stats.icestats.source.title || this.currentAudio.name;
        } else if (stats.icy) {
          this.currentAudio.title =
            stats.icy.StreamTitle || this.currentAudio.name;
        } else if (stats.ogg) {
          if (stats.ogg.TITLE) {
            this.currentAudio.title = stats.ogg.TITLE || this.currentAudio.name;
          }
          if (stats.ogg.ARTIST) {
            this.currentAudio.artist = stats.ogg.ARTIST;
          }
        }
        document.title =
          "\u25b6 " + this.currentAudio.title;
      }
    },
    updateProgressOnPhone(event) {
      let progressBar = document.getElementById("progress-bar_phone_layout");
      this.audioPlayer.currentTime =
        (event.offsetX * this.audioPlayer.duration) / progressBar.offsetWidth;
    },
    ended() {
      var index;
      this.canPlay = false;
      this.$store.commit("setCurrentAudio", null);
      this.currentAudio.isPlaying = false;
      this.$store.dispatch("endPlay");
      if (!this.buttons.loop) {
        if (this.buttons.shuffle && this.playlist.length > 1) {
          index = this.getRandomAudio(
            this.playlist.length,
            this.currentAudio.index
          );

          this.updateCurrentAudio(index);
        } else {
          if (this.playlist.length !== this.currentAudio.index + 1) {
            index = this.currentAudio.index + 1;
          } else {
            index = 0;
          }
          this.updateCurrentAudio(index);
        }
      }
    },
    updateTime(currentTime, duration) {
      if (this.audioPlayer.duration === Infinity) {
        this.currentAudio.duration = "live";
        this.currentAudio.progress = 100;
      } else {
        this.currentAudio.currentTime = this.getTimeFormat(
          currentTime.toFixed(0)
        );
        if (currentTime < duration || currentTime == 0) {
          this.currentAudio.progress = (currentTime / duration) * 100;
        } else {
          this.currentAudio.progress = 0;
        }
      }
    },
    rewindAudio(seconds) {
      this.audioPlayer.currentTime = this.audioPlayer.currentTime + seconds;
      if (this.currentAudio.source_format === "yt_video") {
        this.videoPlayer.seekTo(this.audioPlayer.currentTime);
      }
    },
    adjustPlayspeed() {
      this.playbackRateDirection == "up"
        ? (this.playbackRate += 0.25)
        : (this.playbackRate -= 0.25);
      if (this.playbackRate == 2) {
        this.playbackRateDirection = "down";
      } else if (this.playbackRate == 0.25) {
        this.playbackRateDirection = "up";
      }
      if (this.currentAudio.source_format === "yt_video") {
        this.videoPlayer.setPlaybackRate(this.playbackRate);
      }
    },
    goNext() {
      var index;
      if (this.currentAudio.index == this.playlist.length - 1) {
        index = 0;
      } else {
        index = this.currentAudio.index + 1;
      }
      this.updateCurrentAudio(index, true);
    },
    goPrevious() {
      var index;
      if (this.currentAudio.index == 0) {
        index = this.playlist.length - 1;
      } else {
        index = this.currentAudio.index - 1;
      }
      this.updateCurrentAudio(index, true);
    },
    getRandomAudio(length, index) {
      let randomAudio = Math.floor(Math.random() * length);
      if (randomAudio == index) return this.getRandomAudio(length, index);
      else return randomAudio;
    },
    videoReadyCallback(event) {
      this.currentAudio.duration = this.getTimeFormat(
        event.target.getDuration().toFixed(0)
      );
      this.isLoading = false;
      this.playPause();
    },
    videoStatusChangeCallback(event) {
      this.videoStatus = event.data;
    },
    failedToPlay() {
      this.$notify({
        group: "foo",
        type: "warning",
        title: this.$t("Error"),
        text: this.$t("Failed to load the audio source"),
      });
      if (this.queue.length > 1) {
        this.goNext();
      } else {
        this.$store.state.queue = [];
        // kill the stream
        this.killStream();
      }
    },
    async downloadAudio() {
      this.downloadLoading = true;
      try {
        await this.$store.dispatch("downloadAudio", {
          id: this.currentAudio.id,
          type: this.isPodcastEpisode ? "episode" : "song",
          file_name: this.currentAudio.file_name,
        });
      } catch (e) {}
      this.downloadLoading = false;
    },
    updateCurrentAudio(index, force) {
      this.reset();
      var audio = this.playlist[index];
      if (!this.playlist[index].endpoint) {
        this.currentAudio.file_name = audio.file_name;
        this.currentAudio.file_size = audio.file_size;
        this.currentAudio.source = audio.source;
        this.currentAudio.artist = audio.artist;
        this.currentAudio.artists = audio.artists;
        this.currentAudio.album = audio.album;
        this.currentAudio.title = audio.title;
        this.currentAudio.podcast = audio.podcast;
        this.currentAudio.source_format = audio.source_format;
      } else {
        this.currentAudio.endpoint = audio.endpoint;
        this.currentAudio.title = audio.name;
        this.audioPlayer.pause();
      }
      this.currentAudio.index = index;
      this.currentAudio.id = audio.id;
      this.currentAudio.cover = audio.cover;

      this.currentAudio.progress = 0;
      this.currentAudio.currentTime = this.currentAudio.currentTime;
      if (this.currentAudio.source_format === "yt_video") {
        if (this.$store.getters.getSettings.allowVideos) {
          if (this.currentAudio.index !== 0 || force || this.buttons.shuffle) {
            this.setVideo(
              this.currentAudio.source,
              this.videoReadyCallback,
              this.videoStatusChangeCallback
            );
          }
        } else {
          // Sorry, can't play this song
          this.$notify({
            group: "foo",
            type: "warning",
            title: this.$t("Oops!"),
            text: this.$t("Sorry, you can not play YouTube videos."),
          });
        }
      } else if (this.currentAudio.source_format === "file") {
        this.audioPlayer.src = this.currentAudio.source;
        this.audioPlayer.load();
        if (this.currentAudio.index !== 0 || force || this.buttons.shuffle) {
          this.playPause();
        }
      } else if (this.isRadioStation) {
        this.initStreamPlayer(audio);
      }
    },
    killStream() {
      this.streamAudioElement = null;
      if (this.streamPlayer) {
        this.streamPlayer.stop();
        this.streamPlayer.detachAudioElement();
        this.streamStats.stop();
        this.streamPlayer = null;
        this.streamStats = null;
      }
    },
    muteAudio() {
      if (this.audioPlayer.muted) {
        this.audioPlayer.muted = false;
        this.volumeButton = "volume-high";
      } else {
        this.audioPlayer.muted = true;
        this.volumeButton = "volume-off";
      }
      if (this.streamAudioElement) {
        if (this.streamAudioElement.muted) {
          this.streamAudioElement.muted = false;
          this.volumeButton = "volume-high";
        } else {
          this.volumeButton = "volume-off";
          this.streamAudioElement.muted = true;
        }
      }
    },
    like(song_id) {
      if (this.isLiked) {
        this.$store.dispatch("dislike", song_id);
      } else {
        this.$store.dispatch("like", song_id);
      }
    },
    setVideo(youtube_id, readyCallback, stateChangedCallback) {
      if (!this.videoPlayer) {
        this.$nextTick(() => {
          this.videoPlayer = new YT.Player("youtube_video_container", {
            width: "500",
            height: "305",
            videoId: youtube_id,
            events: {
              onReady: readyCallback,
              onStateChange: stateChangedCallback,
            },
          });
        });
      } else {
        this.videoPlayer.loadVideoById(youtube_id, 0);
      }
    },
    loopAudio() {
      if (this.currentAudio.source_format === "file") {
        if (this.buttons.loop) {
          this.buttons.loop = false;
          this.audioPlayer.removeAttribute("loop");
        } else {
          this.buttons.loop = true;
          this.audioPlayer.loop = true;
        }
      } else {
        // can't loop youtube video from this button
      }
    },
    switchScreenToSmall() {
      this.smallScreen = true;
    },
    switchScreenToLarge() {
      this.smallScreen = false;
    },
    reset() {
      clearInterval(this.timeUpdater);
      this.killStream();
      this.currentAudio = {
        src: null,
        index: this.currentAudio.index,
        title: "",
        album: "",
        artist: "",
        progress: 0,
        duration: "-:--",
        currentTime: "0:00",
        videoCurrentTime: 0,
        isPlaying: false,
      };
      if (this.videoPlayer && this.videoPlayer.stopVideo) {
        this.videoPlayer.stopVideo();
      }
      this.audioPlayer.currentTime = 0;
      this.audioPlayer.currentTime = 0;
      this.audioPlayer.pause();
      this.isLoading = true;
    },
    playPause() {
      this.currentAudio.isPlaying = !this.currentAudio.isPlaying;
      if (this.currentAudio.source_format === "yt_video") {
        if (!this.$store.getters.getSettings.allowVideos) {
          this.$notify({
            group: "foo",
            type: "warning",
            title: this.$t("Oops!"),
            text: this.$t("Sorry, you can not play YouTube videos."),
          });
        }
        if (
          this.videoStatus === 2 ||
          this.videoPlayer.getCurrentTime() === 0 ||
          this.videoStatus === 0
        ) {
          this.videoPlayer.playVideo();
          this.$nextTick(() => {
            document.title =
              "\u25b6 " +
              this.currentAudio.title +
              (this.currentAudio.artist
                ? " - " + this.currentAudio.artist.displayname
                : "");
          });
          this.$store.commit("setCurrentAudio", this.currentAudio);
          this.currentAudio.isPlaying = true;
          if (this.videoPlayer.getCurrentTime() === 0) {
            this.$store.dispatch("registerPlay", {
              id: this.currentAudio.id,
              type: this.isPodcastEpisode ? "episode" : "song",
            });
          }
        } else if (this.videoPlayer.getCurrentTime() > 0) {
          this.currentAudio.isPlaying = false;
          this.$store.commit("setCurrentAudio", null);
          this.$nextTick(() => {
            document.title =
              this.currentAudio.title +
              (this.currentAudio.artist
                ? " - " + this.currentAudio.artist.displayname
                : "");
          });
          this.videoPlayer.pauseVideo();
        }
      } else if (this.currentAudio.source_format === "file") {
        if (this.audioPlayer.paused || this.audioPlayer.currentTime === 0) {
          const int = setInterval(() => {
            if (this.canPlay) {
              this.audioPlayer.play();
              this.$nextTick(() => {
                document.title =
                  "\u25b6 " +
                  this.currentAudio.title +
                  (this.currentAudio.artist
                    ? " - " + this.currentAudio.artist.displayname
                    : "");
              });
              this.$store.commit("setCurrentAudio", this.currentAudio);
              this.currentAudio.isPlaying = true;
              clearInterval(int);
            }
          }, 200);
          if (this.audioPlayer.currentTime === 0) {
            this.$store.dispatch("registerPlay", {
              id: this.currentAudio.id,
              type: this.isPodcastEpisode ? "episode" : "song",
            });
          }
        } else if (this.audioPlayer.currentTime > 0) {
          this.currentAudio.isPlaying = false;
          this.$store.commit("setCurrentAudio", null);
          this.$nextTick(() => {
            document.title =
              this.currentAudio.title +
              (this.currentAudio.artist
                ? " - " + this.currentAudio.artist.displayname
                : "");
          });
          this.audioPlayer.pause();
        }
      } else {
        // live stream
        if (this.streamPlayer.state == "stopped") {
          this.streamPlayer.play();
          this.$nextTick(() => {
            document.title = "\u25b6 " + this.currentAudio.title;
          });
          // current audio works of songs only
          this.$store.commit("setCurrentAudio", null);
          this.currentAudio.isPlaying = true;

          if (this.audioPlayer.currentTime === 0) {
            this.$store.dispatch("registerPlay", {
              id: this.currentAudio.id,
              type: "radio-sation",
            });
          }
        } else {
          this.currentAudio.isPlaying = false;
          this.$store.commit("setCurrentAudio", null);
          this.$nextTick(() => {
            document.title = this.currentAudio.title;
          });
          this.streamPlayer.stop();
        }
      }
    },
    getTimeFormat(secs) {
      var minutes = Math.floor(secs / 60);
      var seconds = secs % 60;
      return (
        minutes + ":" + (Math.floor(seconds / 10) > 0 ? seconds : "0" + seconds)
      );
    },
    addSongToPlaylist(song_id) {
      if (this.$store.getters.getUser) {
        this.$store.commit("setAddSongToPlaylist", song_id);
      } else {
        this.loginOrCancel();
      }
    },
    startPlayer() {
      if (this.playlist[0] !== this.queue[0]) {
        this.updateCurrentAudio(0, true);
      }
      this.queue = this.playlist;
    },
  },
  watch: {
    videoStatus(val) {
      switch (val) {
        case -1:
          if (this.currentAudio.source_format === "yt_video") {
            this.isLoading = false;
          }
          break;
        case 0:
          this.ended();
          break;
        case 1:
          this.currentAudio.duration = this.getTimeFormat(
            this.videoPlayer.getDuration().toFixed(0)
          );
          this.isLoading = false;
          this.currentAudio.isPlaying = true;
          var self = this;
          function updateTime() {
            var oldTime = self.currentAudio.videoCurrentTime;
            if (self.videoPlayer && self.videoPlayer.getCurrentTime) {
              self.currentAudio.videoCurrentTime = self.videoPlayer.getCurrentTime();
            }
            if (self.currentAudio.videoCurrentTime !== oldTime) {
              self.updateTime(
                self.currentAudio.videoCurrentTime,
                self.videoPlayer.getDuration()
              );
            }
          }
          this.timeUpdater = setInterval(updateTime, 100);
          break;
        case 2:
          clearInterval(this.timeUpdater);
          this.currentAudio.isPlaying = false;
          break;
      }
    },
    playbackRate(val) {
      this.audioPlayer.playbackRate = val;
    },
    playlist() {
      setTimeout(() => {
        this.startPlayer();
      }, 100);
    },
  },
  beforeDestroy() {
    this.audioPlayer.pause();
    this.killStream();
  },
};
</script>
