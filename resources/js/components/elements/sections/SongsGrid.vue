<template>
    <div class="songs-grid">
        <div class="song" v-for="song in songs" :key="song.id">
            <song-expo :song="song" />
        </div>
    </div>
</template>
<script>
export default {
    props: ["songs"]
};
</script>
<style lang="scss" scoped>
.songs-grid {
    display: flex;
    flex-wrap: wrap;
    .song {
        min-width: 150px;
        max-width: 220px;
        padding: 0.4em;
        flex-basis: 20%;
        @media screen and (max-width: 1550px) {
            flex-basis: 25%;
            font-size: 95%;
        }
        @media screen and (max-width: 1400px) {
            font-size: 90%;
        }
        @media screen and (max-width: 1300px) {
            flex-basis: 33.33%;
            font-size: 100%;
        }
        @media screen and (max-width: 1200px) {
            font-size: 80%;
        }
        @media screen and (max-width: 1100px) {
            font-size: 100%;
        }
        @media screen and (max-width: 1000px) {
            font-size: 85%;
        }
    }
}
</style>
