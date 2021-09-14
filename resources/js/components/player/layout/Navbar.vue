<template>
    <nav class="navbar" id="navbar">
        <div class="navbar__left-side">
            <div class="chevrons">
                <div class="chevron-left mr-3" @click="$router.go(-1)">
                    <v-icon>mdi-chevron-left</v-icon>
                </div>
                <div class="chevron-right" @click="$router.go(1)">
                    <v-icon>mdi-chevron-right</v-icon>
                </div>
            </div>
            <div class="logo">
                <router-link
                    :to="{ path: $store.getters.getSettings.playerLanding }"
                >
                    <img :src="$vuetify.theme.dark ? $store.getters.getSettings.appLogoDark : $store.getters.getSettings.appLogoLight" alt="" />
                </router-link>
            </div>
            <div
                class="searchbar-container"
                :style="{
                    transform: showSearchBar
                        ? 'translateY(50px)'
                        : 'translateY(8px)',
                    opacity: showSearchBar ? 1 : 0,
                    pointerEvents: showSearchBar ? 'initial' : 'none'
                }"
            >
                <PlayerSearchbar @navigation="showSearchBar = !showSearchBar" />
            </div>
        </div>

        <div class="navbar__right-side">
            <div
                class="search-icon pointer mr-3 ml-auto"
                @click="showSearchBar = !showSearchBar"
            >
                <v-icon>mdi-magnify</v-icon>
            </div>
            <div class="user" v-if="user">
                <div class="upgrade-account">
                    <SubButton></SubButton>
                </div>
                <div class="icons">
                    <div
                        class="chat"
                        v-if="$store.getters.getSettings.enableRealtime && $store.getters.getSettings.enableChat && hasPermission('Chat with friends')"
                    >
                        <div class="icon" @click="show('chat')">
                            <v-btn small icon>
                                <v-icon>mdi-message-processing-outline</v-icon>
                            </v-btn>
                            <div class="unread-indicator" v-if="unreadMessages">
                                <span>{{ unreadMessages }}</span>
                            </div>
                        </div>
                        <div class="chat-component">
                            <chat-component
                                v-if="$store.getters.getFriends"
                                :user="$store.getters.getUser"
                                :whoToOpen="openChatEventFriend"
                                @chatOpened="
                                    $store.commit('setOpenChatWith', null)
                                "
                                :amIAlive="showing == 'chat' ? true : false"
                                v-show="showing === 'chat'"
                                @unread="unreadMessages += $event"
                            />
                        </div>
                    </div>
                    <div class="notifications" v-if="notifications">
                        <v-menu
                            bottom
                            left
                            nudge-bottom="50"
                            :close-on-click="false"
                            :close-on-content-click="false"
                        >
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn small v-bind="attrs" v-on="on" icon>
                                    <v-badge
                                        left
                                        overlap
                                        dot
                                        :color="
                                            notifications.length
                                                ? 'primary'
                                                : 'transparent'
                                        "
                                    >
                                        <v-icon>mdi-bell</v-icon>
                                    </v-badge>
                                </v-btn>
                            </template>
                            <v-card class="panel">
                                <notifications-box
                                    :title="$t('Friend Requests')"
                                    @handled="show('notifications')"
                                >
                                    <template v-if="notifications.length">
                                        <div
                                            v-for="notification in notifications"
                                            :key="notification.id"
                                            class="notification"
                                        >
                                            <friend-request-notification
                                                @handled="show('notifications')"
                                                :notification="notification"
                                            ></friend-request-notification>
                                        </div>
                                    </template>
                                    <template v-else>
                                        <empty-page
                                        class="px-4"
                                            :headline="$t('Nothing New!')"
                                            :sub="$t('You do not have any new requests.')"
                                        />
                                    </template>
                                </notifications-box>
                            </v-card>
                        </v-menu>
                    </div>
                    <div class="friends" @click="$emit('toggle')">
                        <v-icon class="mr-3">mdi-account-group</v-icon>
                    </div>
                </div>
                <div class="account" @click="userMenu = !userMenu">
                    <div class="avatar user-avatar">
                        <div class="badge" v-if="userPlan && userPlan.badge">
                            <v-icon color="primary">mdi-{{ user.plan.badge }}</v-icon>
                        </div>
                        <img :src="user.avatar" alt="" class="avatar-image" />
                    </div>
                    <div class="name max-1-lines">
                        {{ user.name }}
                    </div>
                    <div class="chevron">
                        <v-icon small>mdi-chevron-down</v-icon>
                    </div>
                    <abs-menu
                        :style="{ top: '105%', width: '12em', right: '0' }"
                        v-if="userMenu"
                    >
                        <user-menu
                            :userId="user.id"
                            @click:outside="userMenu = !userMenu"
                        />
                    </abs-menu>
                </div>
            </div>

            <div class="auth" v-else>
                <div class="buttons">
                    <v-btn
                        class="primary white--text"
                        small
                        @click="$router.push({ name: 'login' })"
                        >{{$t('Login')}}</v-btn
                    >
                    <v-btn
                        class="register__btn primary ml-2 white--text"
                        small
                        @click="$router.push({ name: 'register' })"
                        v-if="!$store.getters.getSettings.disableRegistration"
                        >{{$t('Register')}}</v-btn
                    >
                </div>
            </div>
        </div>
    </nav>
</template>
<script>
import SubButton from '../../elements/single-items/SubButton'
import PlayerSearchbar from "../../elements/PlayerSearchbar";
import friendRequestNotification from "../../notifications/FriendRequest";
export default {
    components: {
        SubButton,
        PlayerSearchbar,
        friendRequestNotification
    },
    data() {
        return {
            userMenu: false,
            showing: null,
            openChatEventFriend: null,
            unreadMessages: 0,
            showSearchBar: false
        };
    },
    computed: {
        user() {
            return this.$store.getters.getUser;
        },
        notifications() {
            return this.$store.getters.getNotifications;
        },
        openChatEvent() {
            return this.$store.getters.getOpenChatWith;
        }
    },
    watch: {
        openChatEvent() {
            this.showing = "chat";
            this.openChatEventFriend = this.openChatEvent;
        }
    },
    methods: {
        show(whatToShow) {
            if (this.showing == whatToShow) {
                this.showing = null;
            } else {
                this.showing = whatToShow;
                if (whatToShow == "chat") {
                    this.unreadMessages = 0;
                }
            }
        },
        deleteNotification(not_id) {
            this.notifications.splice(not_id, 1);
        }
    }
};
</script>
