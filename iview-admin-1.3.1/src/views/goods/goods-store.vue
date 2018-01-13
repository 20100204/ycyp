<style lang="less">
    @import '../../styles/common.less';
    @import './components/table.less';
</style>
<template>
    <div>
        <Row :gutter="10">

            <Col span="100">
            <Card>
                <Row>
                    <Input v-model="searchConName2" placeholder="请输入商品标题搜搜..."
                           style="width: 200px"/>
                    <Input v-model="searchConName2" placeholder="请输入barcode搜搜..."
                           style="width: 200px"/>
                    <span @click="handleSearch1" style="margin: 0 10px;">
                        <Button type="primary"
                                icon="search">搜索
                        </Button>
                    </span>
                </Row>

                <Row class="margin-top-10 searchable-table-con1">
                    <Table :columns="columns1" :data="data1"></Table>
                </Row>
            </Card>
            </Col>

        </Row>
    </div>
</template>

<script>
    import * as table from './data/search';
    export default {
        name: 'searchable-table-goods',
        data () {
            return {
                searchConName1: '',
                searchConName2: '',
                searchConName3: '',
                columns1: table.columns1,
                data1: [],
                initTable1: []
            };
        },
        methods: {
            init () {
                this.data1 = this.initTable1 = table.searchTable1;
            },
            handleSearch1 () {
                this.data1 = this.initTable1;
     // this.data1 = this.search(this.data1, {name: this.searchConName1});
            }
        },
        mounted () {
            this.init();
        }
    };
</script>