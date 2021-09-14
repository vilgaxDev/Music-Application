<template>
    <edit-dialog
        @callToAction="saveSection"
        @cancel="closeWindow"
        :loading="isLoading"
        editing="section"
    >
        <template v-slot:body>
            <v-container fluid>
                <v-row>
                    <v-col cols="12" sm="6">
                        <v-text-field
                            :label="$t('title')"
                            outlined
                            v-model="editedSection.title"
                            hide-details=""
                            :rules="nameRules"
                            @update:error="updateErrorState"
                        ></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="6">
                        <vuetify-select
                            :label="$t('Content')"
                            outlined
                            v-model="editedSection.endpoint"
                            hide-details=""
                            :items="contents"
                            item-text="name"
                            item-value="endpoint"
                            @change="fillContent(true)"
                        ></vuetify-select>
                    </v-col>
                    <v-col cols="12" sm="6" v-if="editedSection.endpoint === null">
                        <vuetify-select
                            outlined
                            :label="$t('Content type')"
                            item-disabled="disabled"
                            v-model="editedSection.content_type"
                            hide-details=""
                            :items="contentTypes"
                            item-text="text"
                            item-value="value"
                            @change="fillContent(true)"
                        ></vuetify-select>
                    </v-col>
                    <v-col cols="12" sm="6">
                        <v-text-field
                            outlined
                            :label="$t('Number of labels')"
                            v-model.number="editedSection.nb_labels"
                            hide-details=""
                            type="number"
                            @change="fillContent(false)"
                        ></v-text-field>
                    </v-col>
                </v-row>
                <v-card
                    class="section-skeleton"
                    elevation="lg"
                    v-if="editedSection.content.length && !contentLoading"
                >
                    <div class="section-header">
                        <div class="section-header__title">
                            {{ editedSection.title }}
                        </div>
                        <div class="section-header__chevrons">
                            <v-icon
                                :id="'swiper-button-zuruck-' + editedSection.id"
                                >mdi-chevron-left</v-icon
                            >
                            <v-icon
                                :id="
                                    'swiper-button-naschte-' + editedSection.id
                                "
                                >mdi-chevron-right</v-icon
                            >
                        </div>
                    </div>
                    <div class="section-body" :style="{ sectionWidth }">
                        <swiper ref="mySwiper" :options="swiperOptions">
                            <template v-for="n in editedSection.nb_labels">
                                <swiper-slide
                                    :key="n"
                                    class="section-item"
                                    v-if="
                                        !contentComputed[n - 1] &&
                                            !editedSection.endpoint
                                    "
                                >
                                    <div
                                        class="absolute fill align-justify-center"
                                    >
                                        <v-icon
                                            size="150"
                                            class="pointer"
                                            @click="attachAsset(n - 1)"
                                            >mdi-plus</v-icon
                                        >
                                    </div>
                                </swiper-slide>
                                <swiper-slide :key="n" v-else>
                                    <template
                                        v-if="
                                            editedSection.content_type ===
                                                'songs'
                                        "
                                    >
                                        <song-expo
                                            admin="true"
                                            :song="contentComputed[n - 1]"
                                        >
                                            <template
                                                v-slot:control-layer
                                                v-if="!editedSection.endpoint"
                                            >
                                                <div class="control-layer">
                                                    <div class="actions">
                                                        <div class="move-left">
                                                            <v-btn
                                                                dark
                                                                icon
                                                                large
                                                                @click="
                                                                    moveItemLeft(
                                                                        n - 1
                                                                    )
                                                                "
                                                            >
                                                                <v-icon>
                                                                    mdi-arrow-left
                                                                </v-icon>
                                                            </v-btn>
                                                        </div>
                                                        <div class="remove">
                                                            <v-btn
                                                                dark
                                                                icon
                                                                large
                                                                @click="
                                                                    removeContentItem(
                                                                        n - 1
                                                                    )
                                                                "
                                                            >
                                                                <v-icon
                                                                    color="error"
                                                                >
                                                                    mdi-delete
                                                                </v-icon>
                                                            </v-btn>
                                                        </div>
                                                        <div class="move-right">
                                                            <v-btn
                                                                dark
                                                                icon
                                                                large
                                                                @click="
                                                                    moveItemRight(
                                                                        n - 1
                                                                    )
                                                                "
                                                            >
                                                                <v-icon>
                                                                    mdi-arrow-right
                                                                </v-icon>
                                                            </v-btn>
                                                        </div>
                                                    </div>
                                                </div>
                                            </template>
                                        </song-expo>
                                    </template>
                                    <template
                                        v-else-if="
                                            editedSection.content_type ===
                                                'albums'
                                        "
                                    >
                                        <album-expo
                                            :album="contentComputed[n - 1]"
                                        />
                                    </template>
                                    <template
                                        v-else-if="
                                            editedSection.content_type ===
                                                'podcasts'
                                        "
                                    >
                                        <podcast-box
                                            :podcast="contentComputed[n - 1]"
                                        />
                                    </template>
                                    <template
                                        v-else-if="
                                            editedSection.content_type ===
                                                'radio-stations'
                                        "
                                    >
                                        <radio-station
                                            :radioStation="
                                                contentComputed[n - 1]
                                            "
                                        />
                                    </template>
                                    <template
                                        v-else-if="
                                            editedSection.content_type ===
                                                'playlists'
                                        "
                                    >
                                        <playlist-expo
                                            :playlist="contentComputed[n - 1]"
                                        />
                                    </template>
                                </swiper-slide>
                            </template>
                        </swiper>
                    </div>
                </v-card>
                <empty-page
                    v-else-if="!editedSection.content.length && !contentLoading"
                    ::headline="$t('No content!')"
                    :sub="
                        $t(
                            'There is no content available yet for this section.'
                        )
                    "
                ></empty-page>
                <page-loading v-else />
            </v-container>
        </template>
        <template v-slot:dialogs>
            <v-dialog v-model="attachAssetDialogBoolean" max-width="500">
                <attach-asset-dialog
                    v-if="assetIndex !== null"
                    class="p-3"
                    @asset="updateContent($event)"
                    :type="{
                        title:
                            editedSection.content_type === 'radio-stations'
                                ? 'name'
                                : 'title',
                        name: editedSection.content_type,
                        image: 'cover'
                    }"
                />
            </v-dialog>
        </template>
    </edit-dialog>
