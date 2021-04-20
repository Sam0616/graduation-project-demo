<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="../../layuiadmin/style/template.css" media="all">
    <%--    <script src="layuiadmin/js/jquery-3.3.1.js"></script>--%>
</head>
<body>

<div class="layui-fluid">
    <div class="layadmin-caller">
        <form class="layui-form caller-seach" id="myform"
              action="${pageContext.request.contextPath}/article/toList">
            <i class="layui-icon layui-icon-search caller-seach-icon caller-icon" id="find"></i>
            <input type="text" name="content" required lay-verify="required" placeholder="请输入关键字检索文章"
                   autocomplete="off" id="content" class="layui-input caller-pl32">
            <i class="layui-icon layui-icon-close caller-dump-icon caller-icon" id="clean"></i>
        </form>
        <div class="layui-tab layui-tab-brief caller-tab" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">文章列表</li>
            </ul>
        </div>

        <div class="caller-contar">
            <c:forEach items="${list}" var="item">

                <div class="caller-item">
                    <img src="${item.imgpath}" alt="头像" class="caller-img caller-fl">
                    <div class="caller-main caller-fl" style="width: 100%">
                        <p style="margin-left: 39px;margin-top: -39px"><i class="layui-icon layui-icon-username"
                                                                          style="font-size: 14px">发布人：</i><strong>${item.adname}</strong><span
                                style="float: right;margin-right: 21px"><i class="layui-icon layui-icon-time"
                                                                           style="font-size: 14px;">发布时间：</i>${item.createtime}</span>
                        </p>
                        <p style="margin-left: 39px " class="caller-adds"><i class="layui-icon layui-icon-read"
                                                                             style="font-size: 14px">Title：</i>${item.title}

                                <%--                            <input type="hidden" id="input_hidden" value="${item.id}">--%>
                            <button style="margin-right: 20px;margin-top: 50px" lay-event="edit" id="btn"
                                    onclick="edit(${item.id})"
                                    class="layui-btn layui-btn-sm layui-btn layui-btn-primary caller-fr">
                                查看 / 编辑
                            </button>
                        </p>
                        <p style="margin-left: 39px " class="caller-adds"><i class="layui-icon layui-icon-read"
                                                                             style="font-size: 14px">文章类别：</i>${item.articleType}
                        </p>
                        <div class="caller-iconset" style="margin-left: 39px">
                            <i title="phone:${item.adphone}" class="layui-icon layui-icon-cellphone"></i>
                            <i title="email:${item.ademail}" class="layui-icon layui-icon-at"></i>
                            <i title="删除" style="font-size: 20px" onclick="del(${item.id})" id="del"
                               class="layui-icon layui-icon-delete"></i>
                        </div>
                    </div>
                </div>

            </c:forEach>
        </div>

        <div id="demo1" style="text-align: center"></div>
    </div>
</div>


<script src="../../layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'laypage', 'layer', 'form', 'layedit', 'table', 'laydate', 'element', 'jquery'], function () {
        var form = layui.form,
            layer = layui.layer,
            element = layui.element,
            $ = layui.jquery;
        var layedit = layui.layedit;


        var laypage = layui.laypage, layer = layui.layer;
        //执行一个laypage实例
        var tableIns = laypage.render({
            elem: 'demo1'
            , count:${count}//数据总数，从服务端得到
            , curr:${pageNo}
            , limit:${pageSize}
            , jump: function (obj, first) {
                //obj包含了当前分页的所有参数，比如：
                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数
                //首次不执行
                if (!first) {
                    //do something
                    //调用后台
                    window.location.href = "${pageContext.request.contextPath}/article/toList?pageNo=" + obj.curr + "&pageSize=" + obj.limit;
                }
            }
        });


        //修改
        /*        $(document).on('click', '#btn', function () {
                    var id = $('#input_hidden').val()
                    alert(id)
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        offset: [80],
                        skin: 'yourClass',
                        area: ['850px', '500px'],
                        end: function () {
                            //刷新页面
                            $('#queryRole').trigger("click", 5)
                            // layer.alert("修改成功！")
                        },
                        content: "/article/toUpd?id=" + id
                    });
                });*/


        //这样绑定可以实时监听input框的变化
        $(document).on('input propertychange', '#content', function () {
            /*      var search = $('#content').val()
                  console.log(search)
                  $.post('/article/toList', {content: search}, function (res) {
                  })*/
            // $("#myform").submit()
        });

        //清空输入框
        $(document).on('click', '#clean', function () {
            $('#content').val('')
        });

        //提交
        $(document).on('click', '#find', function () {
            $("#myform").submit()
        });

        //删除
        /*        $(document).on('click', '#del', function () {
                    layer.confirm('确认删除这篇文章吗？', function (index) {
                        layer.close(index);
                        //请求接口
                        var id = $('#input_hidden').val()
                        $.post('/article/del', {id: id}, function (res) {
                            if (res == "true") {
                                layer.msg("删除成功！", {icon: 1})
                            } else {
                                layer.msg("未知错误，删除失败！", {time: 2000, shift: 6, icon: 5})
                            }
                            //刷新页面
                            setTimeout(function () {
                                $("#myform").submit()
                            }, 1000)
                        })
                    });
                });*/
    });

    //删除
    function del(id) {
        layer.confirm('确认删除这篇文章吗？', function (index) {
            layer.close(index);
            //请求接口
            var id = $('#input_hidden').val()
            $.post('/article/del', {id: id}, function (res) {
                if (res == "true") {
                    layer.msg("删除成功！", {icon: 1})
                } else {
                    layer.msg("未知错误，删除失败！", {time: 2000, shift: 6, icon: 5})
                }
                //刷新页面
                setTimeout(function () {
                    $("#myform").submit()
                }, 1000)
            })
        });
    }

    //修改
    function edit(id) {
        layer.open({
            type: 2,
            title: false,
            closeBtn: 0,
            shadeClose: true,
            skin: 'yourClass',
            area: ['850px', '600px'],
            end: function () {
                // layer.msg("修改成功！", {icon: 1})
              //  location.href = "/article/toList"
            },
            content: "/article/toUpd?id=" + id
        });
    }


</script>

</body>
</html>