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
<style type="text/css">
    /* {# 设置table每一行的height #}*/
    .layui-table-cell {
        height: auto;
    }

    .layui-btn-primary {
        border-radius: 5px;
    }

    * {
        margin: 0;
        padding: 0;
    }


</style>
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
                <div class="layui-card-header">领养申请信息列表</div>
                <div class="layui-card-body">

                    <div class="layui-row" align="center" style="height: 40px">

                        <form class="layui-form layui-col-md12 x-so" method="get">

                            <div style="float: left">
                                <div class="layui-inline" style="font-size: 15px">
                                    审核状态筛选：
                                </div>
                                <div class="layui-inline" style="width: 100px">
                                    <select name="chooseStatus"
                                            lay-filter="chooseStatus" id="chooseStatus">
                                        <option value="">全部</option>
                                        <option value="待审核">待审核</option>
                                        <option value="通过">已通过</option>
                                        <option value="驳回">已驳回</option>
                                    </select>
                                </div>
                            </div>


                            <input type="text" id="queryContent" name="content"
                                   style="width:440px;float: left;margin-left:210px"
                                   placeholder="您可以输入用户名，宠物名，住址等来检索数据..."
                                   autocomplete="off" class="layui-input">
                            <button type="button" class="layui-btn" style="margin-top: -65px;margin-left: 35%"
                                    data-type="reload" id="queryRole"><i class="layui-icon">&#xe615;</i></button>
                        </form>

                    </div>


                    <table class="layui-hide" id="test-table-toolbar" lay-filter="test-table-toolbar"></table>
                    <script type="text/html" id="test-table-toolbar-toolbarDemo">
                        <div class="layui-btn-container">
                            <button class="layui-btn layui-btn-sm" lay-event="getCheckData"
                                    style="background-color: #FF5722">
                                批量删除
                            </button>
                            <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
                            <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
                        </div>
                    </script>

                    <script type="text/html" id="test-table-toolbar-barDemo">
                        <a class="layui-btn layui-btn-xs" lay-event="edit">审核</a>
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
            , table = layui.table
            , form = layui.form;
        var tableIns = table.render({
            elem: '#test-table-toolbar'
            , url: "${pageContext.request.contextPath}/adopt/list"
            , toolbar: '#test-table-toolbar-toolbarDemo'
            , title: '用户数据表'
            , cols: [[
                {type: 'checkbox',}
                , {field: 'id', title: 'ID', width: 85, unresize: true, sort: true}
                , {field: 'uname', title: '用户姓名', width: 115, sort: true}
                , {field: 'pname', title: '宠物姓名', width: 115, sort: true}

                , {field: 'message', title: '申请理由', width: 150,}
                , {field: 'wechat', title: '微信号', width: 120,}
                , {field: 'uphone', title: '手机号', width: 120,}
                , {field: 'uaddress', title: '住址', width: 130}
                , {field: 'createtime', title: '申请时间', width: 120, sort: true}
                , {
                    field: 'vtype',
                    title: '审核状态',
                    width: 120,
                    sort: true,
                    fixed: 'right',
                    templet: function (res) {
                        if (res.verifyStatusId == 1) {
                            return '<button disabled="disabled" class="layui-btn layui-btn-primary layui-btn-danger">待审核</button>'
                        } else if (res.verifyStatusId == 2) {
                            return '<button disabled="disabled" class="layui-btn layui-btn-primary layui-btn-checked">已通过</button>'
                        } else {
                            return '<button disabled="disabled" class="layui-btn layui-btn-primary layui-btn-normal">已驳回</button>'
                        }
                    }
                }
                , {title: '操作', fixed: 'right', toolbar: '#test-table-toolbar-barDemo'}
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
                            $.post("/adopt/delBatches", {ids}, function (res) {
                                layer.alert("已删除" + data.length + "条数据");
                                //刷新列表
                                $('#queryRole').trigger("click", 5)
                            });
                        })
                    }
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：' + data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选' : '未全选');
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
                    $.post("/adopt/del", {id: data.id}, function (res) {
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
                    skin: 'yourClass',
                    // offset: [50],
                    area: ['465px', '260px'],
                    end: function () {
                        //刷新页面
                        $('#queryRole').trigger("click", 5)
                        //layer.alert("修改成功！")
                    },
                    content: "/adopt/toUpd?id=" + data.id
                });
            }
        });


        //下拉框筛选审核状态
        form.on('select(chooseStatus)', function (data) {
            var chooseStatus = data.value
            tableIns.reload({
                url: '${pageContext.request.contextPath}/adopt/list?content=' + chooseStatus
            })
        });


        $('#queryRole').on('click', function (event, n) {
            var queryContent = $('#queryContent').val()
            //layer.alert(queryContent)
            if (n) {
                tableIns.reload({
                    url: '${pageContext.request.contextPath}/adopt/list?content=' + queryContent
                })
                return;
            }
            tableIns.reload({
                url: '${pageContext.request.contextPath}/adopt/list?content=' + queryContent
                , page: {
                    curr: 1
                }
            })
        });
    });
</script>


</body>
</html>