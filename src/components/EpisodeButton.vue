<template>
  <div class="button-episode">
    <v-btn
        @click="episode"
        class="ml-3"
        color="orange"
        outlined
        style="font-size: x-small"
    >
      {{ item.name.split(" ")[0] }} Episode
    </v-btn>
  </div>
</template>

<script>
export default {
  name: "EpisodeButton",
  props: {
    item: {
      type: Object,
      required: false,
    }
  },
  methods: {
    episode() {
      this.$store.state.showingEpisodes = this.item.episode;
      this.$store.state.items = this.item;
      this.$router.push({name: 'episodes', replace: true})
    }
  }
}
</script>

<style scoped>

</style>