<link href="${base}/res/vpomo/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${base}/res/vpomo/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
<link href="${base}/res/vpomo/css/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>
<link href="${base}/res/vpomo/css/select2.css" rel="stylesheet" type="text/css"/>

<script src="${base}/res/vpomo/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${base}/res/js/jquery-ui/jquery.ui.js"></script>
<script src="${base}/res/js/jquery.validation.min.js" charset="utf-8"></script>
<script src="${base}/res/vpomo/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${base}/res/vpomo/js/select2.full.min.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="${base}/res/js/layer/layer.js"></script>



<script type="text/javascript">
    var SITEURL = '${base}';
    window.onload = function () {
        $("#order_Id").val('${order.orderId}');
        splitaddress($('#address').val());
        splitparcel($('#parcel').val());
        processCost();
        $(".list-pvz").val('${order.shippingExpressCode}');
        init_list_pvz();
//        $(".list-pvz").val('${order.shippingExpressCode}');
//        alert($(".list-pvz").val());
    };

    function processCost() {
        $("#costParcel").val($("#costGoods").val());
        $("#payment").val($("#costGoods").val());
        $("#deliveryRecipientCost").val(parseFloat($("#costCDEK").val()) + 20 + 0.03 * parseFloat($("#payment").val()));

        if (parseFloat($("#payment").val()) < 3000) {
            $("#deliveryRecipientCost").val(parseFloat($("#costCDEK").val()) + 20 + 0.03 * parseFloat($("#payment").val()));
        } else {
            $("#deliveryRecipientCost").val(0);
        }
    }
    function splitaddress(splitString) {
        tempArray = splitString.split(',');
        $("#address1").val(tempArray[0]);
        $("#address2").val(tempArray[1]);
        $("#address3").val(tempArray[2]);
    }
    function splitparcel(splitString) {
        tempArray = splitString.split('x');
        $("#weightParcel").val(tempArray[0]);
        $("#lengthParcel").val(tempArray[1]);
        $("#widthParcel").val(tempArray[2]);
        $("#heightParcel").val(tempArray[3]);
    }
    function processaddress() {
        $("#address").val($("#address1").val() + "," + $("#address2").val() + "," + $("#address3").val());
    }
    $(function () {
        $("#cityX").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "https://api.cdek.ru/city/getListByTerm/jsonp.php?callback=?",
                    dataType: "jsonp",
                    data: {
                        q: function () {
                            return $("#cityX").val()
                        },
                        name_startsWith: function () {
                            return $("#cityX").val()
                        }
                    },
                    success: function (data) {
                        response($.map(data.geonames, function (item) {
                            //splitaddress($("#address").val());
                            return {
                                label: item.name,
                                value: item.name,
                                id: item.id
                            }
                        }));
                    }
                });
            },
            minLength: 1,
            select: function (event, ui) {
                delivery2(ui.item.id, ui.item.label);
            }
        });
    });
    function delivery2(sdecid) {
        $("#city_id").val(sdecid);
        $("#area_id").val(sdecid);
        $("#area_info").val(sdecid);
        init_list_pvz();
        //alert($(".list-pvz").val());
        //alert($(".list-pvz").text());
    }

</script>

<style type="text/css">
    .ui-autocomplete {
        top: 25px !important;
        left: 50% !important;
        margin-left: -132px !important;
        position: fixed !important;
        font-size: 14px !important;
        width: 383px;
    }

    .list-pvz {
        font-size: 10px !important;
        width: 310px;
        height: 12px;
    }
    .textPvz {
        position: relative;
    }
    .pvz {
        position: relative;
        left: 20px;
        bottom: 5px;
        margin-bottom: -3px;
        float: left;
    }
    .post_address {
        position: relative;
        bottom: 20px;
        margin-bottom: 0px;
    }

    label.error {
        color: red;
        font-style: italic;
    }

    input.error {
        border: 1px dotted #f00;
    }

</style>

