<template>
    <div id="main-content">
        <page-loading v-if="!sections" />
        <template v-else>
            <template
                v-if="
                    sections.length &&
                        sections.reduce(
                            (a, s) => a + (s.content ? s.content.length : 0),
                            0
                        ) !== 0
                "
            >
                <swiper-section
                    v-for="section in sections"
                    :key="section.rank"
                    :section="section"
                ></swiper-section>
            </template>
            <empty-page
                v-else
                :headline="$t('No Content!')"
                :sub="$t('There is content yet.')"
                img="peep-68.png"
            ></empty-page>
        </template>
    </div>
</template>
<script>
import EmptyPage from "../../../templates/EmptyPage.vue";
export default {
    components: { EmptyPage },
    data() {
        return {
            sections: null
        };
    },
    created() {
        axios.get("/api/charts").then(res => {
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
<style lang="scss">
.landing {
    display: flex;
    & > * {
        width: 20%;
        margin: 0 1rem;
    }
}
</style>
