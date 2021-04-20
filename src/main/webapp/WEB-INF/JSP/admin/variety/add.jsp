<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>分步表单</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/css/public.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/css/step.css" media="all">
</head>


<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-fluid">
            <div class="layui-card">
                <div class="layui-card-body" style="padding-top: 40px;">
                    <div class="layui-carousel" id="stepForm" lay-filter="stepForm" style="margin: 0 auto;">
                        <div carousel-item>
                            <div>
                                <form class="layui-form" id="form1"
                                      style="margin: 0 auto;max-width: 460px;padding-top: 40px;">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">动物类别名:</label>
                                        <div class="layui-input-block">
                                            <div class="layui-input-inline">
                                                <select name="categoryId" id="cname" lay-verify="required"
                                                        lay-filter="categoryId"
                                                        id="categoryId">
                                                    <option value="">请选择宠物类别</option>
                                                    <c:forEach var="item" items="${categoryList}">
                                                        <option value="${item.id}">${item.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <%--  <input type="text" placeholder="请填写已存在的动物类别名" name="cname" id="cname"
                                                     class="layui-input"
                                                     style="width: 200px" lay-verify="required" required/>--%>
                                        </div>
                                    </div>

                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit lay-filter="formStep">
                                                &emsp;下一步&emsp;
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div>
                                <form class="layui-form" id="form2"
                                      style="margin: 0 auto;max-width: 460px;padding-top: 40px;">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">动物品种名:</label>
                                        <div class="layui-input-block">
                                            <input type="text" placeholder="请填写不存在的品种名" class="layui-input"
                                                   name="name" id="name" lay-verify="required" required/>
                                        </div>
                                    </div>


                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button type="button" class="layui-btn layui-btn-primary pre">上一步</button>
                                            <button class="layui-btn" lay-submit lay-filter="formStep2">
                                                &emsp;确认添加&emsp;
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div>
                                <div style="text-align: center;margin-top: 90px;">
                                    <i class="layui-icon layui-circle"
                                       style="color: white;font-size:30px;font-weight:bold;background: #52C41A;padding: 20px;line-height: 80px;">&#xe605;</i>
                                    <div style="font-size: 24px;color: #333;font-weight: 500;margin-top: 30px;">
                                        添加成功
                                    </div>
                                    <div style="font-size: 14px;color: #666;margin-top: 20px;">管理员辛苦啦~</div>
                                </div>
                                <div style="text-align: center;margin-top: 50px;">
                                    <button class="layui-btn next">再添加一个</button>
                                    <button class="layui-btn layui-btn-primary" lay-submit lay-filter="formStep3">查看列表
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="color: #666;padding-left: 30px;margin-top: -100px">
                        <br>
                        <br>
                        <h2><em>说明：</em></h2><br>
                        <ul>
                            <li><em>此操作只向管理员以上权限开放！</em></li>
                            <li><em>添加品种前需要基于一个存在的类别！</em></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="${pageContext.request.contextPath}/layuiadmin/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form', 'step'], function () {
        var $ = layui.$,
            form = layui.form,
            step = layui.step;

        step.render({
            elem: '#stepForm',
            filter: 'stepForm',
            width: '100%', //设置容器宽度
            stepWidth: '750px',
            height: '450px',
            stepItems: [{
                title: '请先填写动物类别名'
            }, {
                title: '请填写动物品种名'
            }, {
                title: '完成'
            }]
        });

        form.on('submit(formStep)', function (data) {
            //alert("您正在点击下一步")
            //发送请球判断类别名是否存在
            /*       $.post("/variety/checkVariety", {cname:$("#cname").val()
               }, function x(res) {
                   console.log("~~~~~~~~~~~~")
               })*/
            step.next('#stepForm');
            return false;
        });


        form.on('submit(formStep3)', function (data) {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);//关闭当前弹窗页面
            return false;
        });


        form.on('submit(formStep2)', function (data) {

            //异步提交检测品种是否存在，若存在给出提示
            $.post("/variety/checkVariety", {categoryId: $("#cname").val(), name: $("#name").val()}, function (res) {
                if (res == "false") {
                    layer.msg("\"" + data.field.name + "\"" + "已经存在！", {time: 2000, shift: 6, icon: 5})
                } else {
                    step.next('#stepForm');
                }
            })
            return false;
        });


        $('.pre').click(function () {

            step.pre('#stepForm');
        });

        $('.next').click(function () {
            step.next('#stepForm');
        });
    })
</script>
</body>
</html>