<template>
  <div class="analytics-wrapper" v-if="stats">
    <v-container fluid>
      <v-row>
        <v-col
          cols="12"
          sm="6"
          lg="3"
          v-for="(card, t) in analyticsCards"
          :key="t"
        >
          <v-card rounded outlined class="analytic-info-card">
            <v-card-title>
              <v-row justify="space-between">
                <v-col cols="8">
                  <h5 class="analytic-info-card__headline max-1-lines">
                    {{ $t(card.title) }}
                  </h5>
                  <div class="analytic-info-card__subline">
                    {{ card.number }}
                  </div>
                </v-col>
                <v-col cols="4" class="flex-end">
                  <v-avatar size="45">
                    <v-img :gradient="card.gradient">
                      <v-icon color="white" large>mdi-{{ card.icon }}</v-icon>
                    </v-img>
                  </v-avatar>
                </v-col>
              </v-row>
            </v-card-title>
            <div class="percetage px-3 pb-2">
              <strong
                :class="
                  (card.this_month === 0 ? 'secondary' : 'success') + '--text'
                "
                >{{
                  (card.this_month > 0 ? "+" : "") + card.this_month
                }}</strong
              >
              <span class="muted">{{ $t('New this month') }}</span>
            </div>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <v-container fluid>
      <v-row>
        <v-col cols="12" class="mt-2">
          <v-card height="550px" class="chart" outlined rounded>
            <v-card-title>
              <div class="flex flex-grow-1 align-center plays-chart-card-title">
                <v-icon class="ml-3" color="primary" large
                  >mdi-music-note</v-icon
                >
                <h5 class="analytic-info-card__headline">{{ $t('Plays Chart') }}</h5>
                <div class="card-subline ml-2">{{ $t('Number of plays per interval') }}</div>
              </div>
              <div class="flex-grow-0">
                <veutify-select
                  class="ml-auto plays-chart-card-title__select"
                  :items="timeOptions"
                  item-text="name"
                  return-object
                  v-model="timeOption"
                  @change="updatePlaysChart"
                  :label="$t('Interval')"
                  dense
                ></veutify-select>
              </div>
            </v-card-title>
            <div>
              <area-chart
                v-if="chartPlaysData.datasets[0].data.length"
                :chartdata="chartPlaysData"
                :options="chartPlaysData.options"
                :reset="playsChartReset"
                @resetOver="playsChartReset = false"
              />
            </div>
          </v-card>
        </v-col>
        <v-col cols="12" md="6">
          <v-card height="550px" class="chart" outlined rounded>
            <v-card-title>
              <v-row justify="space-between">
                <v-col class="flex-grow-0">
                  <v-icon class="ml-3" color="primary" large
                    >mdi-music-note</v-icon
                  >
                </v-col>
                <v-col>
                  <h5 class="analytic-info-card__headline">
                    {{ $t('Top Visiting Countries') }}
                  </h5>
                </v-col>
              </v-row>
            </v-card-title>
            <pie-chart
              v-if="chartMostVisitingCountries.datasets[0].data.length"
              :chartdata="chartMostVisitingCountries"
              :options="chartMostVisitingCountries.options"
            />
            <div v-else class="v-data-table__empty-wrapper no-data-chart">{{ $t('No data to show yet!') }}</div>
          </v-card>
        </v-col>
        <v-col cols="12" md="6">
          <v-card height="550px" class="chart" outlined rounded>
            <v-card-title>
              <v-row justify="space-between">
                <v-col class="flex-grow-0">
                  <v-icon class="ml-3" color="primary" large
                    >mdi-music-note</v-icon
                  >
                </v-col>
                <v-col>
                  <h5 class="analytic-info-card__headline">
                    {{ $t('Top Visiting Browsers') }}
                  </h5>
                </v-col>
              </v-row>
            </v-card-title>
            <pie-chart
              v-if="chartMostVisitingBrowsers.datasets[0].data.length"
              :chartdata="chartMostVisitingBrowsers"
              :options="chartMostVisitingBrowsers.options"
            />
            <div v-else class="v-data-table__empty-wrapper no-data-chart">{{ $t('No data to show yet!') }}</div>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <v-container fluid>
      <v-row>
        <v-col cols="12" md="6" v-for="(popular, i) in populars" :key="i">
          <v-card>
            <v-card-title>
              <v-row>
                <v-col class="flex-grow-0">
                  <v-icon class="ml-3" color="primary" large>{{
                    popular.icon
                  }}</v-icon>
                </v-col>
                <v-col>
                  <h5 class="analytic-info-card__headline">
                    {{ $t('Popular') }} {{ $t(popular.text) }}
                  </h5>
                </v-col>
              </v-row>
            </v-card-title>
            <v-data-table
              :no-data-text="$t('No data available')"
              :loading-text="$t('Fetching data') + '...'"
              :headers="popular.headers"
              :items="popular.items"
              hide-default-footer
            >
              <template v-slot:item.rank="{ item }">
                <span
                  v-if="popular.items.indexOf(item) == 0"
                  class="rank rank-one"
                  >1.</span
                >
                <span
                  v-else-if="popular.items.indexOf(item) == 1"
                  class="rank rank-two"
                  >2.</span
                >
                <span
                  v-else-if="popular.items.indexOf(item) == 2"
                  class="rank rank-three"
                  >3.</span
                >
                <span v-else>{{ popular.items.indexOf(item) }}.</span>
              </template>
              <template v-slot:item.cover="{ item }">
                <div class="img-container py-2">
                  <v-img
                    :src="item.cover"
                    :alt="item.title"
                    class="user-avatar song-cover"
                    width="50"
                    height="50"
                  >
                  </v-img>
                </div>
              </template>
              <template v-slot:item.avatar="{ item }">
                <div class="img-container py-2">
                  <v-img
                    :src="item.avatar"
                    class="user-avatar song-cover"
                    width="50"
                    height="50"
                  >
                  </v-img>
                </div>
              </template>
                 <template v-slot:item.title="{ item }">
                   {{ item.title ? item.title : item.name }}
              </template>
              <template v-slot:item.user="{ item }">
                <template v-if="item.user">
                  <router-link
                    class="router-link"
                    :to="{
                      name: 'profile',
                      params: { id: item.id },
                    }"
                    target="_blank"
                  >
                    <div class="avatar">
                      <v-avatar size="35">
                        <v-img :src="item.user.avatar"></v-img>
                      </v-avatar>
                    </div>
                    <div class="artist-name">
                      {{ item.user.email }}
                    </div>
                  </router-link>
                </template>
                <template v-else> - </template>
              </template>
              <template v-slot:item.artists="{ item }">
                {{ getArtists(item.artists) }}
              </template>
              <template v-slot:item.created_at="{ item }">
                {{ moment(item.created_at).format("ll") }}
              </template>
            </v-data-table>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
  <page-loading v-else />
