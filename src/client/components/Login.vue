<template>
    <el-form ref="AccountFrom" :model="account" :rules="rules" label-position="left" label-width="0px"
             class="demo-ruleForm login-container">
        <h3 class="title">请登录{{project_name}}</h3>
        <el-form-item prop="username">
            <el-input type="text" v-model="account.username" auto-complete="off" placeholder="账号"></el-input>
        </el-form-item>
        <el-form-item prop="pwd">
            <el-input type="password" v-model="account.pwd" auto-complete="off" placeholder="密码"></el-input>
        </el-form-item>
        <Verify @success="inputSuccess('success')" @error="inputError('error')" :type="1" :show-button="false" ref="Verify"></Verify>
<!--        <el-checkbox v-model="checked" checked class="remember">记住密码</el-checkbox>-->
        <el-form-item style="width:100%;margin-top: 5px">
            <el-button @click="checkCode()" type="primary" style="width:100%;" >登录</el-button>
        </el-form-item>
    </el-form>
</template>

<script>
    import Verify from 'vue2-verify'

    export default {
        name: 'login',
        data () {
            return  {
                project_name:'财务管理系统',
                logining: false,
                account: {
                    username: '',
                    pwd: ''
                },
                rules: {
                    username: [
                        {required: true, message: '请输入账号', trigger: 'blur'},
                    ],
                    pwd: [
                        {required: true, message: '请输入密码', trigger: 'blur'},
                    ]
                },
                checked: true
            };
        },
        methods: {
            inputSuccess(text) {
                console.log(text);
                console.log('account.username: '+this.account.username);
                console.log('account.pwd: '+this.account.pwd);
                return false;
            },
            inputError(text) {
                console.log(text);
                console.log('account.username: '+this.account.username);
                console.log('account.pwd: '+this.account.pwd);
                return false;
            },
            checkCode(){
                this.$refs.Verify.checkCode();
            }
        },
        components: {
            Verify
        }
    }
</script>


<style>
    body{
        background: #DFE9FB;
    }
    .login-container{
        width:350px;
        height: 100%;
        margin-top: 10%;
        margin-left: auto;
        margin-right: auto;

    }
    .title{
        text-align: center;
    }
</style>