</template>

<script>
import { swiper, swiperSlide } from "vue-awesome-swiper";
import "swiper/css/swiper.css";
import AttachAssetDialog from "../../../dialogs/admin/AttachAssetDialog";
import { VSelect } from "vuetify/lib";
export default {
    props: ["section", "page"],
    components: {
        swiper,
        swiperSlide,
        vuetifySelect: VSelect,
        AttachAssetDialog
    },
    mounted() {
        setTimeout(() => {
            // trigering the section with to fix a bug related with API ( data renderes after the comp mount )
            this.sectionWidth = 1000;
        }, 200);
    },
    data() {
        return {
            sectionWidth: 0,
            editedSection: JSON.parse(JSON.stringify(this.section)),
            attachAssetDialogBoolean: false,
            firstCopy: JSON.parse(JSON.stringify(this.section)),
            isThereAnError: false,
            assetIndex: null,
            isLoading: false,
            contentLoading: false,
            contentTypes: [
                {
                    text: this.$t("Songs"),
                    value: "songs"
                },
                {
                    text: this.$t("Albums"),
                    value: "albums"
                },
                {
                    text: this.$t("Radio Stations"),
                    value: "radio-stations"
                },
                {
                    text: this.$t("Podcasts"),
                    value: "podcasts"
                },
                {
                    text: this.$t("Playlists"),
                    value: "playlists"
                }
            ],
            swiperOptions: {
                slidesPerView: 4,
                spaceBetween: 10,
                navigation: {
                    nextEl: "#swiper-button-naschte-" + this.section.id,
                    prevEl: "#swiper-button-zuruck-" + this.section.id
                },
                pagination: {
                    el: ".swiper-pagination",
                    clickable: true
                },
            },
            contents: [
                {
                    title: this.$t("Custom Section"),
                    name: this.$t("Custom"),
                    endpoint: null,
                    content_type: "songs"
                },
                {
                    name: this.$t("The new released songs"),
                    title: this.$t("New Releases"),
                    endpoint: "new-releases",
                    content_type: "songs"
                },
                {
                    name: this.$t("Most played songs"),
                    title: this.$t("Popular Songs"),
                    endpoint: "popular-songs",
                    content_type: "songs"
                },
                {
                    name: this.$t("Most liked songs"),
                    title: this.$t("Most Liked songs"),
                    endpoint: "most-liked-songs",
                    content_type: "songs"
                },
                {
                    name: this.$t("Latest Albums"),
                    title: this.$t("Latest Albums"),
                    endpoint: "latest-albums",
                    content_type: "albums"
                },
                {
                    name: this.$t("Most played Albums"),
                    title: this.$t("Popular Albums"),
                    endpoint: "popular-albums",
                    content_type: "albums"
                },
                {
                    name:
                        this.$t("Most played podcasts") +
                        (!this.$store.getters.getSettings.enablePodcasts
                            ? "(" + this.$t("podcasts disabled") + ")"
                            : ""),
                    title: this.$t("Popular Podcasts"),
                    endpoint: "popular-podcasts",
                    content_type: "podcasts",
                    disabled: !this.$store.getters.getSettings.enablePodcasts
                },
                {
                    name:
                        this.$t("Latest Podcasts") +
                        (!this.$store.getters.getSettings.enablePodcasts
                            ? "(" + this.$t("podcasts disabled") + ")"
                            : ""),
                    title: this.$t("Latest Podcasts"),
                    endpoint: "latest-podcasts",
                    content_type: "podcasts",
                    disabled: !this.$store.getters.getSettings.enablePodcasts
                }
                // upcoming feature
                // {
                //     name: 'The reccomended songs for the user (based on the genres he played)',
                //     title: 'You may also like',
                //     endpoint: 'you-may-also-like',
                //     content_type: 'songs'
                // },
            ],
            nameRules: [
                value => !!value || this.$t("Required"),
                value => value.length <= 40 || this.$t("Max 40 characters"),
                value => value.length >= 2 || this.$t("Min 2 characters")
            ]
        };
    },
    computed: {
        contentComputed() {
            return this.editedSection.content.slice(
                0,
                this.editedSection.nb_labels
            );
        }
    },
    methods: {
        moveItemLeft(index) {
            if (this.editedSection.content[index - 1] !== undefined) {
                var previous = this.editedSection.content[index - 1];
                var current = this.editedSection.content[index];
                this.$set(this.editedSection.content, index, previous);
                this.$set(this.editedSection.content, index - 1, current);
            }
        },
        moveItemRight(index) {
            if (this.editedSection.content[index + 1] !== undefined) {
                var next = this.editedSection.content[index + 1];
                var current = this.editedSection.content[index];
                this.$set(this.editedSection.content, index, next);
                this.$set(this.editedSection.content, index + 1, current);
            }
        },
        removeContentItem(index) {
            console.log(index);
            this.$set(this.editedSection.content, index, null);
        },
        closeWindow() {
            this.$emit("close");
        },
        updateErrorState(event) {
            this.isThereAnError = event;
        },
        async createPageFirst() {
            const formData = new FormData();
            formData.append("title", this.page.title || "");
            formData.append("description", this.page.description || "");
            formData.append("name", this.page.name || "");
            formData.append("icon", this.page.icon || "");
            formData.append("path", this.page.path || "");
            let res = await axios.post("/api/admin/pages", formData);
            return res.data;
        },
        async saveSection() {
            this.isLoading = true;
            if (
                this.editedSection.nb_labels > this.editedSection.content.length
            ) {
                this.editedSection.nb_labels = this.editedSection.content.length;
            }
            if (this.editedSection.content.find(a => a && a.id)) {
                this.editedSection.content = this.editedSection.content
                    .splice(0, this.editedSection.nb_labels)
                    .filter(asset => asset);
            } else {
                this.isLoading = false;
                return this.$notify({
                    group: "foo",
                    type: "error",
                    title: this.$t("Error"),
                    text: this.$t("Please add some content to your section!")
                });
            }
            var formData = new FormData();
            formData.append("title", this.editedSection.title || "");
            formData.append(
                "content_type",
                this.editedSection.content_type || ""
            );
            formData.append(
                "content",
                JSON.stringify(this.editedSection.content.map(c => c.id)) || ""
            );
            formData.append("nb_labels", this.editedSection.nb_labels || "");
            formData.append("endpoint", this.editedSection.endpoint || "");
            if (!this.page.id) {
                var page = await this.createPageFirst();
                this.$emit("id", page.id);
            }
            formData.append("page_id", this.page.id || page.id || "");
            if (this.editedSection.new) {
                axios
                    .post("/api/admin/sections", formData)
                    .then(() => {
                        this.$emit("created");
                        this.$notify({
                            group: "foo",
                            type: "success",
                            title: this.$t("Created"),
                            text: this.$t(
                                "The section was created successfully."
                            )
                        });
                    })
                    .finally(() => (this.isLoading = false));
            } else {
                formData.append("_method", "PUT");
                axios
                    .post(
                        "/api/admin/sections/" + this.editedSection.id,
                        formData
                    )
                    .then(() => {
                        this.$emit("updated");
                        this.$notify({
                            group: "foo",
                            type: "success",
                            title: this.$t("Updated"),
                            text:
                                this.$t("Section was") +
                                " " +
                                this.$t("updated successfully.")
                        });
                    })
                    .finally(() => (this.isLoading = false));
            }
        },
        fillContent(reset) {
            if (reset) {
                this.resetContent();
            }
            if (this.editedSection.endpoint) {
                this.editedSection.content_type = this.contents.find(
                    c => c.endpoint === this.editedSection.endpoint
                ).content_type;
                this.contentLoading = true;
                axios
                    .get(
                        "/api/" +
                            this.editedSection.endpoint +
                            "/" +
                            this.editedSection.nb_labels
                    )
                    .then(res => (this.editedSection.content = res.data))
                    .finally(() => (this.contentLoading = false));
            }
        },
        resetContent() {
            this.editedSection.content = [];
            for (let i = 0; i < this.editedSection.nb_labels; i++) {
                this.editedSection.content.push(null);
            }
        },
        attachAsset(index) {
            this.attachAssetDialogBoolean = true;
            this.assetIndex = index;
        },
        updateContent(event) {
            this.$set(this.editedSection.content, this.assetIndex, event);
            this.attachAssetDialogBoolean = false;
            this.assetIndex = null;
        }
    }
};
</script>
<style lang="scss" scoped>
.section-header__title {
    margin-bottom: 0 !important;
}
.control-layer {
    .actions {
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
}
</style>
