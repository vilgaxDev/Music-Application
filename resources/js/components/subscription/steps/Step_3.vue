<template>
    <div flat class="successful-payment" v-if="paymentStatus === 'success'">
        <div class="successful-payment__icon">
            <v-icon x-large color="success">mdi-checkbox-marked-circle</v-icon>
        </div>
        <div class="successful-payment__text success--text">
            {{$t("Congratulation! Subscription was successful.")}}
        </div>
            <div class="title my-3 black--text">
            {{$t('You can check your subscription on your account settings')}}
            </div>
        <div class="successful-payment__action my-5  text-center">
           <v-btn color="primary" @click="refresh">
               {{ $t('Home') }}
           </v-btn>
        </div>
    </div>
</template>

<script>
export default {
    props: ['paymentStatus'],
    created() {
        this.$store.dispatch('fetchUser')
    },
    methods: {
        refresh() {
           window.location.href = this.$store.getters.getSettings.playerLanding
        }
    }
};
</script>

<style lang="scss" scoped>
    .successful-payment {
        display: flex;
        flex-direction: column;
        align-items: center;
        &__icon {
            i {
                font-size: 15em !important;
            }
        }
        &__text {
            font-size: 1.3em;
            font-weight: bold;
            padding: 1em 0;
        }
    }
</style>
