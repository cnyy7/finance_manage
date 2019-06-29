<template>
    <div>
        <el-button @click="insertRowEvent" type="primary">插入新成员</el-button>
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
            <!--            <vxe-table-column prop="id" label="#" :edit-render="{name: 'input'}" :disabled="false"></vxe-table-column>-->
            <vxe-table-column prop="name" label="姓名" :edit-render="{name: 'input'}"></vxe-table-column>
            <vxe-table-column prop="sex" label="性别" :edit-render="{name: 'input'}"></vxe-table-column>
            <vxe-table-column prop="control" label="控制" :edit-render="{name: 'input'}"></vxe-table-column>
            <vxe-table-column prop="phone" label="电话" :edit-render="{name: 'input'}"></vxe-table-column>
            <vxe-table-column prop="age" label="年龄"
                              :edit-render="{name: 'ElInputNumber', props: {max: 150, min: 0,size:'small'}}"></vxe-table-column>
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
    </div>
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
            this.loadData();
        },
        methods: {
            activeCellMethod({column, columnIndex}) {
                return columnIndex !== 1
            },
            insertRowEvent(row) {
                let newMember = {};
                this.$refs.xTable.insert(newMember)
                    .then(({row}) => {
                        row.id = undefined;
                        this.$refs.xTable.setActiveRow(row)
                    });
                // alert(JSON.stringify(row,null,2));
            },
            editRowEvent(row) {
                this.$refs.xTable.setActiveRow(row)
            },
            removeRowEvent(row) {
                this.$axios.post('/api/removeMember', {
                    member: row,
                }).then((data) => {
                    if (data.status === 200) {
                        this.$refs.xTable.remove(row);
                        this.successMessage("删除成功");
                    } else {
                        this.errorMessage("删除失败");
                    }
                });

            },
            saveRowEvent(row) {
                row.account = this.$store.state.account;
                // alert(JSON.stringify(row, null, 2));
                var isInsert = false;
                if (row.id === undefined) {
                    isInsert = true;
                }
                this.$axios.post('/api/saveMember', {
                    member: row,
                }).then((data) => {
                    if (data.status === 200) {
                        // alert(JSON.stringify(data, null, 2));
                        // console.log(JSON.stringify(data, null, 2));
                        if (isInsert) {
                            row.id = data.data.id;
                            this.successMessage("添加成功");
                        } else {
                            this.successMessage("修改成功");
                        }

                    } else {
                        this.$refs.xTable.revert(row);
                        if (isInsert) {
                            this.successMessage("添加失败");
                        } else {
                            this.successMessage("修改失败");
                        }
                    }
                });
                // if (isInsert) {
                //     this.loadData();
                // }
                // this.$axios.post('/api/getMembers', {
                //     accountId: this.$store.state.account.id
                // }).then((data) => {
                //     this.$store.commit('setMembers',data.data);
                // });
                this.$refs.xTable.clearActived();
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
            },
            successMessage(message) {
                this.$message({
                    showClose: true,
                    message: message,
                    type: 'success'
                });
            },
            errorMessage(message) {
                this.$message({
                    showClose: true,
                    message: message,
                    type: 'error'
                });
            },
            loadData() {
                this.$axios.post('/api/getMembers', {
                    accountId: this.$store.state.account.id
                }).then((data) => {
                    this.$store.commit('setMembers', data.data);
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


