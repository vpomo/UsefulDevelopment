<@layout.head>
<link href="${base}/res/vpomo/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
        $("#order_Id").val('${order.orderId}');
        writeCouponData ();
    };
</script>

<input type="hidden" name="order_Id" id="order_Id" value="${order.orderId}">
<input type="hidden" name="curNameGoods" id="curNameGoods" value="">
<div class="container">

    <h2 class="h2 page-header">Ввод данных для нового купона</h2>

    <form method="post" action="" id="make_coupon" target="_parent">
        <div class="row-fluid">
            <div class="panel panel-info">
                <div class="panel-heading">Пожалуйста заполните необходимые поля:</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-6">
                            <br>
                            <p><label for="datetimepicker6">Дата начала действия: </label>
                                <input id="datetimepicker6"/>
                            </p>
                        </div>
                        <div class="col-xs-6">
                            <br>
                            <p><label for="datetimepicker7">Дата окончания действия: </label>
                                <input id="datetimepicker7"/>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <p><label for="price_coupon">Цена купона: </label>
                                <input id="price_coupon"/>
                            </p>
                        </div>
                        <div class="col-xs-4">
                            <p><label for="code_coupon">Код купона: </label>
                                <input id="code_coupon"/>
                            </p>
                        </div>
                        <div class="col-xs-4">
                            <br>
                            <p>
                            <button type="button" class="btn btn-primary btn-xs" id="generate" onclick="writeCouponData()" class="form-control">
                                Генерировать
                            </button>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-success btn-md" onclick="saveCoupon();">
                                Создать купон
                            </button>
                        </div>
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-primary btn-md" onclick="quxiao();">
                                Выйти
                            </button>
                        </div>
                    </div>
                    <div class="row">
                    </div>
                </div>
            </div>

        </div>
    </form>
</div>

<script type="text/javascript">
    $(function () {
        $('#datetimepicker6').datetimepicker(
                {pickTime: false, viewMode: 'years', language: 'ru', format:"YYYY-MM-DD"}
        );
        $('#datetimepicker7').datetimepicker(
                {pickTime: false, viewMode: 'years', language: 'ru', format:"YYYY-MM-DD"}
        );
/*
        jQuery.validator.addMethod("isPriceCoupon", function (value, element) {
            var pattern = /^[0-9]$/;
            return this.optional(element) || (pattern.test(value));
        }, "Пожалуйста укажите стоимость купона");
*/
    });
/*
    $('#make_coupon').validate({
        errorPlacement: function (error, element) {
            $(element).next('.field_notice').hide();
            $(element).after(error);
        },
        rules: {
            price_coupon: {
                required: true,
                isPriceCoupon: true
            }
        },
        messages: {//weightParcel
            price_coupon: {
                required: 'Пожалуйста, укажите стоимость купона',
                isPriceCoupon: 'Это должны быть цифры'
            }
        }
    })
*/
    function saveCoupon() {
        var couponContent = $('#code_coupon').val();
        var price = $('#price_coupon').val();
        var couponStartDate = $('#datetimepicker6').val();
        var couponEndDate = $('#datetimepicker7').val();
        if (moment(couponStartDate).isAfter(couponEndDate)) {
            layer.msg("Конечная дата должна быть больше начальной даты!", false, 999999);
            return false;
        }

        $.ajax({
            url: '${base}/coupon/addcoupon',
            type: 'get',
            data: {
                'couponContent': couponContent,
                'price': price,
                'couponStartDate': couponStartDate,
                'couponEndDate': couponEndDate
            },
            dataType: 'json',
            success: function (data) {
                if (data.success == 'true') {
                    layer.msg("Успешно создан купон с ID: " + data.couponId + " !", false, 999999);
                    writeCouponData();
                } else {
                    layer.msg("Внутренняя ошибка !", false, 999999);
                }

            }, error: function (data) {
                parent.layer.msg('Сбой связи', {icon: 2});
            }

        });
}

    function quxiao() {
        layer.closeAll();
        parent.location.reload();
    }

    function randomCouponData() {
        var result       = '';
        var words        = '0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
        var max_position = words.length - 1;
        for( i = 0; i < 8; ++i ) {
            position = Math.floor ( Math.random() * max_position );
            result = result + words.substring(position, position + 1);
        }
        return result;
    }

    function writeCouponData () {
        //alert(randomCouponData());
        $("#code_coupon").val(randomCouponData());
    }

    function quxiao() {
        layer.closeAll();
        parent.location.reload();
    }


</script>

</@layout.body>