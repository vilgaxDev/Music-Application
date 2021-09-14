<template>
    <div class="library-container content-page">
        <div class="library-fixed-wrapper fixed-area">
            <div class="icon-header library-header">
                <div class="cover">
                    <v-icon dark>mdi-music-box-multiple</v-icon>
                </div>
                <div class="title">
                    <div class="headline">
                        {{$t('Your Library')}}
                    </div>
                    <div class="sub">
                        {{$t('Manage your music')}}
                    </div>
                </div>
            </div>
            <div class="list-menu">
                <ul class="list">
                    <li :class="{ active: $route.name == 'library.my-songs' }">
                        <router-link to="/library/my-songs">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon color="#26C6DA">mdi-music</v-icon>
                                </div>
                                <span>{{$t('My Songs')}}</span>
                            </div>
                            <div class="layer"></div>
                        </router-link>
                    </li>
                    <li :class="{ active: $route.name == 'library.playlists' }">
                        <router-link to="/library/playlists">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon color="#009688"
                                        >mdi-playlist-music-outline</v-icon
                                    >
                                </div>
                                <span>{{$t('Playlists')}}</span>
                            </div>
                            <div class="layer"></div>
                        </router-link>
                    </li>
                    <li :class="{ active: $route.name == 'library.artists' }">
                        <router-link to="/library/artists">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon color="#FF8A65"
                                        >mdi-account-music</v-icon
                                    >
                                </div>
                                <span>{{$t('Artists')}}</span>
                            </div>
                        </router-link>
                    </li>
                    <li
                        :class="{ active: $route.name == 'library.podcasts' }"
                        v-if="$store.getters.getSettings.enablePodcasts"
                    >
                        <router-link to="/library/podcasts">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon
                                        color="#4DD0E1
"
                                        >mdi-microphone</v-icon
                                    >
                                </div>
                                <span>{{$t('Podcasts')}}</span>
                            </div>
                        </router-link>
                    </li>
                    <li :class="{ active: $route.name == 'library.albums' }">
                        <router-link to="/library/albums">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon color="#9575CD">mdi-album</v-icon>
                                </div>
                                <span>{{$t('Albums')}}</span>
                            </div>
                        </router-link>
                    </li>
                    <li :class="{ active: $route.name == 'library.likes' }">
                        <router-link to="/library/likes">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon color="#D81B60">mdi-heart</v-icon>
                                </div>
                                <span>{{$t('Likes')}}</span>
                            </div>
                        </router-link>
                    </li>
                    <li :class="{ active: $route.name == 'library.recent' }">
                        <router-link to="/library/recent">
                            <div class="el-container">
                                <div class="icon">
                                    <v-icon color="#1E88E5"
                                        >mdi-backup-restore</v-icon
                                    >
                                </div>
                                <span>{{$t('Recently Played')}}</span>
                            </div>
                        </router-link>
                    </li>
                </ul>
            </div>
        </div>
        <div class="main">
            <router-view></router-view>
        </div>
    </div>
</template>
<style lang="scss">
@import "../../../../../sass/player/pages/library";
</style>
