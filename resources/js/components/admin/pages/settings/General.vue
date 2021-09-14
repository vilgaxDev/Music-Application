<template>
    <v-card class="page pb-4" v-if="!isLoading">
        <v-card-title>
            <div class="page__title">
                <v-icon color="primary" x-large>mdi-application-cog</v-icon>
                {{ $t("General") }}
            </div>
            <div class="page__options">
                <v-btn
                    small
                    class="info"
                    @click="reset"
                    :disabled="isLoadingForButton"
                    :loading="isLoadingForButton"
                    >
                     <template v-slot:loader>
                        <span class="custom-loader">
                            <v-icon light>mdi-cached</v-icon>
                        </span>
                    </template>
                    {{ $t("Reset") }}</v-btn
                >
                <v-btn
                    small
                    class="success"
                    @click="save"
                    :disabled="isLoadingForButton"
                    :loading="isLoadingForButton"
                    >
                     <template v-slot:loader>
                        <span class="custom-loader">
                            <v-icon light>mdi-cached</v-icon>
                        </span>
                    </template>
                    {{ $t("Save") }}</v-btn
                >
            </div>
        </v-card-title>
        <v-container class="pl-5">
            <v-row>
                <v-col cols="12">
                    <div class="title">{{ $t("Localization") }}</div>
                    <v-divider></v-divider>
                </v-col>
                <v-col>
                    <veutify-select
                        :items="locales"
                        v-model="settings.locale"
                        :label="$t('Default Language')"
                        item-text="name"
                        item-value="locale"
                        hide-details
                        outlined
                    >
                        <template v-slot:item="{ item }">
                            <div class="align-center">
                                <div class="img px-2 py-1">
                                    <v-img
                                        max-width="25"
                                        :src="flagsPath + item.flag + '.svg'"
                                    ></v-img>
                                </div>
                                {{ item.name }}
                            </div>
                        </template>
                        <template v-slot:selection="{ item }">
                            <div class="align-center">
                                <div class="img px-2 py-1">
                                    <v-img
                                        max-width="25"
                                        :src="flagsPath + item.flag + '.svg'"
                                    ></v-img>
                                </div>
                                {{ item.name }}
                            </div>
                        </template>
                    </veutify-select>
                </v-col>
            </v-row>
            <v-row>
                <v-col cols="12">
                    <div class="title">{{ $t("Platform") }}</div>
                    <v-divider></v-divider>
                </v-col>
                <v-col cols="12">
                    <v-text-field
                        :label="$t('Platform Name')"
                        v-model="settings.appName"
                        outlined
                        hide-details=""
                    />
                </v-col>
                <v-col cols="12">
                    <v-switch
                        v-model="settings.enablePodcasts"
                        :label="$t('Podcasts')"
                        :messages="
                            $t(
                                'Disabling podcasts will remove anything related to podcasts on the application.'
                            )
                        "
                    ></v-switch>
                </v-col>
                <v-col cols="12">
                    <v-switch
                        v-model="settings.enableBrowse"
                        :label="$t('Browse Page')"
                        :messages="
                            $t(
                                'Remove the browse page which includes music genres & charts.'
                            )
                        "
                    ></v-switch>
                </v-col>
            </v-row>
            <v-row class="row-row">
                <v-col cols="12">
                    <div class="title">{{ $t("Community") }}</div>
                    <v-divider></v-divider>
                </v-col>
                <v-col cols="12">
                    <v-switch
                        v-model="settings.enableFriendshipSystem"
                        :label="$t('Friendship System')"
                        :messages="
                            $t(
                                'Disable this functionality if you do not want users to be friends with each other.'
                            )
                        "
                    ></v-switch>
                </v-col>
                <v-col cols="12">
                    <v-row v-if="settings.enableFriendshipSystem">
                        <v-col cols="12">
                            <v-switch
                                v-model="settings.enableRealtime"
                                :label="$t('Enable Realtime')"
                                :messages="
                                    $t(
                                        'This will allow live chat and shows what the users are currently playing.'
                                    )
                                "
                            ></v-switch>
                            <v-row v-if="settings.enableRealtime">
                                <v-col cols="12">
                                    <v-alert
                                        border="top"
                                        colored-border
                                        type="info"
                                        class="mt-5"
                                        elevation="2"
                                    >
                                        Muzzie offers a Realtime with the help
                                        of a 3rd party API called
                                        <a href="https://pusher.com/">Pusher</a>
                                        which is a Freemium service. Open an
                                        account and get your credentials.
                                    </v-alert>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        dense
                                        hide-details=""
                                        :label="$t('Pusher App ID')"
                                        outlined
                                        v-model="settings.pusherAppId"
                                /></v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        dense
                                        hide-details=""
                                        :label="$t('Pusher Key')"
                                        outlined
                                        v-model="settings.pusherKey"
                                /></v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        dense
                                        hide-details=""
                                        :label="$t('Pusher Secret')"
                                        outlined
                                        type="password"
                                        v-model="settings.pusherSecret"
                                /></v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        dense
                                        hide-details=""
                                        :label="$t('Pusher Cluster')"
                                        outlined
                                        v-model="settings.pusherCluster"
                                /></v-col>
                            </v-row>
                        </v-col>

                        <v-col cols="12" sm="6">
                            <v-switch
                                v-model="settings.enableChat"
                                :label="$t('Enable Chat')"
                                v-if="settings.enableRealtime"
                                :messages="$t('Enable chat between friends')"
                            ></v-switch>
                        </v-col>
                    </v-row>
                </v-col>
                <v-col>
                    <v-switch
                        v-model="settings.allowArtistAccountRequests"
                        :label="$t('Allow artist account requests')"
                        :messages="
                            $t(
                                'Allow users to request an artist account by sending their information to the admins'
                            )
                        "
                    ></v-switch>
                </v-col>
            </v-row>
            <v-row>
                <v-col cols="12">
                    <div class="title">{{ $t("Player") }}</div>
                    <v-divider></v-divider>
                </v-col>
                <v-col>
                    <v-switch
                        :label="$t('Download Button')"
                        v-model="settings.downloadButton"
                        :messages="
                            $t(
                                'Show the download button on the player(if the audio has a file)'
                            )
                        "
                    ></v-switch>
                </v-col>
                <v-col>
                    <v-slider
                        v-model="settings.playerVolume"
                        :label="$t('Default Volume')"
                        thumb-color="primary"
                        hide-details=""
                        :thumb-label="true"
                    ></v-slider>
                </v-col>
            </v-row>
            <v-row>
                <v-col cols="12">
                    <div class="title">{{ $t("About Us") }}</div>
                    <v-divider></v-divider>
                </v-col>
                <v-col>
                    <v-textarea
                        :label="$t('About Us')"
                        :messages="$t('You can add HTML code')"
                        v-model="settings.aboutUs"
                        outlined
                        :placeholder="$t('Describe your platform')"
                    >
                    </v-textarea>
                </v-col>
            </v-row>
        </v-container>
    </v-card>
    <page-loading v-else />
</template>
<script>
import axios from "axios";
import { VSelect } from "vuetify/lib";
export default {
    props: ["settings", "isLoading", "isLoadingForButton"],
    components: {
        veutifySelect: VSelect
    },
    data() {
        return {
            sitemapLoading: false,
            url: null,
            flagsPath: "/storage/defaults/icons/flags/",
            locales: []
        };
    },
    created() {
        axios.get("/api/languages").then(res => (this.locales = res.data));
        axios.get("/api/admin/url").then(res => {
            this.url = res.data;
        });
    },
    methods: {
        save() {
            this.$emit("save-settings");
        },
        reset() {
            this.$emit("reset-settings");
        }
    }
};
</script>
