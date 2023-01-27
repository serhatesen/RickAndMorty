<template>
  <div>

    <navbar/>
    <v-container class="v-main mt-5" fluid style="max-width: 90%">
      <v-row >
        <v-col md="6" sm="12" lg="4" v-for="(item, i) in users" :key="item.id">
          <v-card class="mb-3 blue-grey darken-2 " min-height="220px" >
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
                <DialogComponent :character="users[i]"/>

              </v-col>
            </v-row>
            <v-row>
              <v-col cols="6">
                <dialogLocation :location="item"/>
              </v-col>
              <v-col cols="7">
                <EpisodeButton  :item="item"/>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <v-footer color="#455A64">
      <v-spacer/>
      <v-pagination
          :length="pages.info.pages"
          :total-visible="10"
          @input="changePage"
          v-model="currentPage"
          circle
          dark
          style="color: orange"
      />
      <v-spacer/>
    </v-footer>
    <dialog/>
  </div>
</template>

<script>
import navbar from '../components/navbar.vue'
import DialogComponent from "@/components/DialogComponent.vue";
import axios from "axios";
import {Icon} from "@iconify/vue2";
import EpisodeButton from "@/components/EpisodeButton.vue";
import dialogLocation from "@/components/dialogLocation.vue";

export default {
  name: 'Home-page',

  components: {
    navbar,
    // eslint-disable-next-line vue/no-unused-components
    DialogComponent,
    Icon,
    EpisodeButton,
    dialogLocation
  },
  created() {
    axios.get('https://rickandmortyapi.com/api/character')
        .then((response) => {
          this.users = response.data.results;
          this.pages = response.data;
        })
        .catch((error) => {
          console.log(error);

        });
  },
  data: () => ({
    users: [],
    pages: {
      info: {
        pages: 1
      }
    },
    currentPage: 1,
  }),
  methods: {
    changePage() {
      console.log(this.currentPage);
      axios.get(`https://rickandmortyapi.com/api/character/?page=${this.currentPage}`)
          .then((response) => {
            this.users = response.data.results;
            this.pages = response.data;
          })
          .catch((error) => {
            console.log(error);

          });
    }
  }
}
</script>
<style>
.v-main {
  background-color: #37474F;
}
</style>