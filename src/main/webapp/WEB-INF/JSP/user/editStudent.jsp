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
        <div class="layui-card-header">修改个人信息</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" action="" lay-filter="component-form-group">

                <input type="hidden" name="id" value="${student.id}">
                <div class="layui-form-item">
                    <label class="layui-form-label">头像上传</label>
                    <div class="layui-upload-drag" id="test10">

                        <c:if test="${student.imgpath==null}">
                            <i class="layui-icon"></i>
                            <p>点击上传，或将文件拖拽到此处</p>
                        </c:if>


                        <div class="layui-show" id="uploadDemoView">
                            <img src="${pageContext.request.contextPath}/img/${student.imgpath}" alt="上传的头像"
                                 style="max-width: 196px">
                        </div>
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">学号</label>
                    <div class="layui-input-block">
                        <input type="text" name="number" lay-verify="required" placeholder="请输入学号" autocomplete="off"
                               class="layui-input" value="${student.number}">
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off"
                               class="layui-input" value="${student.name}">
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-block">
                        <input type="radio" name="sex" value="0" title="男" ${student.sex==0?'checked':''}>
                        <input type="radio" name="sex" value="1" title="女" ${student.sex==1?'checked':''}>
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">学校名称</label>
                    <div class="layui-input-block">
                        <select name="schoolid" lay-filter="aihao">
                            <c:forEach items="${univer_list}" var="univer">
                                <c:choose>
                                    <c:when test="${student.schoolid==univer.id}">
                                        <option value="${univer.id}" selected>${univer.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${univer.id}">${univer.name}</option>
                                    </c:otherwise>

                                </c:choose>

                            </c:forEach>

                        </select>
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">专业名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="speciality" lay-verify="required" placeholder="请输入专业名称"
                               autocomplete="off" class="layui-input" value="${student.speciality}">
                    </div>
                </div>


                <div class="layui-inline">
                    <label class="layui-form-label">入学日期</label>
                    <div class="layui-input-inline">
                        <input type="text" name="matriculate" id="LAY-component-form-group-date" lay-verify="date"
                               placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input"
                               value="${student.matriculate}">
                    </div>
                </div>
                <br> <br>

                <div class="layui-inline">
                    <label class="layui-form-label">出生日期</label>
                    <div class="layui-input-inline">
                        <input type="text" name="birthday" lay-verify="date" id="LAY-component-form-group-date2"
                               placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input"
                               value="${student.birthday}">
                    </div>

                </div>
                <br> <br>


                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">手机号</label>
                        <div class="layui-input-inline">
                            <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off"
                                   class="layui-input" value="${student.phone}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-inline">
                            <input type="text" name="email" lay-verify="email" autocomplete="off" class="layui-input"
                                   value="${student.email}">
                        </div>
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
            , upload = layui.upload;

        form.render(null, 'component-form-group');

        laydate.render({
            elem: '#LAY-component-form-group-date'
        });

        laydate.render({
            elem: '#LAY-component-form-group-date2'
        });


        //拖拽上传
        upload.render({
            elem: '#test10'
            , auto: false
            , bindAction: '#sure_edit'//提交按钮  点击按钮之后上传
            , url: '/qiantai/fileupload' //改成您自己的上传接口
            , done: function (res) {
                layer.msg('上传成功');
                layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.files.file);
                console.log(res)
            }
            , choose: function (obj) {
                //回调 显示图片
                obj.preview(function (index, file, result) {
                    //console.log(result)
                    layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', result);

                })
            }
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
            var studentObj = data.field;
            //console.log(data)
            console.log(studentObj)

            $.post("/qiantai/editStudent", studentObj, function (result) {
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

