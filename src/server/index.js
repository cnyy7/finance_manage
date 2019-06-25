import express from 'express'
import path from 'path'
import favicon from 'serve-favicon'
import logger from 'morgan'
import bodyParser from 'body-parser'
import webpack from 'webpack'
import "reflect-metadata";
// 引入history模块
import history from 'connect-history-api-fallback'
import {Account, Member, Saving} from './data/model/Models'

import {createConnection, getRepository} from 'typeorm'

// 正式环境时，下面两个模块不需要引入
import webpackDevMiddleware from 'webpack-dev-middleware'
import webpackHotMiddleware from 'webpack-hot-middleware'

import config from '../../build/webpack.dev.conf'

createConnection({
    type: 'mysql', // 数据库类型
    host: '127.0.0.1', // 数据库地址
    port: 3306, // 数据库端口号
    username: 'root', // 数据库用户名
    password: 'NLP666', // 密码
    database: 'finance', // 数据库名
    entities: [
        require("./data/entity/AccountSchema"),
        require("./data/entity/MemberSchema"),
        require("./data/entity/SavingSchema"),
    ], // 引入实体
    synchronize: true,
})
    .then(async (connection) => {
        // let account = new Account('fafsddsdsssdfas', 'fasd', 'adsf');
        const AccountRepository = getRepository(Account);
        const MemberRepository = getRepository(Member);
        const SavingRepository = getRepository(Saving);
        // let account1 = await accountRepository.find({ select: ["id"],where:{name:"fafsdssdfas"}});
        let account = await AccountRepository.find({
            where: {name: "fafsddsdsssdfas"},
            relations: ["members"]
        });
        console.log('account:' + JSON.stringify(account, null, 2));
        let member = await MemberRepository.find({
            where: {name: 'fasaffdssdad1'},
            relations: ["account", "savings"]
        });
        console.log('member:' + JSON.stringify(member, null, 2));
        let saving = new Saving("fads", "fasdd", "adsdf", new Date(), new Date(), member[0], account[0]);
        // let newsaving = await SavingRepository.save(saving);
        let newsaving = await SavingRepository.find({
            where: {bankName: 'fads'},
            relations: ["account", "member"]
        });
        console.log("newsaving: " + JSON.stringify(newsaving, null, 2));
        console.log('数据库连接成功');
        return true
    })
    .catch((error) => {
        console.log('应用启动失败');
        console.log(error);
        return false
    });
const app = express();

// 引入history模式让浏览器进行前端路由页面跳转
app.use(history());

// uncomment after placing your favicon in /public
app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static(path.join(__dirname, 'public')));

const compiler = webpack(config);
//webpack 中间件
app.use(webpackDevMiddleware(compiler, {
    publicPath: config.output.publicPath,
    stats: {colors: true}
}));

app.use(webpackHotMiddleware(compiler));

app.use(express.static(path.join(__dirname, 'views')));
app.use('/static', express.static('src/client/static'));
app.use('/static', express.static('src/server/static'));
app.get('/', function (req, res) {
    res.sendFile('./views/index.html')
});
// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error(req.full + ': Not Found');
    err.status = 404;
    next(err);
});

// error handler
app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    console.log(err);
    res.send(err.message);
});

// 设置监听端口
const SERVER_PORT = 4000;
app.listen(SERVER_PORT, () => {
    console.info(`服务已经启动，监听端口${SERVER_PORT}`);
});

export default app
