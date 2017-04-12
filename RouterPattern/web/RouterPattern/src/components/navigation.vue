<template lang="html">
  <div v-show="show">
    <div class="nav">
        <span class="title">{{documentTitle}}</span>
    </div>
    <div class="nav-offset"></div>
  </div>
</template>

<script>

import {
  URLQuery
} from '../javascripts/regex'

export default {
  data () {
    return {
      show: true
    }
  },
  props: {
    documentTitle: String
  },
  mounted:function () {
    if (URLQuery('client') === 'app') {
      this.show = false;
    }
  }
}
</script>

<style scoped>

.nav {
    width: 100%;
    height: 44px;
    position: relative;
    background: rgba(248,248,248,1.0);
    border-bottom: 1px solid lightgray;
    position: fixed;
    top: 0px;
    left: 0px;
    z-index: 1;
}

.nav-offset {
    height: 44px;
}

.title {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

</style>
