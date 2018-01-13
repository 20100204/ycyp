<style lang="less">
    @import '../../styles/common.less';
    @import './article-publish.less';
    @import './upload.less';

</style>
<template>
    <div>
        <Row>
            <Col span="100">
            <Card>
                <Form :label-width="80">
                    <FormItem label="商品标题" :error="articleError">
                        <Input v-model="articleTitle" @on-blur="handleArticletitleBlur" icon="android-list" style="width:600px;"/>
                    </FormItem>
                    <FormItem label="生产日期" :error="articleError">
                        <DatePicker type="date" placeholder="请选择日期" style="width: 200px"></DatePicker>
                    </FormItem>

                    <FormItem label="箱包装数量" :error="articleError">
                        <Input  placeholder="请填箱包装数量" style="width: 200px" />
                    </FormItem>
                    <FormItem label="箱包装单位" :error="articleError">
                        <Input   placeholder="请填箱包装单位" style="width: 200px" />
                    </FormItem>
                    <FormItem label="最小销售包装单位" :error="articleError">
                        <Input   placeholder="请填最小销售包装单位" style="width: 200px" />
                    </FormItem>
                    <FormItem label="barcode" :error="articleError">
                        <Input   placeholder="请填barcode" style="width: 200px" />
                    </FormItem>
                    <FormItem label="MOQ" :error="articleError">
                        <Input   placeholder="请填最小起订量" style="width: 200px" />
                    </FormItem>
                    <FormItem label="价格" :error="articleError">

                        <InputNumber placeholder="请填售价" :max="10000" :min="0.1" :step="0.1" v-model="value2"></InputNumber>
                    </FormItem>
                    <FormItem label="供应商" :error="articleError">
                        <Select v-model="model9" style="width:200px" placeholder="请选择供应商">
                        </Select>
                    </FormItem>
                    <FormItem label="是否散卖" :error="articleError">
                        <Switch v-model="switch1"  ></Switch>
                    </FormItem>
                    <FormItem label="图片" :error="articleError">
                        <div class="height-492px">
                            <Col span="4">
                            <Card>
                                <Upload
                                        ref="upload"
                                        :show-upload-list="false"
                                        :default-file-list="defaultList"
                                        :on-success="handleSuccess2"
                                        :format="['jpg','jpeg','png']"
                                        :max-size="2048"
                                        :on-format-error="handleFormatError2"
                                        :on-exceeded-size="handleMaxSize"
                                        :before-upload="handleBeforeUpload2"
                                        multiple
                                        type="drag"
                                        action="//jsonplaceholder.typicode.com/posts/"
                                        style="display: inline-block;width:58px;">
                                    <div style="width: 58px;height:58px;line-height: 58px;">
                                        <Icon type="camera" size="20"></Icon>
                                    </div>
                                </Upload>
                                <Modal title="查看图片" v-model="visible">
                                    <img :src="'https://o5wwk8baw.qnssl.com/' + imgName + '/large'" v-if="visible" style="width: 100%">
                                </Modal>
                            </Card>
                            </Col>
                            <Col span="20" class="padding-left-10">
                            <Card>
                                <div class="height-400px">
                                    <div class="admin-upload-list" v-for="item in uploadList" :key="item.url">
                                        <template v-if="item.status === 'finished'">
                                            <img :src="item.url">
                                            <div class="admin-upload-list-cover">
                                                <Icon type="ios-eye-outline" @click.native="handleView(item.name)"></Icon>
                                                <Icon type="ios-trash-outline" @click.native="handleRemove(item)"></Icon>
                                            </div>
                                        </template>
                                        <template v-else>
                                            <Progress v-if="item.showProgress" :percent="item.percentage" hide-info></Progress>
                                        </template>
                                    </div>
                                </div>
                            </Card>
                            </Col>
                        </div>
                    </FormItem>
                    <FormItem label="">
                        <Button :disabled="hasSubmit" @click="handleSubmit" style="width:100px;position:relative;top:-310px" type="primary">提交</Button>
                    </FormItem>
                </Form>
            </Card>
            </Col>



        </Row>
    </div>
