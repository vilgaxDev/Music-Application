<template>
    <div class="content-page upload-page">
        <disabled-page
            text="You are not allowed to upload"
            v-if="!hasPermission('upload songs')"
        />
        <div class="icon-header">
            <div class="cover">
                <img src="/svg/cloud-download.svg" alt />
            </div>
            <div class="title">
                <div class="headline">Upload</div>
                <div class="sub">
                    Upload a song that you like to hear locally
                </div>
            </div>
        </div>
        <div class="window-body">
            <v-container class="container-max-1024">
                <v-row align-content="center">
                    <v-col cols="auto">
                        <upload-image
                            @imageReady="imageReady($event)"
                            :source="song.cover || defaultCoverPath"
                            :id="'song-' + song.id"
                        />
                        <div>
                            <div
                                v-if="savingStatus == 'Saving...' && progress"
                                class="button-upload"
                            >
                                <button
                                    class="uploading my-2  v-btn v-btn--block v-btn--contained theme--dark v-size--default"
                                    color="transparent"
                                >
                                    <div class="content-text">
                                        {{ savingStatus }} {{ progress }}%
                                    </div>
                                    <div
                                        class="percentage success"
                                        :style="{ width: progress + '%' }"
                                    ></div>
                                </button>
                                <v-btn
                                    class="cancel my-2 "
                                    block
                                    color="error"
                                    @click="cancelRequest()"
                                >
                                    Cancel
                                </v-btn>
                            </div>
                            <v-btn
                                v-else
                                block
                                class="my-2 success"
                                :disabled="
                                    sourceMissing ||
                                        !song.title ||
                                        disableSaveButton
                                "
                                @click.stop="saveSong"
                                >{{ savingStatus }}
                            </v-btn>
                        </div>
                    </v-col>
                    <v-col cols="12" md="8">
                        <v-container>
                            <v-row>
                                <v-col cols="12">
                                    <v-file-input
                                        :rules="[rules.fileSize]"
                                        accept="audio/*"
                                        show-size
                                        :label="
                                            song.source
                                                ? extractFileName(song.source)
                                                : 'Attach Song File'
                                        "
                                        prepend-icon="mdi-music-note"
                                        :loading="songSourceLoading"
                                        @change="loadSongMetadata($event)"
                                    ></v-file-input>
                                    <v-text-field
                                        :label="
                                            'Youtube URL' +
                                                ($store.getters.getSettings
                                                    .allowVideos
                                                    ? '(optional)'
                                                    : '(Videos disabled)')
                                        "
                                        :messages="
                                            $store.getters.getSettings
                                                .allowVideos
                                                ? 'Insering a youtube URL will make the Song/audio play from the video and NOT the audio source asset.'
                                                : ''
                                        "
                                        v-model="youtube_url"
                                        v-if="
                                            $store.getters.getSettings
                                                .allowVideos
                                        "
                                    ></v-text-field>
                                    <v-row>
                                        <v-col>
                                            <v-text-field
                                                label="Title"
                                                v-model="song.title"
                                                :disabled="sourceMissing"
                                            ></v-text-field>
                                        </v-col>
                                    </v-row>
                                    <v-text-field
                                        label="Duration(s)"
                                        placeholder="duration in seconds"
                                        v-model="song.duration"
                                        :disabled="
                                            autoDuration ||
                                                (!songFile &&
                                                    !song.source &&
                                                    sourceMissing)
                                        "
                                    >
                                    </v-text-field>
                                    <v-checkbox
                                        v-model="autoDuration"
                                        :disabled="
                                            !songFile &&
                                                !song.source &&
                                                sourceMissing
                                        "
                                        label="Auto from metadata"
                                    >
                                    </v-checkbox>
                                    <v-row align="end" v-if="!sourceMissing">
                                        <v-col>
                                            <div class="form__group field">
                                                <label
                                                    for="artists"
                                                    class="form__label"
                                                    :class="{
                                                        form__label__active:
                                                            artistsFocused ||
                                                            artists.length
                                                    }"
                                                    >Artists</label
                                                >
                                                <v-select
                                                    @search:focus="
                                                        artistsFocued = true
                                                    "
                                                    :disabled="sourceMissing"
                                                    @search:blur="
                                                        artistsFocused = false
                                                    "
                                                    multiple
                                                    class="v-select"
                                                    v-model="artists"
                                                    taggable
                                                    label="+ Add Artist"
                                                >
                                                    <template v-slot:no-options>
                                                        <em
                                                            style="opacity: 0.75;"
                                                            >Enter the name of
                                                            the artist to
                                                            select.</em
                                                        >
                                                    </template>
                                                </v-select>
                                            </div>
                                        </v-col>
                                    </v-row>

                                    <div
                                        class="form__group field"
                                        v-if="!sourceMissing"
                                    >
                                        <label
                                            for="genre"
                                            class="form__label"
                                            :class="{
                                                form__label__active:
                                                    genresFocused ||
                                                    song.genres.length
                                            }"
                                            >Genres</label
                                        >
                                        <v-select
                                            @search:focus="genresFocused = true"
                                            @search:blur="genresFocused = false"
                                            multiple
                                            append-to-body
                                            maxHeight="200px"
                                            v-model="song.genres"
                                            :options="genres"
                                            label="name"
                                            class="v-select"
                                            @search="fetchGenres"
                                        >
                                            <template
                                                v-slot:no-options="{
                                                    search,
                                                    searching
                                                }"
                                            >
                                                <template v-if="searching">
                                                    No results found for
                                                    <em>{{ search }}</em
                                                    >.
                                                </template>
                                                <em
                                                    style="opacity: 0.75;"
                                                    v-else
                                                    >Start typing to search for
                                                    a genre.</em
                                                >
                                            </template>
                                        </v-select>
                                    </div>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>
