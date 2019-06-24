/*export */
class Member {
    constructor(username, pwd, userType,id) {
        this.id = id;
        this.username = username;
        this.pwd = pwd;
        this.userType = userType;
    }
}

module.exports = {
    Member: Member
};
