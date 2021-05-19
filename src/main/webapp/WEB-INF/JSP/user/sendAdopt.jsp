<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!doctype html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>流浪小动物领养平台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <%--    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/user_student/assets/i/favicon.png">--%>
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/x-icon"/>

    <link rel="icon" sizes="192x192"
          href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed"
          href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/app.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/template.css" media="all">
    <%--
        <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/amazeui.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/app.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">--%>


    <style>
        .button.gray {
            color: #8c96a0;
            text-shadow: 1px 1px 1px #fff;
            border: 1px solid #dce1e6;
            box-shadow: 0 1px 2px #fff inset, 0 -1px 0 #a8abae inset;
            background: -webkit-linear-gradient(top, #f2f3f7, #e4e8ec);
            background: -moz-linear-gradient(top, #f2f3f7, #e4e8ec);
            background: linear-gradient(top, #f2f3f7, #e4e8ec);
        }


        #bolt-container div {
            display: none;
        }

        .layui-form-label{
            width: 100px;
        }


    </style>
</head>

<body id="blog">
<div id="app">
    <header class="am-g am-g-fixed blog-fixed blog-text-center blog-header">
        <div class="am-u-sm-8 am-u-sm-centered">


            <span><img alt="流浪小动物领养平台" style="width: 400px;height: 80px;margin-top: -14px" alt="baidu"
                       src="/agreement_files/logo.png"></span>
        </div>
    </header>
    <hr>
    <!-- nav start -->
    <nav class="am-g am-g-fixed blog-fixed blog-nav">
        <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only blog-button"
                data-am-collapse="{target: '#blog-collapse'}"><span class="am-sr-only">导航切换</span> <span
                class="am-icon-bars"></span></button>

        <div class="am-collapse am-topbar-collapse" id="blog-collapse">
            <ul class="am-nav am-nav-pills am-topbar-nav">
                <li class=""><a href="/front">首页</a></li>
                <li><a href="/user/petList">领养中心</a></li>
                <li><a href="/user/toArticleList">文章动态</a></li>
                <li><a href="/user/toImages">宠图锦集</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a style="color: #10D07A" class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        个人领养管理 <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="/user/personalAdopt">查看领养申请</a></li>
                        <li><a href="/user/toSendAdopt">送养宠物</a></li>
                    </ul>
                </li>

                <li><a href="javascript:void (0);" @click="userlogout">退出登录</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        <img id="img1" src="${user_session.imgpath==null?'/img/headImg.gif':user_session.imgpath}"
                             style="width: 35px;height: 35px;border-radius: 30px" class="layui-nav-img">
                        <span id="span1">${user_session.realname==null?'未登录':user_session.realname}</span>
                        <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="javascript:void (0);" @click="toEditPersonal">完善个人信息</a></li>
                        <li><a href="javascript:void (0);" @click="toEditPersonal2">查看/修改个人信息</a></li>
                        <li><a href="javascript:void (0);" @click="toEditPassword">修改密码</a></li>
                    </ul>
                </li>
            </ul>
            <form class="am-topbar-form am-topbar-right am-form-inline" role="search">
                <div class="am-form-group">
                    <input type="text" class="am-form-field am-input-sm" placeholder="搜索" @input="searchFun"
                           v-model="content">
                </div>
            </form>
        </div>
    </nav>
    <hr>
    <!-- nav end -->
    <!-- banner start -->

    <!-- banner end -->

    <!-- content srart -->
    <div class="am-g am-g-fixed blog-fixed">
<%--        <div class="am-u-md-12 am-u-sm-12">--%>


            <div class="layui-fluid">
                <div class="layui-card">
                    <div class="layui-card-header">送养宠物</div>
                    <div class="layui-card-body" style="padding: 15px;">
                        <form class="layui-form" method="post" style="padding-left: 240px"
                              action="${pageContext.request.contextPath}/user/SendAdopt?id=${pet.id}"
                              lay-filter="component-form-group">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">宠物名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="petname" lay-verify="required" autocomplete="off"
                                               value="${pet.petname}"
                                               class="layui-input">
                                    </div>
                                </div>


                                <div class="layui-inline">
                                    <label class="layui-form-label">年龄/岁</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="age" lay-verify="required" autocomplete="off"
                                               value="${pet.age}"
                                               class="layui-input">
                                    </div>
                                </div>
                            </div>


                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">类别</label>
                                    <div class="layui-input-inline">

                                        <select name="categoryId" lay-verify="required" lay-filter="categoryId"
                                                id="categoryId">
                                            <option value="">请选择宠物类别</option>
                                            <c:forEach var="item" items="${categoryList}">

                                                <option value="${item.id}">${item.name}</option>

                                            </c:forEach>
                                        </select>


                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">品种</label>
                                    <div class="layui-input-inline">

                                        <select name="varietyId" lay-verify="required" lay-filter="varietyId"
                                                id="varietyId">
                                            <option value="">请先选择宠物类别</option>
                                            <c:forEach var="item" items="${varietyList}">

                                                <option value="${item.id}">${item.name}</option>

                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                            </div>

                            <div class="layui-form-item">
                                <div class="layui-inline" hidden>
                                    <label class="layui-form-label">领养状态</label>
                                    <div class="layui-input-inline">
                                        <select name="status">
                                            <option value="">请选择领养状态</option>
                                            <option value="0" selected>待领养</option>
                                            <option value="1">申请中</option>
                                            <option value="2">被领养</option>
                                        </select>
                                    </div>
                                </div>

                            </div>


                            <div class="layui-form-item">
                                <div class="layui-inline" hidden>
                                    <label class="layui-form-label">来源</label>
                                    <div class="layui-input-inline">
                                        <select name="source">
                                            <option value="">请选择宠物来源</option>
                                            <option value="0">流浪宠物</option>
                                            <option value="1" selected>送养宠物</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">疫苗情况</label>
                                    <div class="layui-input-inline">
                                        <select name="vaccine">
                                            <option value="">请选择疫苗接种情况</option>
                                            <option value="0">未接种</option>
                                            <option value="1">已经接种</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">性别</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="sex" value="0" title="雄性" checked>
                                        <input type="radio" name="sex" value="1" title="雌性">
                                    </div>
                                </div>
                            </div>


                            <div class="layui-form-item">
                                <label class="layui-form-label">宠物照片</label>
                                <div class="layui-card-body">
                                    <div class="layui-upload-drag" id="test-upload-drag">
                                        <i class="layui-icon"></i>
                                        <p>点击上传，或将文件拖拽到此处</p>
                                        <div class="layui-hide" id="uploadDemoView">
                                            <hr>
                                            <img src="" alt="上传成功后渲染" style="max-width: 196px">
                                        </div>
                                        <input type="hidden" name="imgpath" id="inputImg">
                                    </div>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <label class="layui-form-label" style="float: left">宠物描述</label>
                                <div class="layui-card-body" style="float: left">
                                    <div style="width: 535px;margin-left: -14px">
                            <textarea name="description" placeholder="请输入"
                                      class="layui-textarea"></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-form-item layui-layout-admin">
                                <div class="layui-input-block">
                                    <div class="layui-footer" style="left: 0; text-align: center">
                                        <button type="submit" class="layui-btn" lay-submit=""
                                                lay-filter="component-form-demo1">
                                            立即发布
                                        </button>
                                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


        </div>
    </div>
    <!-- content end -->


    <footer class="blog-footer">
        <div class="am-g am-g-fixed blog-fixed am-u-sm-centered blog-footer-padding">
            <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
                <h3>网站简介</h3>
                <p class="am-text-sm">该网站的使用对象是想领养动物和想成为我们其中一员的爱心人群。
                    <br>您可以领养本系统的宠物或者分享您的宠物，一切都没有问题！
                    <br>如果你是领养者，请认真选取想要领养的动物领养后，请认真负责对待可爱的宠物！
                    <br>我们欢迎任何爱心人士加入我们！
                </p>

            </div>
            <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">

                <h3>致亲爱的用户：</h3>
                <p>我们将永远追求卓越，然而时间、经验、能力有限，导致本系统仍有很多不足的地方，希望大家包容、不吝赐教！让我们永远年轻，永远热泪盈眶！</p>
                <h3>社交账号</h3>
                <p>
                    <a href=""><span class="am-icon-qq am-icon-fw am-primary blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-github am-icon-fw blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-weibo am-icon-fw blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-reddit am-icon-fw blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-weixin am-icon-fw blog-icon blog-icon"></span></a>
                </p>
            </div>
            <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
                <h1>技术支持</h1>
                <h3>Heroes</h3>
                <p>
                <ul>
                    <li>jQuery</li>
                    <li>layui</li>
                    <li>Spring Boot</li>
                    <li>MySql</li>
                    <li>...</li>
                </ul>
                </p>
            </div>
        </div>
        <div class="blog-text-center">© 2021 April, Inc. Luoyang institute of technology. computer specialty</div>
    </footer>

</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/vue/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/vue/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'laydate', 'upload'], function () {
        var $ = layui.$
            , upload = layui.upload
            , admin = layui.admin
            , element = layui.element
            , layer = layui.layer
            , laydate = layui.laydate
            , form = layui.form;

        form.render(null, 'component-form-group');


        //常规用法
        laydate.render({
            elem: '#test-laydate-normal-cn',
            //弹窗一闪而过：   默认是focus,改为click
            type: 'date',
            trigger: 'click' //采用click弹出
        });


        //拖拽上传
        upload.render({
            elem: '#test-upload-drag'
            , url: '/pet/updImg'//该接口返回的相应信息（response）必须是一个标准的 JSON 格式
            , done: function (res) {
                var imgpath = res.data;
                $("#inputImg").val(imgpath);
                layer.msg('上传成功！')
                layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', imgpath);
            },
            error: function (res) {
                //请求异常回调
                alert(res)
            }
        });


        /* 自定义验证规则 */
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });

        /* 监听指定开关 */
        form.on('switch(component-form-switchTest)', function (data) {
            layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

        /* 监听提交 */
        form.on('submit(component-form-demo1)', function (data) {
            /*         parent.layer.alert(JSON.stringify(data.field), {
                         title: '最终的提交信息'
                     })*/
            // return false;
            //关闭小框
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);//关闭当前弹窗页面

        });

        //二级联动
        form.on('select(categoryId)', function (data) {

            var categoryId = data.value
            // alert(categoryId)
            $.get("/pet/getvariety?id=" + categoryId, function (data) {

                console.log(data)
                $("#varietyId").empty();
                $('#varietyId').append($('<option value="">选择品种</option>'))
                if (data.length > 0) {
                    data.forEach(function (e) {
                        var node = '<option value=' + e.id + '>' + e.name + '</option>'
                        $('#varietyId').append($(node))
                    });
                } else {
                    $('#varietyId').append($('<option value="">赞无品种，管理员添加品种后才能选择！</option>'))
                }
                layui.form.render("select");//重新渲染 固定写法
            });
        });
    });


