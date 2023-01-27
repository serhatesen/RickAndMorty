<template>
  <v-app-bar
  app
  color="#ECEFF1"
  dark
  width="1000%"
  height="200%"
  >
    <v-spacer/>
    <span
    class="text-h1 font-weight-bold black--text"
    >The Rick and Morty </span>
    <v-spacer/>

  </v-app-bar>

</template>


<script>


  export default {
    name: 'Navbar-page',
    data: () => ({
      drawer: null,
    }),

  }
</script>
