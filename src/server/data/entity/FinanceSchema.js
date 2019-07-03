const EntitySchema = require("typeorm").EntitySchema;
const Finance = require("../model/Models").Finance;
module.exports = new EntitySchema({
    name: "Finance",
    target: Finance,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true
        },
        name: {
            type: "varchar",
        },
        type: {
            type: "varchar",
        },
        money: {
            type: "double",
        },
        beginTime: {
            type: "datetime",
        },
        updateTime: {
            type: "datetime",
        },
        memos: {
            type: "text",
            nullable: true,
        }
    },
    relations: {
        member: {
            type: 'many-to-one',
            target: 'Member',
            joinColumn: true,
            nullable: false,
            inverseSide: 'finances',
        }
    },
});