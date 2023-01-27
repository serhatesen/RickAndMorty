<template>
  <div class="button-location">
    <v-btn
        @click="locationMt()"
        class="mb-5 mr-5"
        color="#ffe59a"
        style="font-size: x-small"
    > <Icon class="mr-2" style="font-size: 20px" icon="icon-park:doc-detail" />
      Location Details
    </v-btn>
  </div>
</template>

<script>
import { Icon } from '@iconify/vue2';
export default {
  name: "LocationButton",
  props: {
    item: {
      type: Object,
      required: true,
    }
  },
  components: {
    Icon
  },
  methods: {
    locationMt() {
      this.$store.state.location = this.item.location.url;
      this.$router.push('/location');
    }
  }
}
</script>
<style scoped>

</style>