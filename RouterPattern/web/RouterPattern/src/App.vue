<template>
  <div id="app">
      <router-view></router-view>
  </div>
</template>

<script>

export default {
  data () {
    return {
      name: 'app'
    }
  }
}

</script>

<style>
@import "./stylesheets/global.css";

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

</style>
