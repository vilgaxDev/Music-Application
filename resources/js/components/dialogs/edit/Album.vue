<template>
    <edit-dialog
        @callToAction="saveAlbum(true)"
        @cancel="closeWindow"
        :loading="isLoading"
        :fullscreen="!editedAlbum.new ? true : false"
        editing="Album"
    >
        <template v-slot:body>
            <v-container>
                <v-row>
                    <v-col cols="auto">
                        <upload-image
                            @imageReady="imageReady($event)"
                            :id="'album' + editedAlbum.id"
                            :source="editedAlbum.cover || defaultCoverPath"
                        />
                    </v-col>
                    <v-col>
                        <v-container>
                            <v-row>
                                <v-col cols="12">
                                    <v-text-field
                                        :label="$t('Title')"
                                        v-model="editedAlbum.title"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" v-if="creator === 'admin'">
                                    <div class="form__group field">
                                        <label
                                            for="artists"
                                            class="form__label"
                                            :class="{
                                                form__label__active:
                                                    artistsFocused ||
                                                    artists.length
                                            }"
                                            >{{ $t("Artist") }}</label
                                        >
                                        <v-select
                                            @search:focus="
                                                artistsFocused = true
                                            "
                                            @search:blur="
                                                artistsFocused = false
                                            "
                                            @search="fetchArtists"
                                            v-model="editedAlbum.artist"
                                            :options="artists"
                                            :label="$t('displayname')"
                                        >
                                            <template #selected-option="option">
                                                <div
                                                    class="selected-artist pt-2"
                                                >
                                                    <v-avatar size="35">
                                                        <v-img
                                                            :src="option.avatar"
                                                        />
                                                    </v-avatar>
                                                    <span class="artist-name">
                                                        {{ option.displayname }}
                                                    </span>
                                                </div>
                                            </template>
                                            <template v-slot:option="option">
                                                <v-avatar
                                                    size="35"
                                                    v-if="option.avatar"
                                                >
                                                    <v-img
                                                        :src="option.avatar"
                                                    />
                                                </v-avatar>
                                                {{ option.displayname }}
                                            </template>
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
                                                    style="opacity: 0.75;"
                                                    v-else
                                                    >{{
                                                        $t(
                                                            "Start typing to search to an artist."
                                                        )
                                                    }}</em
                                                >
                                            </template>
                                        </v-select>
                                    </div>
                                </v-col>
                                <v-col cols="12">
                                    <v-menu
                                        ref="menu"
                                        v-model="dateMenu"
                                        :close-on-content-click="false"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="290px"
                                    >
                                        <template
                                            v-slot:activator="{ on, attrs }"
                                        >
                                            <v-text-field
                                                v-model="
                                                    editedAlbum.release_date
                                                "
                                                :label="$t('Release Date')"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker
                                            ref="picker"
                                            v-model="editedAlbum.release_date"
                                            :max="
                                                new Date()
                                                    .toISOString()
                                                    .substr(0, 10)
                                            "
                                            min="1950-01-01"
                                            @change="saveReleaseDate"
                                        ></v-date-picker>
                                    </v-menu>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-col>
                </v-row>
            </v-container>
            <v-container class="songs" v-if="!editedAlbum.new">
                <div class="songs-wrapper">
                    <v-card outlined>
                        <v-card-title>
                            <v-icon color="primary" x-large
                                >mdi-music-note</v-icon
                            >
                            <div class="large-icon-text tertiary--text">
                                {{ $t("Songs") }}
                            </div>
                            <v-btn
                                class="mx-2 ml-3"
                                dark
                                small
                                color="primary"
                                @click="editSong('new')"
                            >
                                <v-icon dark>mdi-plus</v-icon> {{ $t("New") }}
                            </v-btn>
                            <v-btn
                                class="mx-2"
                                dark
                                small
                                color="secondary"
                                @click="addSong = true"
                            >
                                <v-icon>mdi-link</v-icon> {{ $t("Attach") }}
                            </v-btn>
                        </v-card-title>
                        <v-data-table
                            :no-data-text="$t('No data available')"
                            :loading-text="$t('Fetching data') + '...'"
                            :headers="songTableHeaders"
                            :items="editedAlbum.songs || []"
                            :items-per-page="15"
                            hide-default-footer
                            :loading="!editedAlbum.songs"
                        >
                            <template v-slot:body="props">
                                <draggable
                                    v-model="editedAlbum.songs"
                                    v-if="editedAlbum.songs.length"
                                    tag="tbody"
                                >
                                    <tr
                                        v-for="(song,
                                        index) in editedAlbum.songs"
                                        :key="index"
                                    >
                                        <td>
                                            <v-icon
                                                small
                                                class="page__grab-icon"
                                            >
                                                mdi-arrow-all
                                            </v-icon>
                                        </td>
                                        <td>{{ index + 1 }}</td>
                                        <td>
                                            <div class="img-container py-2">
                                                <v-img
                                                    :src="
                                                        song.cover.image ||
                                                            song.cover
                                                    "
                                                    :alt="song.title"
                                                    class="user-avatar song-cover"
                                                    width="50"
                                                    height="50"
                                                >
                                                    <div
                                                        class="upload-percentage"
                                                        v-if="
                                                            song.progress !=
                                                                null &&
                                                                song.progress <
                                                                    100
                                                        "
                                                    >
                                                        <div
                                                            class="content-text"
                                                        >
                                                            <template
                                                                v-if="
                                                                    song.progress <
                                                                        99
                                                                "
                                                            >
                                                                {{
                                                                    song.progress
                                                                }}%
                                                            </template>
                                                            <template v-else>
                                                                <v-progress-circular
                                                                    :size="15"
                                                                    :width="3"
                                                                    color="grey"
                                                                    indeterminate
                                                                ></v-progress-circular>
                                                            </template>
                                                        </div>
                                                    </div>
                                                </v-img>
                                            </div>
                                        </td>
                                        <td>
                                            <router-link
                                                class="router-link"
                                                :to="{
                                                    name: 'song',
                                                    params: { id: song.id }
                                                }"
                                                target="_blank"
                                            >
                                                {{ song.title }}
                                            </router-link>
                                        </td>
                                        <td>
                                            {{ getArtists(song.artists) }}
                                        </td>
                                        <td class="text-center">{{ song.nb_plays }}</td>
                                        <td class="text-center">{{ song.nb_likes }}</td>
                                        <td>
                                            {{
                                                moment(song.created_at).format(
                                                    "ll"
                                                )
                                            }}
                                        </td>
                                        <td>
                                            <v-btn
                                                class="mx-2"
                                                @click="editSong(song.id)"
                                                x-small
                                                fab
                                                dark
                                                color="info"
                                            >
                                                <v-icon dark>mdi-pencil</v-icon>
                                            </v-btn>
                                            <v-btn
                                                class="mx-2"
                                                @click="detachSong(song.id)"
                                                x-small
                                                fab
                                                dark
                                                :title="
                                                    $t(
                                                        'Detach song from this album'
                                                    )
                                                "
                                                color="secondary"
                                            >
                                                <v-icon dark
                                                    >mdi-link-off</v-icon
                                                >
                                            </v-btn>
                                            <v-btn
                                                class="mx-2"
                                                @click="deleteSong(song.id)"
                                                x-small
                                                fab
                                                :title="$t('Delete Song')"
                                                dark
                                                color="error"
                                            >
                                                <v-icon>mdi-delete</v-icon>
                                            </v-btn>
                                        </td>
                                    </tr>
                                </draggable>

                                <empty-page
                                    class="empty-songs"
                                    :headline="$t('No Songs!')"
                                    :sub="$t('This album is empty.')"
                                    v-else
                                />
                            </template>
                        </v-data-table>
                    </v-card>
                </div>
            </v-container>
        </template>
        <template v-slot:dialogs>
            <v-dialog
                v-model="editDialog"
                persistent
                scrollable=""
                max-width="950"
                @click:outside="hideAllsongs"
            >
                <template v-for="song in editedAlbum.songs">
                    <edit-song-dialog
                        :key="song.id"
                        v-if="song.isActive"
                        v-show="isShowing(song.id)"
                        @updated="songEdited(song.id)"
                        @progress="updateProgress($event, song.id)"
                        @created="songCreated"
                        @close="closeSong(song.id)"
                        @sleep="sleepSong(song.id)"
                        @wake="wakeSong(song.id)"
                        :song="song"
                        :uploader="creator"
                        :album_id="editedAlbum.id"
                    />
                </template>
            </v-dialog>
            <v-dialog v-model="deleteSongConfirmationDialog" max-width="400">
                <v-card>
                    <div class="p-2">
                        {{
                            $t("Are you sure you wanna delete this") +
                                $t("Song") +
                                "?"
                        }}
                    </div>
                    <v-card-actions>
                        <v-btn color="error" text @click="goodByeSong">{{
                            $t("Delete")
                        }}</v-btn>
                        <v-btn
                            @click="deleteSongConfirmationDialog = false"
                            text
                            >{{ $t("Cancel") }}</v-btn
                        >
                    </v-card-actions>
                </v-card>
            </v-dialog>
            <v-dialog v-model="addSong" max-width="500px">
                <attach-song-dialog
                    v-if="addSong"
                    @songSelected="attachSong($event)"
                    :creator="creator"
                ></attach-song-dialog>
            </v-dialog>
        </template>
    </edit-dialog>
