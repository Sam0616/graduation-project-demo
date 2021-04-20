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
        <div class="layui-card-header">修改宠物信息</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" method="post" action="${pageContext.request.contextPath}/pet/upd?id=${pet.id}"
                  lay-filter="component-form-group">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">宠物名</label>
                        <div class="layui-input-inline">
                            <input type="text" name="petname" lay-verify="required" autocomplete="off"
                                   value="${pet.petname}"
                                   class="layui-input">
                        </div>
                    </div>


                    <div class="layui-inline">
                        <label class="layui-form-label">年龄/岁</label>
                        <div class="layui-input-inline">
                            <input type="text" name="age" lay-verify="required" autocomplete="off" value="${pet.age}"
                                   class="layui-input">
                        </div>
                    </div>
                </div>


                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">类别</label>
                        <div class="layui-input-inline">


                            <select name="categoryId" lay-verify="required" lay-filter="categoryId" id="categoryId"
                                    lay-search>
                                <c:forEach var="item" items="${categoryList}">

                                    <c:choose>
                                        <c:when test="${pet.categoryId == item.id }">
                                            <option value="${item.id}" selected>${item.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${item.id}">${item.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>


                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">品种</label>
                        <div class="layui-input-inline">

                            <select name="varietyId" lay-verify="required" lay-filter="varietyId" id="varietyId">
                                <c:forEach var="item" items="${varietyList}">
                                    <c:choose>
                                        <c:when test="${pet.varietyId == item.id }">
                                            <option value="${item.id}" selected>${item.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${item.id}">${item.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">来源</label>
                        <div class="layui-input-inline">
                            <select name="source">
                                <c:choose>
                                    <c:when test="${pet.source==0}">
                                        <option value="0" selected>流浪宠物</option>
                                        <option value="1">送养宠物</option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value="0">流浪宠物</option>
                                        <option value="1" selected>送养宠物</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">性别</label>
                        <div class="layui-input-block">
                            <input type="radio" name="sex" value="0" title="雄性" ${pet.sex == 0 ? 'checked':''}>
                            <input type="radio" name="sex" value="1" title="雌性" ${pet.sex == 1 ? 'checked':''}>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">领养状态</label>
                        <div class="layui-input-inline">
                            <select name="status">
                                <c:choose>
                                    <c:when test="${pet.status==0}">
                                        <option value="0" selected>待领养</option>
                                        <option value="1">申请中</option>
                                        <option value="2">被领养</option>
                                    </c:when>
                                    <c:when test="${pet.status==1}">
                                        <option value="0">待领养</option>
                                        <option value="1" selected>申请中</option>
                                        <option value="2">被领养</option>
                                    </c:when>
                                    <c:when test="${pet.status==2}">
                                        <option value="0">待领养</option>
                                        <option value="1">申请中</option>
                                        <option value="2" selected>被领养</option>
                                    </c:when>
                                </c:choose>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">疫苗情况</label>
                        <div class="layui-input-inline">
                            <select name="vaccine">
                                <c:choose>
                                    <c:when test="${pet.vaccine==0}">
                                        <option value="0" selected>未接种</option>
                                        <option value="1">已经接种</option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value="0">未接种</option>
                                        <option value="1" selected>已经接种</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">宠物照片</label>
                    <div class="layui-card-body">
                        <div class="layui-upload-drag" id="test-upload-drag">
                            <i class="layui-icon"></i>
                            <p>点击上传，或将文件拖拽到此处</p>
                            <div class="layui-hide" id="uploadDemoView">
                                <hr>
                                <img src="" alt="上传成功后渲染" style="max-width: 196px">
                            </div>
                            <input type="hidden" name="imgpath" id="inputImg">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="float: left">宠物描述</label>
                    <div class="layui-card-body" style="float: left">
                        <div style="width: 535px;margin-left: -14px">
                            <textarea name="description" placeholder="请输入"
                                      class="layui-textarea">${pet.description}</textarea>
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
    }).use(['index', 'form', 'laydate', 'upload'], function () {
        var $ = layui.$
            , upload = layui.upload
            , admin = layui.admin
            , element = layui.element
            , layer = layui.layer
            , laydate = layui.laydate
            , form = layui.form;

        form.render(null, 'component-form-group');


        //常规用法
        laydate.render({
            elem: '#test-laydate-normal-cn',
            //弹窗一闪而过：   默认是focus,改为click
            type: 'date',
            trigger: 'click' //采用click弹出
        });


        //拖拽上传
        upload.render({
            elem: '#test-upload-drag'
            , url: '/pet/updImg'//该接口返回的相应信息（response）必须是一个标准的 JSON 格式
            , done: function (res) {
                console.log(res.data)
                var imgpath = res.data;
                $("#inputImg").val(imgpath);
                layer.msg('上传成功！')
                layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', imgpath);
            },
            error: function (res) {
                //请求异常回调
                alert(res)
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
            /*         parent.layer.alert(JSON.stringify(data.field), {
                         title: '最终的提交信息'
                     })*/
            // return false;
            //关闭小框
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);//关闭当前弹窗页面

        });

        //二级联动
        form.on('select(categoryId)', function (data) {

            var categoryId = data.value
            // alert(categoryId)
            $.get("/pet/getvariety?id=" + categoryId, function (data) {

                console.log(data)
                $("#varietyId").empty();
                $('#varietyId').append($('<option value="">选择品种</option>'))
                if (data.length > 0) {
                    data.forEach(function (e) {
                        var node = '<option value=' + e.id + '>' + e.name + '</option>'
                        $('#varietyId').append($(node))
                    });
                } else {
                    $('#varietyId').append($('<option value="">赞无品种，管理员添加品种后才能选择！</option>'))
                }
                layui.form.render("select");//重新渲染 固定写法
            });
        });


    });


</script>
</body>
</html>
