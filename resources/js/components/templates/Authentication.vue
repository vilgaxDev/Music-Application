<template>
    <div class="auth-page-wrapper">
        <div class="white-layer">
            <v-card class="auth-box" elevation="lg" light>
                <div class="align-justify-center">
                    <a class="logo-img-container" href="/">
                        <img
                            :src="$store.getters.getSettings.appLogoLight"
                            :alt="$t('Logo Image')"
                        />
                    </a>
                </div>
                <slot></slot>
            </v-card>
        </div>
    </div>
</template>

<script>
export default {
    mounted() {
        if (this.$store.getters.getSettings.google_oauth_client_id) {
            let googleSDK = document.createElement("script");
            let googleMeta = document.createElement("meta");
            googleMeta.setAttribute("name", "google-signin-client_id");
            googleMeta.setAttribute(
                "content",
                this.$store.getters.getSettings.google_oauth_client_id
            );
            googleSDK.setAttribute(
                "src",
                "https://apis.google.com/js/platform.js"
            );
            document.head.appendChild(googleSDK);
            document.head.appendChild(googleMeta);
        }
    }
};
</script>
<style lang="scss">
@import "../../../sass/player/pages/auth";
</style>
