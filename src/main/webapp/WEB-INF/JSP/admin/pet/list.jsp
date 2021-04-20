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
                <div class="layui-card-header">宠物信息列表</div>
                <div class="layui-card-body">


                    <div class="layui-row" align="center" style="height: 40px">

                        <form class="layui-form layui-col-md12 x-so" method="get">
                            <input type="text" id="queryContent" name="content" style="width:50%;"
                                   placeholder="请输入宠物名，宠物年龄，描述，录入时间，类别，或者品种来查询指定数据..."
                                   autocomplete="off" class="layui-input">
                            <button type="button" class="layui-btn" style="margin-top: -65px;margin-left: 50%"
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
            , url: "${pageContext.request.contextPath}/pet/list"
            , toolbar: '#test-table-toolbar-toolbarDemo'
            , title: '用户数据表'
            , cols: [[
                {type: 'checkbox',}
                , {field: 'id', title: 'ID', width: 60, unresize: true, sort: true}
                , {field: 'petname', title: '宠物名', width: 73}
                , {
                    field: 'imgpath', title: '照片', width: 100, templet: function (res) {
                        return "<img style='height: 70px;width: 70px' alt='图片离家出走啦' src='" + res.imgpath + "'>"
                    }
                }
                , {field: 'cname', title: '类别', width: 72,}
                , {field: 'vname', title: '品种', width: 72,}
                , {field: 'age', title: '年龄', width: 80, sort: true}
                , {
                    field: 'source', title: '来源', width: 90, sort: true, templet: function (res) {
                        if (res.source == 0) {
                            return "流浪宠物";
                        } else {
                            return "送养宠物";
                        }
                    }
                }

                , {
                    field: 'sex', title: '性别', width: 80, sort: true, templet: function (res) {
                        if (res.sex == 1) {
                            return "雌性";
                        } else {
                            return "雄性";
                        }
                    }
                }
                , {
                    field: 'status', title: '领养状态', width: 105, sort: true, templet: function (res) {
                        if (res.status == 0) {
                            return "待领养";
                        } else if (res.status == 1) {
                            return "申请中";
                        } else {
                            return "被领养"
                        }
                    }
                }
                , {field: 'description', title: '描述', width: 90, sort: true, sort: true}
                , {
                    field: 'vaccine', title: '疫苗接种情况', width: 130, sort: true, templet: function (res) {
                        if (res.vaccine == 1) {
                            return "已经接种";
                        } else {
                            return "未接种";
                        }
                    }
                }
                , {field: 'createtime', title: '录入时间', width: 105, sort: true}
                , {title: '操作', toolbar: '#test-table-toolbar-barDemo'}
            ]]
            , page: true
            , limit: 4
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
                            $.post("/pet/delBatches", {ids}, function (res) {
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
                    $.post("/pet/del", {id: data.id}, function (res) {
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
                    area: ['900px', '610px'],
                    end: function () {
                        //刷新页面
                        $('#queryRole').trigger("click", 5)
                        //layer.alert("修改成功！")
                    },
                    content: "/pet/toUpd?id=" + data.id
                });
            }
        });

        $('#queryRole').on('click', function (event, n) {
            var queryContent = $('#queryContent').val()
            //layer.alert(queryContent)
            if (n) {
                tableIns.reload({
                    url: '${pageContext.request.contextPath}/pet/list?content=' + queryContent
                })
                return;
            }
            tableIns.reload({
                url: '${pageContext.request.contextPath}/pet/list?content=' + queryContent
                , page: {
                    curr: 1
                }
            })
        });
    });
</script>


</body>
</html>