<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改信息界面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../../layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">修改管理员信息</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" method="post" action="${pageContext.request.contextPath}/admin/upd?id=${admin.id}"
                  lay-filter="component-form-group">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">登录名</label>
                        <div class="layui-input-inline">
                            <input type="text" name="loginname" lay-verify="required" autocomplete="off"
                                   value="${admin.loginname}"
                                   class="layui-input">
                            <%-- <input type="hidden" name="id" lay-verify="required" autocomplete="off" value="${admin.id}"
                                    class="layui-input">--%>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">真实姓名</label>
                        <div class="layui-input-inline">
                            <input type="text" name="realname" lay-verify="required" autocomplete="off"
                                   value="${admin.realname}"
                                   class="layui-input">
                        </div>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">手机号</label>
                        <div class="layui-input-inline">
                            <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off"
                                   value="${admin.phone}"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-inline">
                            <input type="text" name="email" lay-verify="email" autocomplete="off" value="${admin.email}"
                                   class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">管理员类型</label>
                        <div class="layui-input-inline">
                            <select name="role">
                                <c:choose>
                                    <c:when test="${admin.role==0}">
                                        <option value="0" selected>普通管理员</option>
                                        <option value="1">超级管理员</option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value="0">普通管理员</option>
                                        <option value="1" selected>超级管理员</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-block">
                        <input type="radio" name="sex" value="0" title="男" ${admin.sex == 0 ? 'checked':''}>
                        <input type="radio" name="sex" value="1" title="女" ${admin.sex == 1 ? 'checked':''}>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">出生日期</label>
                        <div class="layui-input-inline">
                            <input type="text" name="birthdays" class="layui-input" id="test-laydate-normal-cn"
                                   value="${birthday}"
                                   placeholder="yyyy-MM-dd">
                        </div>
                    </div>
                </div>

                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button type="submit" class="layui-btn" lay-submit="" lay-filter="component-form-demo1">
                                立即提交
                            </button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="../../../layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'laydate'], function () {
        var $ = layui.$
            , admin = layui.admin
            , element = layui.element
            , layer = layui.layer
            , laydate = layui.laydate
            , form = layui.form;

        form.render(null, 'component-form-group');

        laydate.render({
            elem: '#LAY-component-form-group-date'
        });

        //常规用法
        laydate.render({
            elem: '#test-laydate-normal-cn',
            //弹窗一闪而过：   默认是focus,改为click
            type: 'date',
            trigger: 'click' //采用click弹出
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
    });
</script>
</body>
</html>
