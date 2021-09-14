<template>
    <edit-dialog
        @callToAction="saveSong"
        @cancel="closeWindow"
        :loading="isLoading"
        :hideCallToAction="true"
        editing="Song"
    >
        <template v-slot:header-actions>
            <v-btn @click="$emit('sleep')" v-if="uploader !== 'user'"> {{ $t("Hide") }} </v-btn>
        </template>
        <template v-slot:body>
            <v-container>
                <v-row>
                    <v-col cols="auto">
                        <upload-image
                            @imageReady="imageReady($event)"
                            :source="editedSong.cover || defaultCoverPath"
                            :id="'song-' + editedSong.id"
                        />
                        <div>
                            <div
                                v-if="isLoading && progress"
                                class="button-upload"
                            >
                                <button
                                    class="uploading my-2 v-btn v-btn--block v-btn--contained theme--dark v-size--default"
                                    color="transparent"
                                >
                                    <div class="content-text">
                                        {{$t('Saving... ')}}{{ progress }}%
                                    </div>
                                    <div
                                        class="percentage success"
                                        :style="{ width: progress + '%' }"
                                    ></div>
                                </button>
                                <v-btn
                                    class="cancel my-2"
                                    block
                                    color="error"
                                    @click="cancelRequest()"
                                >
                                    {{ $t("Cancel") }}
                                </v-btn>
                            </div>
                            <v-btn
                                v-else
                                block
                                class="my-2 success"
                                :disabled="error"
                                @click.stop="saveSong"
                                >{{ $t("Save") }}
                            </v-btn>
                        </div>
                    </v-col>
                    <v-col>
                        <v-container>
                            <v-row>
                                <v-col cols="5">
                                    <veutifySelect
                                        outlined
                                        :items="sourceFormats"
                                        @change="resetSource"
                                        :label="$t('Source Format')"
                                        item-value="value"
                                        v-model="editedSong.source_format"
                                    >
                                        <template
                                            v-slot:item="{ item }"
                                            :disabled="
                                                item.value == 'video' &&
                                                    !$store.getters.getSettings
                                                        .allowVideos
                                            "
                                        >
                                            <div class="align-center p-1">
                                                <v-icon
                                                    class="mr-2"
                                                    color="primary"
                                                    >mdi-{{ item.icon }}</v-icon
                                                >
                                                {{ item.text }}
                                            </div>
                                        </template>
                                        <template v-slot:selection="{ item }">
                                            <div class="align-center p-1">
                                                <v-icon
                                                    class="mr-2"
                                                    color="primary"
                                                    >mdi-{{ item.icon }}</v-icon
                                                >
                                                {{ item.text }}
                                            </div>
                                        </template>
                                    </veutifySelect>
                                </v-col>
                                <v-col cols="7">
                                    <v-file-input
                                        v-if="
                                            editedSong.source_format === 'file'
                                        "
                                        :rules="[rules.fileSize]"
                                        accept="audio/*"
                                        show-size
                                        outlined
                                        :error="error"
                                        v-model="songFile"
                                        @update:error="error = $event"
                                        :label="
                                            editedSong.file_name
                                                ? editedSong.file_name
                                                : $t('Attach Audio File')
                                        "
                                        :loading="songSourceLoading"
                                        @change="loadSongMetadata($event)"
                                    ></v-file-input>
                                    <v-text-field
                                        v-else-if="
                                            editedSong.source_format ===
                                                'yt_video'
                                        "
                                        :label="$t('Video URL')"
                                        :hint="$t('You can add the video ID, but It must be valid.')"
                                        v-model="editedSong.source"
                                        outlined
                                    ></v-text-field>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col>
                                    <v-text-field
                                        :label="$t('Title')"
                                        dense
                                        outlined
                                        :rules="titleRules"
                                        hide-details="auto"
                                        v-model="editedSong.title"
                                    ></v-text-field>
                                </v-col>
                            </v-row>
                            <v-row justify="center">
                                <v-col cols="6" sm="8">
                                    <v-text-field
                                        :label="$t('Duration')+'(s)'"
                                        :placeholder="$t('Duration in seconds')"
                                        type="number"
                                        outlined
                                        dense
                                        hide-details
                                        v-model="editedSong.duration"
                                        :disabled="autoDuration"
                                    >
                                    </v-text-field>
                                </v-col>
                                <v-col cols="6" sm="4">
                                    <v-switch
                                        v-model="autoDuration"
                                        dense
                                        hide-details
                                        @change="
                                            $event
                                                ? loadSongMetadata(
                                                      songFile ||
                                                          editedSong.source
                                                  )
                                                : ''
                                        "
                                        :label="$t('Auto Duration')"
                                        :disabled="
                                            editedSong.source_format ===
                                                'yt_video'
                                        "
                                    >
                                    </v-switch>
                                </v-col>
                            </v-row>
                            <v-row align="end" class="row-row">
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
                                            >{{ $t("Artists") }}</label
                                        >
                                        <v-select
                                            @search:focus="artistsFocued = true"
                                            @search:blur="
                                                artistsFocused = false
                                            "
                                            multiple
                                            class="v-select"
                                            v-model="artists"
                                            taggable
                                        >
                                            <template v-slot:no-options>
                                                <em style="">{{
                                                    $t(
                                                        "Insert the name of the artist and press the Enter key."
                                                    )
                                                }}</em>
                                            </template>
                                        </v-select>
                                    </div>
                                </v-col>

                                <v-col cols="auto">
                                    <v-btn
                                        v-if="
                                            uploader === 'admin' &&
                                                $store.getters.isUser('admin')
                                        "
                                        class="px-2 primary"
                                        dark
                                        small
                                        :title="
                                            $t(
                                                'Attach this song to an existing artist'
                                            )
                                        "
                                        @click="attachArtistDialog = true"
                                        >{{ $t("Link To Artist") }}</v-btn
                                    >
                                </v-col>
                            </v-row>
                            <v-row class="row-row">
                                <v-col>
                                    <div class="form__group field">
                                        <label
                                            for="genre"
                                            class="form__label"
                                            :class="{
                                                form__label__active:
                                                    genresFocused ||
                                                    editedSong.genres.length
                                            }"
                                            >{{ $t("Genres") }}</label
                                        >
                                        <v-select
                                            @search:focus="genresFocused = true"
                                            @search:blur="genresFocused = false"
                                            multiple
                                            append-to-body
                                            maxHeight="200px"
                                                v-model="editedSong.genres"
                                            :options="genres"
                                            :label="$t('name')"
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
                                                    {{
                                                        $t(
                                                            "No results found for"
                                                        )
                                                    }}
                                                    <em>{{ search }}</em
                                                    >.
                                                </template>
                                                <em
                                                    style="opacity: 0.75"
                                                    v-else
                                                    >{{
                                                        $t(
                                                            "Start typing to search for a genre."
                                                        )
                                                    }}</em
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
        </template>
        <template v-slot:dialogs v-if="uploader === 'admin'">
            <v-dialog v-model="attachArtistDialog" max-width="500px">
                <v-card v-if="attachArtistDialog" class="py-4">
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-autocomplete
                                    v-model="selectedArtist"
                                    :items="searchedArtists"
                                    :loading="isSearchArtistLoading"
                                    :search-input.sync="searchArtists"
                                    item-text="displayname"
                                    :label="$t('Search Artist')"
                                    :placeholder="$t('Start typing to Search')"
                                    return-object
                                    prepend-icon="mdi-music-note"
                                >
                                    <template v-slot:item="{ item }">
                                        <div class="item py-2">
                                            <div class="list-item-cover">
                                                <v-img
                                                    :src="item.avatar"
                                                    class="img mr-1"
                                                    width="40"
                                                    aspect-ratio="1"
                                                >
                                                    <template
                                                        v-slot:placeholder
                                                    >
                                                        <v-row
                                                            class="fill-height ma-0"
                                                            align="center"
                                                            justify="center"
                                                        >
                                                            <content-placeholders
                                                                :rounded="true"
                                                                style="width: 100%"
                                                            >
                                                                <content-placeholders-img />
                                                            </content-placeholders>
                                                        </v-row>
                                                    </template>
                                                </v-img>
                                            </div>
                                        </div>
                                        {{ item.displayname }}
                                    </template>
                                </v-autocomplete>
                            </v-col>
                            <v-col cols="12">
                                <v-btn
                                    class="success"
                                    block
                                    :disabled="!selectedArtist"
                                    @click="attachArtist"
                                    >{{ $t("Attach") }}</v-btn
                                >
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card>
            </v-dialog>
        </template>
    </edit-dialog>
