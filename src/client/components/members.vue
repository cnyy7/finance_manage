<template>
    <vxe-table
            ref="xTable"
            highlight-hover-row
            border
            resizable
            show-overflow
            height="540"
            :data.sync="members"
            :edit-config="{key: 'id', trigger: 'manual', mode: 'row',activeMethod: activeCellMethod}"
            @edit-disabled="editDisabledEvent">
        <vxe-table-column type="index" width="60"></vxe-table-column>
        <!--        <vxe-table-column prop="id" label="#" :edit-render="{name: 'input'}" :disabled="false"></vxe-table-column>-->
        <vxe-table-column prop="name" label="姓名" :edit-render="{name: 'input'}"></vxe-table-column>
        <vxe-table-column prop="sex" label="性别" :edit-render="{name: 'input'}"></vxe-table-column>
        <vxe-table-column prop="control" label="控制" :edit-render="{name: 'input'}"></vxe-table-column>
        <vxe-table-column prop="phone" label="电话" :edit-render="{name: 'input'}"></vxe-table-column>
        <vxe-table-column prop="age" label="年龄" :edit-render="{name: 'ElInputNumber', props: {max: 150, min: 0,size:'small'}}"></vxe-table-column>
        <vxe-table-column label="操作">
            <template v-slot="{ row }">
                <template v-if="$refs.xTable.hasActiveRow(row)">
                    <el-button @click="saveRowEvent(row)" type="warning" size="small">保存</el-button>
                    <el-button @click="cancelRowEvent(row)" type="info" size="small">取消</el-button>
                </template>
                <template v-else>
                    <el-button @click="editRowEvent(row)" type="primary" size="small">编辑</el-button>
                    <el-button @click="removeRowEvent(row)" type="danger" size="small">删除</el-button>
                </template>
            </template>
        </vxe-table-column>
    </vxe-table>
</template>
<script>
    import {mapState} from "vuex";

    export default {
        data() {
            return {
                tableData: this.$store.state.members,
            }
        },
        created() {
            // this.$axios.post('/api/getMembers', {
            //     accountId: this.account.id
            // }).then((data) => {
            //     this.$store.commit('setMembers',data.data);
            // })
            this.$store.commit('setMembers', this.$store.state.account.members);
        },
        methods: {
            activeCellMethod({column, columnIndex}) {
                return columnIndex !== 1
            },
            editRowEvent(row) {
                this.$refs.xTable.setActiveRow(row)
            },
            removeRowEvent(row) {
                this.$refs.xTable.setActiveRow(row)
            },
            saveRowEvent(row) {
                this.$XMsg.alert(JSON.stringify(row, null, 2));
                this.$axios.post('/api/getMembers', {
                    member: row,
                    accountId: this.account.id,
                }).then((data) => {
                    this.$store.commit('setMembers', data.data);
                });
                this.cancelRowEvent()
            },
            cancelRowEvent(row) {
                this.$refs.xTable.revert(row);
                this.$refs.xTable.clearActived();
            },
            editDisabledEvent({row, column}) {
                this.$message({
                    showClose: true,
                    message: '禁止编辑',
                    type: 'waring'
                });
            }
        },
        computed: mapState([
            // 映射 this.account 为 store.state.account
            'account',
            'members',
        ])
    }
</script>
<style>

</style>


