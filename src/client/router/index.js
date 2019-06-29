import Vue from 'vue'
import Router from 'vue-router'

// 导入对应的vuex文件
import store from './../store/store'

// 导入相应的子组件
import Hello from './../components/Hello'
import Login from "../components/Login";
import Home from "../components/Home";
import members from "../components/members";
import Register from "../components/Register";
import changepwd from "../components/changepwd";
import App from "../App";

Vue.use(Router);

var router = new Router({
    mode: 'history',
    routes: [
        {
            name: '',
            path: '/',
            meta: {
                requireAuth: true,
            },
            component: Home
        }, {
            name: 'hello',
            path: '/hello',
            component: Hello
        },
        {
            name: 'login',
            path: '/login',
            component: Login
        },
        {
            name: 'register',
            path: '/register',
            component: Register
        },
        {
            name: 'home',
            path: '/home',
            component: Home,
            meta: {
                requireAuth: true,
            },
            children: [
               {
                    path: 'members',
                    component: members,
                    name: '家庭成员管理',
                    meta: {
                        requireAuth: true,
                    },
                },
                {
                    path: 'changepwd',
                    component: changepwd,
                    name: '修改密码',
                    meta: {
                        requireAuth: true,
                    },
                },
            ]
        }
    ]
});
router.beforeEach((to, from, next) => {
    // 这里的meta就是我们刚刚在路由里面配置的meta
    if (to.meta.requireAuth) {
        // 下面这个判断是自行实现到底是否有没有登录
        if (store.state.isLogin) {
            // 登录就继续
            next();
        } else {
            // 没有登录跳转到登录页面，登录成功之后再返回到之前请求的页面
            next({
                path: '/login',
                query: {redirect: to.fullPath}
            });
        }
    } else if (to.path === '/login' && store.state.isLogin) {

        // 不需要登录的，可以继续访问
        next({
            path: '/home',
        });
    } else {
        next();
    }
});

export default router