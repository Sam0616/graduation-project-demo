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
    <title>article no sidebar  | Amaze UI Examples</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/qiantai_user/assets/i/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/qiantai_student/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/app.css">
</head>

<body id="blog-article-sidebar">

<div class="am-g am-g-fixed blog-fixed blog-content">
    <div class="am-u-sm-12">
        <article class="am-article blog-article-p">
            <div class="am-article-hd">
                <h1 class="am-article-title blog-text-center">${information.title}</h1>
                <p class="am-article-meta blog-text-center">
                    <span><a href="#" class="blog-color">发行时间： &nbsp;</a></span>
                    <span><a href="#"><fmt:formatDate value="${information.issueDate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;至&nbsp; &nbsp;<fmt:formatDate value="${information.endDate}" pattern="yyyy-MM-dd"/></a></span>

<%--                    <span><a href="#">2015/10/9</a></span>--%>
                </p>
            </div>
            <div class="am-article-bd">
                <img src="${pageContext.request.contextPath}/qiantai_user/assets/i/f17.jpg" alt="" class="blog-entry-img blog-article-margin">
                <p class="am-article-lead">
               ${information.content}
                </p>
            </div>
        </article>

        <hr>

        <%--评论表单--%>
        <form class="am-form am-g">
            <h3 class="blog-comment">留言</h3>
            <fieldset>
                <div class="am-form-group am-u-sm-4 blog-clear-left">
                    <input type="text" class="" placeholder="名字">
                </div>
                <div class="am-form-group am-u-sm-4">
                    <input type="email" class="" placeholder="邮箱">
                </div>

                <div class="am-form-group am-u-sm-4 blog-clear-right">
                    <input type="password" class="" placeholder="网站">
                </div>

                <div class="am-form-group">
                    <textarea class="" rows="5" placeholder="一字千金"></textarea>
                </div>

                <p><button type="submit" class="am-btn am-btn-default">发表留言</button></p>
            </fieldset>
        </form>

        <hr>
    </div>
</div>
<!-- content end -->





<!--[if (gte IE 9)|!(IE)]><!-->
<script src="assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="assets/js/amazeui.min.js"></script>
<!-- <script src="assets/js/app.js"></script> -->
</body>
</html>