<script>
import { VSelect } from "vuetify/lib";
export default {
    metaInfo() {
        return {
            title: "Upload"
        };
    },
    components: {
        veutifySelect: VSelect
    },
    data() {
        return {
            song: {
                new: true,
                title: "",
                youtube_id: "",
                genres: []
            },
            songSourceLoading: false,
            defaultCoverPath: "/storage/defaults/images/song_cover.png",
            rules: {
                fileSize: file =>
                    file?.size <
                        parseInt(this.$store.getters.getSettings.maxFileSize) *
                            1024 *
                            1024 ||
                    "Max file size is " +
                        this.$store.getters.getSettings.maxFileSize +
                        " MB"
            },
            songFile: null,
            artistsFocused: false,
            genresFocused: false,
            rolesDialog: false,
            artists: [],
            genres: [],
            fileSize: null,
            progress: null,
            disableSaveButton: false,
            savingStatus: "Save",
            errors: {}
        };
    },
    computed: {
        autoDuration: {
            get() {
                return !this.song.duration;
            },
            set(val) {
                this.song.duration = val ? null : 5000;
            }
        },
        sourceMissing() {
            return !this.songFile && !this.song.youtube_id && !this.song.source;
        },
        youtube_url: {
            set(val) {
                function youtube_parser(url) {
                    var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
                    var match = url.match(regExp);
                    return match && match[7].length == 11 ? match[7] : "";
                }
                this.song.youtube_id = youtube_parser(val);
            },
            get() {
                if (this.song.youtube_id) {
                    return (
                        "https://youtube.com/watch?v=" + this.song.youtube_id
                    );
                }
                return "";
            }
        }
    },
    methods: {
        imageReady(e) {
            this.song.cover = e;
        },
        fetchGenres(search, loading) {
            if (search.length > 0) {
                loading(true),
                    axios
                        .get("/api/match-genres/" + search)
                        .then(
                            res =>
                                (this.genres = res.data.map(genre => ({
                                    id: genre.id,
                                    name: genre.name
                                })))
                        )
                        .then(() => loading(false));
            }
        },
        cancelRequest() {
            this.song.progress = null;
            this.song.requestSource.cancel("upload canceled");
        },
        loadSongMetadata(file) {
            if (!file) return (this.songFile = null), (this.song.source = null);
            this.songSourceLoading = true;
            return new Promise((res, rej) => {
                this.getAudioMetadata(
                    file ? file : this.song.source,
                    function(audioMetadata) {
                        if (!audioMetadata) {
                            this.$notify({
                                group: "foo",
                                type: "error",
                                title: "File corrupted!",
                                text:
                                    "The source file you are trying to upload is corrupted."
                            });
                            this.songSourceLoading = false;
                            rej();
                            return;
                        }
                        this.songFile = file;
                        this.fileSize = file.size;
                        this.song.duration = Math.floor(audioMetadata.duration);
                        this.songSourceLoading = false;
                        res();
                    }.bind(this)
                );
            });
        },
        saveSong() {
            if (this.hasPermission("upload songs")) {
                var formData = new FormData();
                if (this.song.cover && this.song.cover.data) {
                    // if cover was picked, the value is stored as an object from the CropImage component
                    formData.append(
                        "cover",
                        this.song.cover.data,
                        this.song.cover.title
                    );
                } else if (this.song.cover && !this.song.cover.data) {
                    // no cover was picked, the value is stored as a string
                    formData.append("cover", this.song.cover);
                } else {
                    formData.append("cover", this.defaultCoverPath);
                }

                if (this.song.title) {
                    formData.append("title", this.song.title);
                }

                if (this.song.youtube_id) {
                    formData.append("youtube_id", this.song.youtube_id);
                }
                if (this.artists.length) {
                    this.song.artists = JSON.stringify(this.artists);
                    formData.append("artists", this.song.artists);
                } else {
                    this.song.artists = JSON.stringify([]);
                    formData.append("artists", this.song.artists);
                }

                if (this.song.genres.length) {
                    formData.append("genres", JSON.stringify(this.song.genres));
                }
                var duration;
                var promise = new Promise((res) => {
                    if (this.songFile || this.song.source) {
                        if (!this.autoDuration && this.song.duration > 1) {
                            duration = this.song.duration;
                            res();
                        } else {
                            this.loadSongMetadata(
                                this.songFile ? this.songFile : this.song.source
                            );
                            duration = this.song.duration;
                            res();
                        }
                    } else {
                        if (!this.youtube_url) {
                            this.$notify({
                                group: "foo",
                                type: "error",
                                title: "Error!",
                                text:
                                    "Select audio file first or add a youtube URL"
                            });
                            return;
                        }
                        res();
                    }
                });
                promise
                    .then(() => {
                        const request = axios.CancelToken.source();
                        this.song.requestSource = request;
                        this.savingStatus = "Saving...";
                        this.$emit("sleep");
                        if (this.songFile) {
                            formData.append("audio", this.songFile);
                            formData.append("file_size", this.fileSize);
                        }
                        formData.append("duration", this.song.duration || 0);
                        if (this.song.new) {
                            formData.append("new", true);
                            if (this.album_id) {
                                formData.append("album_id", this.album_id);
                            }
                            formData.append("uploaded_by", "user");
                            axios
                                .post("/api/user/songs", formData, {
                                    headers: {
                                        "Content-Type": "multipart/form-data"
                                    },
                                    cancelToken: this.song.requestSource.token,
                                    onUploadProgress: progressEvent => {
                                        let percentCompleted = Math.floor(
                                            (progressEvent.loaded * 100) /
                                                progressEvent.total
                                        );
                                        this.progress =
                                            percentCompleted === 100
                                                ? 99
                                                : percentCompleted;
                                        this.$emit("progress", this.progress);
                                    }
                                })
                                .then(res => {
                                    this.song.new = false;
                                    this.song.id = res.data.id;
                                    this.song.source = res.data.source;
                                    this.song.cover = res.data.cover;
                                    this.song.title = res.data.title;
                                    this.song.duration = res.data.duration;
                                    this.$notify({
                                        group: "foo",
                                        type: "success",
                                        title: "Created!",
                                        text: "song created!"
                                    });
                                    this.savingStatus = "Save";
                                    this.disableSaveButton = true;
                                    this.$router.push({
                                        name: "library.my-songs"
                                    });
                                })
                                .catch(e => {
                                    this.song.progress = null;
                                    this.savingStatus = "Save";
                                    this.$notify({
                                        group: "foo",
                                        type: "error",
                                        title: "Error!",
                                        text: Object.values(
                                            e.response.data.errors
                                        ).join("<br />")
                                    });
                                });
                        } else {
                            formData.append("_method", "PUT");
                            axios
                                .put(
                                    "/api/user/songs/" + this.song.id,
                                    formData,
                                    {
                                        headers: {
                                            "Content-Type":
                                                "multipart/form-data"
                                        },
                                        cancelToken: this.song.requestSource
                                            .token,
                                        onUploadProgress: progressEvent => {
                                            let percentCompleted = Math.floor(
                                                (progressEvent.loaded * 100) /
                                                    progressEvent.total
                                            );
                                            this.progress =
                                                percentCompleted === 100
                                                    ? 99
                                                    : percentCompleted;
                                            this.$emit(
                                                "progress",
                                                this.progress
                                            );
                                        }
                                    }
                                )
                                .then(res => {
                                    this.song.source = res.data.source;
                                    this.song.cover = res.data.cover;
                                    this.song.title = res.data.title;
                                    this.song.duration = res.data.duration;
                                    this.$notify({
                                        group: "foo",
                                        type: "success",
                                        title: "Updated!",
                                        text: "song updated!"
                                    });
                                    this.savingStatus = "Save";
                                    this.disableSaveButton = true;
                                    this.$router.push({
                                        name: "library.my-songs"
                                    });
                                    this.savingStatus = "Save";
                                })
                                .catch(e => {
                                    this.song.progress = null;
                                    this.savingStatus = "Save";
                                    this.$notify({
                                        group: "foo",
                                        type: "error",
                                        title: "Error!",
                                        text: Object.values(
                                            e.response.data.errors
                                        ).join("<br />")
                                    });
                                });
                        }
                    })
                    .catch();
            }
        }
    }
};
</script>

<style lang="scss" scoped>
.upload-page {
    position: relative;
    @media screen and ( max-width: 900px ) {
        padding-bottom: 6em;
    }
}
.icon-header > .cover {
    background: linear-gradient(45deg, #61045f, #aa076b);
}
.edit-song-dialog-wrapper {
    background-color: rgb(33, 33, 33);
}
hr {
    margin-top: 0 !important;
    margin-bottom: 0 !important;
}
.dialog-actions {
    display: flex;
    justify-content: flex-end;
}
.container {
    padding-top: 3px !important;
    padding-bottom: 3px !important;
}
.button-upload {
    &:hover {
        .uploading {
            display: none;
        }
        .cancel {
            display: block;
        }
    }
    .uploading {
        position: relative;
        overflow: hidden;
        .percentage {
            position: absolute;
            top: 0;

            left: 0;
            transition: width 0.3s;
            z-index: 0;
            height: 100%;
        }
        .content-text {
            z-index: 1;
        }
    }
    .cancel {
        display: none;
    }
}
</style>
