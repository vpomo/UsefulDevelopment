<@layout.head>
<link href="${base}/res/vpomo/css/bootstrap.min.css" rel="stylesheet" type="text/css"
      xmlns="http://www.w3.org/1999/html"/>
<link href="${base}/res/vpomo/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
<link href="${base}/res/vpomo/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>

<script src="${base}/res/vpomo/js/jquery-2.1.1.js" type="text/javascript"></script>
<script src="${base}/res/vpomo/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${base}/res/vpomo/js/moment-with-locales.min.js" type="text/javascript"></script>
<script src="${base}/res/vpomo/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${base}/res/js/layer/layer.js"></script>

<style type="text/css">
    label.error {
        color: red;
        font-style: italic;
    }

    input.error {
        border: 1px dotted #f00;
    }
</style>
</@layout.head>
<@layout.body>
<script type="text/javascript">
    var SITEURL = '${base}';
    window.onload = function () {
    };
</script>
<div class="page">

<input type="hidden" name="order_Id" id="order_Id" value="${order.orderId}">
<input type="hidden" name="curNameGoods" id="curNameGoods" value="">

    <div class="container">

    <h2 class="h2 page-header">Работа с купонами</h2>
        <p>
        <button type="button" class="btn btn-success btn-xs" id="add_coupon">
            Добавить новый купон
        </button>
        </p>

        <form method="post" action="${base}/coupon/list" name="formSearch" id="formSearch">
        <input type="hidden" name="pageNo" value="${1}">
        <div class="row-fluid">
            <div class="panel panel-info">
                <div class="panel-heading">Список выпущенных купонов:</div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" style="font-size: small;">
                            <thead>
                            <tr>
                                <th>Дата действия от ... до</th>
                                <th>Цена</th>
                                <th>Код</th>
                                <th>Статус использования</th>
                                <th>Редактировать</th>
                                <th>Удалить</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#if datas??>
                                    <#list datas as data>
                                    <tr>
                                    <td>
                                        <#if data.startTimeStr??>
                                        ${data.startTimeStr?string("yyyy-MM-dd")}
                                            ~${data.endTimeStr?string("yyyy-MM-dd")}</td>
                                        </#if>
                                        </td>
                                        <td>${data.couponPrice}</td>
                                        <td>${data.couponTitle}</td>
                                        <td>
                                            <#if data.couponState == 1>
                                                <span style="color: #0000cc;">Не использован</span>
                                            <#else>
                                                <span style="color: #959FA9;">Использован</span>
                                            </#if>
                                        </td>
                                        <td>
                                            <#if data.couponState != 0>
                                                <button type="button" class="btn btn-default btn-xs" id="edit_coupon"
                                                        onclick="editCoupon('${data.couponId}');">
                                                    Редактировать
                                                </button>
                                            </#if>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-danger btn-xs" id="delete_coupon"
                                                    onclick="deleteCoupon('${data.couponId}');">
                                                Удалить
                                            </button>
                                        </td>
                                    </tr>
                                    </#list>
                                </#if>
                            </tbody>
                            <tfoot>
                            <tr class="tfoot">
                                <td colspan="16">
                                    <@layout.pager pager/>
                                </td>
                            </tr>
                            </tfoot>

                        </table>

                    </div>
                </div>

            </div>
    </form>
</div>
</div>

<script type="text/javascript">
    $(function () {
        $(document).on("click", "#add_coupon", function () {
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Добавление нового купона на скидку',
                content: ['${base}/coupon/new', 'no'],
                area: ['850px', '550px']
            });
        });

    });

    function deleteCoupon(couponId) {
        $.ajax({
            url: '${base}/coupon/delete',
            type: 'post',
            data: {
                'ids': couponId
            },
            dataType: 'json',
            success: function (data) {
                    layer.msg("Купон удален !", false, 999999);
                    location.reload();
            }, error: function (data) {
                parent.layer.msg('Сбой связи', {icon: 2});
            }
        });

    }

    function editCoupon(couponId) {
        layer.open({
            type: 2,
            move: true,
            shade: false,
            offset: '5px',
            title: 'Редактирование данных купона на скидку',
            content: ['${base}/coupon/edit?id=' + couponId, 'no'],
            area: ['850px', '550px']
        });

    }

</script>

</@layout.body>