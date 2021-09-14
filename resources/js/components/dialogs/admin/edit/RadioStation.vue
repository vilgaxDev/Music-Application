<template>
    <edit-dialog
        @callToAction="saveRadioStation"
        @cancel="closeWindow"
        :loading="isLoading"
        editing="Radio Station"
    >
        <template v-slot:body>
            <v-container class="px-3 pb-3">
                <v-row>
                    <v-col cols="auto">
                        <upload-image
                            @imageReady="imageReady($event)"
                            :source="
                                editedRadioStation.cover || defaultCoverPath
                            "
                        />
                    </v-col>
                    <v-col>
                        <v-text-field
                            :label="$t('Name')"
                            v-model="editedRadioStation.name"
                            outlined
                        ></v-text-field>
                        <v-text-field
                            :label="$t('Stream Endpoint')"
                            v-model="editedRadioStation.endpoint"
                            outlined
                        ></v-text-field>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col>
                        <v-container>
                            <v-row>
                                <v-col>
                                    <div class="card-bb-header">
                                        <div class="header">
                                            <div class="title">
                                                {{ $t("Metadata Types") }}
                                            </div>
                                        </div>
                                        <v-divider class="pt-2"></v-divider>
                                        <div class="sub">
                                            {{ $t("Metadata types to parse") }}
                                        </div>
                                        <div class="body">
                                            <v-row>
                                                <v-col cols="6">
                                                    <v-checkbox
                                                        v-model="
                                                            editedRadioStation.metadata_types
                                                        "
                                                        color="primary"
                                                        value="ICY"
                                                        label="ICY"
                                                    ></v-checkbox>
                                                </v-col>
                                                <v-col cols="6">
                                                    <v-checkbox
                                                        v-model="
                                                            editedRadioStation.metadata_types
                                                        "
                                                        color="primary"
                                                        value="OGG"
                                                        label="OGG"
                                                    ></v-checkbox>
                                                </v-col>
                                            </v-row>
                                            <v-row>
                                                <v-col cols="12">
                                                    <v-text-field
                                                        :label="
                                                        'ICY' +  ' ' + 
                                                            $t('Detection Timeout') + '(MS)'
                                                        "
                                                        v-model="
                                                            editedRadioStation.icy_detection_timeout
                                                        "
                                                        :messages="
                                                            $t(
                                                                'Duration in milliseconds to search for ICY metadata if icyMetaInt is not passed in.'
                                                            )
                                                        "
                                                        type="number"
                                                        v-if="
                                                            editedRadioStation.metadata_types.includes(
                                                                'ICY'
                                                            )
                                                        "
                                                    ></v-text-field>
                                                </v-col>
                                            </v-row>
                                        </div>
                                    </div>
                                </v-col>
                                <v-col cols="12">
                                    <v-switch label="Highlight" messages="Show on the live radio section on the right-sidebar" v-model="editedRadioStation.highlight"></v-switch>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-col>
                </v-row>
            </v-container>
        </template>
    </edit-dialog>
</template>
<script>
export default {
    props: ["radioStation"],
    data() {
        return {
            editedRadioStation: this.radioStation,
            isThereAnError: false,
            file: null,
            isLoading: false,
            errors: {},
            defaultCoverPath:
                "/storage/defaults/images/podcast_cover.png",
            firstCopy: JSON.parse(JSON.stringify(this.radioStation))
        };
    },
    methods: {
        imageReady(e) {
            this.editedRadioStation.cover = e;
        },
        updateErrorState(event) {
            this.isThereAnError = event;
        },
        closeWindow() {
            let changed = false;
            if (this.editedRadioStation.name != this.firstCopy.name) {
                changed = true;
            }
            if (this.editedRadioStation.cover != this.firstCopy.cover) {
                changed = true;
            }
            if (changed) {
                this.$confirm({
                    message: `${this.$t(
                        "Are you sure you wanna quit without saving the changes?"
                    )}`,
                    button: {
                        no: this.$t("Cancel"),
                        yes: this.$t("Discard")
                    },
                    callback: confirm => {
                        if (confirm) {
                            this.editedRadioStation = this.firstCopy;
                            this.$emit("close");
                        }
                    }
                });
            } else {
                this.$emit("close");
            }
        },
        saveRadioStation() {
            this.isLoading = true;
            var formData = new FormData();
            formData.append("name", this.editedRadioStation.name || "");
            formData.append("endpoint", this.editedRadioStation.endpoint || "");
            formData.append("highlight", this.editedRadioStation.highlight? 1 : 0);
            formData.append(
                "metadata_types",
                JSON.stringify(this.editedRadioStation.metadata_types)
            );
            formData.append(
                "icy_detection_timeout",
                this.editedRadioStation.icy_detection_timeout
            );
            formData.append(
                "retry_timeout",
                10
                // this.editedRadioStation.retry_timeout 
            );
            if (
                this.editedRadioStation.cover &&
                this.editedRadioStation.cover.data
            ) {
                // if cover was picked, the value is stored as an object from the CropImage component
                formData.append(
                    "cover",
                    this.editedRadioStation.cover.data,
                    this.editedRadioStation.cover.title
                );
            } else if (
                this.editedRadioStation.cover &&
                !this.editedRadioStation.cover.data
            ) {
                // no cover was picked, the value is stored as a string
                formData.append("cover", this.editedRadioStation.cover);
            } else {
                formData.append("cover", this.defaultCoverPath);
            }
            if (this.editedRadioStation.new) {
                axios
                    .post("/api/admin/radio-stations", formData, {
                        headers: {
                            "Content-Type": "multipart/form-data"
                        },
                        onUploadProgress: progressEvent => {
                            let percentCompleted = Math.floor(
                                (progressEvent.loaded * 100) /
                                    progressEvent.total
                            );
                            this.progress = percentCompleted;
                        }
                    })
                    .then(() => {
                        this.$emit("updated");
                    })
                    .catch(e => {
                        this.progress = 0;
                        this.isLoading = false;
                        this.errors = e.response.data.errors;
                        // this.$notify({
                        //     group: "foo",
                        //     type: "error",
                        //     title: this.$t("Error"),
                        //     text: Object.values(e.response.data.errors).join(
                        //         "<br />"
                        //     )
                        // });
                    });
            } else {
                formData.append("id", this.editedRadioStation.id);
                formData.append("_method", "PUT");
                axios
                    .post(
                        "/api/admin/radio-stations/" +
                            this.editedRadioStation.id,
                        formData,
                        {
                            headers: {
                                "Content-Type": "multipart/form-data"
                            },
                            onUploadProgress: progressEvent => {
                                let percentCompleted = Math.floor(
                                    (progressEvent.loaded * 100) /
                                        progressEvent.total
                                );
                                this.progress = percentCompleted;
                            }
                        }
                    )
                    .then(() => {
                        this.$emit("updated");
                        this.isLoading = "Saved";
                    })
                    .catch(e => {
                        this.progress = 0;
                        this.isLoading = false;
                        this.errors = e.response.data.errors;
                        // this.$notify({
                        //     group: "foo",
                        //     type: "error",
                        //     title: this.$t("Error"),
                        //     text: Object.values(e.response.data.errors).join(
                        //         "<br />"
                        //     )
                        // });
                    });
            }
        }
    }
};
</script>
