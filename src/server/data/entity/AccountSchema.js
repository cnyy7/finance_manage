const EntitySchema = require("typeorm").EntitySchema;
const Account = require("../model/Account").Account;
module.exports = new EntitySchema({
    name: "Account",
    target: Account,
    columns: {
        userId: {
            primary: true,
            type: "int",
            generated: true
        },
        username: {
            type: "varchar",
            unique: true,
        },
        pwd: {
            type: "varchar",
        },
        userType: {
            type: "varchar",
        },
    }
    ,
    // relations: {
    //     categories: {
    //         target: "Category",
    //         type: "many-to-many",
    //         joinTable: true,
    //         cascade: true
    //     }
    // }
});