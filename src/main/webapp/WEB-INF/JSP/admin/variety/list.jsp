<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>开启头部工具栏 - 数据表格</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
    <script src="${pageContext.request.contextPath}/layuiadmin/js/jquery-3.3.1.js"></script>

</head>
<body>

<div class="layui-card layadmin-header">
    <div class="layui-breadcrumb" lay-filter="breadcrumb">
        <a lay-href="">主页</a>
        <a><cite>组件</cite></a>
        <a><cite>数据表格</cite></a>
        <a><cite>开启头部工具栏</cite></a>
    </div>
</div>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">宠物类别列表</div>
                <div class="layui-card-body">


                    <div class="layui-row" align="center" style="height: 40px">

                        <form class="layui-form layui-col-md12 x-so" method="get">

                            <input type="text" id="queryContent" name="content" style="width:50%;"
                                   placeholder="请输入类别名，或者品种名，来查询指定数据..."
                                   autocomplete="off" class="layui-input">
                            <button type="button" class="layui-btn" style="margin-top: -65px;margin-left: 50%"
                                    data-type="reload" id="queryRole"><i class="layui-icon">&#xe615;</i></button>

                        </form>

                    </div>


                    <table class="layui-hide" id="test-table-toolbar" lay-filter="test-table-toolbar"></table>
                    <script type="text/html" id="test-table-toolbar-toolbarDemo">
                        <div class="layui-btn-container">

                            <button class="layui-btn layuiadmin-btn-tags" lay-event="getCheckData"
                                    style="background-color: #FF5722">
                                批量删除
                            </button>
                            <button class="layui-btn layuiadmin-btn-tags" lay-event="addCategory">添加</button>

                        </div>
                    </script>

                    <script type="text/html" id="test-table-toolbar-barDemo">
                        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table'], function () {
        var admin = layui.admin
            , table = layui.table;
        var tableIns = table.render({
            elem: '#test-table-toolbar'
            , url: "${pageContext.request.contextPath}/variety/list"
            , toolbar: '#test-table-toolbar-toolbarDemo'
            , title: '用户数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true}
                , {field: 'cname', title: '宠物类别', width: 100, sort: true}
                , {field: 'name', title: '宠物品种', width: 880, sort: true}

                , {fixed: 'right', title: '操作', toolbar: '#test-table-toolbar-barDemo'}
            ]]
            , page: true
            , limit: 5
            , limits: [2, 3, 4, 5, 6, 7, 8]
        });

        //头工具栏事件
        table.on('toolbar(test-table-toolbar)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'getCheckData':
                    //批量删除
                    var data = checkStatus.data;
                    //layer.alert(JSON.stringify(data));
                    var ids = [];
                    for (let i = 0; i < data.length; i++) {
                        ids.push(data[i].id)
                    }
                    if (ids.length == 0) {
                        layer.alert('您未选中任何数据！')
                    } else {

                        layer.alert('确认删除这' + data.length + '条数据吗？', function (index) {
                            layer.close(index)
                            $.post("/variety/delBatches", {ids}, function (res) {
                                layer.alert("已删除" + data.length + "条数据");
                                //刷新列表
                                $('#queryRole').trigger("click", 5)
                            });
                        })
                    }
                    break;

                case 'addCategory':
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        // offset: [10],
                        area: ['1050px', '598px'],
                        end: function () {
                            //刷新页面
                            $('#queryRole').trigger("click", 5)
                        },
                        content: "/variety/toAdd"
                    });
                    break;

            }
            ;
        });

        //监听行工具事件
        table.on('tool(test-table-toolbar)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('确认删除此条数据吗？', function (index) {
                    obj.del();
                    layer.close(index);
                    //请求接口
                    $.post("/variety/del", {id: data.id}, function (res) {
                        //刷新列表
                        $('#queryRole').trigger("click", 5)
                    });
                });
            } else if (obj.event === 'edit') {

                layer.open({
                    type: 2,
                    title: false,
                    closeBtn: 0,
                    shadeClose: true,
                    // offset: [100],
                    skin: 'yourClass',
                    area: ['465px', '275px'],
                    end: function () {
                        //刷新页面
                        $('#queryRole').trigger("click", 5)
                        // layer.alert("修改成功！")
                    },
                    content: "/variety/toUpd?id=" + data.id
                });

            }
        });

        $('#queryRole').on('click', function (event, n) {
            var queryContent = $('#queryContent').val()
            //layer.alert(queryContent)
            if (n) {
                tableIns.reload({
                    url: '${pageContext.request.contextPath}/variety/list?content=' + queryContent
                })
                return;
            }
            tableIns.reload({
                url: '${pageContext.request.contextPath}/variety/list?content=' + queryContent
                , page: {
                    curr: 1
                }
            })
        });
    });
</script>
</body>
</html>