</template>
<script>
import { VSelect } from "vuetify/lib";
import draggable from "vuedraggable";
import editSongDialog from "./Song";
import attachSongDialog from "../../dialogs/AttachSong";
export default {
    props: ["album", "creator"],
    components: {
        veutifySelect: VSelect,
        draggable,
        editSongDialog,
        attachSongDialog
    },
    computed: {
        isShowing() {
            return song_id =>
                this.editedAlbum.songs[
                    this.editedAlbum.songs.findIndex(
                        song => song.id === song_id
                    )
                ].isShowing;
        }
    },
    data() {
        return {
            editedAlbum: JSON.parse(JSON.stringify(this.album)),
            firstCopy: this.album,
            artistsFocused: false,
            editDialog: false,
            songToBeDeleted: null,
            defaultCoverPath: "/storage/defaults/images/album_cover.png",
            deleteSongConfirmationDialog: false,
            editingSong: null,
            artists: [],
            addSong: false,
            dateMenu: false,
            isLoading: false,
            errors: {},
            progress: null,
            songTableHeaders: [
                {
                    text: ""
                },
                {
                    text: this.$t("#"),
                    sortable: true
                },
                {
                    text: this.$t("Cover"),
                    align: "start",
                    sortable: false,
                    value: "cover"
                },
                { text: this.$t("Title"), value: "title" },
                { text: this.$t("Artists"), value: "artists", align: "center" },
                { text: this.$t("Plays"), value: "plays", align: "center" },
                { text: this.$t("Likes"), value: "likes", align: "center" },
                { text: this.$t("Created At"), value: "created_at" },
                {
                    text: this.$t("Operations"),
                    value: "operations",
                    align: "center"
                }
            ]
        };
    },
    watch: {
        dateMenu(val) {
            val && setTimeout(() => (this.$refs.picker.activePicker = "YEAR"));
        }
    },
    beforeDestroy() {
        this.$emit("beforeDestroy");
    },
    methods: {
        closeWindow() {
            let changed = false;
            if (
                JSON.stringify(this.editedAlbum) !=
                JSON.stringify(this.firstCopy)
            ) {
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
                    /**
                     * Callback Function
                     * @param {Boolean} confirm
                     */
                    callback: confirm => {
                        if (confirm) {
                            this.editedAlbum.title = this.firstCopy.title;
                            this.editedAlbum.artist = this.firstCopy.artist;
                            this.editedAlbum.cover = this.firstCopy.cover;
                            this.editedAlbum.release_date = this.firstCopy.release_date;
                            this.$emit("close");
                        }
                    }
                });
            } else {
                this.$emit("close");
            }
        },
        updateProgress(progress, song_id) {
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === song_id
            );
            this.$set(this.editedAlbum.songs[index], "progress", progress);
        },
        saveReleaseDate(date) {
            this.$refs.menu.save(date);
        },
        cancelUpload(song_id) {
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === song_id
            );
            this.editedAlbum.songs[index].requestSource.cancel();
            this.editSong(song_id);
        },
        sleepSong(song_id) {
            this.editDialog = false;
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === song_id
            );
            this.$set(this.editedAlbum.songs[index], "isShowing", false);
        },
        goodByeSong() {
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === this.songToBeDeleted
            );
            if (this.editedAlbum.songs[index].requestSource) {
                this.editedAlbum.songs[index].requestSource.cancel();
            }
            this.deleteSongConfirmationDialog = false;
            this.editedAlbum.songs.splice(index, 1);
            axios
                .delete("/api/songs/" + this.songToBeDeleted)
                .then(() => {
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Deleted"),
                        text: this.$t("Song") + " " + this.$t("Deleted") + "."
                    });
                })
                .catch(e => {});
            this.songToBeDeleted = null;
        },
        wakeSong(song_id) {
            this.editDialog = true;
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === song_id
            );
            this.$set(this.editedAlbum.songs[index], "isShowing", true);
        },
        hideAllsongs() {
            for (let i = 0; i < this.editedAlbum.songs.length; i++) {
                this.$set(this.editedAlbum.songs[i], "isShowing", false);
            }
            this.editDialog = false;
        },
        imageReady(e) {
            this.editedAlbum.cover = e;
        },
        deleteSong(song_id) {
            this.songToBeDeleted = song_id;
            this.deleteSongConfirmationDialog = true;
        },
        editSong(song_id) {
            if (song_id === "new") {
                this.editedAlbum.songs.unshift({
                    id: Math.floor(Math.random() * (100000 - 5000) + 100000),
                    new: true,
                    genres: [],
                    isActive: true,
                    public: true,
                    isShowing: true,
                    artist_id: this.editedAlbum.artist.id,
                    cover: this.editedAlbum.cover.data
                        ? this.editedAlbum.cover.data
                        : this.editedAlbum.cover,
                    nb_likes: 0,
                    nb_plays: 0,
                    source_format: "file",
                    artists: `["${this.editedAlbum.artist.displayname}"]`
                });
                this.editDialog = true;
            } else {
                this.editedAlbum.songs[
                    this.editedAlbum.songs.findIndex(
                        song => song.id === song_id
                    )
                ].isActive = true;
                this.editedAlbum.songs[
                    this.editedAlbum.songs.findIndex(
                        song => song.id === song_id
                    )
                ].isShowing = true;
                this.editDialog = true;
            }
        },
        closeSong(song_id) {
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === song_id
            );
            if (this.editedAlbum.songs[index].isShowing) {
                this.editDialog = false;
            }
            this.$set(this.editedAlbum.songs[index], "isShowing", false);
            this.$set(this.editedAlbum.songs[index], "isActive", false);
            this.$forceUpdate();
        },
        songEdited(song_id) {
            let index = this.editedAlbum.songs.findIndex(
                song => song.id === song_id
            );
            this.$set(this.editedAlbum.songs[index], "progress", 0);
            this.$set(this.editedAlbum.songs[index], "isActive", false);
            this.$notify({
                group: "foo",
                type: "success",
                title: this.$t("Saved"),
                text: this.$t("Song") + " " + this.$t("Updated") + "."
            });
        },
        songCreated() {
            this.saveAlbum();
            this.$notify({
                group: "foo",
                type: "success",
                title: this.$t("Created"),
                text: this.$t("Song") + " " + this.$t("Created") + "."
            });
        },
        fetchArtists(search, loading) {
            if (search) {
                loading(true),
                    axios
                        .get("/api/match-artists/" + search)
                        .then(
                            res =>
                                (this.artists = res.data.map(artist => ({
                                    id: artist.id,
                                    displayname: artist.displayname,
                                    avatar: artist.avatar
                                })))
                        )
                        .finally(() => loading(false));
            }
        },
        attachSong(song) {
            axios
                .post("/api/attach-to-album", {
                    album_id: this.album.id,
                    song_id: song.id
                })
                .then(() => {
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Added"),
                        text: this.$t("Song attached to album.")
                    });
                    this.editedAlbum.songs.push(song);
                    this.addSong = false;
                });
        },
        detachSong(song_id) {
            axios
                .post("/api/detach-from-album", {
                    album_id: this.album.id,
                    song_id: song_id
                })
                .then(() => {
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Added"),
                        text: this.$t("Song detached from album!")
                    });
                    let index = this.editedAlbum.songs.findIndex(
                        song => song.id === song_id
                    );
                    this.editedAlbum.songs.splice(index, 1);
                });
        },
        saveAlbum(emit) {
            var formData = new FormData();
            this.isLoading = true;
            if (this.editedAlbum.cover && this.editedAlbum.cover.data) {
                // if cover was picked, the value is stored as an object from the CropImage component
                formData.append(
                    "cover",
                    this.editedAlbum.cover.data,
                    this.editedAlbum.cover.title
                );
            } else if (this.editedAlbum.cover && !this.editedAlbum.cover.data) {
                // no cover was picked, the value is stored as a string
                formData.append("cover", this.editedAlbum.cover);
            } else {
                formData.append("cover", this.defaultCoverPath);
            }
            if (this.editedAlbum.title) {
                formData.append("title", this.editedAlbum.title);
            }
            if (this.editedAlbum.release_date) {
                formData.append("release_date", this.editedAlbum.release_date);
            }
            if (this.editedAlbum.songs) {
                formData.append(
                    "songs",
                    JSON.stringify(this.editedAlbum.songs.map(s => s.id))
                );
            }
            if (this.creator === "admin") {
                if (this.editedAlbum.artist) {
                    formData.append("artist_id", this.editedAlbum.artist.id);
                } else {
                    formData.append("artist_id", "");
                }
            } else if (this.creator === "artist") {
                formData.append("artist_id", this.$store.getters.getArtist.id);
            } else {
                formData.append("artist_id", "");
            }
            formData.append("created_by", this.creator);
            if (this.editedAlbum.new) {
                axios
                    .post("/api/albums", formData, {
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
                        this.$emit("created");
                        this.isLoading = false;
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
                formData.append("album_id", this.editedAlbum.id);
                formData.append("_method", "PUT");
                axios
                    .post("/api/albums/" + this.editedAlbum.id, formData, {
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
                        if (emit) {
                            this.$emit("updated");
                        }
                        this.isLoading = false;
                    })
                    .catch(e => {
                        this.progress = 0;
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
            }
        }
    }
};
</script>
<style scoped>
.selected-artist > .artist-name {
    color: var(--light-theme-text-color);
}
.v-application.theme--dark .selected-artist > .artist-name {
    color: var(--dark-theme-text-color);
}
</style>
