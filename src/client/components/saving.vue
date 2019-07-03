<template>
    <div>
        <el-button @click="insertRowEvent" type="primary" style="margin-bottom: 5px">
            添加新记录
        </el-button>
        <el-button @click="$refs.xTable.exportCsv({filename:'data'+new Date().toLocaleDateString()})" type="primary"
                   style="margin-bottom: 5px">
            导出数据
        </el-button>
        <vxe-table
                ref="xTable"
                highlight-hover-row
                border
                resizable
                show-overflow
                height="540"
                :loading="loading"
                :data.sync="savings"
                :edit-config="{key: 'id', trigger: 'manual', mode: 'row',activeMethod: activeCellMethod}"
                @edit-disabled="editDisabledEvent">
            <vxe-table-column type="index" width="60"></vxe-table-column>
            <!--            <vxe-table-column prop="id" label="#" :edit-render="{name: 'ElInput'}" :disabled="false"></vxe-table-column>-->
            <vxe-table-column field="bankName" title="银行名" sortable :edit-render="{name: 'ElInput'}"
                              :filters="[{data: ''}]"
                              :filter-render="{name: 'ElInput', props: {placeholder: '请输入姓名'}}"></vxe-table-column>
            <!--            <vxe-table-column prop="sex" label="性别" :edit-render="{name: 'ElInput'}"></vxe-table-column>-->
            <vxe-table-column field="member.id" title="持卡人" sortable
                              :edit-render="{name: 'ElSelect', options: membersList}"></vxe-table-column>
            <vxe-table-column field="cardNumber" title="银行卡号" sortable
                              :edit-render="{name: 'ElInput'}"></vxe-table-column>
            <vxe-table-column field="phone" title="电话" sortable :edit-render="{name: 'ElInput'}"></vxe-table-column>
            <vxe-table-column field="beginTime" title="办卡时间" sortable
                              :edit-render="{name: 'ElDatePicker', props: {type: 'datetime', format: 'yyyy-MM-dd HH:mm:ss'}}"></vxe-table-column>
            <vxe-table-column field="updateTime" title="更新时间" sortable
                              :edit-render="{name: 'ElDatePicker', props: {type: 'datetime', format: 'yyyy-MM-dd HH:mm:ss'}}"></vxe-table-column>
            <vxe-table-column title="操作">
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
    import {mapState, mapActions} from "vuex";

    export default {
        data() {
            return {
                loading: true,
            }
        },
        async created() {
            this.loading = true;
            let result = await this.loadData({path: this.$route.path});
            if (!result) {
                this.errorMessage("数据加载错误");
            } else {
                this.successMessage("数据加载成功");
            }
            this.loading = false;
        },
        methods: {
            ...mapActions([
                'loadData',
                'getType',
            ]),
            activeCellMethod({column, columnIndex}) {
                return columnIndex !== 1
            },
            insertRowEvent(row) {
                let newRow = {
                    updateTime: new Date(Date.now()),
                    beginTime: new Date(Date.now())
                };
                this.$refs.xTable.insert(newRow)
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
                this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(async () => {
                    this.loading = true;
                    let type = await this.getType(this.$route.path);
                    this.$axios.post('/api/remove/' + type, {
                        data: row,
                    }).then((data) => {
                        if (data.status === 200) {
                            this.$refs.xTable.remove(row);
                            this.successMessage("删除成功");
                        } else {
                            this.errorMessage("删除失败");
                        }
                        this.loading = false;
                    });
                }).catch(() => {
                    this.successMessage("已取消删除");
                    this.loading = false;
                });
                this.loading = false;
            },
            async saveRowEvent(row) {
                var isInsert = false;
                if (row.id === undefined) {
                    isInsert = true;
                }
                this.loading = true;
                row.account = this.$store.state.account;
                // alert(JSON.stringify(row, null, 2));
                let type = await this.getType(this.$route.path);
                this.$axios.post('/api/save/' + type, {
                    data: row,
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
                        this.$refs.xTable.clearActived();
                    } else {
                        this.$refs.xTable.revert(row);
                        if (isInsert) {
                            this.errorMessage("添加失败");
                        } else {
                            this.errorMessage("修改失败");
                        }
                    }
                    this.loading = false;
                });
                this.loading = false;
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

        },
        computed: mapState([
            // 映射 this.account 为 store.state.account
            'account',
            'savings',
            'membersList',
        ])
    }
</script>
<style>
    body {
        background: white;
    }
</style>


