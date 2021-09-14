<template>
    <div class="notification-wrapper">
        <div class="notification__card" @click="showDialog = true">
            <div class="notification__avatar">
                <img :src="notification.data.artist.avatar" alt="" />
            </div>
            <div class="info_and_options">
                <div class="notification__title">
                    {{$t('Artist account request')}}
                </div>
                <div class="notification__sub">
                    {{ notification.data.user.name }} {{('Click to see details')}}
                </div>
            </div>
        </div>
        <v-dialog v-model="showDialog" max-width="800">
            <v-card class="p-3  mx-auto">
                <v-card-title>
                    <v-icon color="primary" x-large class="mr-3"
                        >mdi-account-music</v-icon
                    >
                    {{$t('Artist Request')}} : {{$t('Personal Information')}}
                </v-card-title>
                <v-row class="px-4">
                    <v-col lg="3" md="4" x-sm="6" class="p-2">
                        <v-img :src="notification.data.artist.avatar"></v-img>
                    </v-col>
                    <v-col lg="9" sm="6">
                        <v-text-field
                           :label="$t('Firstname')"
                            v-model="notification.data.artist.firstname"
                            disabled
                        ></v-text-field>
                        <v-text-field
                           :label="$t('Lastname')"
                            disabled
                            v-model="notification.data.artist.lastname"
                        ></v-text-field>
                        <v-text-field
                           :label="$t('Displayname')"
                            v-model="notification.data.artist.displayname"
                            disabled
                        ></v-text-field>
                    </v-col>
                    <v-col cols="12">
                        <v-row justify="end">
                            <v-btn
                                class="success mr-2"
                                small
                                @click="approveUserRequest()"
                                >{{$t('Approve')}}</v-btn
                            >
                            <v-btn
                                class="error"
                                small
                                @click="rejectUserRequest()"
                                >{{$t('Reject')}}</v-btn
                            >
                        </v-row>
                    </v-col>
                </v-row>
            </v-card>
        </v-dialog>
    </div>
</template>
<script>
export default {
    props: ["notification"],
    data() {
        return {
            showDialog: false,
        };
    },
    methods: {
        approveUserRequest() {
            axios
                .post("/api/admin/approve-user-artist-request", {
                    notification_id: this.notification.id
                })
                .then(res => {
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Request Accepted"),
                        text:
                            this.notification.data.user.name + " " + 
                            this.$t("has an artist account now.")
                    });
                })
                .finally(
                    () => (
                        this.$emit("delete-notification"),
                        (this.showDialog = false)
                    )
                );
        },
        rejectUserRequest() {
            axios
                .post("/api/admin/reject-user-artist-request", {
                    notification_id: this.notification.id
                })
                .then(res => {
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Request Rejected"),
                        text:
                            this.notification.data.user.name + " " + 
                            "artist account request has been rejected."
                    });
                })
                .finally(
                    () => (
                        this.$emit("delete-notification"),
                        (this.showDialog = false)
                    )
                );
        }
    }
};
</script>
<style lang="scss">
.notification__card {
    display: flex;
    align-items: center;
    padding: 0.3rem 0.3rem;
}
.notification {
    &__avatar {
        margin-right: 1em;
        img {
            border-radius: 50%;
            width: 3.3em;
            height: 3.3em;
        }
    }
    &__title {
        font-weight: 600;
        margin-bottom: 0.2rem;
    }
    &__sub {
        font-size: 0.8em;
        opacity: 0.75;
    }
    &__buttons {
        margin-top: 0.3em;
        .buttons {
            display: flex;
            & > * {
                flex-basis: 50%;
            }
            & > .btn-approve {
                margin-right: 1.5em;
            }
        }
    }
}
</style>
