import Vue from 'vue'
import Vuex from 'vuex'
import createLogger from 'vuex/dist/logger'
import createVuexAlong from 'vuex-along'
import createPersistedState from "vuex-persistedstate"

Vue.use(Vuex);
const logger = createLogger({
    collapsed: false, // 自动展开记录的 mutation
    filter(mutation, stateBefore, stateAfter) {
        // 若 mutation 需要被记录，就让它返回 true 即可
        // 顺便，`mutation` 是个 { type, payload } 对象
        return true;
    },
    logger: console, // 自定义 console 实现，默认为 `console`
});
const store = new Vuex.Store({
    state: {
        isLogin: false,
        account: null,
        members: null,
        savings: null,
        balances: null,
        finances: null,
        borrowings: null,
    },
    mutations: {
        setLogin(state, new_login_state) {
            state.isLogin = new_login_state;
            console.log('setLogin to ' + new_login_state);
        },
        setAccount(state, account) {
            state.account = account;
        },
        setMembers(state, members) {
            state.members = members;
        },
        setSavings(state, savings) {
            state.savings = savings;
        },
        setFinances(state, finances) {
            state.finances = finances;
        },
        setBorrowings(state, borrowings) {
            state.borrowings = borrowings;
        },
    },
    actions: {},
    plugins: [
        logger,
        // createVuexAlong({
        //     session: true,
        // }),
        createPersistedState({
            storage: window.sessionStorage
        })
    ],
});


export default store