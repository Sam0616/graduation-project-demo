<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>忘记密码 - 流浪小动物领养系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/login.css" media="all">
</head>

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>找回密码</h2>
            <p>忘记密码 - 流浪小动物领养系统</p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

            <script type="text/html" template>
                {{# if(layui.router().search.type === 'resetpass'){ }}
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                           for="LAY-user-login-password"></label>
                    <input type="password" name="password" id="LAY-user-login-password" lay-verify="pass"
                           placeholder="新密码" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                           for="LAY-user-login-repass"></label>
                    <input type="password" name="repass" id="LAY-user-login-repass" lay-verify="required"
                           placeholder="确认密码" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-forget-resetpass">重置新密码
                    </button>
                </div>
                {{# } else { }}
                <div class="layui-col-md12" style="margin-top: -10px;margin-bottom: 10px;margin-left: 90px">
                    <input type="radio" name="identity" value="用户" title="用户">
                    <input type="radio" name="identity" value="管理员" title="管理员" checked>
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-cellphone"
                           for="LAY-user-login-cellphone"></label>
                    <input type="text" name="phone" id="LAY-user-login-cellphone" lay-verify="phone"
                           placeholder="请输入注册时的手机号" class="layui-input">
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-form-item">
                            <div id="slider"></div>
                        </div>

                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-xs7">
                            <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                                   for="LAY-user-login-smscode"></label>
                            <input type="text" name="vercode" id="LAY-user-login-smscode" lay-verify="required"
                                   placeholder="短信验证码" class="layui-input">
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
                    <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-forget-submit">找回密码
                    </button>
                </div>
                {{# } }}
            </script>
        </div>
    </div>


</div>

<script src="${pageContext.request.contextPath}/layuimini/lib/jquery-3.4.1/jquery-3.4.1.min.js"
        charset="utf-8"></script>
<script src="../../layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user', 'sliderVerify'], function () {
        var $ = layui.$
            , setter = layui.setter
            , admin = layui.admin
            , form = layui.form
            , router = layui.router()
            , sliderVerify = layui.sliderVerify;

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



        //找回密码下一步
        form.on('submit(LAY-user-forget-submit)', function (obj) {
            //判断验证码是否过期
            if(flag==0){//验证码已经过期
                layer.msg("验证码已经过期，请重新获取！", {time: 2000, shift: 6, icon: 5})
            }else {
                var field = obj.field;
                //请求接口
                admin.req({
                    url: '/findOutPwd'//实际使用请改成服务端真实接口
                    , data: field
                    , done: function (res) {
                        if (res.data == "true") {
                            location.hash = '/type=resetpass';
                            location.reload();
                        } else if(res.data == "false2"){
                            layer.msg("该手机号不存在对应的用户！", {time: 2000, shift: 6, icon: 5})
                        }
                         else if(res.data == "false3"){
                            layer.msg("该手机号不存在对应的管理员！", {time: 2000, shift: 6, icon: 5})
                        } else {
                            layer.msg("验证码错误！", {time: 2000, shift: 6, icon: 5})
                        }
                    }
                });
            }
            return false;
        });

        //重置密码
        form.on('submit(LAY-user-forget-resetpass)', function (obj) {
            var field = obj.field;
            //确认密码
            if (field.password !== field.repass) {
                return layer.msg('两次密码输入不一致');
            }
            //请求接口
            admin.req({
                url: 'ResetPwd' //实际使用请改成服务端真实接口
                , data: field
                , done: function (res) {
                    layer.msg('密码已成功重置', {
                        offset: '15px'
                        , icon: 1
                        , time: 1000
                    }, function () {
                        location.href = '/'; //跳转到登入页
                    });
                }
            });
            return false;
        });
    });



    var flag = 1 //标志位1代表此刻去获取了可用的验证码，并随着下面的倒计时结束，置成0，表示此验证码已经过期
    function getCode() {
        flag = 1 //把过期置成0的flag置成1
        var phone = $('#LAY-user-login-cellphone').val()
        $.post('/getCode', {phone: phone}, function () {
            setTimeout(function () {
                flag = 0
            }, 60000)
        })
    }

</script>
</body>
</html>