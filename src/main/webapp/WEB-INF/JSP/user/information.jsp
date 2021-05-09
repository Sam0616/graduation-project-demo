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
                <li class="am-active"><a href="/user/toArticleList">文章动态</a></li>
                <li><a href="/user/toImages">宠图锦集</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        个人领养管理 <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="/user/personalAdopt">我的领养记录</a></li>
                        <li><a href="/user/toSendAdopt">送养宠物</a></li>
                    </ul>
                </li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        个人信息 <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="javascript:void (0);" @click="toEditPersonal">完善个人信息</a></li>
                        <li><a href="javascript:void (0);" @click="toEditPersonal2">查看/修改个人信息</a></li>
                        <li><a href="javascript:void (0);" @click="toEditPassword">修改密码</a></li>
                    </ul>
                </li>
                <li><a href="/stulogout">退出登录</a></li>
            </ul>

        </div>
    </nav>
    <hr>
    <!-- nav end -->
    <!-- banner start -->
    <!-- banner end -->

    <!-- content srart -->
    <div class="am-g am-g-fixed blog-fixed">
        <div class="am-u-md-12 am-u-sm-12">

            <div class="layui-fluid">
                <div class="layadmin-caller">
                    <form class="layui-form caller-seach" id="myform"
                          action="${pageContext.request.contextPath}/user/toList2">
                        <i class="layui-icon layui-icon-search caller-seach-icon caller-icon" id="find"></i>
                        <input type="text" name="content" required lay-verify="required" placeholder="请输入关键字检索文章"
                               autocomplete="off" id="content" class="layui-input caller-pl32">
                        <i class="layui-icon layui-icon-close caller-dump-icon caller-icon" id="clean"></i>
                    </form>
                    <div class="layui-tab layui-tab-brief caller-tab" lay-filter="docDemoTabBrief">

                    </div>

                    <div class="caller-contar">
                        <c:forEach items="${list}" var="item">

                            <div class="caller-item">
                                <img src="${item.imgpath}" alt="头像" class="caller-img caller-fl">
                                <div class="caller-main caller-fl" style="width: 100%">
                                    <p style="margin-left: 39px;margin-top: -39px"><i
                                            class="layui-icon layui-icon-username"
                                            style="font-size: 14px">发布人：</i><strong>${item.adname}</strong><span
                                            style="float: right;margin-right: 21px"><i
                                            class="layui-icon layui-icon-time"
                                            style="font-size: 14px;">发布时间：</i>${item.createtime}</span>
                                    </p>
                                    <p style="margin-left: 39px " class="caller-adds"><i
                                            class="layui-icon layui-icon-read"
                                            style="font-size: 14px">Title：</i>${item.title}

                                            <%--                            <input type="hidden" id="input_hidden" value="${item.id}">--%>
                                        <button style="margin-right: 20px;margin-top: 50px" lay-event="edit" id="btn"
                                                onclick="edit(${item.id})"
                                                class="layui-btn layui-btn-sm caller-fr">
                                            查看文章内容
                                        </button>
                                    </p>
                                    <p style="margin-left: 39px " class="caller-adds"><i
                                            class="layui-icon layui-icon-read"
                                            style="font-size: 14px">文章类别：</i>${item.articleType}
                                    </p>
                                    <div class="caller-iconset" style="margin-left: 39px">
                                        <i title="phone:${item.adphone}"
                                           class="layui-icon layui-icon-cellphone"></i>: ${item.adphone}
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        <i title="email:${item.ademail}"
                                           class="layui-icon layui-icon-at"></i>: ${item.ademail}

                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </div>

                    <div id="demo1" style="text-align: center"></div>
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

<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'laypage', 'layer', 'form', 'layedit', 'table', 'laydate', 'element', 'jquery'], function () {
        var form = layui.form,
            layer = layui.layer,
            element = layui.element,
            $ = layui.jquery;
        var layedit = layui.layedit;


        var laypage = layui.laypage, layer = layui.layer;
        //执行一个laypage实例
        var tableIns = laypage.render({
            elem: 'demo1'
            , count:${count}//数据总数，从服务端得到
            , curr:${pageNo}
            , limit:${pageSize}
            , jump: function (obj, first) {
                //obj包含了当前分页的所有参数，比如：
                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数
                //首次不执行
                if (!first) {
                    //do something
                    //调用后台
                    window.location.href = "${pageContext.request.contextPath}/article/toList?pageNo=" + obj.curr + "&pageSize=" + obj.limit;
                }
            }
        });


        //这样绑定可以实时监听input框的变化
        $(document).on('input propertychange', '#content', function () {
            /*      var search = $('#content').val()
                  console.log(search)
                  $.post('/article/toList', {content: search}, function (res) {
                  })*/
            // $("#myform").submit()
        });

        //清空输入框
        $(document).on('click', '#clean', function () {
            $('#content').val('')
        });

        //提交
        $(document).on('click', '#find', function () {
            $("#myform").submit()
        });
    });


    //修改
    function edit(id) {
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0,
            shadeClose: true,
            skin: 'yourClass',
            area: ['850px', '600px'],
            end: function () {
                // layer.msg("修改成功！", {icon: 1})
                //  location.href = "/article/toList"
            },
            content: "/user/toContent?id=" + id
        });
    }


</script>
<script>
    new Vue({
    el: "#app",
    methods: {
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
                    area: ['600px', '400px'],
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
                    area: ['450px', '600px'],
                    end: function () {
                        /* tableIns.reload()*/
                    },
                    content: "/user/toEditPersonal2"
                });
            })
            //*********弹框结束位置***************
        }

    },



})
</script>


</body>
</html>