</template>

<script>
import { VSelect } from "vuetify/lib";
export default {
    props: ["song", "album_id", "uploader"],
    components: {
        veutifySelect: VSelect
    },
    data() {
        return {
            firstCopy: JSON.parse(JSON.stringify(this.song)),
            editedSong: this.song,
            songFile: null,
            defaultCoverPath: "/storage/defaults/images/song_cover.png",
            songSourceLoading: false,
            artistsFocused: false,
            attachArtistDialog: false,
            selectedArtist: null,
            fileSize: null,
            searchedArtists: [],
            isSearchArtistLoading: false,
            searchArtists: null,
            autoDuration: true,
            genresFocused: false,
            sourceFormats: [
                {
                    value: "file",
                    text: this.$t("Audio File"),
                    icon: "file-chart"
                },
                {
                    value: "yt_video",
                    text: this.$t("YouTube Video"),
                    icon: "youtube"
                }
            ],
            rules: {
                fileSize: file =>
                    file
                        ? file.size <
                              parseInt(
                                  this.$store.getters.getSettings.maxFileSize
                              ) *
                                  1024 *
                                  1024 ||
                          this.$t("Max file size is") + ' ' + 
                              this.$store.getters.getSettings.maxFileSize + " " + 
                              this.$t("MB")
                        : true
            },
            titleRules: [
                (v) => !!v || this.$t('Please give a title')
            ],
            artists: this.song.artists
                ? Object.values(JSON.parse(this.song.artists))
                : [],
            genres: [],
            progress: null,
            error: false,
            isLoading: false
        };
    },
    watch: {
        searchArtists(val) {
            if (this.isSearchArtistLoading) return;
            this.isSearchArtistLoading = true;
            axios
                .get("/api/match-artists/" + val)
                .then(res => {
                    this.searchedArtists = res.data;
                })
                .catch()
                .finally(() => (this.isSearchArtistLoading = false));
        },
        artists(oldVal, newVal) {
            if (oldVal[0] !== newVal[0]) {
                this.editedSong.artist = null;
            }
        }
    },
    computed: {
        sourceMissing() {
            return !this.editedSong.source && !this.songFile;
        }
    },
    methods: {
        imageReady(e) {
            this.editedSong.cover = e;
        },
        getYoutubeVideoID(string = "") {
            if (string) {
                if (string.length === 11) {
                    return string;
                }
                var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
                var match = string.match(regExp);
                return match && match[7].length == 11 ? match[7] : "";
            }
            return "";
        },
        attachArtist() {
            this.editedSong.artist = this.selectedArtist;
            if (
                !this.artists.some(
                    artist => artist === this.selectedArtist.displayname
                )
            ) {
                this.artists.unshift(this.selectedArtist.displayname);
            }
            this.attachArtistDialog = false;
        },
        closeWindow() {
            if (
                this.songFile ||
                JSON.stringify(this.firstCopy) !==
                    JSON.stringify(this.editedSong)
            ) {
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
                            if (this.editedSong.requestSource) {
                                this.editedSong.requestSource.cancel();
                            }
                            this.editedSong.title = this.firstCopy.title;
                            this.editedSong.genres = this.firstCopy.genres;
                            this.editedSong.artists = this.firstCopy.artists;
                            this.editedSong.youtube_id = this.firstCopy.youtube_id;
                            this.editedSong.cover = this.firstCopy.cover;
                            this.editedSong.artist = this.firstCopy.artist;
                            this.editedSong.duration = this.firstCopy.duration;
                            this.$emit("close");
                        }
                    }
                });
            } else {
                this.$emit("close");
            }
        },
        resetSource($event) {
            this.editedSong.source = null;
            if ($event === "yt_video") {
                this.autoDuration = false;
            } else if ($event === "file") {
                this.autoDuration = true;
            }
        },
        fetchGenres(search, loading) {
            if (search.length >= 1) {
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
            this.editedSong.progress = null;
            this.editedSong.requestSource.cancel("upload canceled");
        },
        loadSongMetadata(file) {
            if (!file) {
                return (this.songFile = null), (this.editedSong.source = null);
            }
            this.songSourceLoading = true;
            this.error = false;
            return new Promise((res, rej) => {
                this.getAudioMetadata(
                    file ? file : this.editedSong.source,
                    function(audioMetadata) {
                        if (!audioMetadata) {
                            this.$notify({
                                group: "foo",
                                type: "error",
                                title: this.$t("File corrupted!"),
                                text:
                                    this.$t("The source file you are trying to upload is corrupted.")
                            });
                            this.error = true
                            this.songSourceLoading = false;
                            rej();
                            return;
                        }
                        this.fileSize = this.editedSong.file_size = file.size;
                        this.editedSong.duration = Math.floor(
                            audioMetadata.duration
                        );
                        this.songSourceLoading = false;
                        res();
                    }.bind(this)
                );
            });
        },
        async saveSong() {
            var formData = new FormData();
            if( !this.editedSong.title ) {
                return this.$notify({
                        group: "foo",
                        type: "error",
                        title: this.$t("Error"),
                        text: this.$t(
                            "Please give a title"
                        )
                 });
            }
            if (this.editedSong.cover && this.editedSong.cover.data) {
                // if cover was picked, the value is stored as an object from the CropImage component
                formData.append(
                    "cover",
                    this.editedSong.cover.data,
                    this.editedSong.cover.title
                );
            } else if (this.editedSong.cover && !this.editedSong.cover.data) {
                // no cover was picked, the value is stored as a string
                formData.append("cover", this.editedSong.cover);
            } else {
                formData.append("cover", this.defaultCoverPath);
            }
            if (this.editedSong.title) {
                formData.append("title", this.editedSong.title);
            }
            if (this.editedSong.public) {
                formData.append("public", 1);
            } else {
                formData.append("public", 0);
            }
            if (this.artists.length) {
                this.editedSong.artists = JSON.stringify(this.artists);
                formData.append("artists", this.editedSong.artists);
            } else {
                this.editedSong.artists = JSON.stringify([]);
                formData.append("artists", this.editedSong.artists);
            }
            if (this.editedSong.genres.length) {
                formData.append(
                    "genres",
                    JSON.stringify(this.editedSong.genres)
                );
            }
            if (this.editedSong.artist_id) {
                formData.append("artist_id", this.editedSong.artist_id);
            } else {
                if (this.editedSong.artist !== undefined) {
                    formData.append(
                        "artist_id",
                        this.editedSong.artist == null
                            ? ""
                            : this.editedSong.artist.id
                    );
                }
            }
            // getting the audio source
            if (this.editedSong.source_format === "yt_video") {
                // source format is youtube video
                var videoID = this.getYoutubeVideoID(this.editedSong.source);
                if (this.editedSong.source && videoID) {
                    formData.append("source", videoID);
                } else {
                    return this.$notify({
                        group: "foo",
                        type: "error",
                        title: this.$t("Error"),
                        text: this.$t(
                            "Please add a valid YouTube video ID or URL."
                        )
                    });
                }
            } else if (this.editedSong.source_format === "file") {
                var duration;
                var promise = new Promise((res, rej) => {
                    if (this.songFile || this.editedSong.source) {
                        if (
                            !this.autoDuration &&
                            this.editedSong.duration > 1
                        ) {
                            duration = this.editedSong.duration;
                            res();
                        } else {
                            this.loadSongMetadata(
                                this.songFile
                                    ? this.songFile
                                    : this.editedSong.source
                            );
                            duration = this.editedSong.duration;
                            res();
                        }
                    } else {
                        return this.$notify({
                            group: "foo",
                            type: "error",
                            title: this.$t("Error"),
                            text: this.$t("Please add a valid source file.")
                        });
                    }
                });
            }
            if (promise) {
                try {
                    await promise;
                } catch (e) {
                    return this.$notify({
                        group: "foo",
                        type: "error",
                        title: this.$t("Error"),
                        text: e
                    });
                }
            }
            const request = axios.CancelToken.source();
            this.editedSong.requestSource = request;
            this.isLoading = true;
            formData.append("source_format", this.editedSong.source_format);
            this.$emit("sleep");
            if (this.songFile) {
                formData.append("source", this.songFile);
                formData.append("file_size", this.fileSize);
            }
            formData.append("duration", duration || "");
            if (this.editedSong.new) {
                formData.append("new", true);
                if (this.album_id) {
                    formData.append("album_id", this.album_id);
                }
                formData.append("uploaded_by", this.uploader);
                axios
                    .post("/api/songs", formData, {
                        headers: {
                            "Content-Type": "multipart/form-data"
                        },
                        cancelToken: this.editedSong.requestSource.token,
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
                        console.log('css')
                        this.editedSong.new = false;
                        this.editedSong.id = res.data.id;
                        this.editedSong.source = res.data.source;
                        this.editedSong.source_format = res.data.source_format;
                        this.editedSong.file_name = res.data.file_name;
                        this.editedSong.cover = res.data.cover;
                        this.editedSong.title = res.data.title;
                        this.editedSong.duration = res.data.duration;
                        this.$emit("progress", 100);
                        this.$emit("created");
                        this.$emit("close");
                        this.isLoading = false;
                    })
                    .catch(e => {
                        this.editedSong.progress = null;
                        this.$emit("wake");
                        this.isLoading = false;
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
                formData.append("id", this.editedSong.id);
                formData.append("_method", "PUT");
                axios
                    .post("/api/songs/" + this.editedSong.id, formData, {
                        headers: {
                            "Content-Type": "multipart/form-data"
                        },
                        cancelToken: this.editedSong.requestSource.token,
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
                        this.$emit("updated");
                        this.$emit("progress", 100);
                        this.editedSong.new = false;
                        this.editedSong.id = res.data.id;
                        this.editedSong.source_format = res.data.source_format;
                        this.editedSong.file_name = res.data.file_name;
                        this.editedSong.source = res.data.source;
                        this.editedSong.cover = res.data.cover;
                        this.editedSong.title = res.data.title;
                        this.editedSong.duration = res.data.duration;
                        this.isLoading = false;
                        this.$emit("close");
                    })
                    .catch(e => {
                        this.editedSong.progress = null;
                        this.isLoading = false;
                        this.$emit("wake");
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

<style>
.row-row {
    margin-top: 0 !important;
}
</style>
