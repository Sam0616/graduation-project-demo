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
<style>
    #LAY_demo1 {
   /*     width: 600px !important;
        height: 800px !important;*/
    }
</style>

<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">文章内容</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" method="post"
                  action="${pageContext.request.contextPath}/article/upd?id=${article.id}"
                  lay-filter="component-form-group">

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="margin-left: 50px">文章Title</label>
                        <div class="layui-input-inline">
                            <input readonly type="text" name="title" lay-verify="required" autocomplete="off"
                                   value="${article.title}"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">文章类别</label>
                        <div class="layui-input-inline">
                            <input readonly type="text" name="articleType" lay-verify="required" autocomplete="off"
                                   value="${article.articleType}"
                                   class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">

                    <div class="layui-inline">
                        <div class="layui-input-inline" style="width:793px;height: auto">

                            <textarea class="layui-textarea" id="LAY_demo1" name="content" style="height: 368px" readonly
                            >${article.content}</textarea>

                        </div>
                    </div>
                </div>


                <div class="layui-form-item layui-layout-admin">
                    <div class="layui-input-block">
                        <div class="layui-footer" style="left: 0;">
                            <button type="button" class="layui-btn" lay-submit="" lay-filter="component-form-demo1">
                                关闭弹层
                            </button>
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
    }).use(['index', 'form', 'laydate', 'layedit'], function () {
        var $ = layui.$
            , admin = layui.admin
            , element = layui.element
            , layer = layui.layer
            , laydate = layui.laydate
            , form = layui.form;

        var layedit = layui.layedit
            , $ = layui.jquery;

        form.render(null, 'component-form-group');

        laydate.render({
            elem: '#LAY-component-form-group-date'

        });


        //构建一个默认的编辑器
        var index = layedit.build('LAY_demo1');


        /*网上粘贴的，不知道怎么用
        var editor = new UE.ui.Editor({ initialFrameHeight:100,initialFrameWidth:400 });
        editor.render("myEditor");
        //1.2.4版本以后可以使用一下代码实例化编辑器
        var editor = UE.getEditor('myEditor');*/



        //编辑器外部操作      没用到
        var active = {
            content: function () {
                alert(layedit.getContent(index)); //获取编辑器内容
            }
            , text: function () {
                alert(layedit.getText(index)); //获取编辑器纯文本内容
            }
            , selection: function () {
                alert(layedit.getSelection(index));
            }
        };
        $('.site-demo-layedit').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        /* 自定义验证规则 */
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , password: function (value) {
                if ($("#password").val().trim() != value.trim()) {
                    return "两次密码输入不一致";
                }
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
            /*  setTimeout(function () {
                  parent.location.href = "/article/toList"
              },10)*/


        });
    });
</script>
</body>
</html>
