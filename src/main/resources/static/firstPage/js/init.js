$.fn.dataTable.ext.errMode = 'none';
var table;
var initParams = {
    "info": true,//是否显示表格的信息
    "lengthChange": false,//是否允许最终用户改变表格每页显示的记录数
    "ordering": true,//是否允许排序。
    "processing": true,//是否显示正在处理的状态。主要用于排序
    "paging": true,//是否允许表格分页
    "pagingType": "full_numbers",//分页样式
    "searching": true,//是否允许开启本地搜索
    "serverSide": true,//是否开启服务器模式
    "stateSave": true,//是否开启状态保存 
    "autoWidth": true,//是否开启自动列宽度
    "iDisplayLength": 10,//每页显示10条数据
    "order": [[0, 'desc']],//第一列倒序 
    "oLanguage": { //汉化
        "decimal": ",",
        "thousands": ".",
        "sLengthMenu": "每页显示 _MENU_ 条记录",
        "sZeroRecords": "没有检索到数据",
        "sInfo": "显示第 _START_ 至 _END_ 项结果；共有 _TOTAL_ 项；第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
        "sInfoEmpty": "没有数据",
        "sSearch": "搜索:",
        "sProcessing": "正在加载数据...",
        "oPaginate": {
            "sFirst": "首页",
            "sPrevious": "上一页",
            "sNext": "下一页",
            "sLast": "尾页"
        }
    }
};

var initParamsck = $.extend(initParams, {
    "order": [[1, 'desc']]//第一列倒序
});

var btnParams = {
    //按钮列
    "columnDefs": [
        {
            "orderable": false,//禁用排序                       
            "targets": -1,//删除和编辑
            "data": null,
            "defaultContent": "<button id='editrow' class='btn btn-success btn-sm' type='button'>编辑</button>&nbsp<button id='delrow' class='btn btn-danger btn-sm' type='button'>删除</button>"
        }
    ]
};

var btnStateParams = {
    //按钮列
    "columnDefs": [
        {
            "orderable": false,//禁用排序                       
            "targets": -1,//删除和编辑
            "data": null,
            "defaultContent": "<button id='editrow' class='btn btn-success btn-sm' type='button'>编辑</button>&nbsp<button id='delrow' class='btn btn-danger btn-sm' type='button'>删除</button>&nbsp<button id='state' class='btn btn-warning btn-sm' type='button'>推荐</button>"
        }
    ]
};

var btnStatePictureParams = {
    //按钮列
    "columnDefs": [
        {
            "orderable": false,//禁用排序                       
            "targets": -1,//删除和编辑
            "data": null,
            "defaultContent": "<button id='editrow' class='btn btn-success btn-sm' type='button'>编辑</button>&nbsp<button id='delrow' class='btn btn-danger btn-sm' type='button'>删除</button>&nbsp<button id='state' class='btn btn-warning btn-sm' type='button'>设为封面</button>"
        }
    ]
};

var btnEditParams = {
    //按钮列
    "columnDefs": [
        {
            "orderable": false,//禁用排序                       
            "targets": -1,//删除和编辑
            "data": null,
            "defaultContent": "<button id='editrow' class='btn btn-success btn-sm' type='button'>编辑</button>"
        }
    ]
};

var btnDelParams = {
    //按钮列
    "columnDefs": [
        {
            "orderable": false,//禁用排序                       
            "targets": -1,//删除和编辑
            "data": null,
            "defaultContent": "<button id='delrow' class='btn btn-danger btn-sm' type='button'>删除</button>"
        }
    ]
};

