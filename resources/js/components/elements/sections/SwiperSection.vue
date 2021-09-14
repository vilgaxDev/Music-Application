<template>
    <section class="section-container" v-if="_content && _content.length">
        <div class="section-header">
            <div class="section-header__title">{{ _title || "section" }}</div>
            <div class="chevrons d-flex">
                <div class="chevron-left mr-3">
                    <div class="chevron-container">
                        <v-icon alt="back" :id="'swiper-button-zuruck-' + section.id"
                            >mdi-chevron-left</v-icon
                        >
                    </div>
                </div>
                <div class="chevron-right">
                    <div class="chevron-container">
                        <v-icon
                            alt="next"
                            :id="'swiper-button-naschte-' + section.id"
                            >mdi-chevron-right</v-icon
                        >
                    </div>
                </div>
            </div>
        </div>
        <div class="section-header-small-screen">
            <div class="section-header__title">{{ _title || "section" }}</div>
        </div>
        <swiper ref="mySwiper" :options="swiperOptions" v-if="false">
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
            <swiper-slide
                v-for="(asset, i) in _content"
                :key="i"
            >
                <template v-if="_content_type === 'songs'">
                    <song-expo :song="asset" />
                </template>
                <template v-else-if="_content_type === 'albums'">
                    <album-expo :album="asset" />
                </template>
                <template v-else-if="_content_type === 'podcasts'">
                    <podcast-box :podcast="asset" />
                </template>
                <template v-else-if="_content_type === 'playlists'">
                    <playlist-expo :playlist="asset" />
                </template>
                <template v-else-if="_content_type === 'radio-stations'">
                    <radio-station :radioStation="asset" />
                </template>
            </swiper-slide>
        </swiper>
    </section>
</template>
<script>
import { swiper, swiperSlide } from "vue-awesome-swiper";
import "swiper/css/swiper.css";
export default {
    props: ["section", "content_type", "content", "rank", "title"],
    computed: {
        swiper() {
            return this.$refs.mySwiper.$swiper
        },
        _content_type() {
            return this.content_type || this.section.content_type;
        },
        _title() {
            return this.title || this.section.title;
        },
        _content() {
            return this.content || this.section.content;
        },
        _rank() {
            return this.rank || this.section.rank;
        }
    },
    data() {
        return {
            loading: true,
            swiperOptions: {
                slidesPerView: 7,
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
    },
    components: {
        swiper,
        swiperSlide
    },
    created() {
        setTimeout(() => {
            this.loading = false;
        }, 500);
    },
    // methods:{
    //     slideRight() {
    //         this.swiper.next();
    //     }
    // }
};
</script>
