<template>
  <div class="podcst-radioStations-wrapper">
    <v-card outlined>
      <v-card-title>
        <v-icon color="primary" x-large>mdi-radio-tower</v-icon>
        <v-btn
          class="mx-2"
          dark
          small
          color="primary"
          @click="createRadioStationDialog"
        >
          <v-icon>mdi-plus</v-icon> {{ $t('New') }}
        </v-btn>
        <v-spacer></v-spacer>
        <v-spacer></v-spacer>
        <div class="admin-search-bar">
          <v-text-field
            v-model="search"
            append-icon="mdi-magnify"
           :label="$t('Search')"
            single-line
            hide-details
          ></v-text-field>
        </div>
      </v-card-title>
      <v-data-table
        :no-data-text="$t('No data available')"
        :loading-text="$t('Fetching data') + '...'"
        :headers="headers"
        :items="radioStations"
        :items-per-page="25"
        :search="search"
        class="elevation-1"
      >
        <template v-slot:item.cover="{ item }">
          <div class="img-container py-2">
            <v-img
              :src="item.cover"
              :alt="item.name"
              class="radioStation-cover user-avatar"
              width="100"
              height="100"
            ></v-img>
          </div>
        </template>
        <template v-slot:item.operations="{ item }">
          <v-btn
            class="mx-2"
            @click="editRadioStation(item)"
            x-small
            fab
            dark
            color="info"
          >
            <v-icon>mdi-pencil</v-icon>
          </v-btn>
          <v-btn
            class="mx-2"
            @click="deleteRadioStation(item.id)"
            x-small
            fab
            dark
            color="error"
          >
            <v-icon>mdi-delete</v-icon>
          </v-btn>
        </template>
        <template v-slot:item.created_at="{ item }">
          {{ moment(item.created_at).format("ll") }}
        </template>
      </v-data-table>
    </v-card>
    <v-dialog v-model="editDialog" max-width="600">
      <edit-radio-station-dialog
        v-if="editDialog"
        @updated="radioStationEdited"
        @close="editRadioStation(null)"
        :radioStation="editingRadioStation"
      />
    </v-dialog>
  </div>
</template>
<script>
import editRadioStationDialog from "../../dialogs/admin/edit/RadioStation";
export default {
  components: {
    editRadioStationDialog,
  },
  data() {
    return {
      radioStations: [],
      search: "",
      headers: [
        {
          text: this.$t("Cover"),
          align: "start",
          sortable: false,
          value: "cover",
        },
        { text: this.$t('Name'), value: "name" },
        { text: this.$t('Created At'), value: "created_at" },
        { text: this.$t('Operations'), value: "operations", align: "center" },
      ],
      editDialog: false,
      editingRadioStation: null,
    };
  },
  created() {
    this.fetchRadioStations();
  },
  methods: {
    fetchRadioStations() {
      axios.get("/api/admin/radio-stations").then((res) => {
        this.radioStations = res.data;
      });
    },
    deleteRadioStation(id) {
      this.$confirm({
        message: `${this.$t("Are you sure you wanna delete this") + " " + this.$t('Radio Station') + "?"}`,
        button: {
          no: this.$t('No'),
          yes: this.$t('Yes'),
        },
        /**
         * Callback Function
         * @param {Boolean} confirm
         */
        callback: (confirm) => {
          if (confirm) {
            axios
              .delete("/api/admin/radio-stations/" + id)
              .then(() => {
                this.$notify({
                  group: "foo",
                  type: "success",
                  title: this.$t("Deleted"),
                  text: this.$t('RadioStation')  + " " + this.$t('Deleted') + ".",
                });
                this.fetchRadioStations();
              })
              .catch();
          }
        },
      });
    },
    editRadioStation(radioStation) {
      if (!radioStation) {
        this.editDialog = false;
        this.editingRadioStation = null;
      } else {
        this.editingRadioStation = radioStation;
        this.editDialog = true;
      }
    },
    createRadioStationDialog() {
        this.editingRadioStation = {
            new: true,
            name: "",
            retry_timeout: 30,
            metadata_types: ['ICY'],
            icy_detection_timeout: 2000
        };
        this.editDialog = true; 
    },
    radioStationEdited() {
      this.editDialog = false;
      this.$notify({
        group: "foo",
        type: "success",
        title: this.$t("Saved"),
        text: this.$t('Radio Station') + " " +  this.$t('Updated') + ".",
      });
      this.fetchRadioStations();
    },
  },
};
</script>