</script>

<script>

    new Vue({
        el: "#app",
        data() {
            return {
                pets: [],
                limit: 5,
                page: '',
                nextPage: '',
                prePage: '',
                content: '',
                pages: ''
            }
        },
        mounted() {
            var that = this;
            axios.get("/user/qiantaiIndex").then(function (result) {
                // console.log(result)
                that.pets = result.data.list;
                that.nextPage = result.data.nextPage;
                that.prePage = result.data.prePage;
                that.page = result.data.page;
                that.pages = result.data.pages;
            })


        },
        methods: {
            nextPageFun: function () {
                var that = this;
                axios.post("/user/qiantaiIndex?page=" + this.nextPage + "&content=" + this.content).then(function (result) {
                    //console.log(result)
                    that.pets = result.data.list;
                    that.nextPage = result.data.nextPage;
                    that.prePage = result.data.prePage;
                    that.page = result.data.page;
                    that.pages = result.data.pages;
                })

            },
            prePageFun: function () {
                var that = this;
                axios.post("/user/qiantaiIndex?content=" + this.content + "&page=" + this.prePage).then(function (result) {
                    //console.log(result)
                    that.pets = result.data.list;
                    that.nextPage = result.data.nextPage;
                    that.prePage = result.data.prePage;
                    that.page = result.data.page;
                    that.pages = result.data.pages;
                })

            },
            searchFun: function () {
                var that = this;
                axios.post("/user/qiantaiIndex?content=" + this.content).then(function (result) {
                    //console.log(result)
                    that.pets = result.data.list;
                    that.nextPage = result.data.nextPage;
                    that.prePage = result.data.prePage;
                    that.page = result.data.page;
                    that.pages = result.data.pages;
                })

            },
            submit_resume: function (id) {
                //alert(id+" "+"submit_resume");
                //*********弹框开始位置**********
                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    //判断生日是否存在来确定是否完善个人信息

                    axios.get("/user/checkComplete?petId=" + id).then(function (res) {
                        console.log(res.data.msg)

                        if (res.data.msg == '0') {
                            layer.msg("请先完善个人信息！！！")
                            return;
                        } else {
                            if (res.data.experience == 1) {
                                layer.confirm('您已经申请过该宠物，继续申请将覆盖之前的申请，确定继续？', function (index) {
                                    layer.open({
                                        type: 2,
                                        title: false,
                                        closeBtn: 0,
                                        shadeClose: true,
                                        // offset: [100],
                                        skin: 'yourClass',
                                        area: ['580px', '310px'],
                                        end: function () {

                                        },
                                        content: "/user/toAdopt?id=" + id
                                    });
                                    layer.close(index);
                                });
                            } else {
                                layer.open({
                                    type: 2,
                                    title: false,
                                    closeBtn: 0,
                                    shadeClose: true,
                                    // offset: [100],
                                    skin: 'yourClass',
                                    area: ['580px', '310px'],
                                    end: function () {

                                    },
                                    content: "/user/toAdopt?id=" + id
                                });
                            }
                        }
                    })


                })

                //*********弹框结束位置***************

            },

            submit_comment: function (id) {

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {

                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        // offset: [100],
                        skin: 'yourClass',
                        area: ['580px', '310px'],
                        end: function () {

                        },
                        content: "/user/addComment?id=" + id
                    });

                })

                //*********弹框结束位置***************


            },


            display_detail: function (id) {
                //alert(id+" "+"display_detail");
                //*********弹框开始位置**********
                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['620px', '700px'],

                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toDisplaypet?petid=" + id
                    });
                })

                //*********弹框结束位置***************
            },
            toUpdStuMessage: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['600px', '800px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toUpdStuMessage"
                    });
                })

                //*********弹框结束位置***************
            },




            userlogout: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {

                    layer.confirm("您确定退出登陆吗？", function () {
                        layer.close()
                        location.href = "/userlogout"
                    })
                })
                //*********弹框结束位置***************
            },
            toEditPassword: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['500px', '300px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toEditPassword"
                    });
                })
                //*********弹框结束位置***************
            },
            toEditPersonal: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['450px', '600px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toEditPersonal"
                    });
                })
                //*********弹框结束位置***************
            },
            toEditPersonal2: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['800px', '590px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toEditPersonal2"
                    });
                })
                //*********弹框结束位置***************
            }

        },





        filters: {
            contentFormat: function (value) {
                if (value.length > 45) {
                    return value.substr(0, 45) + "...";
                } else {
                    return value;
                }
            },
            contentFormat2: function (value) {
                if (value == 0) {
                    return "待领养";
                } else if (value == 1) {
                    return "被申请中(您仍可申请)";
                }
            }
        }
    })

</script>


</body>
</html>
