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
    };
</script>

<div class="container">

    <h2 class="h2 page-header">Редактирование данных купона</h2>
    <input type="hidden" name="coupon_id" id="coupon_id" value="${coupon.couponId}">

    <form method="post" action="" id="make_coupon" target="_parent">
        <div class="row-fluid">
            <div class="panel panel-info">
                <div class="panel-heading">Пожалуйста заполните необходимые поля:</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-6">
                            <br>
                            <p><label for="datetimepicker6">Дата начала действия: </label>
                                <input id="datetimepicker6" value="${coupon.startTimeStr?string("yyyy-MM-dd")}"/>
                            </p>
                        </div>
                        <div class="col-xs-6">
                            <br>
                            <p><label for="datetimepicker7">Дата окончания действия: </label>
                                <input id="datetimepicker7" value="${coupon.endTimeStr?string("yyyy-MM-dd")}"/>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <p><label for="price_coupon">Цена купона: </label>
                                <input id="price_coupon" value="${coupon.couponPrice}"/>
                            </p>
                        </div>
                        <div class="col-xs-4">
                            <p><label for="code_coupon">Код купона: </label>
                                <input id="code_coupon" value="${coupon.couponTitle}"/>
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
                            <button type="button" class="btn btn-success btn-md" onclick="updateCoupon();">
                                Обновить данные
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

    });

    function updateCoupon() {
        var couponContent = $('#code_coupon').val();
        var price = $('#price_coupon').val();
        var couponStartDate = $('#datetimepicker6').val();
        var couponEndDate = $('#datetimepicker7').val();
        if (moment(couponStartDate).isAfter(couponEndDate)) {
            layer.msg("Конечная дата должна быть больше начальной даты!", false, 999999);
            return false;
        }

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