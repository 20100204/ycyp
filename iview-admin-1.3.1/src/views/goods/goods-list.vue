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
                    <Input v-model="searchConName1"     placeholder="请输入商品标题搜搜..."
                           style="width: 200px"/>
                    <Input v-model="searchConName2"    placeholder="请输入barcode搜搜..."
                           style="width: 200px"/>
                    <Input v-model="searchConName3"     placeholder="请输入bn搜搜..."
                           style="width: 200px"/>
                    <span @click="handleSearch1" style="margin: 0 10px;"><Button type="primary"
                                                                                 icon="search">搜索</Button></span>
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
    import * as table from './data/goodslist';
    export default {
        name: 'searchable-table-goods-list',
        data () {
            return {
                searchConName1: '',
                searchConName2: '',
                searchConName3: '',
                columns1: [],
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
            }
        },
        mounted () {
            this.init();
            this.columns1=[
                {
                    key: 'barcode',
                    title: 'barcode'
                },
                {
                    key: 'bn',
                    title: 'bn'
                },
                {
                    key: 'title',
                    title: '商品标题'
                },
                {
                    key: 'item_id',
                    title: 'item_id'
                },
                {
                    key:'MOQ',
                    title:'最小起订量'
                },
                {
                    key:'packing_qty',
                    title:'箱包装数量'
                },
                {
                    key:'packing_unit',
                    title:'箱包装单位'
                },
                {
                    key:'is_whole',
                    title:'散卖'
                },
                {
                    key:'price',
                    title:'价格'
                },
                {
                    key:'supplier_id',
                    title:'供应商'
                },
                {
                    key:'attr_id',
                    title:'属性名称'
                },
                {
                    key:'attr_val',
                    title:'属性值'
                },
                {
                    key:'operation',
                    title:'操作',
                    render: (h, params) => {
                        return h('a', {
                            props: {
                                type: 'text',
                                size: 'small'
                            },
                            on: {
                                click: () => {
                                    let query = {sku_id: params.row.item_id};
                                    this.$router.push({
                                        name: 'goodsedit',
                                        query: query
                                    });
                                }
                            }
                        }, '编辑');
                    }
                }
            ];
        }
    };
</script>