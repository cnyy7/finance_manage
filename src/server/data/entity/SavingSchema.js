const EntitySchema = require("typeorm").EntitySchema;
const Saving = require("../model/Models").Saving;
module.exports = new EntitySchema({
    name: "Saving",
    target: Saving,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true
        },
        bankName: {
            type: "varchar",
        },
        cardNumber: {
            type: "varchar",
            unique: true,
        },
        phone: {
            type: "varchar",
        },
        beginTime: {
            type: "datetime",
        },
        updateTime: {
            type: "datetime",
        },
    },
    relations: {
        member: {
            type: 'many-to-one',
            target: 'Member',
            joinColumn: true,
            nullable: false,
            inverseSide: 'savings',
        },
        // account: {
        //     type: 'many-to-one',
        //     target: 'Account',
        //     joinColumn: true,
        //     nullable: false,
        //     inverseSide: 'savings',
        // }
    },
});