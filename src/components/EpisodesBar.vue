<template>
    <v-app-bar
        app
        color="#263238"
        dark
        height="100%"
    >
      <v-row>
        <v-col cols="4">
          <v-btn class="ml-16 mt-4" color="#455A64" style="color: orange" @click="back()">
            <Icon class="mr-3" style="font-size: 20px" icon="mdi:home-circle" />
            Home
          </v-btn>
        </v-col>
        <v-col cols="4" class="text-center title orange--text">
          <span class="text-h2">Episodes</span>
        </v-col>
        <v-col cols="4" class="text-right mt-4">
        <span class="orange--text">
          Contact Dev Studio Design
        </span>
        </v-col>
      </v-row>
    </v-app-bar>
</template>

<script>
import { Icon } from '@iconify/vue2';
export default {
  name: "EpisodesBar",
  methods: {
    back() {
      this.$router.push('/')
    }
  },
  components: {
    Icon
  }
}
</script>

<style scoped>

</style>