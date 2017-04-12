import Vue from 'vue'
import Router from 'vue-router'
import J1 from '../components/J1'

Vue.use(Router)

export default new Router({
  routes: [{
      path: '/',
      component: J1
    },
    {
      path: '/J1',
      component: J1
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
