<template>
    <v-app-bar v-if="artist">
        <v-app-bar-nav-icon
            @click="$emit('toggle-sidebar')"
        ></v-app-bar-nav-icon>
        <v-toolbar-title>{{$t('Artist Area')}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <div class="text-overflow-ellipsis">
            <v-avatar color="primary" class="mr-2" size="35">
                <v-img :src="artist.avatar" />
            </v-avatar>
            {{ artist.displayname }}
        </div>
        <v-menu left bottom>
            <template v-slot:activator="{ on, attrs }">
                <v-btn icon v-bind="attrs" v-on="on">
                    <v-icon>mdi-dots-vertical</v-icon>
                </v-btn>
            </template>
            <v-list>
                <v-list-item
                    :to="{ path: $store.getters.getSettings.playerLanding }"
                >
                    <v-list-item-title>
                        <v-icon>mdi-music-note-eighth</v-icon>
                        {{$t('Player')}}</v-list-item-title
                    >
                </v-list-item>
                <v-list-item
                    @click="$vuetify.theme.dark = !$vuetify.theme.dark"
                >
                    <v-list-item-title>
                        <v-icon>mdi-brightness-4</v-icon>
                        {{ $t(($vuetify.theme.dark ? "Light" : "Dark") + ' Mode')}}</v-list-item-title
                    >
                </v-list-item>
                <v-list-item @click="$store.dispatch('logout')">
                    <v-list-item-title>
                        <v-icon>mdi-logout</v-icon> {{$t('Logout')}}</v-list-item-title
                    >
                </v-list-item>
            </v-list>
        </v-menu>
    </v-app-bar>
</template>

<script>
export default {
    props: ["artist"]
};
</script>
