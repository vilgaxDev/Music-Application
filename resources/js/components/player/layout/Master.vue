<template>
  <main
    @click="hideWindows"
    id="player-container"
    :class="this.$vuetify.theme.dark ? 'player--dark' : 'player--light'"
  >
    <Sidebar></Sidebar>
    <Navbar
      @toggle="rightSidebar = !rightSidebar"
      @width="rightSidebarWidth = $event"
    ></Navbar>
    <div class="player-container__content">
      <div id="player-container__content__main">
        <add-to-playlist
          v-if="$store.getters.getAddSongToPlaylist"
          @end="$store.commit('setAddSongToPlaylist', null)"
        ></add-to-playlist>
        <v-container fluid class="player-main-container full-heigth">
          <router-view :key="$store.getters.getCurrentPageId"></router-view>
        </v-container>
      </div>
      <RightSidebar
        @width="rightSidebarWidth = $event"
        @toggle="rightSidebar = !rightSidebar"
                    :style="{
                transform:
                    windowWidth < 900
                        ? 'translateX(' + (rightSidebar ? '0px' : '100%') + ')'
                        : 'translateX(0)'
            }"
      ></RightSidebar>
    </div>
    <!--  Global dialogs -->
      <v-dialog v-model="$store.state.showSharingDialog" max-width="500px">
      <v-card class="panel" v-if="$store.getters.getShareContentUrl">
          <v-card-title>{{$t('Copy URL')}}</v-card-title>
          <div class="justify-between align-center px-2">
              <v-text-field
                  :value="$store.getters.getShareContentUrl"
                  class="px-2"
              ></v-text-field>
              <v-icon
                  class="px-1"
                  :title="$t('Copy to clipboard')"
                  @click="copyToClipboard($store.getters.getShareContentUrl)"
                  >mdi-clipboard-outline</v-icon
              >
          </div>
      </v-card>
  </v-dialog>
  </main>
</template>
<script>
import Navbar from "./Navbar.vue";
import Sidebar from "./Sidebar.vue";
import RightSidebar from "./RightSidebar.vue";
import addToPlaylist from "../../dialogs/Playlists";
import "pusher-js";
import Echo from "laravel-echo";

export default {
  components: {
    Navbar,
    Sidebar,
    RightSidebar,
    addToPlaylist,
  },
  computed: {
    windowWidth() {
      return this.$store.getters.getScreenWidth;
    },
  },
  data() {
    return {
      rightSidebar: false,
      rightSidebarWidth: 0,
    };
  },
  created() {
    window.addEventListener(
      "resize",
      function () {
        this.$store.commit("setScreenWidth", window.innerWidth);
      }.bind(this)
    );
    if (this.$store.getters.getSettings.allowVideos) {
      var tag = document.createElement("script");
      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName("script")[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    }
    // init pusher/echo
    if (this.$store.getters.getSettings.enableRealtime) {
      window.Echo = new Echo({
        auth: {
          headers: {
            Authorization: "Bearer " + this.$store.getters.getToken,
          },
        },
        authEndpoint: "/api/broadcasting/auth",
        broadcaster: "pusher",
        key: this.$store.getters.getSettings.pusherKey,
        cluster: this.$store.getters.getSettings.pusherCluster,
      });
      console.log(window.Echo)
    }
  },
  methods: {
    hideWindows() {
      this.$store.commit("setSongMenu", null);
      this.$store.commit("setSongContextMenu", null);
      this.$store.commit("setSearchResultsPanel", false);
    },
  },
};
</script>
<style lang="scss">
@import "../../../../sass/player/main.scss";
</style>
