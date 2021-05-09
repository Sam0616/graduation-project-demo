<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!doctype html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>流浪小动物领养平台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <%--    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/user_student/assets/i/favicon.png">--%>
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.png" type="image/x-icon"/>

    <link rel="icon" sizes="192x192"
          href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed"
          href="${pageContext.request.contextPath}/qiantai_user/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/qiantai_user/assets/css/app.css">
    <style>
        .button.gray {
            color: #8c96a0;
            text-shadow: 1px 1px 1px #fff;
            border: 1px solid #dce1e6;
            box-shadow: 0 1px 2px #fff inset, 0 -1px 0 #a8abae inset;
            background: -webkit-linear-gradient(top, #f2f3f7, #e4e8ec);
            background: -moz-linear-gradient(top, #f2f3f7, #e4e8ec);
            background: linear-gradient(top, #f2f3f7, #e4e8ec);
        }


        #bolt-container div {
            display: none;
        }


    </style>
</head>

<body id="blog">
<div id="app">
    <header class="am-g am-g-fixed blog-fixed blog-text-center blog-header">
        <div class="am-u-sm-8 am-u-sm-centered">


            <span><img alt="流浪小动物领养平台" style="width: 400px;height: 80px;margin-top: -14px" alt="baidu"
                       src="/agreement_files/logo.png"></span>
        </div>
    </header>
    <hr>
    <!-- nav start -->
    <nav class="am-g am-g-fixed blog-fixed blog-nav">
        <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only blog-button"
                data-am-collapse="{target: '#blog-collapse'}"><span class="am-sr-only">导航切换</span> <span
                class="am-icon-bars"></span></button>

        <div class="am-collapse am-topbar-collapse" id="blog-collapse">
            <ul class="am-nav am-nav-pills am-topbar-nav">
                <li class=""><a href="/front">首页</a></li>
                <li class="am-active"><a href="/user/petList">领养中心</a></li>
                <li><a href="/user/toArticleList">文章动态</a></li>
                <li><a href="/user/toImages">宠图锦集</a></li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        个人领养管理 <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="/user/personalAdopt">查看领养申请</a></li>
                        <li><a href="/user/toSendAdopt">送养宠物</a></li>
                    </ul>
                </li>

                <li class="am-dropdown" data-am-dropdown>
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                        个人信息 <span class="am-icon-caret-down"></span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li><a href="javascript:void (0);" @click="toEditPersonal">完善个人信息</a></li>
                        <li><a href="javascript:void (0);" @click="toEditPersonal2">查看/修改个人信息</a></li>
                        <li><a href="javascript:void (0);" @click="toEditPassword">修改密码</a></li>
                    </ul>
                </li>
                <li><a href="/stulogout">退出登录</a></li>
            </ul>
            <form class="am-topbar-form am-topbar-right am-form-inline" role="search">
                <div class="am-form-group">
                    <input type="text" class="am-form-field am-input-sm" placeholder="搜索" @input="searchFun"
                           v-model="content">
                </div>
            </form>
        </div>
    </nav>
    <hr>
    <!-- nav end -->
    <!-- banner start -->

    <!-- banner end -->

    <!-- content srart -->
    <div class="am-g am-g-fixed blog-fixed">
        <div class="am-u-md-8 am-u-sm-12">


            <article class="am-g blog-entry-article" v-for="pet in pets">
                <div class="am-u-lg-6 am-u-md-12 am-u-sm-12 blog-entry-img">
                    <img style="border-radius: 0px" :src="pet.imgpath" class="am-u-sm-12">
                </div>
                <div class="am-u-lg-6 am-u-md-12 am-u-sm-12 blog-entry-text">
                    <span style="font-weight: bold">昵称:</span>
                    <span style="font-style: italic">{{pet.petname}}</span>
                    <span style="">（{{pet.age}}岁）</span>
                    <hr>
                    <span style="font-weight: bold">宠物类别:</span>
                    <span style="font-weight: bold">{{pet.cname}}</span>
                    <br>
                    <span style="font-weight: bold">宠物品种:</span>
                    <span style="font-weight: bold">{{pet.vname}}</span>
                    <hr>
                    <span style="font-weight: bold">宠物状态:</span>
                    <span style="font-weight: bold">{{pet.status|contentFormat2}}</span>
                    <hr>
                    <span style="font-weight: bold">宠物描述:</span>
                    <span><a href="javascript:void (0)"
                             :title="pet.description">{{pet.description|contentFormat}}</a></span>

                    <hr>

                    <button type="button" class="button gray" @click="display_detail(pet.id)">查看详情</button>&nbsp;&nbsp;
                    <button type="button" class="button gray" @click="submit_resume(pet.id)">领养我叭</button>
                    <button style="margin-left: 10px" type="button" class="button gray" @click="submit_comment(pet.id)">
                        评论我叭
                    </button>
                </div>
            </article>


            <ul class="am-pagination">
                <li class="am-pagination-prev"><a href="javascript:void (0);" @click="prePageFun">&laquo; 上一页</a></li>
                <li class="am-pagination-prev" style="position: absolute;left:320px;border:none !important;"><a
                        href="javascript:void (0);">{{page}}/{{pages}}</a></li>
                <li class="am-pagination-next"><a href="javascript:void (0);" @click="nextPageFun">下一页&raquo;</a></li>
            </ul>
        </div>

        <div id="city-middle">
            <div class="am-u-md-4 am-u-sm-12 blog-sidebar" id="bolt-container">
                <div class="blog-sidebar-widget blog-bor bolt-1" id="intro1">
                    <h2 class="blog-title"><span>波斯猫简介</span></h2>
                    <img src="${pageContext.request.contextPath}/img/波斯猫.jpg"
                         style="margin-left: 0px;width: 200px;height: 200px;border-radius: 100px"
                         class="blog-entry-img">
                    <ul class="am-list">
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;波斯猫是最常见的长毛猫，波斯猫有一</a></li>
                        <li><a href="#">张讨人喜爱的面庞，长而华丽的背毛，优雅</a></li>
                        <li><a href="#">的举止，故有 “猫中王子”之称，是世界上爱</a></li>
                        <li><a href="#">猫者最喜欢猫种之一，占有极其重要的地位</a></li>
                    </ul>
                </div>

                <div class="blog-sidebar-widget blog-bor bolt-2" id="intro2">
                    <h2 class="blog-title"><span>折耳猫简介</span></h2>
                    <img src="${pageContext.request.contextPath}/img/折耳猫.jpg"
                         style="margin-left: 0px;width: 200px;height: 200px;border-radius: 100px"
                         class="blog-entry-img">
                    <ul class="am-list" style="text-align: left">
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;折耳猫是一种在耳朵有基因突变的猫种,</a></li>
                        <li><a href="#">由于这猫种最初在苏格兰发现，所以以它的</a></li>
                        <li><a href="#">发现地和身体特征而命名。这种猫在软骨部</a></li>
                        <li><a href="#">份有一个折，使耳朵向前屈折，并指向头的</a></li>
                        <li><a href="#">前方，十分可爱！</a></li>
                    </ul>
                </div>
                <div class="blog-sidebar-widget blog-bor bolt-3" id="intro3">
                    <h2 class="blog-title"><span>橘猫简介</span></h2>
                    <img src="${pageContext.request.contextPath}/img/橘猫.jpg"
                         style="margin-left: 0px;width: 200px;height: 200px;border-radius: 100px"
                         class="blog-entry-img">
                    <ul class="am-list" style="text-align: left">
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;橘猫因为体型原因，至今被网友们疯狂</a></li>
                        <li><a href="#">调侃。据说十个橘猫九个胖，还有一个压塌</a></li>
                        <li><a href="#">炕，橘猫的胖有图为证。橘猫憨态可掬，还</a></li>
                        <li><a href="#">喜欢撒娇耍赖。卖萌也是一把好手!</a></li>
                    </ul>
                </div>
                <div class="blog-sidebar-widget blog-bor bolt-4" id="intro4">
                    <h2 class="blog-title"><span>布偶猫简介</span></h2>
                    <img src="${pageContext.request.contextPath}/img/布偶猫.jpg"
                         style="margin-left: 0px;width: 200px;height: 200px;border-radius: 100px"
                         class="blog-entry-img">
                    <ul class="am-list" style="text-align: left">
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;布偶猫性格温顺和好静，不会像很多猫</a></li>
                        <li><a href="#">咪一样常在家中上蹿下跳，但对人非常友善,</a></li>
                        <li><a href="#">忍耐性强，常被误认为缺乏疼痛感。生活中</a></li>
                        <li><a href="#">的布偶给人感觉特别亲切，摸起来也很柔软,</a></li>
                        <li><a href="#">它喜欢粘着主人，主人多跟它玩可以让它更</a></li>
                        <li><a href="#">有安全感！</a></li>
                    </ul>
                </div>


            </div>
        </div>
    </div>
    <!-- content end -->


    <footer class="blog-footer">
        <div class="am-g am-g-fixed blog-fixed am-u-sm-centered blog-footer-padding">
            <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
                <h3>网站简介</h3>
                <p class="am-text-sm">该网站的使用对象是想领养动物和想成为我们其中一员的爱心人群。
                    <br>您可以领养本系统的宠物或者分享您的宠物，一切都没有问题！
                    <br>如果你是领养者，请认真选取想要领养的动物领养后，请认真负责对待可爱的宠物！
                    <br>我们欢迎任何爱心人士加入我们！
                </p>

            </div>
            <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">

                <h3>致亲爱的用户：</h3>
                <p>我们将永远追求卓越，然而时间、经验、能力有限，导致本系统仍有很多不足的地方，希望大家包容、不吝赐教！让我们永远年轻，永远热泪盈眶！</p>
                <h3>社交账号</h3>
                <p>
                    <a href=""><span class="am-icon-qq am-icon-fw am-primary blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-github am-icon-fw blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-weibo am-icon-fw blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-reddit am-icon-fw blog-icon blog-icon"></span></a>
                    <a href=""><span class="am-icon-weixin am-icon-fw blog-icon blog-icon"></span></a>
                </p>
            </div>
            <div class="am-u-sm-12 am-u-md-4- am-u-lg-4">
                <h1>技术支持</h1>
                <h3>Heroes</h3>
                <p>
                <ul>
                    <li>jQuery</li>
                    <li>layui</li>
                    <li>Spring Boot</li>
                    <li>MySql</li>
                    <li>...</li>
                </ul>
                </p>
            </div>
        </div>
        <div class="blog-text-center">© 2021 April, Inc. Luoyang institute of technology. computer specialty</div>
    </footer>

</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../../qiantai_user/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath}/qiantai_user/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/vue/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/vue/axios.min.js"></script>
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>

<script>
    $.get("/user/newNotice", function (result) {
        var obj = JSON.parse(result)
        // console.log(obj)
        var time = new Date(obj.createdate);
        var strTime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
        $("#notice_issue_name").text(obj.adminname);
        $("#notice_title").text(obj.title);
        $("#notice_content").text(obj.content);
        $("#notice_issueTime").text(strTime);

    })
</script>

<script>

    new Vue({
        el: "#app",
        data() {
            return {
                pets: [],
                limit: 5,
                page: '',
                nextPage: '',
                prePage: '',
                content: '',
                pages: ''
            }
        },
        mounted() {
            var that = this;
            axios.get("/user/qiantaiIndex").then(function (result) {
                // console.log(result)
                that.pets = result.data.list;
                that.nextPage = result.data.nextPage;
                that.prePage = result.data.prePage;
                that.page = result.data.page;
                that.pages = result.data.pages;
            })


        },
        methods: {
            nextPageFun: function () {
                var that = this;
                axios.post("/user/qiantaiIndex?page=" + this.nextPage + "&content=" + this.content).then(function (result) {
                    //console.log(result)
                    that.pets = result.data.list;
                    that.nextPage = result.data.nextPage;
                    that.prePage = result.data.prePage;
                    that.page = result.data.page;
                    that.pages = result.data.pages;
                })

            },
            prePageFun: function () {
                var that = this;
                axios.post("/user/qiantaiIndex?content=" + this.content + "&page=" + this.prePage).then(function (result) {
                    //console.log(result)
                    that.pets = result.data.list;
                    that.nextPage = result.data.nextPage;
                    that.prePage = result.data.prePage;
                    that.page = result.data.page;
                    that.pages = result.data.pages;
                })

            },
            searchFun: function () {
                var that = this;
                axios.post("/user/qiantaiIndex?content=" + this.content).then(function (result) {
                    //console.log(result)
                    that.pets = result.data.list;
                    that.nextPage = result.data.nextPage;
                    that.prePage = result.data.prePage;
                    that.page = result.data.page;
                    that.pages = result.data.pages;
                })

            },
            submit_resume: function (id) {
                //alert(id+" "+"submit_resume");
                //*********弹框开始位置**********
                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    //判断生日是否存在来确定是否完善个人信息

                    axios.get("/user/checkComplete?petId=" + id).then(function (res) {
                        console.log(res.data.msg)

                        if (res.data.msg == '0') {
                            layer.msg("请先完善个人信息！！！")
                            return;
                        } else {
                            if (res.data.experience == 1) {
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

            },

            submit_comment: function (id) {

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {

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
                        content: "/user/addComment?id=" + id
                    });

                })

                //*********弹框结束位置***************


            },


            display_detail: function (id) {
                //alert(id+" "+"display_detail");
                //*********弹框开始位置**********
                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['620px', '700px'],

                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toDisplaypet?petid=" + id
                    });
                })

                //*********弹框结束位置***************
            },
            toUpdStuMessage: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['600px', '800px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toUpdStuMessage"
                    });
                })

                //*********弹框结束位置***************
            },
            toEditPassword: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['600px', '400px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toEditPassword"
                    });
                })
                //*********弹框结束位置***************
            },
            toEditPersonal: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['450px', '600px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toEditPersonal"
                    });
                })
                //*********弹框结束位置***************
            },
            toEditPersonal2: function () {

                //*********弹框开始位置**********

                layui.config({
                    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
                }).extend({
                    index: 'lib/index' //主入口模块
                }).use(['index', 'table'], function () {
                    layer.open({
                        type: 2,
                        title: false,
                        closeBtn: 0,
                        shadeClose: true,
                        skin: 'yourClass',
                        area: ['450px', '600px'],
                        end: function () {
                            /* tableIns.reload()*/
                        },
                        content: "/user/toEditPersonal2"
                    });
                })
                //*********弹框结束位置***************
            }

        },





        filters: {
            contentFormat: function (value) {
                if (value.length > 45) {
                    return value.substr(0, 45) + "...";
                } else {
                    return value;
                }
            },
            contentFormat2: function (value) {
                if (value == 0) {
                    return "待领养";
                } else if (value == 1) {
                    return "被申请中(您仍可申请)";
                }
            }
        }
    })

