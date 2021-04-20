<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登入 - 流浪小动物领养系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/login.css" media="all">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuimini/lib/layui-v2.5.5/css/layui.css"
          media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>

        .layui-bg-green {
            background-color: #1E9FFF !important;
        }

        element.style {
            left: 293px;
            border: 1px solid #1E9FFF;
            color: #1E9FFF;
        }

        .layui-form-checked[lay-skin=primary] i {
            border-color: #1E9FFF !important;
            background-color: #1E9FFF;
            color: #fff;
        }

        .layui-form-radio > i:hover, .layui-form-radioed > i {
            color: #1E9FFF;
        }

        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden
        }

        body {
            background: #1E9FFF;
        }

        body:after {
            content: '';
            background-repeat: no-repeat;
            background-size: cover;
            -webkit-filter: blur(3px);
            -moz-filter: blur(3px);
            -o-filter: blur(3px);
            -ms-filter: blur(3px);
            filter: blur(3px);
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: -1;
        }

        .layui-container {
            width: 100%;
            height: 100%;
            overflow: hidden
        }

        .admin-login-background {
            width: 360px;
            height: 300px;
            position: absolute;
            left: 50%;
            top: 40%;
            margin-left: -180px;
            margin-top: -100px;
        }

        .logo-title {
            text-align: center;
            letter-spacing: 2px;
            padding: 14px 0;
        }

        .logo-title h1 {
            color: #1E9FFF;
            font-size: 25px;
            font-weight: bold;
        }

        .login-form {
            background-color: #fff;
            border: 1px solid #fff;
            border-radius: 3px;
            padding: 14px 20px;
            box-shadow: 0 0 8px #eeeeee;
        }

        .login-form .layui-form-item {
            position: relative;
        }

        .login-form .layui-form-item label {
            position: absolute;
            left: 1px;
            top: 1px;
            width: 38px;
            line-height: 36px;
            text-align: center;
            color: #d2d2d2;
        }

        .login-form .layui-form-item input {
            padding-left: 36px;
        }

        .captcha {
            width: 60%;
            display: inline-block;
        }

        .captcha-img {
            display: inline-block;
            width: 34%;
            float: right;
        }

        .captcha-img img {
            height: 34px;
            border: 1px solid #e6e6e6;
            height: 36px;
            width: 100%;
        }
    </style>
</head>
<body>


<div class="layadmin-user-login layui-container layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="admin-login-background">
        <div class="layui-form login-form" style="width: 340px;height: 440px;margin-left: -10px;margin-top: -47px">
            <div class="layadmin-user-login-main" style="margin-left: -17px">
                <div class="layadmin-user-login-box layadmin-user-login-header">
                    <h2 style=" color: #1E9FFF;font-size: 25px;font-weight: unset;letter-spacing: 3px;margin-bottom: 1px">
                        流浪小动物领养系统</h2>
                </div>

                <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
                    <div class="layui-form-item">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                               for="LAY-user-login-username"></label>
                        <input type="text" name="loginname" id="LAY-user-login-username" lay-verify="required"
                               placeholder="用户名" value="${cookie.name.value}"
                               class="layui-input">
                    </div>
                    <div class="layui-form-item">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                               for="LAY-user-login-password"></label>
                        <input type="password" name="password" id="LAY-user-login-password" lay-verify="required"
                               placeholder="密码" value="${cookie.pwd.value}" class="layui-input">
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-form-item">
                                <div id="slider"></div>
                            </div>

                        </div>
                    </div>

                    <div class="layui-form-item" style="margin-bottom: 20px;">
                        <input type="checkbox" name="remember" lay-skin="primary" title="记住我">
                        <a href="/forget" class="layadmin-user-jump-change layadmin-link"
                           style="margin-top: 7px"><span style="color: #1E9FFF">忘记密码？</span></a>
                    </div>
                    <div class="layui-col-md12" style="margin-top: -10px;margin-bottom: 10px;margin-left: 1px">
                        <input type="radio" name="identity" value="用户" title="用户">
                        <input type="radio" name="identity" value="管理员" title="管理员" checked>
                    </div>
                    <div class="layui-form-item">
                        <button style="background-color: #1E9FFF" class="layui-btn layui-btn-fluid" lay-submit
                                lay-filter="LAY-user-login-submit">登 入
                        </button>
                    </div>


                    <div class="layui-trans layui-form-item layadmin-user-login-other"
                         style="margin-top: -20px;margin-left: 4px;margin-right: -6px">
                        <a href="javascript:;" title="开发中..."><i class="layui-icon layui-icon-login-qq"></i></a>
                        <a href="javascript:;" title="开发中..."><i class="layui-icon layui-icon-login-wechat"></i></a>
                        <a href="javascript:;" title="开发中..."><i class="layui-icon layui-icon-login-weibo"></i></a>

                        <a href="/toregister" class="layadmin-user-jump-change layadmin-link"><span
                                style="color: #1E9FFF;margin-right: 0px">注册账号</span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/layuimini/lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/layuimini/lib/jq-module/jquery.particleground.min.js"
        charset="utf-8"></script>
<script>
    layui.config({
        base: '../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user', 'form', 'sliderVerify'], function () {

        var $ = layui.$
            , setter = layui.setter
            , admin = layui.admin
            , form = layui.form
            , router = layui.router()
            , search = router.search
            , sliderVerify = layui.sliderVerify;
        var layer = layui.layer;

        var slider = sliderVerify.render({
            elem: '#slider',
            onOk: function () {//当验证通过回调
                setTimeout(function () {
                    layer.msg("滑块验证通过")
                })
            }
        })
        //监听提交
        form.on('submit(formDemo)', function (data) {
            if (slider.isOk()) {//用于表单验证是否已经滑动成功
                layer.msg(JSON.stringify(data.field));
            } else {
                layer.msg("请先通过滑块验证");
            }
            return false;
        });


        form.render();

        //提交
        form.on('submit(LAY-user-login-submit)', function (obj) {
            console.log(obj.field)
            //请求登入接口
            admin.req({
                url: '/login' //实际使用请改成服务端真实接口
                , data: obj.field
                , done: function (res) {
                    console.log(res)
                    if (res.msg == "用户") {
                        if (res.data == "true") {
                            //请求成功后，写入 access_token
                            layui.data(setter.tableName, {
                                key: setter.request.tokenName
                                , value: res.data.access_token
                            });
                            //登入成功的提示与跳转
                            layer.msg('用户登入成功', {
                                offset: '15px'
                                , icon: 1
                                , time: 1000
                            }, function () {
                                location.href = '/front'; //前台主页
                            });
                        } else {
                            layer.msg("登入失败,用户名或密码错误！", {time: 2000, shift: 6, icon: 5})
                        }
                    } else {
                        if (res.data == "true") {
                            //请求成功后，写入 access_token
                            layui.data(setter.tableName, {
                                key: setter.request.tokenName
                                , value: res.data.access_token
                            });
                            //登入成功的提示与跳转
                            layer.msg('管理员登入成功', {
                                offset: '15px'
                                , icon: 1
                                , time: 1000
                            }, function () {
                                location.href = '/back'; //后台主页
                            });
                        } else {
                            layer.msg("登入失败,用户名或密码错误！", {time: 2000, shift: 6, icon: 5})
                        }
                    }
                }
            });
        });

        // 粒子线条背景
        $(document).ready(function () {
            $('.layui-container').particleground({
                dotColor: '#7ec7fd',
                lineColor: '#7ec7fd'
            });
        });

    });
</script>
</body>
</html>
