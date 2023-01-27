<template>
  <div>
    <v-dialog
        v-model="dialog"
        persistent
        max-width="1000px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
            color="orange"
            v-bind="attrs"
            v-on="on"
            outlined
            class="mt-5 ml-8 elevation-4"
        >
          Open {{character.name.split(" ")[0]}}
        </v-btn>
      </template>
      <v-card color="#455A64">
        <v-card-text>
          <v-row class="pt-16">
            <v-col cols="5">
              <div>
                <img
                    width="350px"
                    class="rounded-lg"
                    :src="character.image"
                />
              </div>
            </v-col>
            <v-col cols="7">
                <div class="mb-8 pa-0" style="font-size: 50px; color: #ffe59a; line-height: 45px;">
                  <span class="ma-0 pa-0" style="position: relative; bottom: -10px;">{{ character.name }}</span>
                </div>
              <div style="line-height: 35px;">
                <div class="white--text pa-2" style="font-size: 30px"> Gender: {{ character.gender }}</div>
                <div class=" white--text pa-2" style="font-size: 30px"> Status: {{ character.status }}</div>
                <div class="white--text pa-2" style="font-size: 30px"> Species: {{ character.species }}</div>
                <div class="white--text pa-2" style="font-size: 30px">Origin: {{ character.origin.name }}</div>

              </div>
                 </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
              class="mb-5 mr-5"
              color="#ffe59a"
              @click="dialog = false"
          >
            <Icon icon="mdi:close-outline" />
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { Icon } from '@iconify/vue2';
export default {
  name: "dialogView",
  data: () => ({
    dialog:false
  }),
  methods: {
    //
  },
  props : {
    character : {
      type : Object,
      required : false,
    }
  },
  components: {
    Icon
  }
}
</script>

<style scoped>

</style>