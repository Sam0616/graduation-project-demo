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
                <li class=""><a href="/front">首页</a></li>
                <li class=""><a href="/user/petList">领养中心</a></li>
                <li ><a href="/user/toArticleList">文章动态</a></li>
                <li class="am-active"><a href="/user/toImages">宠图锦集</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        个人领养管理 <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="/user/personalAdopt">查看领养申请</a></li>
                        <li><a href="/user/toSendAdopt">送养宠物</a></li>
                    </ul>
                </li>

                <li><a href="javascript:void (0);" onclick="userlogout()">退出登录</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        <img id="img1" src="${user_session.imgpath}"
                             style="width: 35px;height: 35px;border-radius: 30px" class="layui-nav-img">
                        <span id="span1">${user_session.realname}</span>
                        <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="javascript:void (0);" onclick="toEditPersonal()">完善个人信息</a></li>
                        <li><a href="javascript:void (0);" onclick="toEditPersonal2()">查看/修改个人信息</a></li>
                        <li><a href="javascript:void (0);" onclick="toEditPassword()">修改密码</a></li>
                    </ul>
                </li>
            </ul>

        </div>
    </nav>

    <!-- nav end -->
    <hr>
    <!-- banner start -->
    <!-- banner end -->

    <!-- content srart -->
    <div class="am-g am-g-fixed blog-fixed blog-content">
        <figure data-am-widget="figure" class="am am-figure am-figure-default " data-am-figure="{  pureview: 'true' }">
            <div id="container">
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/01.jpg">
                    <h3>Agfa</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/02.jpg">
                    <h3>Auto</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/03.jpg">
                    <h3>Bald eagle</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/04.jpg">
                    <h3>Black swan</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/05.jpg">
                    <h3>Book shelf</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/06.jpg">
                    <h3>Camera</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/07.jpg">
                    <h3>Camera</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/25.jpg">
                    <h3>Vintage camera</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/09.jpg">
                    <h3>Coffee</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/10.jpg">
                    <h3>Cookies</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/11.jpg">
                    <h3>Cubes</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/12.jpg">
                    <h3>DJ</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/13.jpg">
                    <h3>Doors</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/14.jpg">
                    <h3>Matchbox</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/15.jpg">
                    <h3>Freiburg</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/16.jpg">
                    <h3>Henna</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/17.jpg">
                    <h3>Home office</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/18.jpg">
                    <h3>iPad</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/19.jpg">
                    <h3>Keyboard</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/20.jpg">
                    <h3>Lynx</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/21.jpg">
                    <h3>Mac</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/22.jpg">
                    <h3>Notebook</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/23.jpg">
                    <h3>Thoughts</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/24.jpg">
                    <h3>Office</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/25.jpg">
                    <h3>Children</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/26.jpg">
                    <h3>Portrait</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/27.jpg">
                    <h3>Startup</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/28.jpg">
                    <h3>Sun</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/29.jpg">
                    <h3>The Eiffel Tower</h3></div>
                <div><img src="${pageContext.request.contextPath}/qiantai_user/images/30.jpg">
                    <h3>Water drops</h3></div>

            </div>
        </figure>

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
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/pinto.min.js"></script>
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/img.js"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>

<script>
    function userlogout() {

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
    }

    function toEditPersonal() {
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
    }

    function toEditPersonal2() {
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

    function toEditPassword() {
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
    }


</script>




</body>
</html>
