<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>注册 - 流浪小动物领养系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/x-icon"/>
    <link rel="stylesheet" href="../../layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="../../layuiadmin/style/login.css" media="all">

    <style>
        #xieyi:hover {
            color: #30A89D;
        }

        #xieyi {
            position: absolute;
            left: 101px;
            top: 8px;
            width: 200px;
        }
    </style>
</head>

<body>


<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>新用户注册</h2>
            <p>注册 - 流浪小动物领养系统</p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-cellphone"
                       for="LAY-user-login-cellphone"></label>
                <input type="text" name="phone" id="LAY-user-login-cellphone" lay-verify="phone" placeholder="手机"
                       class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                               for="LAY-user-login-vercode"></label>
                        <input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required"
                               placeholder="验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-fluid"
                                    onclick="getCode()"
                                    id="LAY-user-getsmscode">获取验证码
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="LAY-user-login-password"></label>
                <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass" placeholder="密码"
                       class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="LAY-user-login-repass"></label>
                <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码"
                       class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                       for="LAY-user-login-nickname"></label>
                <input type="text" name="loginname" id="LAY-user-login-nickname" lay-verify="nickname" placeholder="登录名"
                       class="layui-input">
            </div>
            <div class="layui-form-item">
                <input type="checkbox" name="agreement" lay-skin="primary" title="阅读并接受 ">
                <a style="" id="xieyi" href="/agreement.html">《流浪小动物领养协议》</a>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-reg-submit">注 册</button>
            </div>

        </div>
    </div>


</div>
<script src="${pageContext.request.contextPath}/layuimini/lib/jquery-3.4.1/jquery-3.4.1.min.js"
        charset="utf-8"></script>
<script src="../../layuiadmin/layui/layui.js"></script>
<script>


    // alert(flag2)


    layui.config({
        base: '../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user'], function () {
        var $ = layui.$
            , setter = layui.setter
            , admin = layui.admin
            , form = layui.form
            , router = layui.router();

        form.render();


        //提交
        form.on('submit(LAY-user-reg-submit)', function (obj) {
            var field = obj.field;

            //确认密码
            if (field.password !== field.repass) {
                return layer.msg('两次密码输入不一致');
            }

            //是否同意用户协议
            if (!field.agreement) {
                return layer.msg('你必须同意用户协议才能注册');
            }

            if (flag2 == 0) {//验证码已经过期
                layer.msg("验证码已经过期，请重新获取！", {time: 2000, shift: 6, icon: 5})
            } else {
                //请求接口
                admin.req({
                    url: '/register' //实际使用请改成服务端真实接口
                    , data: field
                    , done: function (res) {
                        if (res.data == "false") {
                            layer.msg("验证码错误！", {time: 2000, shift: 6, icon: 5})
                        } else if (res.data == "false2") {
                            layer.msg("登录名已经被注册，麻烦在换一个吧~", {time: 2000, shift: 6, icon: 5})
                        } else if (res.data == "false3") {
                            layer.msg("未知错误，注册失败！", {time: 2000, shift: 6, icon: 5})
                        } else {
                            layer.msg('注册成功', {
                                offset: '15px'
                                , icon: 1
                                , time: 1000
                            }, function () {
                                location.href = '/tologin'; //跳转到登入页
                            });
                        }
                    }
                });
            }
            return false;
        });
    });

    //以下代码搬进admin.js源码中了
    // var flag2 = 1 //标志位1代表此刻去获取了可用的验证码，并随着下面的倒计时结束，置成0，表示此验证码已经过期
    /*    function getCode() {
            flag = 1 //把过期置成0的flag置成1
            var phone = $('#LAY-user-login-cellphone').val()
            $.post('/getCode', {phone: phone}, function (res) {
                setTimeout(function () {
                    flag = 0
                }, 60000)
            })
        }*/
</script>
</body>
</html>