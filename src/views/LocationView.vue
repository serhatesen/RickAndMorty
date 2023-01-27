<template>
  <div>
    <location-bar/>
    <v-container>
      <v-row>
        <v-col cols="12">
          <v-card class="text-center mt-5 blue-grey darken-2 orange--text">
            <v-card-title>
              <v-spacer/>
              <span class="">{{ location_url.name }}</span>
              <v-spacer/>
            </v-card-title>
            <v-card-title>
              <v-spacer/>
              <span>{{ location_url.type }}</span>
              <v-spacer/>
            </v-card-title>
            <v-card-title>
              <v-spacer/>
              <span>{{ location_url.dimensions }}</span>
              <v-spacer/>
            </v-card-title>
          </v-card>
        </v-col>
      </v-row>
      <v-row>
        <v-col md="6" sm="12" lg="4" v-for="item in characters" :key="item.id">
          <v-card class="mt-8 mb-3 blue-grey darken-2 " min-height="220px">
            <v-row>
              <v-col cols="5">
                <img
                    width="150px"
                    class="d-inline-block rounded-lg ml-2"
                    :src="item.image"
                />
              </v-col>
              <v-col cols="6">
                <div class="text-center mt-4 font-weight-light text-h5">
                  <span class="white--text">{{ item.name }}</span>
                </div>
                <div class="ml-4">
                  <Icon icon="material-symbols:circle" :color="item.status === 'Alive' ? 'green' : 'red'"/>
                  <span class="white--text ">{{ item.status }}</span>
                </div>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import LocationBar from "@/components/LocationBar.vue";
import axios from "axios";
import {Icon} from "@iconify/vue2";

export default {
  name: "LocationView",
  components: {
    LocationBar,
    Icon
  },
  data: () => ({
    character_location_url: [],
    characters: [],
    location_url: []
  }),
  mounted() {
    axios.get(this.$store.state.location)
        .then(response => {
          {
            if (response.status === 200) {
              console.log("Location data fetched successfully");
              this.character_location_url = response.data.residents;
              this.location_url = response.data;
              this.forEachCharacter()
            } else console.log(response)
          }
        })
        .catch(error => {
          console.log(error)
        })
  },
  methods: {
    forEachCharacter() {
      this.character_location_url.forEach(chr => {
        axios.get(chr)
            .then(response => {
              {
                if (response.status === 200) {
                  console.log("Character data fetched successfully");
                  this.characters.push(response.data);
                } else console.log(response)
              }
            })
            .catch(error => {
              console.log(error)
            })
      })
    }
  }


}
</script>

<style scoped>

</style>