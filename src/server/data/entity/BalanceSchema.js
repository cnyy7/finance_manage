const EntitySchema = require("typeorm").EntitySchema;
const Balance = require("../model/Models").Balance;
module.exports = new EntitySchema({
    name: "Balance",
    target: Balance,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true
        },
        type: {
            type: "varchar",
        },
        datetime: {
            type: "datetime",
        },
        money: {
            type: "double",
        },
        transFrom: {
            type: "varchar",
        },
        transTo: {
            type: "varchar",
        }
    },
    relations: {
        member: {
            type: 'many-to-one',
            target: 'Member',
            joinColumn: true,
            nullable: false,
            inverseSide: 'balances',
        }
    }
});