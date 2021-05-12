<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>前台添加宠物评论</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../../layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../../layuiadmin/style/admin.css" media="all">
    <script src="${pageContext.request.contextPath}/layuiadmin/js/jquery-3.3.1.js"></script>

</head>
<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-header">添加宠物评论</div>
        <div class="layui-card-body" style="padding: 15px;">
            <form class="layui-form" method="post"
                  action="${pageContext.request.contextPath}/user/addCommentIng?petId=${id}"
                  lay-filter="component-form-group">

                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">请输入:</label>
                        <div class="layui-input-block">
                            <textarea style="width: 342px;height: 136px;" placeholder="说点什么吧" lay-verify="commentPet"
                                      class="layui-textarea" id="content" name="content"></textarea>
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

        /* 自定义验证规则 */
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , commentPet: function (value) {
                var reg = /(你妈的)|(你大爷)|(他妈的)|(你麻痹)|(尼玛的)|(艹你)|(丢你老母)|(操你嘴)|(日他姐)|(妈蛋)|(妈逼)|(去死吧)|(麻痹)/g;//这个就是正则式了，将想过滤的词汇放在这里
                var str = value.trim().match(reg);
                if (str != null) {
                    var arrStr = str.join("\",\"");//match可以将符合的词汇挑出来组成一个数组
                    // alert(arrStr.length)
                    if (arrStr.length > 0) {
                        // layer.msg("请不要使用\"" + str + "\"等不文明词汇！", {time: 2000, shift: 6, icon: 5})
                        return "请不要使用\"" + str + "\"等不文明词汇！";
                    }
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

        });
    });
</script>
</body>
</html>