</script>


<script>
    //随机显示2个宠物简介

    var flag = true;

    function showCity() {
        //生成1到4的随机整数
        // var num = Math.floor(Math.random() * (4 - 1 + 1) + 1);
        $('#intro1').fadeIn(500);
        setTimeout(function () {
            /*      var num2 = Math.floor(Math.random() * (4 - 1 + 1) + 1);
                  if (num == num2) {
                      if (num2 = 4) {
                          num2 = 1;
                      } else {
                          num2 = num2 + 1;
                      }
                  }*/
            $('#intro2').fadeIn(500);
            flag = false;
            window.setTimeout(hideCity, 8000);
        }, 800)
    }

    function showCity2() {

        $('#intro3').fadeIn(500);
        setTimeout(function () {
            $('#intro4').fadeIn(500);
            flag = true;
            window.setTimeout(hideCity, 8000);
        }, 500)
    }

    function hideCity() {
        if (flag) {
            $('#intro4').fadeOut(500);
            setTimeout(function () {
                $('#intro3').fadeOut(500);
                window.setTimeout(showCity, 1500);
            }, 500)

        } else {
            $('#intro2').fadeOut(500);
            setTimeout(function () {
                $('#intro1').fadeOut(500);

                window.setTimeout(showCity2, 1500);

            }, 500)
        }


    }

    setTimeout(function () {
        showCity();
    }, 400)

</script>
</body>
</html>