<div id="fwin_my_address_add" class="dialog_wrapper ui-draggable"
     style="z-index: 1100; position: relative; padding: 5px; top: 3px; font-size: small;">

    <input type="hidden" name="address" id="address" value="${order.address.address}">
    <input type="hidden" name="parcel" id="parcel" value="${order.tradeSn}">
    <input type="hidden" name="order_Id" id="order_Id" value="${order.orderId}">
    <input type="hidden" name="curNameGoods" id="curNameGoods" value="">

    <form method="post" action="" id="make_order_cdek" target="_parent">
        <div class="row-fluid">
            <input type="hidden" name="form_submit" value="ok">
            <div class="col-xs-12">
                <span class="areaMsgReturn" style="color: green"></span>
                <div class="panel panel-info">
                    <div class="panel-title">Адрес доставки товара:</div>
                    <div class="panel-body" style="padding: 5px; margin-bottom: -20px;">
                        <div class="row">
                            <div class="col-xs-4">
                                <div class="required"><em class="pngFix"></em>*Населенный пункт:</div>
                                <div id="region">
                                    <input id="city_id" type="hidden" name="city_id"
                                           value="${order.address.cityId}">
                                    <input id="area_id" class="area_ids" type="hidden" name="area_id"
                                           value="${order.address.areaId}">
                                    <input id="area_info" class="area_names" type="hidden" name="area_info"
                                           value="${order.address.areaInfo}">

                                    <input id="cityX" style="width:250px"
                                           placeholder="Начните вводить название"
                                           type="text" value="${order.address.areaInfo}">

                                    <span id="spancity"></span>
                                    <span id="spanqu"></span>
                                </div>
                            </div>
                            <div class="col-xs-2">
                                <div class="required"><em class="pngFix"></em>*Тариф:</div>
                                <p>
                                    <input type="radio" id="radio_136" name="group_tarif" value="136"> Склад-Склад<br>
                                    <input type="radio" id="radio_137" name="group_tarif" value="137" checked> Склад-Дверь<br>
                                </p>
                            </div>
                            <div class="col-xs-6">
                                <div class="pvz">
                                    <span class="textPvz">Укажите пункт выдачи заказа:</span>
                                    <select class="list-pvz" placeholder='Выбор пункта выдачи заказа ...'>
                                        <!--  <option value="3620194" selected="selected">select2/select2</option>  -->
                                        <option value="${order.bundlingId}" selected="selected">${order.bundlingExplain}</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                    <div class="row post_address" style="padding: 5px;">
                        <ul style="list-style-type: none;padding: 5px;">
                            <li class="col-xs-4">
                                <div class="required">*Улица:</div>
                                <p>
                                    <input style="width:180px" type="text" name="address1"
                                           onkeyup="processaddress()" id="address1"
                                           value="">
                                </p>
                            </li>
                            <li class="col-xs-2">
                                <div class="required">*Дом:</div>
                                <p>
                                    <input style="width:50px" type="text" name="address2"
                                           onkeyup="processaddress()" id="address2"
                                           value="">
                                </p>
                            </li>
                            <li class="col-xs-2">
                                <div class="required"><em class="pngFix"></em>*Квартира:</div>
                                <p>
                                    <input style="width:50px" type="text" name="address3"
                                           onkeyup="processaddress()" id="address3"
                                           value="">
                                </p>
                            </li>
                            <li class="col-xs-4">
                                    <div style="padding:0px;">
                                        <div class="required">Почт. индекс：</div>
                                        <div>
                                            <input type="text" class="text valid" name="zipCode" id="zipCode"
                                                   style="width:60px" maxlength="6"
                                                   value="${order.address.zipCode}">
                                        </div>
                                    </div>
                            </li>
                        </ul>
                    </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="panel panel-info" style="z-index: 0;">
                            <div class="panel-title" style="z-index: 0;">Сведения о получателе:</div>
                            <div class="panel-body" style="padding: 5px;z-index: 0;">

                                <ul style="list-style-type: none; padding: 5px;">
                                    <li class="col-xs-7">
                                        <p>*Имя и Фамилия:</p>
                                        <input style="width:150px" type="text" class="text" id="trueName"
                                               name="trueName" value="${order.address.trueName}">
                                    </li>
                                    <li class="col-xs-5">
                                        <p>*Моб. тел.:</p>
                                        <input type="text" class="text" name="mobPhone" id="mobPhone" maxlength="11"
                                               style="width:90px" value="${order.address.mobPhone}">
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="panel panel-info">
                            <div class="panel-title">Габариты посылки:</div>
                            <div class="panel-body" style="padding: 5px 0px 5px 5px; left: 5 px;">
                                <ul style="list-style-type: none; padding: 2px;">
                                    <li class="col-xs-2">
                                        <p>*вес:</p>
                                        <input style="width:30px" type="text" class="text" id="weightParcel"
                                               name="weightParcel" value="">
                                    </li>
                                    <li class="col-xs-3">
                                        <p style="padding: 0px 5px">*длина:</p>
                                        <input type="text" class="text" name="lengthParcel" id="lengthParcel"
                                               maxlength="3"
                                               style="width: 30px; left: 5 px;" value="">
                                    </li>
                                    <li class="col-xs-3">
                                        <p>*ширина:</p>
                                        <input type="text" class="text" name="widthParcel" id="widthParcel"
                                               maxlength="3"
                                               style="width:30px" value="">
                                    </li>
                                    <li class="col-xs-4">
                                        <p>*высота:</p>
                                        <input type="text" class="text" name="heightParcel" id="heightParcel"
                                               maxlength="3"
                                               style="width:30px" value="">
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12">
                    <div class="panel panel-info">
                        <div class="panel-title">Содержимое посылки:</div>
                        <div class="panel-body panel-success" style="padding: 0px;">
                            <ul style="list-style-type: none; padding: 0px; left: 0px;">
                                <li class="col-xs-4">
                                    <p>Перечень товаров:</p>
                                    <textarea name="nameGoods" id="nameGoods" cols="30" rows="2" wrap="virtual"
                                              maxlength="50">
                                                </textarea>
                                    </p>
                                </li>
                            <#list order.orderGoodsList as goods>
                                <script type="text/javascript">
                                    currentNameGoods = $("#curNameGoods").val();
                                    newNameGoods = '${goods.goodsName}' + ' - ' + '${goods.goodsNum}' + 'шт.;';
                                    $("#curNameGoods").val(currentNameGoods + newNameGoods);
                                    $("#nameGoods").val(currentNameGoods + newNameGoods);
                                </script>
                            </#list >
                                <li class="col-xs-6">
                                    <p>Особые отметки:</p>
                                    <textarea name="commentParcel" id="commentParcel" cols="48" rows="2" wrap="virtual"
                                              maxlength="255">
                                                </textarea>
                                    </p>
                                </li>
                                <li class="col-xs-2">
                                    <p>Число предм.:</p>
                                    <input style="width:30px;padding: 0px;" type="text" class="text" id="numberGoods"
                                           name="numberGoods" value="1">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel panel-info">
                            <div class="panel-title">Стоимость посылки:</div>
                            <div class="panel-body" style="padding: 5px;">
                                <ul style="list-style-type: none; padding: 0px;">
                                    <li class="col-xs-2">
                                        <p>*Ст-ть товара:</p>
                                        <input style="width:50px" type="text" class="text" id="costGoods"
                                               readonly="true"
                                               name="costGoods" value="${order.goodsAmount}">
                                    </li>
                                    <li class="col-xs-3">
                                        <p>*Ст-ть доставки:</p>
                                        <input type="text" class="text" name="costCDEK" id="costCDEK" maxlength="5"
                                               readonly="true"
                                               style="width:40px" value="${order.shippingFee}">
                                    </li>
                                    <li class="col-xs-3">
                                        <p>*Объявл. ст-ть:</p>
                                        <input type="text" class="text" name="costParcel" id="costParcel" maxlength="5"
                                               style="width:50px" value="0">
                                    </li>
                                    <li class="col-xs-2">
                                        <p>*Налж. платеж:</p>
                                        <input type="text" class="text" name="payment" id="payment" maxlength="5"
                                               style="width:50px" value="0">
                                    </li>
                                    <li class="col-xs-2">
                                        <p>*Доп. сбор:</p>
                                        <input type="text" class="text" name="deliveryRecipientCost"
                                               id="deliveryRecipientCost" maxlength="5"
                                               style="width:50px" value="0">
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="well">
                    <div class="col-xs-6">
                        <button type="button" class="btn btn-sm btn-success">
                            <a href="#none" onclick="calc_order_cdek()" style="color: white">Пересчитать стоимость
                                доставки</a>
                        </button>
                    </div>
                    <div class="col-xs-4">
                        <button type="button" class="btn btn-sm btn-danger">
                            <a href="#none" onclick="make_order_cdek()" style="color: white">Создать заказ СДЭК</a>
                        </button>
                    </div>
                    <div class="col-xs-2">
                        <button type="button" class="btn btn-sm btn-info">
                            <a href="#none" onClick="quxiao();return false;" style="color: white">OK</a>
                        </button>
                    </div>
                    <br>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    $(function () {
        jQuery.validator.addMethod("isHeightParcel", function (value, element) {
            var pattern = /^[1-9]|[0-9]{,2}$/;
            return this.optional(element) || (pattern.test(value));
        }, "Пожалуйста укажите высоту посылки");

        jQuery.validator.addMethod("isWidthParcel", function (value, element) {
            var pattern = /^[1-9]|[0-9]{,2}$/;
            return this.optional(element) || (pattern.test(value));
        }, "Пожалуйста укажите ширину посылки");

        jQuery.validator.addMethod("isLengthParcel", function (value, element) {
            var pattern = /^[1-9]|[0-9]{,2}$/;
            return this.optional(element) || (pattern.test(value));
        }, "Пожалуйста укажите длину посылки");

        jQuery.validator.addMethod("isWeightParcel", function (value, element) {
            var pattern = /^[1-9]|[0-9]{,2}$/;
            return this.optional(element) || (pattern.test(value));
        }, "Пожалуйста укажите вес посылки");

        jQuery.validator.addMethod("isZipCode", function (value, element) {
            var pattern = /^[0-9]{6}$/;
            return this.optional(element) || (pattern.test(value));
        }, "Заполните, пожалуйста, правильный код почтового индекса");

        jQuery.validator.addMethod("isMobPhone", function (value, element) {
            //Так должно быть:
            //var pattern = /^[8][0-9]{10}$/;

            //А так на самом деле:
            var pattern = /^[0-9]{10,11}$/;
            return this.optional(element) || (pattern.test(value));
        }, "11-значный номер телефона, должен начинаться с 8");

        if ('${order.shippingName}'=='FREE') {
            $("#radio_136").attr("checked", "checked");
        }
        if ('${order.shippingName}'=='SDEC' || '${order.shippingName}'=='SDEK') {
            $("#radio_137").attr("checked", "checked");
        }


});



        $('#make_order_cdek').validate({
            errorPlacement: function (error, element) {
                $(element).next('.field_notice').hide();
                $(element).after(error);
            },
            rules: {
                heightParcel: {
                    required: true,
                    maxlength: 2,
                    isWeightParcel: true
                },
                widthParcel: {
                    required: true,
                    maxlength: 2,
                    isWeightParcel: true
                },
                lengthParcel: {
                    required: true,
                    maxlength: 2,
                    isWeightParcel: true
                },
                weightParcel: {
                    required: true,
                    maxlength: 2,
                    isWeightParcel: true
                },
                trueName: {
                    required: true
                },
                mobPhone: {
                    required: true,
                    isMobPhone: true
                },
                address: {
                    required: true
                }
            },
            messages: {//weightParcel
                heightParcel: {
                    required: 'Заполните, пожалуйста, высоту посылки в см',
                    maxlength: 'Высота посылки должна быть не больше 99 см',
                    isHeightParcel: 'Высота должна быть больше 0'
                },
                widthParcel: {
                    required: 'Заполните, пожалуйста, ширину посылки в см',
                    maxlength: 'Ширина посылки должен быть не больше 99 см',
                    isWidthParcel: 'Ширина должна быть больше 0'
                },
                lengthParcel: {
                    required: 'Заполните, пожалуйста, длину посылки в см',
                    maxlength: 'Длина посылки должен быть не больше 99 см',
                    isLengthParcel: 'Длина должна быть больше 0'
                },
                weightParcel: {
                    required: 'Заполните, пожалуйста, вес посылки',
                    maxlength: 'Вес посылки должен быть не больше 99 кг',
                    isWeightParcel: 'Вес должен быть больше 0'
                },
                trueName: {
                    required: 'Заполните, пожалуйста, настоящее имя'
                },
                mobPhone: {
                    required: 'Укажите телефон получателя',
                    isMobPhone: 'Заполните, пожалуйста, правильный номер телефона'
                },
                address: {
                    required: 'Заполните, пожалуйста, адрес'
                }
            }
        })


    function quxiao() {
        layer.closeAll();
        parent.location.reload();
    }

    function returnOK(messageOK) {
        //layer.msg("Успешно создан заказ в СДЭК № " + messageOK,false,999999);
    }

    function returnCalcDelivery(shipPrice) {
        $('#costCDEK').val(shipPrice);
    }

    function make_order_cdek() {
        if ($('#make_order_cdek').valid()) {
            var orderId = $("input[name='order_Id']").val();
            var trueName = $('#trueName').val();
            var mobPhone = $('#mobPhone').val();
            var cityId = $('#city_id').val();
            var zipCode = $('#zipCode').val();
            var address = $('#address').val();
            //alert("adress = " + address);

            var commentParcel = $('#commentParcel').val();
            var nameGoods = $('#nameGoods').val();
            var numberGoods = $('#numberGoods').val();

            var weightParcel = $('#weightParcel').val();
            var lengthParcel = $('#lengthParcel').val();
            var widthParcel = $('#widthParcel').val();
            var heightParcel = $('#heightParcel').val();

            var costGoods = $('#costGoods').val();
            var costCDEK = $('#costCDEK').val();
            var costParcel = $('#costParcel').val();
            var payment = $('#payment').val();
            var deliveryRecipientCost = $('#deliveryRecipientCost').val();
            var tariffId = getTarif();
            //codePvz after tariffId
            var $codePvz = $(".list-pvz");
            if((($codePvz.val()== null)||($codePvz.val()== '')) && $("#radio_136").prop("checked")==true){
                layer.msg("Пожалуйста, выберите пункт выдачи заказа!",false,999999);
                return false;
            }
            if ((($codePvz.val()== null)||($codePvz.val()== '')) && (address == ',,') ) {
                layer.msg("Адрес получателя не указан! Пожалуйста, выберите пункт выдачи заказа!",false,999999);
                return false;
            }

            if ((($codePvz.val()!= null)||($codePvz.val()!= '')) && (address == ',,') ) {
                layer.msg("Адрес получателя не указан! Будет взят адрес пункта выдачи заказа!",false,999999);
                alert($codePvz.val());
            }

            if (cityId == '' || cityId == '0') {
                layer.msg("Пожалуйста, выберите город!",false,999999);
                return false;
            }

            var formjson = '{';
            formjson += '\"orderId\":\"' + orderId + '\",';
            formjson += '\"trueName\":\"' + trueName + '\",';
            formjson += '\"mobPhone\":\"' + mobPhone + '\",';
            formjson += '\"cityId\":\"' + cityId + '\",';
            formjson += '\"zipCode\":\"' + zipCode + '\",';
            formjson += '\"address\":\"' + address + '\",';
            formjson += '\"commentParcel\":\"' + commentParcel + '\",';
            formjson += '\"nameGoods\":\"' + nameGoods + '\",';
            formjson += '\"numberGoods\":\"' + numberGoods + '\",';

            formjson += '\"weightParcel\":\"' + weightParcel + '\",';
            formjson += '\"lengthParcel\":\"' + lengthParcel + '\",';
            formjson += '\"widthParcel\":\"' + widthParcel + '\",';
            formjson += '\"heightParcel\":\"' + heightParcel + '\",';

            formjson += '\"costGoods\":\"' + costGoods + '\",';
            formjson += '\"costCDEK\":\"' + costCDEK + '\",';
            formjson += '\"costParcel\":\"' + costParcel + '\",';
            formjson += '\"payment\":\"' + payment + '\",';
            formjson += '\"deliveryRecipientCost\":\"' + deliveryRecipientCost + '\"';
            formjson += '\"tariffId\":\"' + tariffId + '\"';
            formjson += '\"codePvz\":\"' + $codePvz.val() + '\"';

            formjson += '}';

            $.ajax({
                url: '${base}/cdek/makeorder',
                type: 'post',
                data: {'data': formjson},
                dataType: 'json',
                success: function (data) {
                    if (data.success == 'true') {
                        parent.layer.msg('Запрос успешно выполнен', {icon: 1}, returnOK(data.cdekNumber));
                        setTimeout(function () {
                            parent.location.reload();
                            //parent.layer.closeAll();
                        }, 2000)
                    } else {
                        parent.layer.msg('Выполнить этот запрос не удалось' + data.errorMessage, {icon: 2});
                    }
                }, error: function (data) {
                    console.log(data.data);
                    parent.layer.msg('Сбой связи', {icon: 2});
                }
            });
        }
    }

    function getTarif() {
        var tariffId = '';
        if ($("#radio_136").prop("checked")==true){
            tariffId = '136';
        }
        if ($("#radio_137").prop("checked")==true){
            tariffId = '137';
        }
        return tariffId;
    }

    function calc_order_cdek() {
        if ($('#make_order_cdek').valid()) {
            var orderId = $("input[name='order_Id']").val();
            var cityId = $('#city_id').val();

            var weightParcel = $('#weightParcel').val();
            var lengthParcel = $('#lengthParcel').val();
            var widthParcel = $('#widthParcel').val();
            var heightParcel = $('#heightParcel').val();
            var tariffId = getTarif();

            if (cityId == '' || cityId == '0') {
                $(".areaMsg").html('Пожалуйста, выберите город');
                return false;
            } else {
                $(".areaMsg").html('');
            }

            var formjson = '{';
            formjson += '\"orderId\":\"' + orderId + '\",';
            formjson += '\"cityId\":\"' + cityId + '\",';
            formjson += '\"weightParcel\":\"' + weightParcel + '\",';
            formjson += '\"lengthParcel\":\"' + lengthParcel + '\",';
            formjson += '\"widthParcel\":\"' + widthParcel + '\",';
            formjson += '\"heightParcel\":\"' + heightParcel + '\"';
            formjson += '\"tariffId\":\"' + tariffId + '\"';
            formjson += '}';

            $.ajax({
                url: '${base}/cdek/calcorder',
                type: 'post',
                data: {'data': formjson},
                dataType: 'json',
                success: function (data) {
                    if (data.success == 'true') {
                        parent.layer.msg('Запрос успешно выполнен', {icon: 1}, returnCalcDelivery(data.shipPrice));
                        setTimeout(function () {
                            processCost();
                            //location.reload();
                            //parent.layer.closeAll();
                        }, 2000)
                    } else {
                        parent.layer.msg(data.errorMessage, {icon: 2});
                    }
                }, error: function (data) {
                    parent.layer.msg('Сбой связи', {icon: 2});
                }
            });
        }
    }
    function init_list_pvz() {
        var cityId = $('#city_id').val();
        $('.list-pvz').select2({
            language: "ru",
            placeholder: "Выберите пункт выдачи заказа ...",
            tags: true,
            multiple: false,
            tokenSeparators: [',', ' '],
            minimumInputLength: 0,
            minimumResultsForSearch: 10,
            ajax: {
                url: '/cdek/allpvz?cityId=' + cityId,
                dataType: "json",
                type: "GET",
                data: function (params) {

                    var queryParameters = {
                        term: params.term
                    }
                    return queryParameters;
                },
                processResults: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.namePvz + " " + item.address + " тел.:" + item.phone,
                                id: item.codePvz
                            }
                        })
                    };
                },
                cache: false
            }
        })
    }

</script>

