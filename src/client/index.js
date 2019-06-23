import Vue from 'vue'
import App from './App'
// import Vuex from 'Vuex'
import router from './router'
import store from './store/store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

import axios from 'axios'
Vue.config.debug = true;

Vue.config.productionTip = false;
Vue.prototype.$axios = axios;
Vue.use(ElementUI);
Vue.use(router);
// Vue.use(Vuex);
new Vue({
  el: '#app',
  router: router,
  store: store,
  template: '<App/>',
  components: { App }
});
