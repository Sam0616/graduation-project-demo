<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>动物领养后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/x-icon"/>

    <link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../layuiadmin/style/admin.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/js/jquery-3.3.1.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/js/fkjava_timer.js"></script>
    <!-- <script>
      /^http(s*):\/\//.test(location.href) || alert('请先部署到 localhost 下再访问');
    </script> -->
    <script>

        $(function () {
            $("#nowTime").runTimer();
            var calendar = showCal();
            $("#currentDate").text("农历" + calendar);
        });

    </script>
</head>
<body class="layui-layout-body">

<div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layadmin-flexible" lay-unselect>
                    <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
                        <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="http://www.layui.com/admin/" target="_blank" title="前台">
                        <i class="layui-icon layui-icon-website"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" layadmin-event="refresh" title="刷新">
                        <i class="layui-icon layui-icon-refresh-3"></i>
                    </a>
                </li>

                <%--                <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search"
                                       layadmin-event="serach" lay-action="template/search.html?keywords=">--%>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <div class="left_open ">
                        <p style="color:#009688;margin-left:150px;">当前时间 ：<span id="nowTime"></span></p>
                    </div>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <div class="left_open">
                        <p style="color:#009688;margin-left:14px;"><span id="currentDate"></span></p>
                    </div>
                </li>

            </ul>
            <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">

                <li class="layui-nav-item" lay-unselect>
                    <a lay-href="app/message/index.html" layadmin-event="message" lay-text="消息中心">
                        <i class="layui-icon layui-icon-notice"></i>

                        <!-- 如果有新消息，则显示小圆点 -->
                        <span class="layui-badge-dot"></span>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="theme">
                        <i class="layui-icon layui-icon-theme"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="note">
                        <i class="layui-icon layui-icon-note"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="fullscreen">
                        <i class="layui-icon layui-icon-screen-full"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;"><img src="/img/headImg.gif" style="width: 35px;height: 35px"
                                                class="layui-nav-img">我</a>


                    <%--         <div class="layui-card-body">
                                 <ul class="layui-nav" lay-filter="component-nav">
                                     <li class="layui-nav-item">
                                         <a href="javascript:;">控制台<span class="layui-badge">9</span></a>
                                     </li>
                                     <li class="layui-nav-item">
                                         <a href="javascript:;">个人中心<span class="layui-badge-dot"></span></a>
                                     </li>
                                     <li class="layui-nav-item" lay-unselect="">
                                         <a href="javascript:;"><img src="http://t.cn/RCzsdCq" class="layui-nav-img">我</a>
                                         <dl class="layui-nav-child">
                                             <dd><a href="javascript:;">修改信息</a></dd>
                                             <dd><a href="javascript:;">安全管理</a></dd>
                                             <dd><a href="javascript:;">退了</a></dd>
                                         </dl>
                                     </li>
                                 </ul>
                             </div>
         --%>


                    <dl class="layui-nav-child">
                        <dd><a lay-href="set/user/info.html">基本资料</a></dd>
                        <dd><a lay-href="set/user/password.html">修改密码</a></dd>
                        <hr>
                        <dd layadmin-event="logout" style="text-align: center;"><a>退出</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="about"><i
                            class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
                <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
                    <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
            </ul>
        </div>

        <!-- 侧边菜单 -->
        <div class="layui-side layui-side-menu">
            <div class="layui-side-scroll">
                <div class="layui-logo" lay-href="home/console.html">
                    <span>动物领养后台管理系统</span>
                </div>

                <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu"
                    lay-filter="layadmin-system-side-menu">
                    <li data-name="home" class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;" lay-tips="主页" lay-direction="2">
                            <i class="layui-icon layui-icon-home"></i>
                            <cite>主页</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd data-name="console" class="layui-this">
                                <a lay-href="/home/console.html">控制台</a>
                            </dd>
                            <dd data-name="console">
                                <a lay-href="/home/homepage1.html">主页一</a>
                            </dd>
                            <dd data-name="console">
                                <a lay-href="/home/homepage2.html">主页二</a>
                            </dd>
                        </dl>
                    </li>


                    <li data-name="component" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="用户信息管理" lay-direction="2">
                            <i class="layui-icon layui-icon-user"></i>
                            <cite>用户信息管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd data-name="grid">
                                <a lay-href="/user/toList">用户信息列表</a>
                            </dd>
                            <dd data-name="button">
                                <a lay-href="/user/toAdd">添加用户</a>
                            </dd>
                        </dl>
                    </li>


                    <li data-name="template" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="管理员信息管理" lay-direction="2">
                            <i class="layui-icon layui-icon-friends"></i>
                            <cite>管理员信息管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a lay-href="/admin/tolist">管理员信息列表</a>
                            </dd>
                            <dd>
                                <a lay-href="/admin/toAdd">添加管理员</a>
                            </dd>
                        </dl>
                    </li>


                    <li data-name="template" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="宠物信息管理" lay-direction="2">
                            <i class="layui-icon layui-icon-template"></i>
                            <cite>宠物信息管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a lay-href="/pet/toList">宠物信息列表</a></dd>
                            <dd><a lay-href="/pet/toAdd">添加宠物</a></dd>
                            <dd><a lay-href="/category/toList">宠物类别列表</a></dd>
                            <dd><a lay-href="/variety/toList">宠物品种列表</a></dd>
                        </dl>
                    </li>


                    <li data-name="app" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="领养模块管理" lay-direction="2">
                            <i class="layui-icon layui-icon-app"></i>
                            <cite>领养管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a lay-href="/adopt/toList">领养申请列表</a></dd>
                            <dd><a lay-href="/adopt/toAdd">待定</a></dd>

                        </dl>
                    </li>



                    <li data-name="app" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="文章模块管理" lay-direction="2">
                            <i class="layui-icon layui-icon-app"></i>
                            <cite>文章模块管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a lay-href="/article/toList">文章列表</a></dd>
                            <dd><a lay-href="/article/toAdd">添加文章</a></dd>

                        </dl>
                    </li>
                    <li data-name="app" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="评论模块管理" lay-direction="2">
                            <i class="layui-icon layui-icon-app"></i>
                            <cite>评论模块管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a lay-href="/comment/toList">评论列表</a></dd>
                            <dd><a lay-href="/comment/toAdd">待定</a></dd>

                        </dl>
                    </li>



                    <li data-name="app" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="留言板模块管理" lay-direction="2">
                            <i class="layui-icon layui-icon-app"></i>
                            <cite>留言板模块管理</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a lay-href="/board/toList">评论列表</a></dd>
                            <dd><a lay-href="/board/toAdd">待定</a></dd>
                        </dl>
                    </li>



                    <li data-name="senior" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="高级" lay-direction="2">
                            <i class="layui-icon layui-icon-senior"></i>
                            <cite>高级</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a layadmin-event="im">LayIM 通讯系统</a>
                            </dd>
                            <dd data-name="echarts">
                                <a href="javascript:;">Echarts集成</a>
                                <dl class="layui-nav-child">
                                    <dd><a lay-href="senior/echarts/line.html">折线图</a></dd>
                                    <dd><a lay-href="senior/echarts/bar.html">柱状图</a></dd>
                                    <dd><a lay-href="senior/echarts/map.html">地图</a></dd>
                                </dl>
                            </dd>
                        </dl>
                    </li>

                    <li data-name="set" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="设置" lay-direction="2">
                            <i class="layui-icon layui-icon-set"></i>
                            <cite>设置</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd class="layui-nav-itemed">
                                <a href="javascript:;">系统设置</a>
                                <dl class="layui-nav-child">
                                    <dd><a lay-href="set/system/website.html">网站设置</a></dd>
                                    <dd><a lay-href="set/system/email.html">邮件服务</a></dd>
                                </dl>
                            </dd>
                            <dd class="layui-nav-itemed">
                                <a href="javascript:;">我的设置</a>
                                <dl class="layui-nav-child">
                                    <dd><a lay-href="set/user/info.html">基本资料</a></dd>
                                    <dd><a lay-href="set/user/password.html">修改密码</a></dd>
                                </dl>
                            </dd>
                        </dl>
                    </li>
                    <li data-name="get" class="layui-nav-item">
                        <a href="javascript:;" lay-href="//www.layui.com/admin/#get" lay-tips="授权" lay-direction="2">
                            <i class="layui-icon layui-icon-auz"></i>
                            <cite>授权</cite>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 页面标签 -->
        <div class="layadmin-pagetabs" id="LAY_app_tabs">
            <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-down">
                <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                    <li class="layui-nav-item" lay-unselect>
                        <a href="javascript:;"></a>
                        <dl class="layui-nav-child layui-anim-fadein">
                            <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                            <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                            <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
            <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
                <ul class="layui-tab-title" id="LAY_app_tabsheader">
                    <li lay-id="home/console.html" lay-attr="home/console.html" class="layui-this"><i
                            class="layui-icon layui-icon-home"></i></li>
                </ul>
            </div>
        </div>






        <!-- 主体内容 -->
        <div class="layui-body" id="LAY_app_body">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="home/console.html" frameborder="0" class="layadmin-iframe"></iframe>
            </div>
        </div>


        <!-- 辅助元素，一般用于移动设备下遮罩 -->
        <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
</div>

<script src="../layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '../layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use('index');
</script>
<script>
    $.support.transition = false;
</script>

</body>
</html>


