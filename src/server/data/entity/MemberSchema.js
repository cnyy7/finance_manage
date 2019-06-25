const EntitySchema = require("typeorm").EntitySchema;
const Member = require("../model/Models").Member;
module.exports = new EntitySchema({
    name: "Member",
    target: Member,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true
        },
        name: {
            type: "varchar",
        },
        sex: {
            type: "varchar",
        },
        control: {
            type: "varchar",
        },
        phone: {
            type: "varchar",
        },
        age: {
            type: "int",
        },
    },
    relations: {
        account: {
            type: 'many-to-one',
            target: 'Account',
            joinColumn: true,
            nullable:false,
            inverseSide: 'members',
        }
    }
});