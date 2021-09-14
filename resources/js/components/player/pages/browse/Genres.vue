<template>
    <div class="browse-genres-container" v-if="genres">
        <div class="genres">
            <div class="genre" v-for="genre in genres" :key="genre.id">
                <router-link
                    :to="{
                        name: 'genre-page',
                        params: { genre_name: slug(genre.name) }
                    }"
                >
                    <div class="content-wrapper">
                        <div class="content">
                            <img class="icon" :src="genre.icon" alt="" />
                            <div class="content-text">
                                {{ $t(genre.name) }}
                            </div>
                        </div>
                        <div class="genre-dark-layer dark-layer"></div>
                        <div class="genre-img">
                            <v-img
                                :src="genre.cover"
                                class="img"
                                aspect-ratio="1"
                            >
                                <template v-slot:placeholder>
                                    <div class="fill-height">
                                        <content-placeholders :rounded="true">
                                            <content-placeholders-img />
                                        </content-placeholders>
                                    </div>
                                </template>
                            </v-img>
                        </div>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
    <page-loading v-else />
</template>
<script>
export default {
    async created() {
        const res = await axios.get(`/api/genres`);
        this.genres = res.data;
    },
    data() {
        return {
            genres: null
        };
    }
};
</script>
