<template>
    <div class="home-container content-page">
        <div class="icon-header">
            <div class="cover">
                <v-icon dark>mdi-navigation</v-icon>
            </div>
            <div class="title">
                <div class="headline">
                    Explore
                </div>
                <div class="sub">
                    Explore & listen to the diffrent podcasts
                </div>
            </div>
        </div>
        <div id="main-content" v-if="sections">
            <template v-if="sections.length">
                <swiper-section
                    v-for="section in sections"
                    :key="section.rank"
                    :section="section"
                ></swiper-section>
            </template>
            <template v-else>
                <empty-page
                    img="peep-34.png"
                    headline="No content!"
                    sub="There is no content to be displayed"
                ></empty-page>
            </template>
        </div>
        <page-loading v-else />
    </div>
</template>
<script>
export default {
    metaInfo() {
        return {
            title: this.generateMetaInfos(
                {},
                this.$store.getters.getSettings.homePageTitle
            ),
            meta: [
                {
                    name: "description",
                    content: this.generateMetaInfos(
                        {},
                        this.$store.getters.getSettings.homePageDescription
                    )
                }
            ]
        };
    },
    data() {
        return {
            sections: null
        };
    },
    created() {
        axios.get("/api/landing-sections").then(res => {
            var sections = res.data;
            if (!this.$store.getters.getSettings.enablePodcasts) {
                sections = sections.filter(
                    section => section.content_type !== "podcasts"
                );
            }

            this.sections = sections;
        });
    }
};
</script>
<style lang="scss" scoped>
@import "../../../../../sass/variables";
.section-bestof {
    display: flex;
    & > * {
        width: 20%;
        margin: 0 1rem;
    }
}
.icon-header > .cover {
    background: linear-gradient(45deg, $color-secondary, $color-primary);
}
</style>
