<template>
    <v-card>
        <v-container>
            <v-row>
                <v-col>
                    <v-autocomplete
                        v-model="selectedAsset"
                        :items="searchedAssets"
                        :loading="isSearchAssetLoading"
                        :search-input.sync="searchAssets"
                        :item-text="type.title"
                        :no-data-text="$t('No data available')"
                        :label="
                            $t('Search') + ' ' + $t(type.name.replace(/s$/, ''))
                        "
                        :placeholder="$t('Start typing to Search')"
                        return-object
                    >
                        <template v-slot:item="{ item }">
                            <div class="item py-2">
                                <div class="list-item-cover">
                                    <v-img
                                        :src="item[type.image]"
                                        width="40"
                                        class="img mr-2"
                                        aspect-ratio="1"
                                    >
                                        <template v-slot:placeholder>
                                            <v-row
                                                class="fill-height ma-0"
                                                align="center"
                                                justify="center"
                                            >
                                                <content-placeholders
                                                    :rounded="true"
                                                    style="width: 100%"
                                                >
                                                    <content-placeholders-img />
                                                </content-placeholders>
                                            </v-row>
                                        </template>
                                    </v-img>
                                </div>
                            </div>
                            {{ item[type.title] }}
                        </template>
                    </v-autocomplete>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <v-btn
                        class="success"
                        block
                        :disabled="!selectedAsset"
                        @click="$emit('asset', selectedAsset)"
                        >{{ $t("Select") }}</v-btn
                    >
                </v-col>
            </v-row>
        </v-container>
    </v-card>
</template>

<script>
export default {
    props: ["type"],
    data() {
        return {
            selectedAsset: null,
            searchedAssets: [],
            isSearchAssetLoading: false,
            searchAssets: null
        };
    },
    watch: {
        searchAssets(val) {
            if (val) {
                if (this.isSearchAssetLoading) return;
                this.isSearchAssetLoading = true;
                axios
                    .get("/api/match-" + this.type.name + "/" + val)
                    .then(res => {
                        this.searchedAssets = res.data;
                    })
                    .catch()
                    .finally(() => (this.isSearchAssetLoading = false));
            }
        }
    }
};
</script>
<style lang="scss" scoped>
.img {
    border-radius: 8px;
}
</style>
