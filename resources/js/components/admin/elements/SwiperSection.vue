<template>
    <v-card class="section-skeleton" rounded>
        <v-card outlined class="section-option section-option__drag handle">
            <v-icon>mdi-cursor-move</v-icon>
        </v-card>
        <v-card
            @click="$emit('edit')"
            outlined
            class="section-option section-option__edit"
        >
            <v-icon color="#039BE5">mdi-pencil</v-icon>
        </v-card>
        <v-card
            @click="$emit('delete')"
            outlined
            class="section-option section-option__delete"
        >
            <v-icon color="error">mdi-delete</v-icon>
        </v-card>
        <div class="section-header">
            <div class="section-header__title">
                {{ $t(section.title) }}
            </div>
            <div class="section-header__chevrons" v-if="section.swipable">
                <v-icon :id="'swiper-button-zuruck-' + section.id"
                    >mdi-chevron-left</v-icon
                >
                <v-icon :id="'swiper-button-naschte-' + section.id"
                    >mdi-chevron-right</v-icon
                >
            </div>
        </div>
        <swiper ref="mySwiper" :options="swiperOptions" v-if="!section.content">
            <swiper-slide v-for="n in 10" :key="n">
                <div class="song-expo-skeleton">
                    <content-placeholders :rounded="true">
                        <content-placeholders-img />
                        <content-placeholders-text :lines="2" />
                    </content-placeholders>
                </div>
            </swiper-slide>
        </swiper>
        <swiper ref="mySwiper" :options="swiperOptions" v-else>
            <template v-if="section.content.length">
                <swiper-slide
                    v-for="(item, n) in section.content"
                    :key="n"
                    :style="{ sectionWidth }"
                >
                    <template v-if="section.content_type === 'songs'">
                        <song-expo :song="item" admin="true"> </song-expo>
                    </template>
                    <template v-else-if="section.content_type === 'albums'">
                        <album-expo :album="item" />
                    </template>
                    <template v-else-if="section.content_type === 'podcasts'">
                        <podcast-box :podcast="item" />
                    </template>
                    <template v-else-if="section.content_type === 'playlists'">
                        <playlist-expo :playlist="item" />
                    </template>
                    <template
                        v-else-if="section.content_type === 'radio-stations'"
                    >
                        <radio-station :radioStation="item" />
                    </template>
                </swiper-slide>
            </template>
            <template v-else>
                <div class="empty-section-text muted text-center">
                    <template v-if="section.endpoint">
                        {{ $t("No Data!") }}
                    </template>
                    <template v-else>
                        {{ $t("Empty Section") }}
                    </template>
                </div>
            </template>
        </swiper>
    </v-card>
</template>
<script>
import { swiper, swiperSlide } from "vue-awesome-swiper";
import "swiper/css/swiper.css";
export default {
    props: ["section"],
    components: {
        swiper,
        swiperSlide
    },
    mounted() {
        setTimeout(() => {
            // trigering the section with to fix a bug related with API ( data renderes after the comp mount )
            this.sectionWidth = 1000;
        }, 200);
    },
    data() {
        return {
            loading: true,
            sectionWidth: 0,
            swiperOptions: {
                slidesPerView: 5,
                spaceBetween: 10,
                navigation: {
                    nextEl: "#swiper-button-naschte-" + this.section.id,
                    prevEl: "#swiper-button-zuruck-" + this.section.id
                },
                pagination: {
                    el: ".swiper-pagination",
                    clickable: true
                },
                breakpoints: {
                    1920: {
                        slidesPerView: 7,
                        spaceBetweenSlides: 10
                    },
                    1680: {
                        slidesPerView: 5,
                        spaceBetweenSlides: 10
                    },
                    1100: {
                        slidesPerView: 4,
                        spaceBetweenSlides: 10
                    },
                    900: {
                        slidesPerView: 3,
                        spaceBetweenSlides: 10
                    },
                    500: {
                        slidesPerView: 2,
                        spaceBetweenSlides: 10
                    }
                }
            }
        };
    }
};
</script>
<style lang="scss" scoped>
.section-header {
    width: 100% !important;
    &__title {
        margin-bottom: 0 !important;
    }
}
.empty-section-text {
    font-size: 1.2em;
    padding: 0.2em;
}
</style>