//编辑
$("#grid").delegate('button#editrow', 'click', function () {
    //var data = table.row($(this).parents("tr")).data();
    var index = $(this).parents("tr").index();
    var id = table.row($(this).parents("tr")).columns().data()[0][index];
    if (id == null) {
        id = table.row($(this).parents("tr")).columns().data()[1][index];
    }
    editUrl = editUrl + id;
    window.location.href = editUrl;
});
//删除
$("#grid").delegate('button#delrow', 'click', function () {
    //var data = table.row($(this).parents("tr")).data();
    //var cols = table.columns([0]).dataSrc()[0];     
    var idx = $(this).parents("tr").index();
    var id = table.row($(this).parents("tr")).columns().data()[0][idx];
    if (id == null) {
        id = table.row($(this).parents("tr")).columns().data()[1][idx];
    }
    layer.confirm("确定要删除吗？", { icon: 3, skin: 'layer-ext-moon' }, function (index) {           
        del(id);
    });
});
//更改状态
$("#grid").delegate('button#state', 'click', function () {
    var idx = $(this).parents("tr").index();
    var id = table.row($(this).parents("tr")).columns().data()[0][idx];
    if (id == null) {
        id = table.row($(this).parents("tr")).columns().data()[1][idx];
    }
    state(id);
});
//全选
$("#grid").delegate('input#checkall', 'click', function () {
    if ($(this).is(':checked')) {
        $("#grid tbody input[type=checkbox]").prop("checked", true);
        $("#grid tbody input[type=checkbox]").parent().parent().addClass("selected");
    } else {
        $("#grid tbody input[type=checkbox]").prop("checked", false);
        $("#grid tbody input[type=checkbox]").parent().parent().removeClass("selected");
    }
});
//单击行
$("#grid").delegate('tbody tr', 'click', function () {
    if ($(this).hasClass('selected')) {
        $(this).removeClass('selected');
        $(this).children("td:first").children("input[type=checkbox]").prop("checked", false);
    } else {
        $(this).addClass("selected");
        $(this).children("td:first").children("input[type=checkbox]").prop("checked", true);
    }
});
//批量删除
function _deleteList() {
    var str = '';
    $("#grid tbody input[type=checkbox]:checked").each(function (i, o) {
        str += $(this).val() + ",";
    });
    if (str.length > 0) {
        var IDS = str.substr(0, str.length - 1);
        layer.confirm("确定要删除吗？", { icon: 3, skin: 'layer-ext-moon' }, function (index) {
            del(IDS);
        });        
    } else {
        layer.msg("至少选择一条记录操作！", { icon: 0, skin: 'layer-ext-moon' });
    }
}

//查看
$("#grid").delegate('button#find', 'click', function () {
    var index = $(this).parents("tr").index();
    var id = table.row($(this).parents("tr")).columns().data()[0][index];
    if (id == null) {
        id = table.row($(this).parents("tr")).columns().data()[1][index];
    }
    findUrl = findUrl + id;
    window.location.href = findUrl;
});

function _stateList() {
    var str = '';
    $("#grid tbody input[type=checkbox]:checked").each(function (i, o) {
        str += $(this).val() + ",";
    });
    if (str.length > 0) {
        var IDS = str.substr(0, str.length - 1);
        state(IDS);
    } else {
        layer.msg("至少选择一条记录操作！", { icon: 0, skin: 'layer-ext-moon' });
    }
}

function del(ids) {
    $.ajax({
        url: delUrl,
        type: "POST",
        data: "id=" + ids,
        dataType: "json",
        success: function (rep) {
            if (rep.success) {
                table.ajax.reload();
                layer.msg(rep.msg, { icon: 1, skin: 'layer-ext-moon' });
            } else {
                layer.msg(rep.msg, { icon: 2, skin: 'layer-ext-moon' });
            }            
        },
        error: function () {
            layer.msg("网络延迟，请稍后再试！", { icon: 0, skin: 'layer-ext-moon' });
        }
    });
}

function state(ids) {
    $.ajax({
        url: stateUrl,
        type: "POST",
        data: "id=" + ids,
        dataType: "json",
        success: function (rep) {
            if (rep.success) {
                table.ajax.reload();
                layer.msg(rep.msg, { icon: 1, skin: 'layer-ext-moon' });
            } else {
                layer.msg(rep.msg, { icon: 2, skin: 'layer-ext-moon' });
            }
        },
        error: function () {
            layer.msg("网络延迟，请稍后再试！", { icon: 0, skin: 'layer-ext-moon' });
        }
    });
}