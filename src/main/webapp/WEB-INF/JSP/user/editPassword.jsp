<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>表单组合</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">修改密码</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" action="" lay-filter="component-form-group">




                <div class="layui-form-item">
                    <label class="layui-form-label">密码1</label>
                    <div class="layui-input-block">
                        <input type="text" id="password1" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off"
                               class="layui-input" >
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">密码2</label>
                    <div class="layui-input-block">
                        <input type="text" id="password2" name="repassword" lay-verify="repassword" placeholder="请再次输入密码" autocomplete="off"
                               class="layui-input" >
                    </div>
                </div>



                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button type="button" id="cancel_box" class="layui-btn layui-btn-primary">取消</button>
                            <button class="layui-btn" lay-submit="" lay-filter="component-form-demo1" id="sure_edit">
                                确认修改
                            </button>

                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'upload', 'laydate'], function () {
        var $ = layui.$
            , admin = layui.admin
            , element = layui.element
            , layer = layui.layer
            , laydate = layui.laydate
            , form = layui.form


        form.render(null, 'component-form-group');



        /* 自定义验证规则 */
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,repassword:function (value) {
                var pas=$("#password1").val();
                if(value!==pas){
                 return "两次密码不一致";
                }

            }
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
            var password=$("#password1").val();

            $.post("/qiantai/editPassword", {password}, function (result) {
                parent.layer.alert(result, {
                    title: '修改状态'
                })
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);//关闭当前弹窗页面

                //刷新表格 5 随便传的参数，目的是为了在方法内判断触发函数的方式-- 手动 和非手动
                parent.$('#queryRole').trigger("click", "5");

            })

            return false;
        });


    });

    $("#cancel_box").click(function () {
        var cancel = parent.layer.getFrameIndex(window.name);
        parent.layer.close(cancel);//关闭当前弹窗页面
    })


</script>
</body>
</html>


