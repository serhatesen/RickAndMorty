<template>
  <div>
    <v-dialog
        v-model="dialog"
        persistent
        max-width="1000px"
    >
      <template v-slot:activator="{ on }">
        <v-btn
            color="orange"
            v-on="on"
            outlined
            class="ml-3"
            style="font-size: x-small"
        >{{ location.location.name }}
        </v-btn>
      </template>
      <v-card color="#455A64">
        <v-card-text>
          <v-row>
            <v-col cols="5">
              <img
                  class="mt-5"
                  :src="location.image"
                  width="350px"
              />
            </v-col>
            <v-col cols="7" class="mt-3">
              <div class="mb-8 pa-0" style="font-size: 35px; color: #ffe59a; line-height: 45px;">
                <span class="ml-16 pl-8 mt-5" style="position: relative; bottom: -10px;">{{ location.name }}</span>
              </div>
              <div class="mt-16" style="line-height: 45px">
                <div class="mt-auto mt-16 white--text" style="font-size: 30px; line-height: 50px">
                  Location: {{ location.location.name }}
                </div>
                <div class="white--text" style="font-size: 25px; line-height: 50px">
                  Type: {{ url.type }}
                </div>
                <div class="white--text" style="font-size: 25px; line-height: 50px">
                  Dimension: {{ url.dimension }}
                </div>
              </div>
            </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer/>
          <location-button :item="location"/>
          <v-btn
              class="mb-5 mr-5"
              color="#ffe59a"
              @click="dialog = false"
          >
            <Icon icon="mdi:close-outline" />
            <span >Close</span>
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
import { Icon } from '@iconify/vue2';
import LocationButton from "@/components/LocationButton.vue";

export default {
  name: "dialogLocation",
  data: () => ({
    dialog: false,
    url: "",
  }),
  props: {
    location: {
      type: Object,
      required: false,
    },
  },
  components: {
    Icon,
    LocationButton
  },
  created() {
    axios
        .get(this.location.location.url)
        .then((response) => {
          this.url = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
        }
}
</script>

<style scoped>

</style>