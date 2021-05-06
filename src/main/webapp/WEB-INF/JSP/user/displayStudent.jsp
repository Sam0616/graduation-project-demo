<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>image   | Amaze UI Examples</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/qiantai_user/assets/i/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/app.css">
</head>

<body id="blog-article-sidebar">
<!-- header start -->
<header class="am-g am-g-fixed blog-fixed blog-text-center blog-header">
    <div class="am-u-sm-8 am-u-sm-centered">
        <img width="200" src="${pageContext.request.contextPath}/image/logo.png" alt="大学生兼职系统"/>
    </div>
</header>
<!-- header end -->
<hr>

<!-- nav start -->
<nav class="am-g am-g-fixed blog-fixed blog-nav">
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only blog-button" data-am-collapse="{target: '#blog-collapse'}" ><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="blog-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav">
            <li><a href="/qiantai/toqiantaiIndex">首页/工作招聘</a></li>
            <li><a href="/qiantai/toInformation">招聘信息</a></li>
            <li><a href="/qiantai/toImages">图片库</a></li>

            <li class="am-dropdown" data-am-dropdown>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                    个人简历 <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="/qiantai/toEditResume">完善简历信息</a></li>
                    <li><a href="/qiantai/toDisplayResume">查看简历信息</a></li>
                    <li><a href="/qiantai/toResumeList">简历投递信息</a></li>
                </ul>
            </li>

            <li class="am-dropdown am-active" data-am-dropdown>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                    个人信息 <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="/qiantai/toDisplayStudent">查看个人信息</a></li>
                    <li><a href="javascript:void (0);" onclick="toUpdStuMessage()">修改个人信息</a></li>
                    <li><a href="javascript:void (0);" onclick="toEditPassword()">修改密码</a></li>
                </ul>
            </li>
            <li><a href="/stulogout">退出登录</a></li>
        </ul>
        <form class="am-topbar-form am-topbar-right am-form-inline" role="search">
            <div class="am-form-group">
                <input type="text" class="am-form-field am-input-sm" placeholder="搜索">
            </div>
        </form>
    </div>
</nav>
<!-- nav end -->
<hr>
<!-- content srart -->
<div class="am-g am-g-fixed blog-fixed blog-content">
    <figure data-am-widget="figure" class="am am-figure am-figure-default ">
        <div style="width: 1000px;margin-left: 150px;margin-right: 150px">


            <span style="font-weight: bold">个人信息</span>
            <hr>
            <span style="margin-left: 150px;font-weight: bold">头像:&nbsp;&nbsp;&nbsp;</span>
            <img width="150px" height="150px" src="${pageContext.request.contextPath}/img/${student.imgpath}">

           <br>

            <span style="margin-left: 150px;font-weight: bold">姓名:&nbsp;&nbsp;&nbsp;</span><span>${student.name}</span>&nbsp;&nbsp;

            <span style="margin-left: 150px;font-weight: bold">性别:&nbsp;&nbsp;&nbsp;</span><span>${student.sex==0?"男":"女"}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">学号:&nbsp;&nbsp;&nbsp;</span><span>${student.number}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">邮箱:&nbsp;&nbsp;&nbsp;</span><span>${student.email}</span>
            &nbsp;&nbsp;
            <span style="margin-left: 150px;font-weight: bold">手机号:&nbsp;&nbsp;&nbsp;</span><span>${student.phone}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">专业:&nbsp;&nbsp;&nbsp;</span><span>${student.speciality}</span>

            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">入学年月:&nbsp;&nbsp;&nbsp;</span><span>${student.matriculate}<fmt:formatDate value="" /></span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">出生日期:&nbsp;&nbsp;&nbsp;</span><span>${student.birthday}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">开户日期:&nbsp;&nbsp;&nbsp;</span><span>${student.createdate}</span>

            <br>
            <br>  <br>
            <br>

            <span style="font-weight: bold">学校信息</span>
            <hr>

            <span style="margin-left: 150px;font-weight: bold">学校名称:&nbsp;&nbsp;&nbsp;</span><span>${university.name}</span>&nbsp;&nbsp;

            <span style="margin-left: 150px;font-weight: bold">高校编码:&nbsp;&nbsp;&nbsp;</span><span>${university.code}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">高校类型:&nbsp;&nbsp;&nbsp;</span><span>${university.type}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">所处地区:&nbsp;&nbsp;&nbsp;</span><span>${university.region}</span>
            &nbsp;&nbsp;
            <span style="margin-left: 150px;font-weight: bold">高校地址:&nbsp;&nbsp;&nbsp;</span><span>${university.address}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">学校电话:&nbsp;&nbsp;&nbsp;</span><span>${university.phone}</span>

            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">学校邮箱:&nbsp;&nbsp;&nbsp;</span><span>${university.email}</span>
            <br>
            <br>
            <span style="margin-left: 150px;font-weight: bold">负责人姓名:&nbsp;&nbsp;&nbsp;</span><span>${university.respon}</span>






















        </div>
    </figure>

</div>
<!-- content end -->
<footer class="blog-footer">
    <div class="am-g am-g-fixed blog-fixed am-u-sm-centered blog-footer-padding">
        <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
            <h3>网站简介</h3>
            <p class="am-text-sm">这是一个针对在校大学生做的一个兼职系统。<br> 在校大学生注册登录之后 <br> 能够进行工作查询，个人信息管理，存放简历，投递简历等功能。<br>嗯嗯嗯，不知道说啥了，外面的世界真精彩，毕设真难写。<br><br>
                在这个系统中，在校大学生可以根据自己的需求，查询自己喜欢的企业的招聘信息，也可以想自己喜欢的单位投递简历呦。</p>

        </div>
        <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
            <h3>社交账号</h3>
            <p>
                <a href=""><span class="am-icon-qq am-icon-fw am-primary blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-github am-icon-fw blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-weibo am-icon-fw blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-reddit am-icon-fw blog-icon blog-icon"></span></a>
                <a href=""><span class="am-icon-weixin am-icon-fw blog-icon blog-icon"></span></a>
            </p>
            <h3>Credits</h3>
            <p>我们追求卓越，然时间、经验、能力有限。该系统有很多不足的地方，希望大家包容、不吝赐教，给我们提意见、建议。感谢你们！</p>
        </div>
        <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
            <h1>我们站在巨人的肩膀上</h1>
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


<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/qiantai_student/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/pinto.min.js"></script>
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/img.js"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>

<script>

    function toUpdStuMessage(){

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
                end:function(){
                    /* tableIns.reload()*/
                },
                content: "/qiantai/toUpdStuMessage"
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
                area: ['600px', '400px'],
                end:function(){
                    /* tableIns.reload()*/
                },
                content: "/qiantai/toEditPassword"
            });
        })

        //*********弹框结束位置***************

    }




</script>
</body>
</html>