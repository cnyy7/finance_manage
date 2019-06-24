/*export */
class Account {
    constructor(username, pwd, userType,userId) {
        this.userId = userId;
        this.username = username;
        this.pwd = pwd;
        this.userType = userType;
    }
}

module.exports = {
    Account: Account
};
