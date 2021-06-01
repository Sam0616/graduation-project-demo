<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>

<html>

<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->

    <style>
        body {
            background-color: lightgray;
        }

        #box {
            margin-left: 20px;
            width: 540px;
            height: 500px;
            padding: 20px;
        }
    </style>
</head>

<body>

<div id="box" style="">

    <h3><span style="margin-left: 235px"></span>宠物详情</h3>
    <hr>
    <br>
    <span><span style="font-weight: bold">宠物名：</span>${pet.petname}</span>
    <br>


    <br>
    <span><span style="font-weight: bold">年龄：</span>${pet.age}岁</span>
    <br>
    <br>
    <span style="font-weight: bold">来源：</span><span>${pet.source==0?'流浪宠物':'送养宠物'}</span>
    <br>
    <br>
    <span style="font-weight: bold">性别：</span><span>${pet.sex==0?'雄性':'雌性'}</span>
    <br>
    <br>
    <span><span style="font-weight: bold">领养状态：</span>${pet.status==0?'待领养':pet.status==1 ? '被申请中(您仍可申请)':'被领养' }</span>
    <br>
    <br>
    <span style="font-weight: bold">疫苗接种：</span><span>${pet.vaccine==1?'未接种':'已接种'}</span>
    <br>
    <br>
    <span style="font-weight: bold">描述：</span><span>${pet.description}</span><BR><BR>
    <BUTTON type="button" class="button gray" ><span onclick="lingyang(${pet.id})" style="font-weight: bold">领养我叭</span></BUTTON>

    <br>
    <br>
    <hr>
    <br>
    <span style="font-weight: bold">评论：</span><span></span><br><br>

    <c:if test="${comments==[]}">
        <blockquote class="layui-elem-quote layui-quote-nm">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这只宝贝暂无评论，快来评论吧!
        </blockquote>
    </c:if>
    <c:if test="${comments!=null}">
        <c:forEach var="comment" items="${comments}">
            <blockquote class="layui-elem-quote layui-quote-nm">
                <div class="layui-inline">
                    <img src="${comment.uimgpath}" class="layui-circle" style="width:30px;height: 30px">
                </div>
                <SPAN style="color: #2E8AE7">${comment.uname}</SPAN>：${comment.content}
                <span style="float: right;margin-right: 2px;margin-top: 2px"><i class="layui-icon layui-icon-time"
                                                                                style="font-size: 12px;font-weight: lighter">&nbsp;&nbsp;${comment.createtime}</i></span>
            </blockquote>
        </c:forEach>
    </c:if>


</div>
<script src="${pageContext.request.contextPath}/layuiadmin/js/jquery-3.3.1.js"></script>

<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->

<script>

    function lingyang(id) {
        //*********弹框开始位置**********
        layui.config({
            base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'table'], function () {
            //判断生日是否存在来确定是否完善个人信息
            $.get("/user/checkComplete?petId=" + id, function (res) {
                // console.log(res.msg)
                if (res.msg == '0') {
                    layer.msg("请先完善个人信息！！！")
                    return;
                } else {
                    if (res.experience == 1) {
                        layer.confirm('您已经申请过该宠物，继续申请将覆盖之前的申请，确定继续？', function (index) {
                            layer.open({
                                type: 2,
                                title: false,
                                closeBtn: 0,
                                shadeClose: true,
                                // offset: [100],
                                skin: 'yourClass',
                                area: ['580px', '310px'],
                                end: function () {

                                },
                                content: "/user/toAdopt?id=" + id
                            });
                            layer.close(index);
                        });
                    } else {
                        layer.open({
                            type: 2,
                            title: false,
                            closeBtn: 0,
                            shadeClose: true,
                            // offset: [100],
                            skin: 'yourClass',
                            area: ['580px', '310px'],
                            end: function () {

                            },
                            content: "/user/toAdopt?id=" + id
                        });
                    }
                }
            })
        })


        //*********弹框结束位置***************
    }
</script>
</body>
</html>
