<template>
    <el-form ref="RegisterFrom" :model="account" :rules="rules" label-position="left" label-width="0px"
             class="demo-ruleForm login-container">
        <h3 class="title">请注册{{project_name}}</h3>
        <el-form-item prop="username">
            <el-input type="text" v-model="account.username" auto-complete="off" placeholder="账号"
                      prefix-icon="el-icon-user" clearable></el-input>
        </el-form-item>
        <el-form-item prop="pwd">
            <el-input type="password" v-model="account.pwd" auto-complete="off" placeholder="密码"
                      prefix-icon="el-icon-lock" clearable show-password></el-input>
        </el-form-item>
        <el-form-item prop="pwd2">
            <el-input type="password" v-model="account.pwd2" auto-complete="off" placeholder="重新输入密码"
                      prefix-icon="el-icon-lock" clearable show-password></el-input>
        </el-form-item>
        <Verify @success="inputSuccess('success')" @error="inputError('error')" :type="1" :show-button="false"
                ref="VerifyRegister"></Verify>
        <!--        <el-checkbox v-model="checked" checked class="remember">记住密码</el-checkbox>-->
        <el-form-item>
            <el-button @click="checkCode()" type="primary" style="width:100%;">注册</el-button>
        </el-form-item>
        <el-link href="/login"><strong>已有账号？点此登陆</strong><i class="el-icon-document el-icon--right"></i></el-link>

    </el-form>
</template>

<script>
    import Verify from 'vue2-verify'

    export default {
        name: 'register',
        data() {
            var validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.account.pwd) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            return {
                project_name: '财务管理系统',
                logining: false,
                account: {
                    username: '',
                    pwd: '',
                    pwd2: '',
                },
                rules: {
                    username: [
                        {
                            required: true,
                            message: '请输入账号',
                            trigger: ['blur', 'change']
                        },
                    ],
                    pwd: [
                        {
                            required: true,
                            message: '请输入密码',
                            trigger: ['blur', 'change']
                        },
                    ],
                    pwd2: [
                        {
                            required: true,
                            validator: validatePass2,
                            trigger: ['blur', 'change']
                        },
                    ]
                },
                checked: true
            };
        },
        methods: {
            inputSuccess(text) {
                this.$refs.RegisterFrom.validate((valid) => {
                    if (valid) {

                        this.logining = true;
                        var registerParams = { name: this.account.username, pwd: this.account.pwd };
                        this.$axios.post('/api/register',registerParams).then((data)=>{
                            alert(JSON.stringify(data,null,2));
                            console.log(JSON.stringify(data,null,2));
                            // this.$router.replace('/home');
                            if (data.status===200)
                            {
                                this.$router.push('/login');
                                return true;
                            }else{
                                alert("用户名已被使用，请重新输入");
                                this.logining=false;
                                this.$refs.RegisterFrom.resetFields();
                                this.$refs.VerifyRegister.refresh();
                                return false;
                            }
                        })
                    } else {
                        alert('error submit!!');
                        console.log('error submit!!');
                        return false;
                    }
                });
                alert('1username: '+this.account.username+'\npwd: '+this.account.pwd+'\npwd2: '+this.account.pwd2);
                console.log(text);
                console.log('account.username: '+this.account.username);
                console.log('account.pwd: '+this.account.pwd);
                console.log('account.pwd2: '+this.account.pwd2);
                return false;
            },
            inputError(text) {
                alert("验证码错误！请重新输入");
                console.log(text);
                console.log('account.username: '+this.account.username);
                console.log('account.pwd: '+this.account.pwd);
                console.log('account.pwd2: '+this.account.pwd2);
                return false;
            },
            checkCode() {
                this.$refs.VerifyRegister.checkCode();
            }
        },
        components: {
            Verify
        }
    }
</script>


<style>
    body {
        background: #DFE9FB;
    }

    .login-container {
        width: 350px;
        height: 100%;
        margin-top: 10%;
        margin-left: auto;
        margin-right: auto;

    }

    .title {
        text-align: center;
    }

    .el-form-item {
        width: 100%;
        margin-top: 17px;
        margin-bottom: 15px
    }
</style>