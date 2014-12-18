/**
 * Created by lcheng on 2014/12/1.
 */
/**
 * 创建日期选择器
 * @param fieldId
 * @param type
 */
function createDatePicker(fieldId, type) {
    if (type == "date") {
        $(fieldId).datetimepicker({
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            idField: "id",
            forceParse: 0,
            language: 'zh-CN'
        });
    } else if (type == "datetime") {
        $(fieldId).datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN'});
    }
}

function goBack() {
    window.history.go(-1);
}

(function ($) {
    "use strict";
    $.fn.createBootstrapTable = function (ops) {
        var f = $.createBootstrapTable;
        f.createToolBar(ops,this);
        this.bootstrapTable(f.optsWithDefaults(ops)).
            on("check.bs.table check-all.bs.table", function (e, row) {
                f.enableBtn(ops);
            }).on("uncheck.bs.table", function (e, row) {
                var sel = $(this).bootstrapTable('getSelections');
                if (sel.length == 0) {
                    f.disableBtn(ops);
                }
            }).on("uncheck-all.bs.table", function (e) {
                f.disableBtn(ops);
            });
        f.disableBtn(ops);
    };
    $.createBootstrapTable = {
        defaultOpts: {
            contentType: "application/x-www-form-urlencoded",
            pagination: true,
            sidePagination: "server",
            pageSize: 10,
            method: "POST",
            queryParamsType: "not-limit",
            search: true,
            showRefresh: true,
            showColumns: true,
            toolbar: "#custom-toolbar",
            clickToSelect: true,
            queryParams: function (params) {
                var page = params.pageNumber,
                    size = params.pageSize;
                delete params.pageNumber;
                delete params.pageSize;
                params.page = (page - 1);
                params.size = size;
                return params;
            }
        },
        optWithDefaults: function (key, options) {
            return (options[key] !== false) && (options[key] !== '') && (options[key]
                || $.createBootstrapTable.defaultOpts[key]);
        },
        optsWithDefaults: function (options) {
            var f = $.createBootstrapTable;
            return {
                url: options.url,
                contentType: f.optWithDefaults("contentType", options),
                pagination: f.optWithDefaults("pagination", options),
                sidePagination: f.optWithDefaults("sidePagination", options),
                pageSize: f.optWithDefaults("pageSize", options),
                method: f.optWithDefaults("method", options),
                queryParamsType: f.optWithDefaults("queryParamsType", options),
                search: f.optWithDefaults("search", options),
                showRefresh: f.optWithDefaults("showRefresh", options),
                showColumns: f.optWithDefaults("showColumns", options),
                toolbar: f.optWithDefaults("toolbar", options),
                clickToSelect: f.optWithDefaults("clickToSelect", options)
            }
        },
        createToolBar: function (options, table) {
            var f = $.createBootstrapTable,
                btnTxt = "";
            if (options.cudBtn) {
                btnTxt += '<button id="btnAdd" type="button" class="btn btn-default">'
                + '<span class="fa fa-file-text"></span> 添加</button>'
                + '<button id="btnEdit" type="button" class="btn btn-default">'
                + '<span class="fa fa-edit"></span> 修改</button>'
                + '<button id="btnDel" type="button" class="btn btn-default">'
                + '<span class="fa fa-trash"></span> 删除</button>';
            }
            if (options.btns) {
                $.each(options.btns, function (idx, val) {
                    btnTxt += '<button id="' + val.id + '" type="button" class="btn btn-default"> '
                    + '<span class="' + val.iconCls + '"></span> ' + val.name + '</button>';
                });
            }
            if (options.cudBtn || options.btns) {
                btnTxt = '<div id="custom-toolbar">' +
                '<div class="btn-group">' + btnTxt + '</div></div>';
                $(btnTxt).insertBefore(table);
            }
        },
        disableBtn: function (options) {
            if (options.cudBtn) {
                $("#btnEdit").prop("disabled", true);
                $("#btnDel").prop("disabled", true);
            }
            if (options.btns) {
                $.each(options.btns, function (idx, val) {
                    if (val.rowSelectAware) {
                        $("#" + val.id).prop("disabled", true);
                    }
                })
            }
        },
        enableBtn: function (options) {
            if (options.cudBtn) {
                $("#btnEdit").removeAttr("disabled");
                $("#btnDel").removeAttr("disabled");
            }
            if (options.btns) {
                $.each(options.btns, function (idx, val) {
                    if (val.rowSelectAware) {
                        $("#" + val.id).removeAttr("disabled");
                    }
                })
            }
        }
    }
})(window.jQuery);

function createDualSelect(sid,cssCls){
    $(sid).multiSelect({
        selectableHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='查询:'>",
        selectionHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='查询:'>",
        cssClass:(cssCls) ? cssCls:"",
        afterInit: function(ms){
            var that = this,
                $selectableSearch = that.$selectableUl.prev(),
                $selectionSearch = that.$selectionUl.prev(),
                selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
                selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

            that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
                .on('keydown', function(e){
                    if (e.which === 40){
                        that.$selectableUl.focus();
                        return false;
                    }
                });

            that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
                .on('keydown', function(e){
                    if (e.which == 40){
                        that.$selectionUl.focus();
                        return false;
                    }
                });
        },
        afterSelect: function(){
            this.qs1.cache();
            this.qs2.cache();
        },
        afterDeselect: function(){
            this.qs1.cache();
            this.qs2.cache();
        }
    });
}