</template>
<script>
import AreaChart from "../../charts/AreaChart";
import PieChart from "../../charts/PieChart";
import BarChart from "../../charts/BarChart";
import { VSelect } from "vuetify/lib";
export default {
  components: {
    AreaChart,
    PieChart,
    BarChart,
    veutifySelect: VSelect,
  },
  data() {
    return {
      stats: null,
      playsChartReset: false,
      timeOptions: [
        {
          name:this.$t("Last 7 days"),
          param: "lw",
        },
        {
          name:this.$t("Last Month"),
          param: "lm",
        },
        {
          name:this.$t("Last Year"),
          param: "ly",
        },
      ],
      timeOption: {
        name:this.$t("Last 7 days"),
        param: "lw",
      },
      populars: [
        {
          text: "Songs",
          name: "songs",
          icon: "mdi-music-note",
          headers: [
            {
              text: this.$t('#'),
              value: "rank",
              sortable: false,
            },
            {
              text: this.$t("Cover"),
              align: "start",
              sortable: false,
              value: "cover",
            },
            { text: this.$t('Title'), value: "title" },
            { text: this.$t('Created At'), value: "created_at" },
          ],
          items: [],
        },
        {
          text: "Radio Stations",
          name: "radioStations",
          icon: "mdi-radio-tower",
          headers: [
            {
              text: this.$t('#'),
              value: "rank",
              sortable: false,
            },
            {
              text: this.$t("Cover"),
              align: "start",
              sortable: false,
              value: "cover",
            },
            { text: this.$t('Title'), value: "title" },
            { text: this.$t('Created At'), value: "created_at" },
          ],
          items: [],
        },
        {
          text: "Albums",
          name: "albums",
          icon: "mdi-album",
          headers: [
            {
              text: this.$t('#'),
              value: "rank",
              sortable: false,
            },
            {
              text: this.$t("Cover"),
              align: "start",
              sortable: false,
              value: "cover",
            },
            { text: this.$t('Title'), value: "title" },
            ,
            { text: this.$t('Created At'), value: "created_at" },
          ],
          items: [],
        },
        {
          text: "Podcasts",
          name: "podcasts",
          icon: "mdi-microphone",
          headers: [
            {
              text: this.$t('#'),
              value: "rank",
              sortable: false,
            },
            {
              text: this.$t("Cover"),
              align: "start",
              sortable: false,
              value: "cover",
            },
            { text: this.$t('Title'), value: "title" },
            { text: this.$t('Created At'), value: "created_at" },
          ],
          items: [],
        },
        {
          text: "Playlists",
          name: "playlists",
          icon: "mdi-playlist-music",
          headers: [
            {
              text: this.$t('#'),
              value: "rank",
              sortable: false,
            },
            {
              text: this.$t("Cover"),
              align: "start",
              sortable: false,
              value: "cover",
            },
            { text: this.$t('Title'), value: "title" },
            { text: this.$t('User'), value: "user", align: "center" },
          ],
          items: [],
        },
        {
          text: "Artists",
          name: "artists",
          icon: "mdi-account-music",
          headers: [
            {
              text: this.$t('#'),
              value: "rank",
              sortable: false,
            },
            { text: this.$t('Avatar'), sortable: false, value: "avatar" },
            { text: this.$t('Displayname'), value: "displayname" },
            { text: this.$t('User account'), value: "user", align: "center" },
          ],
          items: [],
        },
      ],
      analyticsCards: [
        {
          icon: "music-note",
          title: "Songs",
          number: 0,
          gradient: "45deg,#00cdac,#02aab0",
          this_month: "0",
        },
        {
          icon: "account",
          title: "Users",
          number: 0,
          gradient: "45deg,#8C366C, #6E64E7",
          this_month: "0",
        },
        {
          icon: "account-music",
          title: "Artists",
          number: 0,
          gradient: "45deg, #904e95, #e96443",
          this_month: "0",
        },
        {
          icon: "album",
          title: "Albums",
          number: 0,
          gradient: "45deg,#f09819,#edde5d",
          this_month: "0",
        },
      ],
      plays: [],
      chartPlaysData: {
        labels: [],
        datasets: [
          {
            data: [],
            fill: true,
            borderColor: "#2196f3",
            backgroundColor: "#4245a8",
            borderWidth: 1,
          },
        ],
        options: {
          legend: {
            display: false,
          },
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            yAxes: [
              {
                ticks: {
                  precision: 0,
                  beginAtZero: true,
                },
              },
            ],
          },
        },
      },
      chartMostVisitingCountries: {
        labels: [],
        datasets: [
          {
            data: [],
            backgroundColor: [
              "#6E64E7",
              "#8C85E5",
              "#6D67B6",
              "#9467B6",
              "#B667B0",
            ],
          },
        ],
        options: {
          tooltips: {
            callbacks: {
              title: function (tooltipItem, data) {
                return data["labels"][tooltipItem[0]["index"]];
              },
              label(tooltipItem, data) {
                let totalVisits = data["datasets"][0]["data"].reduce(
                  (acc, val) => acc + val
                );
                let countryVisits =
                  data["datasets"][0]["data"][tooltipItem["index"]];
                return Math.floor((countryVisits / totalVisits) * 100) + "%";
              },
            },
          },
          legend: {
            display: false,
          },
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            yAxes: [
              {
                display: false,
                ticks: {
                  display: false,
                  beginAtZero: true,
                },
              },
            ],
          },
        },
      },
      chartMostVisitingBrowsers: {
        labels: [],
        datasets: [
          {
            data: [],
            backgroundColor: [
              "#6E64E7",
              "#8C85E5",
              "#6D67B6",
              "#9467B6",
              "#B667B0",
            ],
          },
        ],
        options: {
          tooltips: {
            callbacks: {
              title: function (tooltipItem, data) {
                return data["labels"][tooltipItem[0]["index"]];
              },
              label(tooltipItem, data) {
                let totalVisits = data["datasets"][0]["data"].reduce(
                  (acc, val) => acc + val
                );
                let browserVisits =
                  data["datasets"][0]["data"][tooltipItem["index"]];
                return Math.floor((browserVisits / totalVisits) * 100) + "%";
              },
            },
          },
          legend: {
            display: false,
          },
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            yAxes: [
              {
                display: false,
                ticks: {
                  display: false,
                  beginAtZero: true,
                },
              },
            ],
          },
        },
      },
    };
  },
  methods: {
    updatePlaysChart() {
      var playsCount;
      axios
        .get("/api/admin/plays/" + this.timeOption.param)
        .then((res) => {
          playsCount = res.data;
        })
        .then(() => {
          if (this.timeOption.param === "lw") {
            // lw = last week
            // After getting the plays data from the API
            // this script reform the data so it is displayable
            // by the ChartJs script
            let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
            let last7Days = [];
            for (let i = 1; i <= 7; i++) {
              let moment = this.moment().subtract(1, "weeks").add(i, "d");
              last7Days.push({
                day: days[moment.day()],
                date: moment.format("YYYY-MM-DD"),
              });
            }
            let plays = last7Days.map((day) => {
              if (playsCount.some((play) => play.date === day.date)) {
                day.plays = playsCount.find(
                  (play) => play.date === day.date
                ).plays;
              } else {
                day.plays = 0;
              }
              return day;
            });
            this.chartPlaysData.labels = plays.map((play) => play.day);
            this.chartPlaysData.datasets[0].data = plays.map(
              (play) => play.plays
            );
            this.playsChartReset = true;
          } else if (this.timeOption.param === "lm") {
            // lm = last month
            let last30Days = [];
            for (let i = 1; i <= 30; i++) {
              let moment = this.moment().subtract(30, "days").add(i, "d");
              last30Days.push({
                day: moment.format("ll"),
                date: moment.format("YYYY-MM-DD"),
              });
            }
            let plays = last30Days.map((day) => {
              if (playsCount.some((play) => play.date === day.date)) {
                day.plays = playsCount.find(
                  (play) => play.date === day.date
                ).plays;
              } else {
                day.plays = 0;
              }
              return day;
            });
            this.chartPlaysData.labels = plays.map((play) => play.day);
            this.chartPlaysData.datasets[0].data = plays.map(
              (play) => play.plays
            );
            this.playsChartReset = true;
          } else if (this.timeOption.param === "ly") {
            // ly = last year
            let months = [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec",
            ];
            let last12Month = [];
            for (let i = 1; i <= 12; i++) {
              let moment = this.moment().subtract(12, "months").add(i, "M");
              last12Month.push({
                month: months[moment.month()],
                date: moment.format("M"),
              });
            }
            let plays = last12Month.map((month) => {
              if (
                playsCount.some((play) => play.date === parseInt(month.date))
              ) {
                month.plays = playsCount.find(
                  (play) => play.date === parseInt(month.date)
                ).plays;
              } else {
                month.plays = 0;
              }
              return month;
            });
            this.chartPlaysData.labels = plays.map((play) => play.month);
            this.chartPlaysData.datasets[0].data = plays.map(
              (play) => play.plays
            );
            this.playsChartReset = true;
          }
        });
      setTimeout(() => {
        this.playsChartReset = false;
      }, 300);
    },
  },
  created() {
    // fetching the stats and updating the page components
    axios.get("/api/admin/analytics").then((res) => {
      this.stats = res.data;
      // updating the plays card
      this.updatePlaysChart();
      // updating the songs card
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/song/i))
      ].number = this.stats.nb_songs;
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/song/i))
      ].this_month = this.stats.nb_songs_this_month;
      // updating the users card
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/user/i))
      ].number = this.stats.nb_users;
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/user/i))
      ].this_month = this.stats.nb_users_this_month;
      // updating the artists card
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/artist/i))
      ].number = this.stats.nb_artists;
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/artist/i))
      ].this_month = this.stats.nb_artists_this_month;
      // updating the albums card
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/album/i))
      ].number = this.stats.nb_albums;
      this.analyticsCards[
        this.analyticsCards.findIndex((card) => card.title.match(/album/i))
      ].this_month = this.stats.nb_albums_this_month;
      // updating popular items
      for (let i = 0; i < this.populars.length; i++) {
        this.populars[i].items = this.stats.populars[this.populars[i].name];
      }
      // updating the countries & browsers charts
      let top5VisitngBrowsers = this.stats.visiting_browsers.slice(0, 5);
      let top5VisitingCountries = this.stats.visiting_countries.slice(0, 5);
      this.chartMostVisitingBrowsers.labels = top5VisitngBrowsers.map(
        (visit) => visit.name
      );
      this.chartMostVisitingBrowsers.datasets[0].data = top5VisitngBrowsers.map(
        (visit) => visit.visitors
      );
      this.chartMostVisitingCountries.labels = top5VisitingCountries.map(
        (visit) => visit.name
      );
      this.chartMostVisitingCountries.datasets[0].data = top5VisitingCountries.map(
        (visit) => visit.visitors
      );
    });
  },
};
</script>
<style lang="scss" scoped>
.card-subline {
  font-size: 0.7em;
  color: grey;
  font-weight: 600;
  @media screen and (max-width: 500px) {
    display: none;
  }
}
.no-data-chart {
  color: rgb(202, 202, 202);
  transform: translateY(10em);
}
.plays-chart-card-title__select {
  max-width: 130px;
  margin-top: 0.3em;
  @media screen and (max-width: 600px) {
    margin: 1em !important;
    margin-left: 1em !important;
  }
}
.flex-end {
  display: flex;
  align-items: center;
  justify-content: flex-end;
}
</style>
