<!DOCTYPE html>
<head><script src="/res_v4.0/js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="/res_v4.0/tracking/css/tracking.css">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>



    <title>Возврат</title>
    <style>
        @font-face {
            font-family: MuseoSansBlack;
            src: url(/res_v4.0/tracking/fonts/MuseoSansBlack.ttf);
        }
        @font-face {
            font-family: MuseoSansLight;
            src: url(/res_v4.0/tracking/fonts/MuseoSansLight.ttf);
        }
        .button_yes  {
            height: 35px;
            width:228px;
            position: relative;
            margin: 10px 115px 0px 0px;
            float:right;
            text-align:  center;
            background-color: black;
            font-size: 15pt;
            font-family:MuseoSansBlack;
            color:white;
            cursor:pointer;
        }
        .button_no  {
            height: 35px;
            width:228px;
            margin:20px 120px 0px 0px;
            float:left;
            /* border: 1px solid; */
            text-align:  center;
            color:black;
            font-size: 15pt;
            font-family:MuseoSansBlack;
            /* cursor:pointer; */
        }
		.text_transport {
			display: block;
			position: relative;
			left: 90px;
		}

	</style>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".inner_botton_yes").hover(function() {
                $(this).stop().animate({ backgroundColor: "#64DC96"}, 500);
            },function() {
                $(this).stop().animate({ backgroundColor: "black" }, 500);
            });
        });
    </script>

</head>

<body>
<div class="main_div" style="border:0px solid #ccc">

    <div class="reg_title" name="reg_title">
        ДАННЫЕ ОТПРАВЛЕНИЯ ОБМЕНА
    </div>
    <div class="line"></div>
    <div class="rows1">

        <img style="width: 320px;" class="images_tracking_goods" src="/res_v4.0/tracking/images_return_goods/tracking.png">

    </div>



    <div class="rows7" style="    margin: 260px auto;">
		<div class="row">
			<div class="col-xs-6">
                <p class="text_transport">ОТПРАВИТЬ КОМПАНИЕЙ СДЭК:</p>
                <div id="send_cdek_company" class="button_yes" name="button_yes">
                    <div id="cdek_confirm_button" class="inner_botton_yes">
                        ОТПРАВИТЬ
                    </div>
                </div>
			</div>
            <div class="col-xs-6">
                <p class="text_transport">ОТПРАВИТЬ ДРУГОЙ КОМПАНИЕЙ:</p>
                <div id="text_any_trek" class="button_no" name="button_no">
                    <div class="sposob_dostavki">
                        ВВЕДИТЕ ТРЕК-НОМЕР ПОСЫЛКИ С ВОЗВРАТОМ
                    </div>
                    <input type="text"  class="user_name" id="shippingCode" name="shippingCode"  placeholder="ТРЭК-НОМЕР:"  style="font-size: 12pt; border: 1px solid black; font-family: MuseoSansLight;">
                </div>
                <div id="send_any_company" class="button_yes" name="button_yes" style="display: 1none;">
                    <div id="confirm_button" class="inner_botton_yes">
                        ОТПРАВИТЬ
                    </div>
                </div>
            </div>
		</div>
        <a href="#">

        </a>
    </div>
</div>

</body>
</html>
<script type="text/javascript" src="${base}/res_v4.0/js/nc-sideMenu.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res_v4.0/js/utils.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res_v4.0/js/layer/layer.js" charset="utf-8"></script>
<link href="${base}/res_v4.0/css/font-icons/style.css"  rel="stylesheet" />



<#if barterDetail??>
	<#if barterDetail.goodsState??  >

    <input name="refundId" value="${barterDetail.refundId}" type="hidden"/>

    <input name="barterId" value="${barterDetail.barterId}" type="hidden"/>




    <input type="hidden" name="shippingExpressName" value="delivery" class="nickname bg" />



	<#else>

	</#if>
<#else>
</#if>




<script type="text/javascript">
    $(function(){
        $("#confirm_button").click(function(){
            var reg = /^[-\+]?\d+(\.\d+)?$/; //?????????????
            var barterId = $("input[name='barterId']").val();
            //var expressId = $("[name=shippingExpressId]").val();
            var invoiceNo = $("#shippingCode").val();
            var expressName = $("input[name='shippingExpressName']").val();
            if(invoiceNo==""){
                layer.msg("Укажите номер отправки!",{icon:2});
                return false;
            }
            if(expressName==""){
                layer.msg("????????!",{icon:2});
                return false;
            }
            var fmUrl = '${base}/user/barterDelivery';
            $.ajax({
                type: "post",
                url: fmUrl,
                data: {barterId:barterId,expressName:expressName,invoiceNo:invoiceNo},
                dataType: "json",
                success:function(data) {
                    if(data.success){
                        layer.alert("Сохранено!",{icon:1},function(){
                            parent.location.href="${base}/user/setting/index";
                        });
                    }else{
                        layer.alert("Ошибка!",{icon:2},function(){
                            parent.layer.closeAll();
                        });
                    }
                }
            });
        });

        $("#cdek_confirm_button").click(function(){
            var shopBarterId = $("input[name='barterId']").val();
            var refundReturnId = $("input[name='refundId']").val();

            var cdekUrl = '${base}/cdek/makeorder';
            $.ajax({
                type: "post",
                url: cdekUrl,
                data: {shopBarterId:shopBarterId,refundReturnId:refundReturnId},
                dataType: "json",
                success:function(data) {
                    if(data.success == "true"){
                        layer.alert("Заказ на возвращение товара успешно создан! Трэк-номер: " + data.cdekNumber,{icon:1},function(){
                            parent.location.href="${base}/user/setting/index";
                        });
                    }else{
                        layer.alert(data.errorMessage,{icon:2},function(){
                            layer.closeAll();
                        });
                    }
                }
            });
        });

    });
</script>