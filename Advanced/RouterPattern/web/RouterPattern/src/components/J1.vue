<template lang="html">
  <div>
    <navigation :documentTitle="title"></navigation>
    <div class="cell" v-for="model in models" @click="push('J1')">
        <img :src="model.imageUrl">
        <span>{{model.text}}</span>
        <span>{{model.detailText}}</span>
    </div>
  </div>
</template>

<script>

import navigation from './navigation'
import { GET,URL } from '../javascripts/http'
import { URLQuery } from '../javascripts/regex'
import { NativePush, NativeParams } from '../javascripts/native'

export default {
  data () {
    return {
      title: '',
      models: []
    }
  },
  components: {
    navigation
  },
  methods: {
    request: function() {
      GET(URL.getJ1List).then((data) => {
          this.models = data.models;
      }).catch((error) => {

      })
    },
    push : function(path) {
      if (URLQuery('client') === 'app') {
          let params = {
            text : "web端 传入数据",
            code : 1002
          }
          NativeParams(params);
          NativePush(path);
      } else {
          this.$router.push({
                path: '/' + path
          });
      }
    }
  },
  mounted:function () {
    this.title = document.title = "J1";
    this.request();
    // alert(window.location.href);
  }
}
</script>

<style scoped>

.cell {
    height: 100px;
    position: relative;
    border-bottom: 1px solid lightgray;
}

.cell img {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    padding-left: 10px;
}

.cell span:first-of-type {
    position: absolute;
    top: 35%;
    transform: translateY(-35%);
    padding-left: 84px;
    font-size: 15px;
}

.cell span:last-of-type {
    position: absolute;
    top: 65%;
    transform: translateY(-65%);
    padding-left: 84px;
    font-size: 12px;
}

</style>
