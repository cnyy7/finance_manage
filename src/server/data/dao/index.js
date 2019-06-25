const createConnection= require("typeorm").createConnection;
const getRepository= require("typeorm").getRepository;
const Account = require("../model/Models").Account;
const Member = require("../model/Models").Member;
const Saving = require("../model/Models").Saving;
const Balance = require("../model/Models").Balance;
createConnection({
    type: 'mysql', // 数据库类型
    host: '127.0.0.1', // 数据库地址
    port: 3306, // 数据库端口号
    username: 'root', // 数据库用户名
    password: 'NLP666', // 密码
    database: 'finance', // 数据库名
    entities: [
        require("../entity/AccountSchema"),
        require("../entity/MemberSchema"),
        require("../entity/SavingSchema"),
        require("../entity/BalanceSchema"),
    ], // 引入实体
    synchronize: true,
})
    .then(async (connection) => {

        // let account = new Account('fafsddsdsssdfas', 'fasd', 'adsf');
        const AccountRepository = getRepository(Account);
        const MemberRepository = getRepository(Member);
        const SavingRepository = getRepository(Saving);
        const BalanceRepository = getRepository(Balance);
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
        let balance=new Balance('afs',new Date(),2.3,'fsa','fasdf',member[0]);
        let newbalance= await BalanceRepository.save(balance);
        console.log("newbalance: " + JSON.stringify(newbalance, null, 2));
        return true
    })
    .catch((error) => {
        console.log('应用启动失败');
        console.log(error);
        return false
    });