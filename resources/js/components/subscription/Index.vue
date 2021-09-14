<template>
    <div class="upgrade-plan-page-container">
        <MuzzieNavbar />
        <div class="upgrade-plan-page-container__dialog">
            <v-container>
                <v-stepper v-model="stepper_step" light>
                    <v-stepper-header>
                        <v-stepper-step :complete="stepper_step > 1" step="1">
                            {{$t('Choose your plan')}}
                        </v-stepper-step>
                        <v-divider></v-divider>
                        <v-stepper-step :complete="stepper_step > 2" step="2">
                            {{$t('Payment')}}
                        </v-stepper-step>
                        <v-divider></v-divider>
                        <v-stepper-step :complete="stepper_step == 3" step="3">
                            {{$t('Complete')}}
                        </v-stepper-step>
                    </v-stepper-header>
                    <v-stepper-items>
                        <v-stepper-content step="1">
                            <StepOne :isPageLoading="isPageLoading" @planChosen="proceedSubscription($event)"/>
                        </v-stepper-content>
                        <v-stepper-content step="2">
                           <StepTwo v-if="chosenPlan" :error="error" :isSubscriptionLoading="isSubscriptionLoading" :chosenPlan="chosenPlan" @isSubscriptionLoading="isSubscriptionLoading = $event" @error="error = $event" @dec-stepper="stepper_step--" @paymentStatusChanged="paymentStatus = $event" @createSubscription="createSubscription($event)"/>
                        </v-stepper-content>
                        <v-stepper-content step="3">
                            <StepThree :paymentStatus="paymentStatus" />
                        </v-stepper-content>
                    </v-stepper-items>
                </v-stepper>
            </v-container>
        </div>
    </div>
</template>

<script>

import MuzzieNavbar from "../elements/Navbar";
import StepOne from './steps/Step_1';
import StepTwo from './steps/Step_2';
import StepThree from './steps/Step_3';
export default {
    components: {
        MuzzieNavbar,
        StepOne,
        StepTwo,
        StepThree
    },
    data() {
        return {
            isPageLoading: false,
            // reloadProgress: null,
            stepper_step: 1,
            chosenPlan: null,
            paymentStatus: null,
            isSubscriptionLoading: false,
            error: false
        };
    },
    methods: {
        proceedSubscription(plan) {
            this.chosenPlan = plan;
            if (plan.free) {
                this.isPageLoading = true
                this.createSubscription({ gateway: 'local' })
                .finally(() => this.isPageLoading = false)
            } else {
                this.stepper_step++;
            }
        },
        async createSubscription({gateway, paymentMethod, paypal_subscription_id }) {
            const requestData = {};
            requestData.plan = this.chosenPlan;
            requestData.gateway = gateway;
            if( paymentMethod ) {
                requestData.paymentMethod = paymentMethod.id
            }
            if( paypal_subscription_id ) {
                requestData.paypal_subscription_id = paypal_subscription_id
            }
            try {
                await axios.post("/api/subscribe", requestData)
                this.isSubscriptionLoading = false
                this.paymentStatus = "success";
                this.stepper_step = 3;
                this.isSubscriptionLoading = false;
                // this.reloadProgress = 1;
                // const intervalFn = setInterval(() => {
                //     this.reloadProgress += 5;
                //     if (this.reloadProgress >= 100) {
                //         location.replace(
                //             this.$store.getters.getSettings.playerLanding
                //         );
                //         clearInterval(intervalFn);
                //     }
                // }, 50);
            } catch(e) {
                this.isSubscriptionLoading = false;
                // this.error = e // never show errors in DEMO
            }

        }
    }
};
</script>

<style lang="scss" scoped>
.upgrade-plan-page-container {
    background-image: url("/images/background.png");
    background-size: cover;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    width: 100%;
    height: 100%;
    overflow: hidden;
    &__dialog {
        width: 95%;
        max-width: 1200px;
        .v-stepper__items {
            height: 65vh;
            background-color: rgba(117, 107, 177, 0.15);
            padding: 0.5em;
        }
    }
}
</style>