</template>
<script>
    import tinymce from 'tinymce';

    export default {
        mounted () {
            this.uploadList = this.$refs.upload.fileList;
        },
        name: 'artical-publish',
        data () {
            return {
                defaultList: [
                    {
                        'name': 'a42bdcc1178e62b4694c830f028db5c0',
                        'url': 'https://o5wwk8baw.qnssl.com/a42bdcc1178e62b4694c830f028db5c0/avatar'
                    },
                    {
                        'name': 'bc7521e033abdd1e92222d733590f104',
                        'url': 'https://o5wwk8baw.qnssl.com/bc7521e033abdd1e92222d733590f104/avatar'
                    }
                ],
                imgName: '',
                visible: false,
                uploadList: [],
                value2:0,
                switch1:false,
                model9:1,
                articleTitle: '',
                articleError: '',
                showLink: false,
                fixedLink: '',
                articlePath: '',
                articlePathHasEdited: false,
                editLink: false,
                editPathButtonType: 'ghost',
                editPathButtonText: '编辑',
                articleStateList: [{value: '草稿'}, {value: '等待复审'}],
                editOpenness: false,
                Openness: '公开',
                currentOpenness: '公开',
                topArticle: false,
                publishTime: '',
                publishTimeType: 'immediately',
                editPublishTime: false, // 是否正在编辑发布时间
                articleTagSelected: [], // 文章选中的标签
                articleTagList: [], // 所有标签列表
                classificationList: [],
                classificationSelected: [], // 在所有分类目录中选中的目录数组
                offenUsedClass: [],
                offenUsedClassSelected: [], // 常用目录选中的目录
                classificationFinalSelected: [], // 最后实际选择的目录
                publishLoading: false,
                addingNewTag: false, // 添加新标签
                newTagName: '' // 新建标签名
            };
        },
        methods: {
            handleFormatError (file) {
                this.$Notice.warning({
                    title: '文件格式不正确',
                    desc: '文件 ' + file.name + ' 格式不正确，请选择图片文件。'
                });
            },
            handleBeforeUpload (file) {
                this.$Notice.warning({
                    title: '文件准备上传',
                    desc: '文件 ' + file.name + ' 准备上传。'
                });
            },
            handleProgress (event, file) {
                this.$Notice.info({
                    title: '文件正在上传',
                    desc: '文件 ' + file.name + ' 正在上传。'
                });
            },
            handleSuccess (evnet, file) {
                this.$Notice.success({
                    title: '文件上传成功',
                    desc: '文件 ' + file.name + ' 上传成功。'
                });
            },
            handleError (event, file) {
                this.$Notice.error({
                    title: '文件上传成功',
                    desc: '文件 ' + file.name + ' 上传失败。'
                });
            },
            handleView (name) {
                this.imgName = name;
                this.visible = true;
            },
            handleRemove (file) {
                // 从 upload 实例删除数据
                const fileList = this.$refs.upload.fileList;
                this.$refs.upload.fileList.splice(fileList.indexOf(file), 1);
            },
            handleSuccess2 (res, file) {
                // 因为上传过程为实例，这里模拟添加 url
                file.url = 'https://o5wwk8baw.qnssl.com/7eb99afb9d5f317c912f08b5212fd69a/avatar';
                file.name = '7eb99afb9d5f317c912f08b5212fd69a';
            },
            handleFormatError2 (file) {
                this.$Notice.warning({
                    title: '文件格式不正确',
                    desc: '文件 ' + file.name + ' 格式不正确，请上传 jpg 或 png 格式的图片。'
                });
            },
            handleMaxSize (file) {
                this.$Notice.warning({
                    title: '超出文件大小限制',
                    desc: '文件 ' + file.name + ' 太大，不能超过 2M。'
                });
            },
            handleBeforeUpload2 () {
                const check = this.uploadList.length < 5;
                if (!check) {
                    this.$Notice.warning({
                        title: '最多只能上传 5 张图片。'
                    });
                }
                return check;
            },
            renderFormat (label) {
                return label.join(' => ');
            },
            handleArticletitleBlur () {
                if (this.articleTitle.length !== 0) {
                    // this.articleError = '';
                    localStorage.articleTitle = this.articleTitle; // 本地存储文章标题
                    if (!this.articlePathHasEdited) {
                        let date = new Date();
                        let year = date.getFullYear();
                        let month = date.getMonth() + 1;
                        let day = date.getDate();
                        this.fixedLink = window.location.host + '/' + year + '/' + month + '/' + day + '/';
                        this.articlePath = this.articleTitle;
                        this.articlePathHasEdited = true;
                        this.showLink = true;
                    }
                } else {
                    // this.articleError = '文章标题不可为空哦';
                    this.$Message.error('文章标题不可为空哦');
                }
            },
            editArticlePath () {
                this.editLink = !this.editLink;
                this.editPathButtonType = this.editPathButtonType === 'ghost' ? 'success' : 'ghost';
                this.editPathButtonText = this.editPathButtonText === '编辑' ? '完成' : '编辑';
            },
            handleEditOpenness () {
                this.editOpenness = !this.editOpenness;
            },
            handleSaveOpenness () {
                this.Openness = this.currentOpenness;
                this.editOpenness = false;
            },
            cancelEditOpenness () {
                this.currentOpenness = this.Openness;
                this.editOpenness = false;
            },
            handleEditPublishTime () {
                this.editPublishTime = !this.editPublishTime;
            },
            handleSavePublishTime () {
                this.publishTimeType = 'timing';
                this.editPublishTime = false;
            },
            cancelEditPublishTime () {
                this.publishTimeType = 'immediately';
                this.editPublishTime = false;
            },
            setPublishTime (datetime) {
                this.publishTime = datetime;
            },
            setClassificationInAll (selectedArray) {
                this.classificationFinalSelected = selectedArray.map(item => {
                    return item.title;
                });
                localStorage.classificationSelected = JSON.stringify(this.classificationFinalSelected); // 本地存储所选目录列表
            },
            setClassificationInOffen (selectedArray) {
                this.classificationFinalSelected = selectedArray;
            },
            handleAddNewTag () {
                this.addingNewTag = !this.addingNewTag;
            },
            createNewTag () {
                if (this.newTagName.length !== 0) {
                    this.articleTagList.push({value: this.newTagName});
                    this.addingNewTag = false;
                    setTimeout(() => {
                        this.newTagName = '';
                    }, 200);
                } else {
                    this.$Message.error('请输入标签名');
                }
            },
            cancelCreateNewTag () {
                this.newTagName = '';
                this.addingNewTag = false;
            },
            canPublish () {
                if (this.articleTitle.length === 0) {
                    this.$Message.error('请输入文章标题');
                    return false;
                } else {
                    return true;
                }
            },
            handlePreview () {
                if (this.canPublish()) {
                    if (this.publishTimeType === 'immediately') {
                        let date = new Date();
                        let year = date.getFullYear();
                        let month = date.getMonth() + 1;
                        let day = date.getDate();
                        let hour = date.getHours();
                        let minute = date.getMinutes();
                        let second = date.getSeconds();
                        localStorage.publishTime = year + ' 年 ' + month + ' 月 ' + day + ' 日 -- ' + hour + ' : ' + minute + ' : ' + second;
                    } else {
                        localStorage.publishTime = this.publishTime; // 本地存储发布时间
                    }
                    localStorage.content = tinymce.activeEditor.getContent();
                    this.$router.push({
                        name: 'preview'
                    });
                }
            },
            handleSaveDraft () {
                if (!this.canPublish()) {
                    //
                }
            },
            handlePublish () {
                if (this.canPublish()) {
                    this.publishLoading = true;
                    setTimeout(() => {
                        this.publishLoading = false;
                        this.$Notice.success({
                            title: '保存成功',
                            desc: '文章《' + this.articleTitle + '》保存成功'
                        });
                    }, 1000);
                }
            },
            handleSelectTag () {
                localStorage.tagsList = JSON.stringify(this.articleTagSelected); // 本地存储文章标签列表
            }
        },

        computed: {
            completeUrl () {
                let finalUrl = this.fixedLink + this.articlePath;
                localStorage.finalUrl = finalUrl; // 本地存储完整文章路径
                return finalUrl;
            }
        },
        mounted () {
            this.articleTagList = [
                {value: 'vue'},
                {value: 'iview'},
                {value: 'ES6'},
                {value: 'webpack'},
                {value: 'babel'},
                {value: 'eslint'}
            ];
            this.classificationList = [
                {
                    title: 'Vue实例',
                    expand: true,
                    children: [
                        {
                            title: '数据与方法',
                            expand: true
                        },
                        {
                            title: '生命周期',
                            expand: true
                        }
                    ]
                },
                {
                    title: 'Class与Style绑定',
                    expand: true,
                    children: [
                        {
                            title: '绑定HTML class',
                            expand: true,
                            children: [
                                {
                                    title: '对象语法',
                                    expand: true
                                },
                                {
                                    title: '数组语法',
                                    expand: true
                                },
                                {
                                    title: '用在组件上',
                                    expand: true
                                }
                            ]
                        },
                        {
                            title: '生命周期',
                            expand: true
                        }
                    ]
                },
                {
                    title: '模板语法',
                    expand: true,
                    children: [
                        {
                            title: '插值',
                            expand: true
                        },
                        {
                            title: '指令',
                            expand: true
                        },
                        {
                            title: '缩写',
                            expand: true
                        }
                    ]
                }
            ];
            this.offenUsedClass = [
                {
                    title: 'vue实例'
                },
                {
                    title: '生命周期'
                },
                {
                    title: '模板语法'
                },
                {
                    title: '插值'
                },
                {
                    title: '缩写'
                }
            ];
            tinymce.init({
                selector: '#articleEditor',
                branding: false,
                elementpath: false,
                height: 600,
                language: 'zh_CN.GB2312',
                menubar: 'edit insert view format table tools',
                theme: 'modern',
                plugins: [
                    'advlist autolink lists link image charmap print preview hr anchor pagebreak imagetools',
                    'searchreplace visualblocks visualchars code fullscreen fullpage',
                    'insertdatetime media nonbreaking save table contextmenu directionality',
                    'emoticons paste textcolor colorpicker textpattern imagetools codesample'
                ],
                toolbar1: ' newnote print fullscreen preview | undo redo | insert | styleselect | forecolor backcolor bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image emoticons media codesample',
                autosave_interval: '20s',
                image_advtab: true,
                table_default_styles: {
                    width: '100%',
                    borderCollapse: 'collapse'
                }
            });
        },

    };
</script>