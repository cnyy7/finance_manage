const EntitySchema = require("typeorm").EntitySchema;
const Borrowing = require("../model/Models").Borrowing;
module.exports = new EntitySchema({
    name: "Borrowing",
    target: Borrowing,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true
        },type: {
            type: "varchar",
        },money: {
            type: "double",
        },beginTime: {
            type: "datetime",
        },updateTime: {
            type: "datetime",
        },transTo: {
            type: "varchar",
        },transToPhone: {
            type: "varchar",
        },memos: {
            type: "text",
        }
    },
    relations: {
        member: {
            type: 'many-to-one',
            target: 'Member',
            joinColumn: true,
            nullable: false,
            inverseSide: 'borrowings',
        }
    },
});