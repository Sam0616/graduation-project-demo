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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/app.css">
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
                <li class="am-active"><a href="/front">首页</a></li>
                <li class=""><a href="/user/petList">领养中心</a></li>
                <li><a href="/user/toArticleList">文章动态</a></li>
                <li><a href="/user/toImages">宠图锦集</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
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
        </div>
    </nav>
    <hr>
    <!-- nav end -->
    <!-- banner start -->
    <div class="am-g am-g-fixed blog-fixed am-u-sm-centered blog-article-margin">
        <div data-am-widget="slider" class="am-slider am-slider-b1" data-am-slider='{&quot;controlNav&quot;:false}'>
            <ul class="am-slides">
                <li>
                    <img src="${pageContext.request.contextPath}/qiantai_user/assets/i/i4.jpg" style="width: 1434px;height: 735px">
                    <div class="am-slider-desc blog-slider-desc" style="height: 271px">
                        <div class="blog-text-center blog-slider-con" style="height: 260px">
                            <span><a href="" class="blog-color">Daily slogan &nbsp;</a></span>
                            <h1 class="blog-h-margin"><a href="">全民偕手，给流浪宠物一个家！</a></h1>
                            <p>"它只是你的一条狗

                                但你却是它的一生"
                            </p>
                            <span>2021/04/05</span>
                        </div>
                    </div>
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/qiantai_user/assets/i/i7.jpg" style="width: 1434px;height: 735px">
                    <div class="am-slider-desc blog-slider-desc" style="height: 271px">
                        <div class="blog-text-center blog-slider-con" style="height: 260px">
                            <span><a href="" class="blog-color">Daily slogan &nbsp;</a></span>
                            <h1 class="blog-h-margin"><a href="">动物是人类的好朋友~</a></h1>
                            <p>"它教会了我们忠诚的含义———

                                永远不应忘记你爱的人"
                            </p>
                            <span class="blog-bor">2021/04/05</span>
                            <br><br><br><br><br><br><br>
                        </div>
                    </div>
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/qiantai_user/assets/i/i6.jpg" style="width: 1434px;height: 735px">
                    <div class="am-slider-desc blog-slider-desc" style="height: 271px">
                        <div class="blog-text-center blog-slider-con" style="height: 260px">
                            <span><a href="" class="blog-color">Daily slogan &nbsp;</a></span>
                            <h1 class="blog-h-margin"><a href="">请爱护人类最亲密的伙伴~</a></h1>
                            <p>"我们从猫咪身上学到,
                                幸福是温暖而柔软的东西,
                                它也许就在身边，不在别处"
                            </p>
                            <span>2021/04/18</span>
                        </div>
                    </div>
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/qiantai_user/assets/i/i5.jpg" style="width: 1434px;height: 735px">

                    <div class="am-slider-desc blog-slider-desc" style="height: 271px">
                        <div class="blog-text-center blog-slider-con" style="height: 260px">
                            <span><a href="" class="blog-color">Daily slogan &nbsp;</a></span>
                            <h1 class="blog-h-margin"><a href="">爱护动物，让人类不孤单!</a></h1>
                            <p>"这个世界是多么冷酷，然而，待在猫儿身边，世界就可以变得美好而温柔了"
                            </p>
                            <span>2021/04/29</span>
                        </div>
                    </div>
                </li>

            </ul>
        </div>
    </div>
    <!-- banner end -->

    <!-- content srart -->
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
            userlogout: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {

                    layer.confirm("您确定退出登录吗？", function () {
                        layer.close()
                        location.href = "/userlogout"
                    })
                })
                //*********弹框结束位置**************
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
