<template>
    <v-app-bar v-if="user">
        <v-app-bar-nav-icon
            @click="$emit('toggle-sidebar')"
        ></v-app-bar-nav-icon>
        <v-toolbar-title>{{ $t('Admin Area') }}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-menu
            bottom
            nudge-bottom="50"
            :close-on-click="false"
            :close-on-content-click="false"
        >
            <template v-slot:activator="{ on, attrs }">
                <v-btn v-bind="attrs" v-on="on" icon>
                    <v-badge
                        overlap
                        :color="
                            notifications.length ? 'primary' : 'transparent'
                        "
                    >
                        <v-icon>mdi-bell</v-icon>
                    </v-badge>
                </v-btn>
            </template>
            <v-card>
                <notifications-box
                    :title="$t('Notifications')"
                    @handled="show('notifications')"
                >
                    <template v-if="notifications.length">
                        <div
                            v-for="notification in notifications"
                            :key="notification.id"
                            class="notification"
                        >
                            <artist-request-notification
                                @delete-notification="fetchNotifications"
                                :notification="notification"
                            ></artist-request-notification>
                        </div>
                    </template>
                    <template v-else>
                        <empty-page
                            :headline="$t('Nothing New!')"
                            :sub="$t('You do not have any new notifications.')"
                        />
                    </template>
                </notifications-box>
            </v-card>
        </v-menu>
        <div class="admin-name ml-5 text-overflow-ellipsis">
            <div class="avatar">
                 <img :src="user.avatar" alt="" class="avatar-image" width="35" />
            </div>
            {{ user.name }}
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
                        {{ $t('Player') }}</v-list-item-title
                    >
                </v-list-item>
                <v-list-item :to="{ name: 'account-settings' }">
                    <v-list-item-title>
                        <v-icon>mdi-account-cog</v-icon> {{ $t('Account Settings') }}
                        </v-list-item-title
                    >
                </v-list-item>
                <v-list-item
                    @click="changeTheme(!$vuetify.theme.dark)"
                >
                    <v-list-item-title>
                        <v-icon>mdi-brightness-4</v-icon>
                        {{ $t($vuetify.theme.dark ? 'Light' : 'Dark' +  ' Mode') }}
                        </v-list-item-title
                    >
                </v-list-item>
                <v-list-item @click="$store.dispatch('logout')">
                    <v-list-item-title>
                        <v-icon>mdi-logout</v-icon>  {{ $t('Logout') }}</v-list-item-title
                    >
                </v-list-item>
            </v-list>
        </v-menu>
    </v-app-bar>
</template>
<script>
import artistRequestNotification from "../../notifications/ArtistRequest";
export default {
    components: {
        artistRequestNotification
    },
    created() {
        this.fetchNotifications();
    },
    data() {
        return {
            notifications: []
        };
    },
    computed: {
        user() {
            return this.$store.getters.getUser;
        }
    },
    methods: {
        fetchNotifications() {
            axios
                .get("/api/admin/notifications")
                .then(res => (this.notifications = res.data))
        }
    }
};
</script>

<style lang="scss" scoped>
.admin-name {
    max-width: 13em;
    display: flex;
    align-items: center;
}
.avatar {
    border-radius: 50%;
    width: 35px;
    overflow: hidden;
    margin-right: 0.3rem;
    &-image {
        height: 100%;
        width: 100%;
    }
}
</style>