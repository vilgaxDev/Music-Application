<template>
    <v-card class="page" v-if="!isLoading">
        <v-card-title>
            <div class="page__title">
                <v-icon color="primary" x-large>mdi-email-multiple</v-icon>
                {{ $t("Email") }}
            </div>
            <div class="page__options">
                <v-btn
                    small
                    class="success"
                    @click="save"
                    :disabled="isLoadingForButton"
                    :loading="isLoadingForButton"
                    >{{ $t("Save") }}
                    <template v-slot:loader>
                        <span class="custom-loader">
                            <v-icon light>mdi-cached</v-icon>
                        </span>
                    </template>
                </v-btn>
            </div>
        </v-card-title>
        <v-container fluid>
            <v-row class="pl-4">
                <v-col cols="12" sm="6">
                    <v-switch
                        v-model="settings.enableMail"
                        :label="$t('Enable Emails')"
                        :messages="$t('Enable to receive Emails from users. Enable to verify users Email addresses.')"
                    ></v-switch>
                </v-col>
                <v-col cols="12" sm="6" v-if="settings.enableMail">
                    <v-text-field
                        :label="$t('Contact Email Address')"
                        outlined
                        v-model="settings.contactEmailAddress"
                        @change="settings.mailFromAddress = $event"
                    ></v-text-field>
                </v-col>
            </v-row>
            <template v-if="settings.enableMail">
                <v-row>
                    <!-- <template v-if="settings.mailMailer === 'smtp'"> -->
                    <v-col md="6" cols="12">
                        <v-text-field
                            :label="$t('SMTP Host')"
                            outlined
                            v-model="settings.mailHost"
                        ></v-text-field
                    ></v-col>
                    <v-col md="6" cols="12">
                        <v-text-field
                            :label="$t('SMTP Username')"
                            outlined
                            v-model="settings.mailUsername"
                        ></v-text-field
                    ></v-col>
                    <v-col md="6" cols="12">
                        <v-text-field
                            :label="$t('SMTP Password')"
                            type="password"
                            outlined
                            v-model="settings.mailPassword"
                        ></v-text-field
                    ></v-col>
                    <v-col md="6" cols="12">
                        <v-text-field
                            :label="$t('SMTP Port')"
                            outlined
                            v-model="settings.mailPort"
                        ></v-text-field
                    ></v-col>
                    <v-col md="6" cols="12">
                        <v-text-field
                            :label="$t('Mail From Address')"
                            class="pb-4"
                            :messages="
                                $t(
                                    'The address that the users will see when they receive an Email from you.'
                                )
                            "
                            outlined
                            v-model="settings.mailFromAddress"
                        ></v-text-field
                    ></v-col>
                    <v-col md="6" cols="12">
                        <v-text-field
                            :label="$t('Mail From Name')"
                            class="pb-4"
                            :messages="
                                $t(
                                    'The name that the users will see when they receive an Email from you.'
                                )
                            "
                            outlined
                            v-model="settings.mailFromName"
                        ></v-text-field
                    ></v-col>
                    <!-- </template> -->
                </v-row>
            </template>
        </v-container>
    </v-card>
    <page-loading v-else />
</template>
<script>
export default {
    props: ["settings", "isLoading"],
    data() {
        return {
            isLoadingForButton: false
        };
    },
    methods: {
        save() {
            if (
                this.settings.enableMail &&
                (!this.settings.mailHost ||
                    !this.settings.mailPort ||
                    !this.settings.mailUsername ||
                    !this.settings.mailPassword ||
                    !this.settings.mailFromAddress ||
                    !this.settings.mailFromName)
            ) {
                this.$notify({
                    group: "foo",
                    type: "error",
                    title: this.$t("Oops!"),
                    text: this.$t("You need to add your SMTP information.")
                });
                return;
            }
            this.isLoadingForButton = true;
            const formData = new FormData();
            formData.append("enable_mail", this.settings.enableMail ? 1 : "");
            formData.append(
                "contact_email_address",
                this.settings.contactEmailAddress
            );
            formData.append("mailer", "smtp");
            formData.append("username", this.settings.mailUsername);
            formData.append("password", this.settings.mailPassword);
            formData.append("host", this.settings.mailHost);
            formData.append("port", this.settings.mailPort);
            formData.append("from_address", this.settings.mailFromAddress);
            formData.append("from_name", this.settings.mailFromName);
            axios
                .post("/api/admin/save-mail-settings", formData)
                .then(() => {
                    this.$notify({
                        group: "foo",
                        type: "success",
                        title: this.$t("Updated"),
                        text:
                            this.$t("Settings") +
                            " " +
                            this.$t("updated successfully.")
                    });
                })
                .catch(() => {
                    this.$notify({
                        group: "foo",
                        type: "error",
                        title: this.$t("Error"),
                        text: Object.values(e.response.data.errors).join(
                            "<br />"
                        )
                    });
                })
                .finally(() => {
                    this.isLoadingForButton = false;
                });
        }
    }
};
</script>
