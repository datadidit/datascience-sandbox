import Vue from 'vue'
import Router from 'vue-router'
import Hello from '@/components/Hello'
import Titanic from '@/components/Titanic'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/Hello',
      name: 'Hello',
      component: Hello
    },
    {
      path: '/',
      name: 'Titanic',
      component: Titanic
    }
  ]
})
