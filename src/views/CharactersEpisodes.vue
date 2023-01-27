<template>
  <v-row>
    <v-col>
      <EpisodesBar/>
    </v-col>
    <v-col cols="12">
      <div
          class="mt-15 mx-auto flex"
          style="height: 700px; width: 600px; overflow: scroll;"
      >
        <v-card color="#455A64">
          <v-card-text>
            <v-row>
              <v-col cols="6">
                <div class="text-center mt-8 ml-5"
                     style="color: #ffe59a; background: #455A64; font-size: 50px; line-height: 60px">
                  {{ $store.state.items.name }}
                </div>
              </v-col>
              <v-col cols="6">
                <div class="text-center mt-10" style="color: #ffe59a; background: #455A64">
                  <img
                      width="150px"
                      height="150px"
                      class="d-inline-block rounded-lg ml-2"
                      :src="$store.state.items.image"/>
                </div>
              </v-col>
            </v-row>
          </v-card-text>
        </v-card>
        <div v-for="ep in $store.state.showingEpisodes"
             :key="$store.state.showingEpisodes.indexOf(ep)"
        >
          <v-expansion-panels
              flat
              class="mx-auto mb-1 pa-4 mt-1 blue-grey darken-2">
            <v-expansion-panel>
              <v-expansion-panel-header style="color: #ffe59a" color="#455A64">
                <Icon icon="arcticons:episodes" style="font-size: 70px; color: #ffe59a;"/>
                <span>Episode  {{ ep.split("/")[5] }}</span> <v-spacer/>
              </v-expansion-panel-header>
              <v-expansion-panel-content style="color: #ffe59a; " color="#455A64">
                Episode Name: {{ filteredEpisodes(ep.split("/")[5]).name }}
              </v-expansion-panel-content>
              <v-expansion-panel-content style="color: #ffe59a; " color="#455A64">
                Date: {{ filteredEpisodes(ep.split("/")[5]).air_date }}
              </v-expansion-panel-content>
              <v-expansion-panel-content style="color: #ffe59a; " color="#455A64">
                {{ filteredEpisodes(ep.split("/")[5]).episode }}
              </v-expansion-panel-content>
              <v-expansion-panel-content style="color: #ffe59a; " color="#455A64">
                {{ ep }}
              </v-expansion-panel-content>
            </v-expansion-panel>
          </v-expansion-panels>
        </div>
      </div>
    </v-col>
  </v-row>
</template>

<script>
import axios from "axios";
import EpisodesBar from "@/components/EpisodesBar.vue";
import { Icon } from '@iconify/vue2';
export default {
  name: "CharactersEpisodes",
  mounted() {
    this.forEachEpisode()
  },
  data: () => ({
    episodes_data: []
  }),
  methods: {
    forEachEpisode() {
      this.$store.state.showingEpisodes.forEach(ep => {
        axios.get(ep)
            .then(response => {
              this.episodes_data.push(response.data)
            })
            .catch(error => {
              console.log(error);
            })
      })
    },
    filteredEpisodes(id) {
      return this.episodes_data.filter(ep => ep.id == id)[0]
    },
  },
  components:{
    EpisodesBar,
    Icon
  }

}
</script>

<style scoped>

</style>