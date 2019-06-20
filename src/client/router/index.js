import Vue from 'vue'
import Router from 'vue-router'

// 导入对应的vuex文件
import store from './../store/store'

// 导入相应的子组件
import Hello from './../components/Hello'
import Home from "../components/Home";
import strategy from "../components/strategy";
import product from "../components/product";
import forms from "../components/forms";
import App from "../App";

Vue.use(Router);

var router = new Router({
  mode: 'history',
  routes: [
    { name: 'hello', path: '/hello', component: Hello },
    { name: 'home', path: '/home', component: Home },
    {
      path: '/',
      name: '管理系统',
      component: App,
      children: [
        { path: '/product', component: product, name: '列表管理' },
        { path: '/strategy', component: strategy, name: '瞎画的' },
        { path: '/forms', component: forms, name: '表单管理' },
        // { path: '/user', component: user, name: '列表' },
      ]
    }
  ]
})

export default router