import express from 'express'
import path from 'path'
import favicon from 'serve-favicon'
import logger from 'morgan'
import bodyParser from 'body-parser'
import webpack from 'webpack'
import "reflect-metadata";
// 引入history模块
import history from 'connect-history-api-fallback'
import {Account, Member, Saving, Finance, Borrowing, Balance} from './data/model/Models'

import {createConnection, getRepository} from 'typeorm'
import sha256 from 'crypto-js/sha256';

const SALT = 'c@QSK2*fpav939#F';
// 正式环境时，下面两个模块不需要引入
import webpackDevMiddleware from 'webpack-dev-middleware'
import webpackHotMiddleware from 'webpack-hot-middleware'

import config from '../../build/webpack.dev.conf'

function toJSON(data = {}, message = '', status = '', code = '') {
    return Object(JSON.stringify({
        data,
        message,
        status,
        code
    }))
}

var AccountRepository, MemberRepository, SavingRepository, BalanceRepository, BorrowingRepository, FinanceRepository;
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
        require("./data/entity/BalanceSchema"),
        require("./data/entity/BorrowingSchema"),
        require("./data/entity/FinanceSchema"),
    ], // 引入实体
    synchronize: true,
}).then(async (connection) => {
    // let account = new Account('fafsddsdsssdfas', 'fasd', 'adsf');
    AccountRepository = getRepository(Account);
    MemberRepository = getRepository(Member);
    SavingRepository = getRepository(Saving);
    BalanceRepository = getRepository(Balance);
    BorrowingRepository = getRepository(Borrowing);
    FinanceRepository = getRepository(Finance);
    // // let account1 = await accountRepository.find({ select: ["id"],where:{name:"fafsdssdfas"}});
    // let account = await AccountRepository.find({
    //     where: {name: "fafsddsdsssdfas"},
    //     relations: ["members"]
    // });
    // console.log('account:' + JSON.stringify(account, null, 2));
    // let member = await MemberRepository.find({
    //     where: {name: 'fasaffdssdad1'},
    //     relations: ["account", "savings"]
    // });
    // console.log('member:' + JSON.stringify(member, null, 2));
    // let saving = new Saving("fads", "fasdd", "adsdf", new Date(), new Date(), member[0], account[0]);
    // // let newsaving = await SavingRepository.save(saving);
    // let newsaving = await SavingRepository.find({
    //     where: {bankName: 'fads'},
    //     relations: ["member"]
    // });
    // console.log("newsaving: " + JSON.stringify(newsaving, null, 2));
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

app.post('/api/login', async function (req, res) {
    let accounts = await AccountRepository.find({
        where: {name: req.body.name},
        // relations: ["members"]
    });

    if (accounts.length !== 0 && accounts[0].pwd === sha256(req.body.pwd + SALT).toString()) {
        accounts[0].pwd = accounts[0].pwd.substring(0, 1);
        res.json(accounts[0]);
    } else {
        res.status(203).end();
    }
    // res.json(toJSON(account, 'success'));
});

app.post('/api/register', async function (req, res) {
    let account = new Account(req.body.name, sha256(req.body.pwd + SALT)
        .toString(), 'normal');
    AccountRepository.save(account)
                     .then(() => {
                         res.status(200)
                            .end();
                     })
                     .catch((err) => {
                         console.log('error ==> ' + err);
                         res.status(203)
                            .end();
                     });
    // res.json(toJSON(account, 'success'));
});

app.post('/api/changepwd', async function (req, res) {
    // console.log(JSON.stringify(req.body,null,2));
    let account = new Account(undefined, sha256(req.body.pwd + SALT)
        .toString(), undefined, undefined, undefined, req.body.id);
    AccountRepository.save(account)
                     .then(() => {
                         res.status(200)
                            .end();
                     })
                     .catch((err) => {
                         console.log('error ==> ' + err);
                         res.status(203)
                            .end();
                     });
    // res.json(toJSON(account, 'success'));
});

app.post('/api/logout', function (req, res) {
    res.status(200).end();
});
app.post('/api/getMembers', async function (req, res) {
    console.log("req.body.accountId:" + req.body.accountId);
    let members = await MemberRepository.find({
        account: {id: req.body.accountId}
    });
    // console.log(JSON.stringify(members, null, 2));
    res.json(members);
});
app.post('/api/saveMember', async function (req, res) {
    // console.log(JSON.stringify(req.body.member, null, 2));
    MemberRepository.save(req.body.member).then((data) => {
        res.json(data);
    }).catch((err) => {
        console.log('error ==> ' + err);
        res.status(203).end();
    });
});
app.post('/api/removeMember', async function (req, res) {
    MemberRepository.remove(req.body.member).then(() => {
        res.status(200).end();
    }).catch((err) => {
        console.log('error ==> ' + err);
        res.status(203).end();
    });
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
