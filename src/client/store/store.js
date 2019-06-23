import Vue from 'vue'
import Vuex from 'vuex'
import createLogger from 'vuex/dist/logger'
Vue.use(Vuex);
const logger = createLogger({
    collapsed: false, // 自动展开记录的 mutation
    filter (mutation, stateBefore, stateAfter) {
        // 若 mutation 需要被记录，就让它返回 true 即可
        // 顺便，`mutation` 是个 { type, payload } 对象
        return true;
    },
    logger: console, // 自定义 console 实现，默认为 `console`
});
const store = new Vuex.Store({
  state: {
      isLogin:false,
  },
  mutations: {
    setLogin(state,new_login_state){
        state.isLogin=new_login_state;
    }
  },
  actions: {

  },
  plugins: [logger],
});

export default store