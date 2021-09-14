<template>
    <div class="content-page" v-if="page && page !== '404'">
        <div class="icon-header">
            <div class="cover">
                <v-icon dark>mdi-{{ page.icon }}</v-icon>
            </div>
            <div class="title">
                <div class="headline">
                    {{ $t(page.title) }}
                </div>
                <div class="sub">
                    {{ $t(page.description) }}
                </div>
            </div>
        </div>
        <template v-if="$store.getters.getSettings.enableAds">
        <div
            class="ad-slot"
            v-if="
                parseAd($store.getters.getSettings.rect_ad).position === 'tcp'
            "
        >
            <ad
                v-if="!hasPermission('No ads')"
                :ad_code="parseAd($store.getters.getSettings.rect_ad).code"
            ></ad>
        </div>
        </template>
        <div id="main-content" v-if="page.sections">
            <template
                v-if="
                    page.sections.length &&
                        page.sections.reduce(
                            (a, s) => a + (s.content ? s.content.length : 0),
                            0
                        )
                "
            >
                <swiper-section
                    v-for="section in page.sections"
                    :key="section.rank"
                    :section="section"
                ></swiper-section>
            </template>
            <template v-else>
                <empty-page
                    img="peep-34.png"
                    :headline="$t('No Content!')"
                    :sub="$t('There is no content to be displayed.')"
                ></empty-page>
            </template>
            <template v-if="$store.getters.getSettings.enableAds">
            <div
                class="ad-slot"
                v-if="
                    parseAd($store.getters.getSettings.rect_ad).position ===
                        'bcp'
                "
            >
                <ad
                    v-if="!hasPermission('No ads')"
                    :ad_code="parseAd($store.getters.getSettings.rect_ad).code"
                ></ad>
            </div>
            </template>
        </div>
        <page-loading v-else />
    </div>
    <div id="page-404-container" v-else-if="page === '404'">
        <div class="content">
            <empty-page :headline="$t('Page Not Found')" img="peep-68.png"></empty-page>
        </div>
    </div>
    <page-loading v-else />
</template>

<script>
export default {
    metaInfo() {
        return {
            title: this.page ? this.page.title : document.title,
            meta: [
                {
                    name: "description",
                    content: this.page ? this.page.description : ""
                }
            ]
        };
    },
    data() {
        return {
            page: null
        };
    },
    created() {
        if (this.$route.path === "/charts") {
            this.$router.push({ path: "/not-found" });
        } else {
            axios
                .get("/api/page?path=" + this.$route.path)
                .then(res => (this.page = res.data))
                .catch(() => (this.page = "404"));
        }
    }
};
</script>
<style lang="scss">
@import "../../../../sass/player/pages/404-page";
</style>
