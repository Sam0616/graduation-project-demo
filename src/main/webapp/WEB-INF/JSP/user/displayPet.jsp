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
            background-color: lightgray ;
        }

        #box {
            margin-left: 20px;
            width: 540px ;
            height: 500px ;
            padding: 20px ;
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
    <span style="font-weight: bold">描述：</span><span>${pet.description}</span>
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
                <span style="float: right;margin-right: 2px;margin-top: 2px"><i class="layui-icon layui-icon-time" style="font-size: 12px;font-weight: lighter">&nbsp;&nbsp;${comment.createtime}</i></span>
            </blockquote>
        </c:forEach>
    </c:if>



</div>

<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->
</body>
</html>
