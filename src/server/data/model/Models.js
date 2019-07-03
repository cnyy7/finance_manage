/*export */
class Member {
    constructor(name, sex, age, control, phone, account, savings, balances, borrowings, finances, id) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.control = control;
        this.phone = phone;
        this.account = account;
        this.savings = savings;
        this.balances = balances;
        this.borrowings = borrowings;
        this.finances = finances;
    }
}

class Account {
    constructor(name, pwd, type, members, savings, id) {
        this.id = id;
        this.name = name;
        this.pwd = pwd;
        this.type = type;
        this.members = members;
        this.savings = savings;
    }
}

class Saving {
    constructor(bankName, cardNumber, phone,
                beginTime, updateTime, member, account, id) {
        this.id = id;
        this.bankName = bankName;
        this.cardNumber = cardNumber;
        this.phone = phone;
        this.beginTime = beginTime;
        this.updateTime = updateTime;
        this.member = member;
        this.account = account;
    }
}

class Balance {
    constructor(type, datetime, money,
                transTo, transFrom, member, id) {

        this.id = id;
        this.type = type;
        this.datetime = datetime;
        this.money = money;
        this.transTo = transTo;
        this.transFrom = transFrom;
        this.member = member;
    }
}

class Borrowing {

    constructor(type, money, beginTime, updateTime,
                transTo, transToPhone, memos, member, id) {
        this.id = id;
        this.type = type;
        this.money = money;
        this.beginTime = beginTime;
        this.updateTime = updateTime;
        this.transTo = transTo;
        this.transToPhone = transToPhone;
        this.memos = memos;
        this.member = member;
    }
}

class Finance {

    constructor(name, type, money, beginTime, updateTime,
                memos, member, id) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.money = money;
        this.beginTime = beginTime;
        this.updateTime = updateTime;
        this.memos = memos;
        this.member = member;
    }
}

module.exports = {
    Member: Member,
    Account: Account,
    Saving: Saving,
    Balance: Balance,
    Borrowing: Borrowing,
    Finance: Finance,
};