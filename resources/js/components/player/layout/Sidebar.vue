<template>
    <div id="player-sidebar" v-if="items">
        <v-card id="sidebar-wrapper">
            <router-link
                :to="{ path: $store.getters.getSettings.playerLanding }"
            >
                <div class="logo">
                    <img :src="$vuetify.theme.dark ? $store.getters.getSettings.appLogoDark : $store.getters.getSettings.appLogoLight" alt="" />
                </div>
            </router-link>
            <v-list class="list">
                <v-list-item-group color="primary" class="list-group">
                    <template v-for="(item, i) in items">
                        <v-list-item
                            :key="i"
                            :to="item.path"
                            link
                            v-if="
                                item.path.substr(0, 1) === '/' &&
                                    item.visibility
                            "
                            class="sidebar-item"
                        >
                            <div>
                                <v-icon>mdi-{{ item.icon }}</v-icon>
                            </div>
                            <v-list-item-content>
                                <v-list-item-title
                                    v-text="$t(`${item.name}`)"
                                ></v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                        <v-list-item
                            :key="i"
                            @click="navigate(item.path)"
                            link
                            v-else-if="
                                item.visibility &&
                                    item.path.substr(0, 1) !== '/'
                            "
                            class="sidebar-item"
                        >
                            <div>
                                <v-icon>mdi-{{ item.icon }}</v-icon>
                            </div>
                            <v-list-item-content>
                                <v-list-item-title
                                    v-text="item.name"
                                ></v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                    </template>
                </v-list-item-group>
            </v-list>
            <div class="container theme-switch">
                <v-switch v-model="$vuetify.theme.dark" @change="changeTheme">
                    <template v-slot:label>
                        <v-icon v-if="$vuetify.theme.dark"
                            >mdi-weather-night</v-icon
                        >
                        <v-icon v-else>mdi-white-balance-sunny</v-icon>
                    </template>
                </v-switch>
            </div>
        </v-card>
        <v-bottom-navigation id="bottom-nav" grow color="primary">
            <v-btn
                v-for="item in items"
                :key="item.rank"
                @click="navigate(item.path)"
                v-show="item.visibility"
            >
                <span>{{ $t(item.name) }}</span>
                <v-icon>mdi-{{ item.icon }}</v-icon>
            </v-btn>
        </v-bottom-navigation>
        <player
            :playlist="$store.getters.getQueue"
            v-if="$store.getters.getQueue.length"
        ></player>
    </div>
</template>
<script>
export default {
    created() {
        axios
            .get("/api/navigation-items")
            .then(res => (this.items = res.data))
    },
    data() {
        return {
            items: []
        };
    },
    methods: {
        navigate(path) {
            if (path.match(/\./)) {
                window.open(path, "_self");
            } else {
                this.$router.push({ path: path });
            }
        }
    }
};
</script>
<style lang="scss" scoped>
.theme-switch {
    position: absolute;
    bottom: 65px;
    transform: scale(0.9);
}
</style>
