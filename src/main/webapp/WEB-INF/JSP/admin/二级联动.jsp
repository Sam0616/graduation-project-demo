<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form class="layui-form" action="">
    <label class="layui-form-label">学校：</label>
    <div class="layui-inline">
        <select name="schoolId" lay-verify="required" lay-filter="schoolId" id="schoolId" lay-search>
            <option value="">请选择学校</option>
        </select>
    </div>

    专业:
    <div class="layui-inline">
        <select name="zyId" lay-verify="required" lay-filter="zyId" id="zyId"
                lay-search>
            <option value="">请选择专业</option>
        </select>
    </div>

    <button type="button" class="layui-btn" data-type="reload" id="search">搜索</button>
    <button type="reset" class="layui-btn">重置</button>
</form>

<script>
    ctxPath = /*[[@{/}]]*/ '';

    layui.use(['element', 'form'], function () {
        var element = layui.element,
            form = layui.form;
        $(function () {
            $.ajax({
                async: false,
                type: "POST",
                url: ctxPath + 'school/selectAll',
                success: function (result) {
                    if (result.code === 0) {
                        var list = result.data;
                        var s = '<option value="">请选择学校</option>';
                        $.each(list, function (i, company) {
                            console.log(company.name);
                            s = s + '<option value="' + company.id + '">' + company.name + '</option>';
                        });
                        $("#schoolId").html(s);
                        form.render('select');
                    }
                }
            });
        });

        form.on('select(schoolId)', function (data) {
            var companyId = data.value;
            var s = '<option value="">请选择专业</option>';
            if (companyId == '') {
                $("#xyId").html(s);
                form.render('select');
            } else {
                $.ajax({
                    async: false,
                    type: "POST", //提交方式
                    url: ctxPath + 'xx/selectxxId',//路径
                    data: {
                        companyId: companyId
                    },
                    success: function (result) {
                        if (result.code === 0) {
                            var list = result.data;
                            $.each(list, function (i, ss) {
                                s = s + '<option value="' + ss.id + '">' + ss.name + '</option>';
                            });
                            $("#xyId").html(s);
                            form.render('select');
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>
