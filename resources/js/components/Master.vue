<template>
    <v-app>
        <router-view></router-view>
        <vue-confirm-dialog></vue-confirm-dialog>
        <dialog-wrapper v-if="$store.getters.getDialog"></dialog-wrapper>
        <notifications group="foo" classes="muzzie-notification" />
    </v-app>
</template>
<script>
export default {
    created() {
        if( localStorage.getItem('dark-theme') == "true") {
            this.$vuetify.theme.dark = true;
        } else {
            if( localStorage.getItem('dark-theme') == "false") {
            this.$vuetify.theme.dark =false;
            } else {
                this.$vuetify.theme.dark = this.$store.getters.getSettings.defaultTheme === "Dark";
            }

        }
    }
};
</script>
