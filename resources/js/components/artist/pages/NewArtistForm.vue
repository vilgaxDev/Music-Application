<template>
    <div class="new-artist-account">
        <div class="header_and_sub_title">
            <div class="header_and_sub_title__header">
                {{ $t("Welcome to your artist account") }}
            </div>
            <div class="header_and_sub_title__sub">
                {{ $t("Firstly, fill your information") }}
            </div>
        </div>
        <v-card class="p-3 mt-5">
            <v-row class="px-4">
                <v-col auto class="p-2">
                    <upload-image
                        @imageReady="imageReady($event)"
                        :source="artist.avatar || defaultCoverPath"
                    />
                </v-col>
                <v-col>
                    <v-text-field
                        :label="$t('Firstname')"
                        v-model="artist.firstname"
                        :message="$t('This is a private information.')"
                    ></v-text-field>
                    <v-text-field
                        :label="$t('Lastname')"
                        :message="$t('This is a private information.')"
                        v-model="artist.lastname"
                    ></v-text-field>
                    <v-text-field
                        :label="$t('Displayname')"
                        :message="
                            $t('This name will be displayed on your profile.')
                        "
                        v-model="artist.displayname"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                    <v-btn
                        class="success ml-auto d-flex"
                        @click="save"
                        :loading="loading"
                        :disabled="loading"
                    >
                        <template v-slot:loader>
                            <span class="custom-loader">
                                <v-icon light>mdi-cached</v-icon>
                            </span> </template
                        >{{ $t("Save") }}</v-btn
                    >
                </v-col>
            </v-row>
        </v-card>
    </div>
</template>

<script>
export default {
    data() {
        return {
            artist: {},
            loading: false,
            defaultCoverPath: "/storage/defaults/images/artist_avatar.png"
        };
    },
    methods: {
        imageReady(e) {
            this.artist.avatar = e;
        },
        save() {
            var formData = new FormData();
            this.loading = true;
            formData.append("firstname", this.artist.firstname);
            formData.append("lastname", this.artist.lastname);
            formData.append("displayname", this.artist.displayname);
            if (this.artist.avatar && this.artist.avatar.data) {
                formData.append(
                    "avatar",
                    this.artist.avatar.data,
                    this.artist.avatar.title
                );
            } else {
                formData.append("avatar", this.defaultCoverPath);
            }
            axios
                .post("/api/artist/save-personal-infos", formData, {
                    headers: {
                        "Content-Type": "multipart/form-data"
                    }
                })
                .then(() => {
                    this.loading = false;
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Success"),
                        text:
                            this.$t("Artist account") +
                            " " +
                            this.$t("updated successfully.")
                    });
                    setTimeout(() => {
                        location.reload();
                    }, 500);
                })
                .catch(e => {
                    this.loading = false;
                    this.$notify({
                        group: "foo",
                        type: "error",
                        title: this.$t("Error"),
                        text: Object.values(e.response.data.errors).join(
                            "<br />"
                        )
                    });
                });
        }
    }
};
</script>

<style lang="scss">
.new-artist-account {
    max-width: 800px;
    margin: 5em auto;
}
.header_and_sub_title {
    text-align: center;
    &__header {
        font-size: 1.3em;
        font-weight: bold;
    }
    &__sub {
        opacity: 0.75;
    }
}
</style>
