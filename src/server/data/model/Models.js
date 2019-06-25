/*export */
class Member {
    constructor(name, sex, age,control,phone,account,id) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.control = control;
        this.phone = phone;
        this.account = account;
    }
}

class Account {
    constructor(name, pwd, type,members,id) {
        this.id = id;
        this.name = name;
        this.pwd = pwd;
        this.type = type;
        this.members = members;
    }
}

module.exports = {
    Member: Member,
    Account: Account
};