<#assign cartTag = newTag("cartTag") />
<#assign cartMap = cartTag("{'cartIds':'${cartIds}','activityIds':'${activityIds}'}") />

<#assign goodsBaseTag =newTag("goodsBaseInfoTag")>
<#assign goods =goodsBaseTag("{'goodsid':'${goodsId}'}")>


<!DOCTYPE html>
<head>  
  <meta http-equiv='X-UA-Compatible' content='IE=8'>
    <meta name="renderer" content="webkit"/>
    <link href="${base}/res_v4.0/CDN/css/pageOrder.css" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="${base}/res_v4.0/images/favicon.ico"/>

    <link href="${base}/res_v4.0/CDN/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/res_v4.0/CDN/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/res_v4.0/CDN/css/select2.min.css" rel="stylesheet" type="text/css"/>

    <link href="${base}/res_v4.0/css/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>

    <script src="${base}/res_v4.0/js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/jquery-ui-1.8.21.custom.min.js" type="text/javascript"></script>

    <script src="${base}/res_v4.0/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/jquery.imagezoom.min.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/layer/layer.js" type="text/javascript" charset="utf-8"></script>
    <script src="${base}/res_v4.0/js/jquery.validation.min.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/common_js.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/cart/cart.js" type="text/javascript" charset="utf-8"></script>
    <script src="${base}/res_v4.0/js/cart/area_array.js" type="text/javascript" charset="utf-8"></script>
    <script src="${base}/res_v4.0/CDN/js/select2.full.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${base}/res_v4.0/CDN/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
 
  <link rel="stylesheet" type="text/css" href="${base}/res_v4.0/kusto/css/zakaz.css">
  <meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
  <title>Оформить заказ</title>
   <style> 
	   @font-face {
		font-family: MuseoSansBlack;
		src: url(${base}/res_v4.0/kusto/fonts/MuseoSansBlack.ttf);
	   }
		@font-face {
		font-family: MuseoSansLight;
		src: url(${base}/res_v4.0/kusto/fonts/MuseoSansLight.ttf);
	   }
	   .layui-layer-dialog .layui-layer-content {color:#fff !important}
  </style> 
 </head>
<#assign memberInfoTag =newTag("memberInfoTag")>
<#assign member =memberInfoTag("")>

<#assign memberName = member.memberName>
<body>
				
	<style>
	.ui-autocomplete{
		position:absolute;  
		top: 135px !important ;
		left: 267px !important;
	}
    .list-pvz {
        font-size: 12px !important;
        width: 230px;
        height: 16px;
    }
    .button_code_pvz {
        height: 35px;
        width: 228px;
        float: left;
        font-size: 12pt;
        margin: 36px 2px 0px 10px;
    }

    </style>
    
	<div class="main_div"> 
		<div class="zakaz_title" name="zakaz_title">
			ОФОРМИТЬ ЗАКАЗ
		</div>
		<div class="line"></div>
		<div style="display:none" class="basket_text">
		КОРЗИНА
		</div>
		<div style="display:none" class="zakaz_text">
		ОФОРМЛЕНИЕ ЗАКАЗА
		</div>
			<img style="display:none"  class="progress_1" src="${base}/res_v4.0/kusto/images_zakaz/progress_1.png" >
			<div class="right0">
			
			
			
			
			
			

<#if cartMap.get("addressList")??>
    <#if (cartMap.get("addressList")?index_of("[]") == 0)>
  
                <form method="post" action="" id="address_form" target="_parent">
                 
                        <input type="hidden" name="form_submit" value="ok">
                        <input type="hidden" name="id" value="${address.addressId}">  
                                
							
			<div class="rows1">
				<input type="text" id="trueName" onchange="cleandelivery()" class="user_name" name="user_name" placeholder="ВАШЕ ИМЯ ФАМИЛИЯ И ОТЧЕСТВО" value="${memberName}" value= style="font-size:12pt; border-color:black; border:1px solid black; font-family:MuseoSansLight;"  >
				 
				 
			<input type="text" onfocus="$(this).select();" onchange="cleandelivery()" id="cityX" class="user_soname" name="user_soname"
			style="font-size:12pt; border:1px solid black; font-family:MuseoSansLight;" placeholder="Населенный пункт">
				 
			</div>
			
			<div class="rows2"> 
			<input class="text w300" type="hidden" name="address" id="address">
				<input type="text" onkeyup="processaddress();cleandelivery()" id="address1" class="gorod" name="gorod" placeholder="Улица">
				<input type="text" onkeyup="processaddress();cleandelivery()" id="address2" class="gorod" name="gorod" placeholder="Дом / Строение">
				<input type="text" onkeyup="processaddress();cleandelivery()" id="address3" class="gorod" name="gorod" placeholder="Квартира"> 
			<div class="user_phone_prefix" name="user_phone_prefix"><div class="inner_phone_prefix" name="inner_phone_prefix">+7</div></div>
			<input type="text" onchange="cleandelivery()"  class="user_phone" name="user_phone" id="mobPhone" value="${member.memberMobile}"  placeholder="ВАШ ТЕЛЕФОН"> 
			<div id="region" style="display:none">
                                                <input type="hidden" name="addressId" id="addressId">
                                                <input id="city_id" type="hidden" name="city_id"
                                                       value="">
                                                <input id="area_id" class="area_ids" type="hidden" name="area_id"
                                                       value="">
                                                <input id="area_info" class="area_names" type="hidden" name="area_info"
                                                       value=""> 
                                                <span class="areaMsg" style="color: red"></span>
                                            </div> 
                                            <input type="hidden" class="text valid" name="zipCode" id="zipCode"
                                                   maxlength="6"
                                                   value="000000">
                                     
                </form>
            
    </#if>

    <#list cartMap.get("addressList") as address>
        <#if (cartMap.get("addressList")?size) gte 0 >
           
                    <form method="post" action="" id="update_address_form" target="_parent">
                  
                            <input type="hidden" name="form_submit" value="ok">
                            <input type="hidden" name="id" value="${address.addressId}">
            
			
			<div class="rows1">
				<input type="text" id="trueName" class="user_name" name="user_name" placeholder="ВАШЕ ИМЯ ФАМИЛИЯ И ОТЧЕСТВО"  onchange="cleandelivery()" value="${address.trueName}"  style="font-size:12pt; border-color:black; border:1px solid black; font-family:MuseoSansLight;"  >
				 
				 
			<input type="text" id="cityX" onfocus="$(this).select();" class="user_soname" name="user_soname" value="${address.areaInfo}"
			style="font-size:12pt; border:1px solid black; font-family:MuseoSansLight;" onchange="cleandelivery()" placeholder="Населенный пункт">
				 
			</div>
			
			<div class="rows2"> 
			<input class="text w300" type="hidden" name="address" id="address" value="${address.address}">
				<input type="text" onkeyup="processaddress(); cleandelivery()" id="address1" class="gorod" name="gorod" placeholder="Улица">
				<input type="text" onkeyup="processaddress(); cleandelivery()" id="address2" class="gorod" name="gorod" placeholder="Дом / Строение">
				<input type="text" onkeyup="processaddress(); cleandelivery()" id="address3"class="gorod" name="gorod" placeholder="Квартира"> 
			<div class="user_phone_prefix" name="user_phone_prefix"><div class="inner_phone_prefix" name="inner_phone_prefix">+7</div></div>
			<input type="text" onchange="cleandelivery()" class="user_phone" name="user_phone" id="mobPhone" value="${address.mobPhone}"   placeholder="ВАШ ТЕЛЕФОН"> <div id="region">
                                                <input type="hidden" name="addressId" id="addressId"
                                                       value="${address.addressId}">
                                                <input id="city_id" type="hidden" name="city_id"
                                                       value="${address.cityId}">
                                                <input id="area_id" class="area_ids" type="hidden" name="area_id"
                                                       value="${address.areaId}">
                                                <input id="area_info" class="area_names" type="hidden" name="area_info"
                                                       value="${address.areaInfo}"> 
                                                <span class="areaMsg" style="color: red"></span>
                                            </div> 
                                            <input type="hidden" class="text valid" name="zipCode" id="zipCode"
                                                   maxlength="6"
                                                   value="${address.zipCode}">
                                     
                    </form> 
   
        </#if >
    </#list>
</#if>		 
			</div> 
					
			<div style="position:absolute; top:199px;"
			>	<div class="sposob_dostavki">
					СПОСОБ ДОСТАВКИ:
				</div>
				<div class="rows3">
<script> 
function cleandelivery(){
	$('#shipselect').val('');
	$('#order_shipp_min_day').html('~');
	$('#order_shipp_max_day').html('~');
	$('#order_shipp').html('~');
	$('#order_amount').html('~'); 
	$('.button_code3').addClass('button_code2').removeClass('button_code3'); 
}
function choosepay(el,val){
	$(".paym").addClass('button_code2').removeClass('button_code3');
	$(el).addClass('button_code3').removeClass('button_code2');
	$('#payselect').val(val); 
}
$(function() {
	<#if (RequestParameters.delivery??) > 
	$('#shipselect').val('${RequestParameters.delivery}');getTotalPrice();activedelivey($('.order-pickupdelivery-icon'));
	</#if>
});
</script>	
					<a href="#" onclick="<#if cartMap.get("addressList")??><#if (cartMap.get("addressList")?index_of("[]") == 0)>save_address('FREE');<#else>update_address('FREE')</#if></#if>; return false;" >
					<div style="margin-left:0px;" class="<#if (RequestParameters.delivery?? && RequestParameters.delivery == "FREE")>button_code3<#else>button_code2</#if>" name="button_code">
					<div class="inner_input_data2">
						САМОВЫВОЗ
					</div>
					</div>
					</a>
				 
					<a onclick="<#if cartMap.get("addressList")??><#if (cartMap.get("addressList")?index_of("[]") == 0)>save_address('CDEK');<#else>update_address('CDEK')</#if></#if>; return false;" href="#">
					<div class="<#if (RequestParameters.delivery?? && RequestParameters.delivery == "CDEK")>button_code3<#else>button_code2</#if>" name="button_code3">
					<div class="inner_input_data2">
						КУРЬЕРОМ ТК
					</div>
					</div>
					</a>

                    <div style="top: 0px; right: 50px;" class="sposob_dostavki">
                        ВЫБЕРИТЕ ПУНКТ ВЫДАЧИ ЗАКАЗА::
                    </div>
                        <div class="button_code_pvz">
                            <div class="inner_input_data2">
                                <select class="list-pvz">
                                    <!--  <option value="3620194" selected="selected">select2/select2</option>  -->
                                </select>
                            </div>
                        </div>



                </div>
			</div>
			<div style="position:absolute; top:269px;">
				<div style="top: 0px;" class="sposob_dostavki">
					СПОСОБ ОПЛАТЫ:
				</div>
					
				<div class="rows4">
					<a href="#">
					<div onclick="choosepay(this,'AC')" style="margin-left:0px;" class="button_code2 paym" name="button_code4">
					<div class="inner_input_data2">
						VISA / MASTER CARD
					</div>
					</div>
					</a>
					
					<a href="#">
					<div onclick="choosepay(this,'PC')" class="button_code2 paym" name="button_code2">
					<div class="inner_input_data2">
						ЯНДЕКС ДЕНЬГИ
					</div>
					</div>
					</a>
				</div>
			</div>

            <div class="rows4">
			</div>
			
			</div>
			<div class="right1" style="position:relative">
				
				<div class="text_info_bay">
				ИНФОРМАЦИЯ О ПОКУПКЕ:
				</div>
				<div class="line_small_right"></div>
			
					<div class="button_up">
						<img class="button_up_image" src="${base}/res_v4.0/kusto/images_zakaz/button_up.png" >
					</div>
			




				<div id="catalogX">
					<#if cartMap.get("cartVoList")??>
                        <#list cartMap.get("cartVoList") as cartVo> 
                                    <#if cartVo.list??>
                                        <#list cartVo.list as cart>
                                             
											 
				<div class="image_right_div">
					<a target="_blank" href="${base}/product/${cart.specId}.html"><img class="image_right" alt="${cart.goodsName}" src="${imgServer}${cart.goodsImages}" ></a> 
				</div> 
					<div class="my_order_color_product">${cart.specInfo}</div>
					<!-- <div class="my_order_size_product">Размер:</div>   -->                                       
                                             
                                          
                                        </#list>
                                    </#if>
                         
                        </#list>
                    </#if>
				</div>
 		
		
				<div class="bbd">
					<div class="button_down">
						<img class="button_down_image" src="${base}/res_v4.0/kusto/images_zakaz/button_down.png" >
					</div> 
					<div class="line_small_right_button"></div>
				</div>
			</div>
		 
		<div class="row4_div">
			<div class="u_fun_text">
				U-FUN постоянно стремиться обеспечить своим клиентам наилучшее качество обслуживания
			</div>
			<div class="payment_card1">
			<a href="#"><img class="payment_card1" src="${base}/res_v4.0/kusto/images_basket/payment_visa.png"></a>
			</div>
			<div class="payment_card2">
			<a href="#"><img class="payment_card2" src="${base}/res_v4.0/kusto/images_basket/payment_mastercard.png"></a>
			</div>
			<div class="payment_card3">
			<a href="#"><img class="payment_card3" src="${base}/res_v4.0/kusto/images_basket/payment_yandex.png"></a>
			</div>
			<div class="payment_card4">
			<a href="#"><img class="payment_card4" src="${base}/res_v4.0/kusto/images_basket/payment_qiwi.png"></a>
			</div>
			<div class="castle">
			<a href="#"><img class="castle" src="${base}/res_v4.0/kusto/images_basket/castle.png">
			<div class="security_div">Безопасные онлайн-платежи</div>
			</a>
			</div>
			<div class="all_summa">
				Cумма товаров <span style="float:right"><span id="goods_amount"></span> РУБ.</span><br>
				Cтоимость доставки <span style="float:right"><span id="order_shipp">~</span> РУБ.</span><br>
				Получение <span style="float:right"><span id="order_shipp_min_day">0</span> / <span id="order_shipp_max_day">0</span></span><br>
				<div class="line2"></div>
				<br>
				ИТОГО: <span style="float:right"><span id="order_amount"></span> РУБ.</span>
			</div> 
		</div>
		<div class="row5_div">
			<div class="left_button">
				<a href="/cart/index"><img class="left_button" src="${base}/res_v4.0/kusto/images_basket/left_button.png"><div class="inner_black">НАЗАД В КОРЗИНУ</div></a>
			</div>
			<div class="right_button">
				
			</div>
			<a href="#" id="submitToPay" onclick="return false;" style="cursor:pointer;"><img class="right_button" src="${base}/res_v4.0/kusto/images_basket/checkout_black.png"><div style="cursor:pointer;" class="inner_white">ОФОРМИТЬ ЗАКАЗ</div></a>
			<!-- <div class="right_button">
				<a href="#"><img class="right_button" src="images_basket/checkout_green.png"><div class="inner_white">ОФОРМИТЬ ЗАКАЗ</div></a>
			</div> -->
		</div>
	</div>
<input type="hidden" id="cartlist" name="cartlist"  value='cartMap.get("cartVoList")'/>		
<input type="hidden" name="form_submit" id="payselect" value="">	
<input type="hidden" name="cartIds" value="${cartIds}" id="cartIds"/>
</body>
</html>

 


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>














<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>










<head>


    <script>

        var memberId = '';

        $(document).ready(function () {
            $(".button_show").click(function () {
                var defaultexpand = $(this).attr("defaultexpand");
                if (defaultexpand != "true") {
                    $(this).attr("defaultexpand", "true");
                    $(this).find("img").attr("src", "${base}/res_v4.0/images/icon_11.png");
                } else {
                    $(this).attr("defaultexpand", "false");
                    $(this).find("img").attr("src", "${base}/res_v4.0/images/icon_007.png");
                }
                $(".button_showp").toggle(500)
            });
            $(".button_show1").click(function () {
                var defaultexpand = $(this).attr("defaultexpand");
                if (defaultexpand != "true") {
                    $(this).attr("defaultexpand", "true");
                    $(this).find("img").attr("src", "${base}/res_v4.0/images/icon_11.png");
                } else {
                    $(this).attr("defaultexpand", "false");
                    $(this).find("img").attr("src", "${base}/res_v4.0/images/icon_007.png");
                }
                $(".button_showp1").toggle(500);
            });

            $(".con_coupon ul .coupon_title").click(function () {
                var coupontype = $(this).attr("coupontype");
                if (coupontype == "1") {
                    $(this).addClass("coupon_hover");
                    $(this).next().removeClass("coupon_hover");
                    $(".canusercoupon").css("display", "block");
                    $(".nocanusercoupon").css("display", "none");
                } else if (coupontype == "2") {
                    $(this).addClass("coupon_hover");
                    $(this).prev().removeClass("coupon_hover");
                    $(".canusercoupon").css("display", "none");
                    $(".nocanusercoupon").css("display", "block");
                }
            });
        });
        var delivprice = 0;
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

            $(".list-pvz").select2({
                language: "ru",
                placeholder: "Начните вводить данные ...",
                tags: true,
                multiple: false,
                tokenSeparators: [',', ' '],
                minimumInputLength: 0,
                minimumResultsForSearch: 10,
                ajax: {
                    url: '/cdek/allpvz?cityId=' + $('#city_id').val(),
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
            });

        });

        function processaddress() {
            $("#address").val($("#address1").val() + "," + $("#address2").val() + "," + $("#address3").val());
        }
        function splitaddress(splitString) {
            tempArray = splitString.split(',');
            $("#address1").val(tempArray[0]);
            $("#address2").val(tempArray[1]);
            $("#address3").val(tempArray[2]);
        }

        function delivery2(sdecid, cityname) {
            //    if(($("#address1").val() == ''))&&($("#address2").val() == ''))&&($("#address3").val() == '')) {
            //        alert("empty!");
            //    };

            $("#city_id,#area_id,#area_info").val(sdecid);
            //   $("#address").val(cityname);

        }

    </script>
   
</head>
<body>

<#assign siteSettingTag = newTag("siteSettingTag") />
<#assign siteSet = siteSettingTag("") />
<title>${siteSet.siteTitle} -- ${title}</title>
<#if keywords?? && keywords != ''>
<meta name="keywords" content='${keywords}'/>
<#else>
<meta name="keywords" content='${siteSet.siteKey}'/>
</#if>

<#if description?? && description != ''>
<meta name="description" content='${description}'/>
<#else>
<meta name="description" content='${siteSet.siteDiscription}'/>
</#if>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 
<!--搜索框开始-->
<!--
<div class="wrap clearfix">
    <!--header start-->
 
<div class="container pay-container">
    <div class="row rowX">
        <div class="col-xs-offset-1 col-xs-10 section-name2">Способ доставки</div>
    </div>
    <div class="row rowX">
        <div class="col-xs-offset-1 col-xs-3">
            <form action="">
                <div style="display:1none;" id="kuriercb" class="radio-choice">
                    <input onclick="$('#shipselect').val('CDEK');getTotalPrice();activedelivey($('.order-pickupdelivery-icon'))"
                           type="radio" name="adress">Доставка курьером
                </div>
                <div style="display:1none;" id="samcb" class="radio-choice">
                    <input onclick="$('#shipselect').val('FREE');getTotalPrice();activedelivey($('.order-mandelivery-icon'))"
                           type="radio" name="adress">Самовывоз
                </div>
            </form>
        </div>
        <div class="col-xs-offset-1 col-xs-5">
            <div class="inlineblck">
                <div class="order-icon-delivery order-pickupdelivery-icon" id="kurierpic"
                     onclick="$('#kuriercb input').trigger('click');activedelivey(this)"></div>
            </div>
            <div class="inlineblck">
                <div class="order-icon-delivery order-mandelivery-icon" id="sampic"
                     onclick="$('#samcb input').trigger('click');activedelivey(this)"></div>
            </div>
        </div>
    </div> 
 
    <div class="col-xs-offset-6">Габариты посылки：<span id="order_shipp_parcel_size"></span></div>
    <div class="col-xs-offset-6">Вес посылки (кг)：<span id="order_shipp_parcel_weight"></span></div>

    <input id="shipselect" type="hidden" name="shipselect" value="">
    <input id="shippingFee" type="hidden" name="shippingFee" value="0">
    <input id="parcel" type="hidden" name="parcel" value="0">


</div>
<br><br>

<script>
    function active(el) {
        $(".order-icon").removeClass("order-color-icon");
        $(el).addClass("order-color-icon");
    }
</script>

<script>
    function activedelivey(el) {
        $(".order-icon-delivery").removeClass("order-color-icon");
        $(el).addClass("order-color-icon");
    }
</script>


<form method="post" id="order_form" name="order_form" action="${base}/cart/subOrder">
    
    <div class="mem_ads"
         style="width:1200px;margin:0 auto;border:#e5e5e5 1px solid;padding-bottom:20px;padding-right:2px;padding-left:2px;">
        <div class="member_wrap mt15">
            <div class="online payment pb20" style="line-height:30px;color:#666;width:100%;height:auto;">
                <div class="receipt_address">
                    <input name="invoiceId" type="hidden" value=""/>
                    <div class="coverage area">
                        <p class="fl f16 pl10">Просмотреть счет-фактуру</p></br>
                        <table class="my_infor" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <div>
                                        <span id="invoice"
                                              style="text-align: left;padding-left:40px;">Счет не выставлен</span>
                                <span style="text-align: left;"><a href="javascript:void(0)"
                                                                   onClick="updateInvoice()"
                                                                   class="pl10 goods-b">Редактировать</a></span>
                            </div>
                        </table>
                        <div class="fapiao_div"></div>
                    </div>
                    <div class="coverage area">
                        <p class="fl f16 pl10">Выберите способ оплаты</p></br>
                        <table class="my_infor" width="100%" border="0" cellspacing="0" cellpadding="0"
                               style="padding-left:40px;border-bottom:#e5e5e5 solid 1px;">
                            <p class="bianku txl pl40 mt10"><a href="javascript:void(0)" id="on_line"
                                                               class="border_x"
                                                               style="border: #fc0000 1px solid;color: #fc0000;">Оплата
                                on-line</a>
                                <a href="javascript:void(0)" id="offline" style="width:30px;height:15px;">Наложенный
                                    платеж</a>
                            </p>
                            <input type="hidden" id="payment_method" name="paytype" value="1"/>
                        </table>
                        <div class="fapiao_div"></div>
                    </div>
                    <!--清单-->
                    <div class="coverage area">
                    <p class="fl f16 pl10">Утверждение списка товаров<#if activityIds==null||activityIds=="" ></p><span
                            style="text-align: right;color: red;">
                    </#if></span></br>
                   
                    <#assign availablePredeposit = cartMap.get("member").availablePredeposit/>
                    <#assign couponMemberTag = newTag("couponMemberTag") />
                    <#assign map = couponMemberTag("{'cartIds':'${cartIds}'}") />
                    <#assign couponMemberMap =map.get("couponMemberMap") />
                        <div class="balance mt10" style=" text-align: left; ">
                            <a class="button_show" style="margin-left: 20px; cursor: pointer;"><img
                                    src="${base}/res_v4.0/images/icon_007.png"/><em class="pl10">使用优惠券</em></a>
                            <div class="con_coupon button_showp" style="display: none;">
                                <ul>
                                <#-- <li class="coupon_title coupon_hover" coupontype="1">
                                     <span>
                                     可用优惠卷
                                     <em class="goods-h">（${map.cannum}）</em>
                                     </span>
                                 </li>
                                 <li class="coupon_title" coupontype="2">
                                     <span>
                                     不可用优惠券
                                     <em class="goods-h">（${map.nonum}）</em>
                                     </span>
                                 </li>-->
                                <#if  couponMemberMap?size == 0 >
                                    <li>此订单暂无可用的优惠券</li>
                                <#else>
                                    <li class="canusercoupon">
                                        <div style="clear:both;"></div>
                                        <input name="couponId" id="couponMember" value="" type="hidden"/>
                                    <ul class="couponul">

                                        <#list couponMemberMap?keys as storeId>
                                            <#list couponMemberMap.get(storeId) as couponMember>
                                                <li>
                                                    <div class="virtual-table">
                                                        <div class="virtual-table-body">
                                                            <div class="virtual-action">
                                                                <input type="checkbox" class="jdcheckbox"
                                                                       value="${couponMember.id}"
                                                                       price="${couponMember.shopActivityPromotionRule.couponSource}"
                                                                       onclick="selectCoupon(this,'${couponMember.shopActivityPromotionRule.couponSource}','${storeId}');"
                                                                       name="couponCheckBox_${storeId}"
                                                                       style="margin-top: 7px;">
                                                            </div>
                                                            <div class="virtual-sum">
                                                                    <span class="coupon-scope">${couponMember.shopActivityPromotionRule.limitWhere}
                                                                        -${couponMember.shopActivityPromotionRule.couponSource}<font>元</font>
                                                                    </span>
                                                            </div>

                                                            <div class="virtual-type" title="">
                                                                <div sytle="width:300px;height:28px;overflow:hidden;line-height:28px;">
                                                                ${couponMember.shopActivityPromotionRule.shopActivity.storeName}
                                                                </div>
                                                            </div>
                                                            <div class="virtual-vtime">
                                                            ${couponMember.shopActivityPromotionRule.shopActivity.startTimeStr?string('yyyy-MM-dd')}
                                                                --${couponMember.shopActivityPromotionRule.shopActivity.endTimeStr?string('yyyy-MM-dd')}
                                                            </div>
                                                            <div class="clr"></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <#if couponMember_index%4 == 0 && couponMember_index != 0>
                                                </ul>
                                                <ul class="couponul">
                                                </#if>
                                                <#if !couponMember_has_next>
                                                </ul>
                                                </#if>
                                            </#list>
                                        </#list>
                                    </li>
                                </#if>
                                    <li class="usercoupon" style="width:240px">
                                            <span>
                                                共使用了
                                                <em id="couponNum" class="goods-y">0</em>
                                                张优惠券&nbsp;可以优惠
                                                <em class="goods-y" id="couponPrice">0.00</em>元
                                            </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="balance mt10">
                            <p><a class="button_show1" style="cursor:pointer"><img class="expandType"
                                                                                   src="${base}/res_v4.0/images/icon_007.png"/>
                                <em class="pl10">баланс</em></a>
                            </p>
                            <div class="con_coupon button_showp1" style="display: none;">
                                <ul>
                                    <li style="margin-left: 15px;">
                                        <input type="checkbox" name="isPd" value="0"
                                               <#if availablePredeposit==0>disabled="disabled"</#if>>
                                        <span class="pl10">Баланс（Сальдо счета текущих операций：
                                                <script type="text/javascript">
                                                    var pd = number_format(${availablePredeposit}, 2);
                                                    document.write("&yen;" + pd);
                                                </script>元）
                                            </span>
                                    </li>
                                    <li>支付密码：<input type="password" class="text"
                                                    style="width:320px;height:26px;color:#666;"
                                                    name="paymentpass" value="" style="color:#999999">&nbsp;
                                        <a href="${base}/user/setting/queryPaymentPass">忘记支付密码？</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bk30"></div>
            <div class="balance_list font_color">
                <ul>
                 
                    <li class="pt30">
                        <a href="javascript:void(0)" class="ml10 button_ys"  
                           style="color:#000;font-weight:300">Отправить заказ</a>
                        <a href="${base}/cart/index" class="button_yg" style="color:#666;font-weight:300">Назад
                            к корзине</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    </div>
    </div>
</form>


<script>
    //禁止点击浏览器返回
    //javascript:window.history.forward(1);
    //history.go(1);


    var APP_BASE = '${frontServer}';
    $(function () {
        //验证cart信息是否存在
        isexistcartIds();
        //加载运费
        addShipping();
        //加载默认收货地址,收货人
        addressmember();
        //选择已经存在的收货人地址
        $(document).on('click', "#defAddress", function () {
            var id = $(this).parents("#my_infor2").prev().val();
            var addressId = "address_" + id;
            //var obj = $("#"+addressId).parent("ul");
            $.ajax({
                type: "post",
                url: '${base}/myaddress/updateDef',
                data: {addressId: id},
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        $("a#defAddress").text("设为默认收货地址");
                        $("#" + addressId).next().find("a#defAddress").text("Установлен, как адрес доставки по-умолчанию");
                        $("#my_infor2 .list_one a").parents("#address_z").siblings().contents().find("a").removeAttr("style");
                        $("#" + addressId).next().find(".list_one").children().attr("style", "padding: 5px;border: #fc0000 1px solid;color: #fc0000;");
                    } else {
                        layer.msg("默认收货地址设置失败!");
                    }
                }
            });
        });
        $(document).on("click", "#fewer_id", function () {//展开发货地址
            var pd = $("#addresslist .list_one a[style]");
            if (pd.length > 0) {
                var dizh = $("#addresslist .list_one a:not([style])").parents("#address_z");
                $("#fewer_id").text(dizh.is(":hidden") ? "Collapse адрес" : "Expand Адрес");
                dizh.slideToggle();
            } else {
                $("#fewer_id").text($(".coverage #my_infor2:gt(0)").is(":hidden") ? "Collapse адрес" : "Expand Адрес");
                $(".coverage #my_infor2:gt(0)").slideToggle();
            }
        });
        $("#on_line").click(function () {//Оплата on-line
            $("#offline").attr("style", "");
            $(this).attr("style", "border: #fc0000 1px solid;color: #fc0000;");
            $("#payment_method").val("1");
        });
        $("#offline").click(function () {//Наложенный платеж
            $("#on_line").attr("style", "");
            $(this).attr("style", "border: #fc0000 1px solid;color: #fc0000;");
            $("#payment_method").val("2");
        });
        $(document).on('click', "#my_infor2 .list_one a", function () {
            $("#my_infor2 .list_one a").parents("#address_z").siblings().contents().find("a").removeAttr("style");
            $(this).attr("style", "border: #fc0000 1px solid;color: #fc0000;");
        });
//        $("#my_infor2 .list_one a").click(function () {
//            $("#my_infor2 .list_one a").parents("#address_z").siblings().contents().find("a").removeAttr("style");
//            $(this).attr("style", "border: #fc0000 1px solid;color: #fc0000;");
//        });

        $(document).on('click', "#editAddress", function () {	//修改地址
            var id = $(this).parents("#my_infor2").prev().val();
            var addressId = "address_" + id;
            //var obj = $("#"+addressId).parent("ul");
            layer.open({
                type: 2,
                move: false,
                shade: false,
                offset: ['RT'],
                title: 'Редактировать',
                content: ['${base}/myaddress/updateAddress?id=' + id, 'no'],
                area: ['550px', '330px']
            });
        });
        $(document).on('click', "#delAddress", function () {	//删除地址
            var id = $(this).parents("#my_infor2").prev().val();
            var addressId = "address_" + id;
            layer.confirm('Действительно удалить ?', function () {
                $.ajax({
                    type: "post",
                    url: "${base}/myaddress/deleteAddress?id=" + id,
                    data: null,
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.success == "true") {
                            layer.msg('Успешно удалено', {icon: 1}, initDataList());
                        } else {
                            layer.msg('Не удалось удалить');
                        }
                    }
                });
            });
        });
        //选择是否使用余额
        $(document).on('click', "input[name='isPd']", function () {
            if ($("input[name='isPd']").prop("checked")) {
                $("input[name='isPd']").val(1);
            } else {
                $("input[name='isPd']").val(0);
            }
            getTotalPrice();
        });
        //提交订单
        $('#submitToPay').click(function () {
            if ($("input[name='isPd']").val() == 1) { //如果使用余额支付
                var pwd = $("input[name='paymentpass']").val();  <#--支付密码-->
                if (pwd == "") {
                    layer.msg("Пожалуйста, введите платежный пароль！");
                    return false;
                } 
                $.ajax({
                    url: "${base}/chkPasswd",
                    type: 'post',
                    data: {'passwd': pwd},
                    dataType: 'json',
                    success: function (data) {
                        if (data.success == 0) {
                            if ($("#addddresid").val() == "") {
                                layer.msg('Установить адрес доставки');
                                return false;
                            }
                            //showLoading();
                            var cartIds = $("#cartIds").val();
                            $.ajax({
                                url: "${base}/cart/orderVal",
                                type: 'post',
                                data: {'cartIds': cartIds},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.success) {
                                        //获取返回的map集合
                                        var result = data.result;
                                        if (result.specnotfund.length != 0) { //判断商品是否存在
                                            //新建一个字符串,存储不存在的商品名称
                                            var str = "";
                                            result.specnotfund.forEach(function (s) {
                                                str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                            });
                                            layer.msg("Ваша покупка:" + str + "Не существует, пожалуйста, повторно отправьте заказ!");
                                        } else if (result.goodsshow.length != 0) { //先判断商品状态
                                            //新建一个字符串,存储状态异常的商品名称
                                            var str = "";
                                            result.goodsshow.forEach(function (s) {
                                                str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                            });
                                            layer.msg("Ваша покупка:" + str + "в ненормальном состоянии, пожалуйста, повторите ваш заказ!");
                                        } else if (result.understock.length != 0) { //判断库存量
                                            //新建一个字符串,存储库存不足的商品名称
                                            var str = "";
                                            result.understock.forEach(function (s) {
                                                str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                            });
                                            layer.msg("Ваша покупка:" + str + "отсутствут в системе учета, пожалуйста, повторите ваш заказ!");
                                        } else if (result.pricechange.length != 0) { //然后判断价格是否变动
                                            //新建一个字符串,存储价格变动的商品名称
                                            var str = "";
                                            result.pricechange.forEach(function (s) {
                                                str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                            });
                                            layer.msg("Ваша покупка:" + str + "Цены изменились, пожалуйста, повторите ваш заказ!");
                                        }
                                        //hideLoading();
                                    } else {
                                        submitFrom();
                                        $("#submitToPay").removeAttr("id");
                                    }
                                }
                            });
                        } else if (data.success == 1) {
                            layer.msg(data.msg, {icon: 2});

                        } else {
                            layer.msg(data.msg, {icon: 2});
                        }
                    }
                });
            } else {
                if ($("#addddresid").val() == "") {
                    layer.msg('Выберите адрес доставки');
                    return false;
                }
				if ($('#shipselect').val() == "") { //判断商品是否存在 
					layer.msg("Выберите способ доставки!",false,999999);
					return false;
                }

                var codePvz = $(".list-pvz").val();
                if (($('#shipselect').val() == "FREE") && (codePvz == null)) {
                    layer.msg("Пожалуйста, выберите пункт выдачи заказа!",false,999999);
                    return false;
                }


                if ($("#payselect").val() == "") { //判断商品是否存在
					layer.msg("Выберите способ оплаты!");
					return false;
                }
               // showLoading();
                var cartIds = $("#cartIds").val();
                $.ajax({
                    url: "${base}/cart/orderVal",
                    type: 'post',
                    data: {'cartIds': cartIds,'codePvz':codePvz},
                    dataType: 'json',
                    success: function (data) {
                        if (data.success) {
                            //获取返回的map集合
                            var result = data.result;
                           
							
							if (result.specnotfund.length != 0) { //判断商品是否存在
                                //新建一个字符串,存储不存在的商品名称
                                var str = "";
                                result.specnotfund.forEach(function (s) {
                                    str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                });
                                layer.msg("Ваша покупка:" + str + " не существует, пожалуйста, повторно отправьте заказ!");
                            } else if (result.goodsshow.length != 0) { //先判断商品状态
                                //新建一个字符串,存储状态异常的商品名称
                                var str = "";
                                result.goodsshow.forEach(function (s) {
                                    str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                });
                                layer.msg("Ваша покупка:" + str + " в ненормальном состоянии, пожалуйста, повторите Ваш заказ!");
                            } else if (result.understock.length != 0) { //判断库存量
                                //新建一个字符串,存储库存不足的商品名称
                                var str = "";
                                result.understock.forEach(function (s) {
                                    str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                });
                                layer.msg("Ваша покупка:" + str + "отсутствует в системе учета, пожалуйста, повторите ваш заказ!");
                            } else if (result.pricechange.length != 0) { //然后判断价格是否变动
                                //新建一个字符串,存储价格变动的商品名称
                                var str = "";
                                result.pricechange.forEach(function (s) {
                                    str += s.goodsName + "&nbsp;&nbsp;&nbsp;";
                                });
                                layer.msg("Ваша покупка:" + str + "изменились цены, пожалуйста, повторите ваш заказ!");
                            }
                            //hideLoading();
                        } else {
                            submitFrom();
                            $("#submitToPay").removeAttr("id");
                        }
                    }
                });
            }
        });

        // 提交订单
        function submitFrom() {
            var cartIds = $("input[name=cartIds]").val();
            var storeId = 0;
            var address_options = $("input[name=id]").val();
            var paytype = 1;
            var couponId = $("input[name=couponId]").val();
            if (couponId == undefined) {
                couponId = "";
            }
            var transport_type = $('#shipselect').val();
            if (transport_type == undefined) {
                transport_type = "";
            }
            var invoiceId = $("input[name=invoiceId]").val();
            var isPd = $("input[name=isPd]").val();
            var shipping_Fee = $("input[name=shippingFee]").val();
            var parcel = $("input[name=parcel]").val();

            var codePvz = $(".list-pvz").val();

            $.ajax({
                url: "${base}/cart/addOrder",
                type: 'post',
                data: {
                    'cartIds': cartIds,
                    "storeId": storeId,
                    "address_options": address_options,
                    "paytype": paytype,
                    "couponId": couponId,
                    "transport_type": transport_type,
                    "invoiceId": invoiceId,
                    "isPd": isPd,
                    'activityIds': '${activityIds}',
                    'shippingFee': shipping_Fee,
                    'parcel': parcel,
                    'codePvz': codePvz
                },
                dataType: 'json',
                success: function (data) {
                    if (data.result == "1") {
                        var paySn = data.message;
                        var params = "?paySn=" + paySn;
                        params += "&memberId=" + memberId;
                        params += "&payType=" + paytype;
                        params += "&paymethod=" + $('#payselect').val();
                        params += "&order_amount=" + $('#order_amount').html();
                        window.location.href = "${base}/cart/orderToPay" + params;
                    } else {
                        layer.msg(data.message);
                    }
                    hideLoading();
                },
				error: function (data) {
					console.log(data);
				}
            });
        }
    });
    /**添加收货地址**/
    function shownewaddress() {
        layer.open({
            type: 2,
            move: false,
            offset: ['RT'],
            shade: false,
            title: 'Введите адрес',
            content: ['${base}/cart/addresslist', 'no'],
            area: ['550px', '330px']
        });
    }

    //加载运费
    function addShipping() {
        //市级id
        var cityId = "";
        //收货地址信息
        var city = $("#my_infor2 li a[style]").parent().attr("id");
//        var cityId = $("#" + city).parent("address_list").attr("city_id");
        var cityId = $("#" + city).parents(".address_list").children("input").attr("city_id");//获取省市id
        var trans_total_ = $("#trans_total_").val();//获取后面价格值
        var cartIds = $("#cartIds").val();
        $.ajax({
            url: '${base}/cart/addShipping',
            type: 'post',
            data: {'cartIds': cartIds, 'cityId': cityId},
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    $.each(data.result, function (key, values) {   //遍历map
                        var str = '';
                        var num = 0; //循环次数
                        str += '<span>доставка：';
                        str += "<select name=\"transport_type\" style=\"height:30px;width:110px;\" onchange=\"shipUpdate(this,'" + key + "')\" >";
                        $.each(values, function (key1, values1) {  //遍历运费模板map
                            num += 1;
                            str += '<option value="';
                            str += key1 + '|' + key + '">';  //选择的值为运输方式|店铺id
                            if (key1 == 'py') {
                                str += 'обычная почта  ' + toDecimal2(values1);
                            } else if (key1 == 'kd') {
                                str += 'срочная доставка  ' + toDecimal2(values1);
                            } else if (key1 == 'es') {
                                str += 'EMS  ' + toDecimal2(values1);
                            }
                            str += '</option>';
                        });
                        str += '</select> <span id="trans_total_' + trans_total_ + '" class="font_gb"></span></span>';
                        //将运费加入页面
                        if (num != 0) {
                            $("#ship_" + key).html(str);
                            var freight = $("#ship_" + key).find("select[name='transport_type'] option:selected").text().split("  ");
                            $("#ship_" + key).parent().find("#trans_total_" + key).html("&yen;" + toDecimal2(freight[1]));
                        }
                    });
                    getTotalPrice();
                }
            }, error: function (data) {
                layer.msg('сбой связи');
            }
        });
    }

    function replacingCity(idCity) {
        var arrayIdFarEastCity = new Array(
		//Амурская область
		'14424','896','286','918','13488','14425','33594','32721','13370','14427',
		'24454','32961','3224','2329','13328','14445','13012','32973','13065',
		'13936','13447','14426','14423','14422','13013','14428','3229','13396',
		'13064','1763','16577','13937','13294','318','13395','24418','13931',
		'32145','24403','1760','14792',
		//Саха-Якутия
		'2989','502','16078','1420','13962','13963','31507','1418','13964','14831',
		'13426','1427','13965','19','13984','1428','33316','13966','1465','1415',
		'13967','33489','32900','13968','32968','1416','1422','33454','2995',
		'1462','2994','891','13969','1423','892','14556','14832','13144','13970',
		'1429','1425','13971','13003','33114','1488','1421','23003','2990','2991',
		'31930','13972','33507','1426','31989','893','1417','13973','1298','13974',
		'13975','13474','13976','33074','24401','13977','2992','1424','1464',
		'2993','13473','1419','15224','15195','283',
		//Сахалинская область
		'14668','14552','16267','23832','33329','22966','32058','23974','32743',
		'32152','13960','13436','13563','32869','32135','24000','56','31577',
		'14977','31278','14420','30969','3216','2997','16509','23822','2399',
		'2996','31652','16268','14978','14554','23926','31067','14555','16076',
		'14553','14551','68','13425','13007','473',
		//Камчатский край
		'32134','31350','13087','407','2543','31815','13074','13076','895','2544',
		'13075','13086','31352','31816','3205','31351','894','13084','13078',
		'31819','31353','3214','13079','30996','13081','31355','31348','14545',
		'16041','13082','285','2542','13071','13085','2545','31817','16071','33584',
		'13080','13083','14546','31300','13073','14550','13564','31354','13077',
		'13072','31349','14544','31818',
		//Приморский край
		'14565','2379','53','13282','904','288','2380','16101','1853','24327','128',
		'500','32641','24361','13060','1148','2378','24363','16456','13448','1074',
		'13429','31667','13449','2868','14558','13442','14560','13283','33017',
		'13284','16954','2377','2869','31168','2398','13440','2870','23831','501',
		'24362','14299','32760','23821','23668','14298','13100','33318','14301',
		'33533','31006','13439','33590','14564','2394','33167','31491','14561',
		'2375','14295','907','31177','31492','33602','13441','14302','14297','14563',
		'14976','15081','2871','2872','14296','2376','24326','33109','13285','16404',
		'13443','31511','13099','31391','13279','2873','13280','955','906','31120',
		'14559','14303','14300','2874','14557','14294','13306','14566','14562','13281',
		//Хабаровский край
		'900','1438','3121','14547','13866','13410','31396','14969','13147','29','13863',
		'13935','2363','13862','30968','32153','14900','902','33098','14973','31333',
		'1266','31990','3122','13673','3123','903','13861','31279','14970','16931','13867',
		'14897','14898','31714','31806','13438','14901','14975','14971','2372','1487','32232',
		'15569','14899','899','13115','31733','23661','13864','30967','2373','3124',
		'32792','23862','31541','22990','13398','13148','14972','31539','287','14974',
		'13865','24337','13500','16929','31540','13432','31228','13672','14291',
		//Еврейская АО
		'23919','32147','914','32985','31584','14548','31934','14336',
		'1295','1106','13618','14549','13613','23886',
		//Магаданская область
		'24406','33166','314','31959','2738','2741','31258','2743','13142','32034',
		'2739','13143','2740','2744','2347','2742','2745','15896',
		//Чукотский АО
		'2381','3163','32068','15801','14671','32998','3164',
		'3166','13149','3162','3165'
		);

        if (arrayIdFarEastCity.indexOf(idCity) > -1 ) {
            idCity = idCity + ',farEastCity';
        } else {
            idCity = idCity + ',otherCity';
        }
        return idCity;
    }

    //计算应付金额
    function getTotalPrice() {
        var couponId = "";
        //获取优惠券信息
        var couponMember = $("#couponMember");

        var cityId = replacingCity($('#city_id').val());

        //运费信息
        var freight = $('#shipselect').val();
        //运费模块
        var ship = $("select[name='transport_type']");
        //市级id
        //收货地址信息
        var city = $("#my_infor2 tr td a[style]").parent().attr("id");
        //是否使用余额
        var isPd = 0;
        if ($("input[name='isPd']").prop("checked")) {//选中
            isPd = 1;
        }

        //多个购物车的id
        var cartIds = $("#cartIds").val();

        $.ajax({
            url: '${base}/cart/getTotalPrice',
            type: 'post',
            data: {
                'cartIds': cartIds,
                'cityId': cityId,
                'couponId': couponId,
                'freight': freight,
                'isPd': isPd,
                'activityIds': '${activityIds}'
            },
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    //alert(data.result.infoDelivery);
                    $("#goods_amount").html(  toDecimal2(data.result.totalGoodsPrice));
                    $("#order_amount").html( toDecimal2(data.result.totalPrice));
                    $("#order_shipp").html( toDecimal2(data.result.totalFreight));
                    $("#order_shipp_radio").html( toDecimal2(data.result.totalFreight));
                    $("#shippingFee").val(toDecimal2(data.result.totalFreight));
                    $("#parcelSize").val(toDecimal2(data.result.totalFreight));
                    $("#coupon_price").html( toDecimal2(data.result.couponPrice));
                    $("#condition_price").html(  toDecimal2(data.result.conditionPrice));
                    $("#predeposit_amount").html(  toDecimal2(data.result.predepositAmount));
                 
                if (data.result.infoDelivery.calculateDelivery.deliveryDateMin.length > 0) {
					 $("#order_shipp_min_day").html(data.result.infoDelivery.calculateDelivery.deliveryDateMin); 
					 $("#order_shipp_max_day").html(data.result.infoDelivery.calculateDelivery.deliveryDateMax);
				}
				else {
					  $("#order_shipp_max_day").html("завтра");
					  $("#order_shipp_min_day").html("сегодня");
				}
				  
				  
                    $("#order_shipp_parcel_weight").html(data.result.infoDelivery.parcelGoods.weight);
                    $("#order_shipp_parcel_size").html(data.result.infoDelivery.parcelGoods.length + "x"
                            + data.result.infoDelivery.parcelGoods.width + "x" + data.result.infoDelivery.parcelGoods.height);
                    $("#parcel").val(data.result.infoDelivery.parcelGoods.weight + "x" + data.result.infoDelivery.parcelGoods.length + "x"
                            + data.result.infoDelivery.parcelGoods.width + "x" + data.result.infoDelivery.parcelGoods.height);

                }
            }, error: function (data) {
                layer.msg('сбой связи');
            }
        });
    }

    function addressmember() {
        var checked_address_radio = $("input[name='address_options']:checked");
        var address = $(checked_address_radio).parent().attr("address");
        var buyer = $(checked_address_radio).parent().attr("buyer");
    }
    //修改订单运费显示
    function shipUpdate(obj, storeId) {
        var freight = $(obj).find("option:selected").text().split("  ");
        var store = "#trans_total_" + storeId;
        $(obj).parent().parent().parent().find(store).html("&yen;" + toDecimal2(freight[1]));
        //重新加载订单金额信息
        getTotalPrice();
    }

    //修改发票信息
    function updateInvoice() {
        layer.open({
            type: 2,
            move: '.layui-layer-title',
            shade: false,
            title: 'Информация счета-фактуры',
            content: ['${base}/invoice/updateInvoiceIndex', 'no'],
            area: ['600px', '600px']
        });
    }

    //准换价格格式
    function toDecimal2(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return false;
        }
        var f = Math.round(x * 100) / 100;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 2) {
            s += '0';
        }
        return s;
    }

    /** 优惠券选择 **/
    function selectCoupon(obj, price, storeId) {
        if ($(obj).prop("checked")) {
            $("input[name='couponCheckBox_" + storeId + "']").prop("checked", false);
            $(obj).prop("checked", true);
        }
        var checkcoupon = $("input[type='checkbox'][class='jdcheckbox']:checked");
        var couponPrice = 0;
        var couponIds = "";
        $("#couponNum").html(checkcoupon.length);
        checkcoupon.each(function () {
            couponIds += $(this).val() + ",";
            couponPrice += $(this).attr("price") * 1;
        });
        $("#couponPrice").html(toDecimal2(couponPrice));
        $("#couponMember").val(couponIds);
        getTotalPrice();
    }

    function initDataList() {
        location.reload();
    }
    //判断cartIds是否存在
    function isexistcartIds() {
        var cartIds = $("#cartIds").val();
        $.ajax({
            type: "post",
            url: '${base}/cart/checkcartid',
            data: {cartIds: cartIds},
            dataType: "json",
            success: function (data) {
                if (data.success) {

                } else {
                    layer.confirm('Не удалось загрузить информацию о заказе пользователя', {
                        btn: ['подтвердить', 'отменить'] //按钮
                    }, function () {
                        window.location = "${base}/";
                    }, function () {
                        window.location = "${base}/";
                    });
                }
            }
        });
    }
</script>
<script type="text/javascript">
    $(function () {
        addressValidate();
    });

    jQuery.validator.addMethod("isZipCode", function (value, element) {
        var pattern = /^[0-9]{6}$/; //邮编格式
        return this.optional(element) || (pattern.test(value));
    }, "Заполните, пожалуйста, правильный код почтового индекса");

    jQuery.validator.addMethod("isMobPhone", function (value, element) {
        var pattern = /^[8][0-9]{10}$/; //手机号格式
        return this.optional(element) || (pattern.test(value));
    }, "11-значный номер телефона, должен начинаться с 8");

    var addressValidate = function () {
        $('#address_form').validate({
            errorPlacement: function (error, element) { 
                $(element).after(error.attr("class",$(element).attr("class")));
            }
        });
    };

    function quxiao() {
        parent.layer.closeAll();
    }

    function save_address(spopobd) {
		var spopobd = spopobd;
        if ($('#address_form').valid()) {
            var provinceId = $('#area_id').val(); //省的id
            var cityId = $('#city_id').val(); //城市id
            var areaId = $('#qu').val(); //区的id
            var address = $('#address').val(); //具体地址
            var zipCode = $('#zipCode').val(); //邮政编码
            var trueName = $('#trueName').val(); //收货人
            var mobPhone = $('#mobPhone').val(); //收货人手机号

            var provinceval = $('#area').find("option:selected").html(); //省的值
            var cityval = $('#city').find("option:selected").html(); //城市的值
            var quval = $('#qu').find("option:selected").html(); 	 //区的值
            var areaInfo = $('#cityX').val(); 
			
            if (provinceId == '' || provinceId == '0') {
				layer.msg('Укажите город!');
                return false;
            } 
			if (trueName == '') {
				layer.msg('Укажите Имя и Фимилию!');
                return false;
            } 
			if (mobPhone == '') {
				layer.msg('Укажите телефон!');
                return false;
            } 
			if (address == '') {
				layer.msg('Укажите адрес');
                return false;
            } 
			
            var formjson = '{';
            formjson += '\"trueName\":\"' + trueName + '\",';//分类id
            formjson += '\"provinceId\":\"' + provinceId + '\",';//分类id
            formjson += '\"cityId\":\"' + cityId + '\",';//城市id
            formjson += '\"areaId\":\"' + areaId + '\",';//地区ID
            formjson += '\"mobPhone\":\"' + mobPhone + '\",';//手机号
            formjson += '\"areaInfo\":\"' + areaInfo + '\",';//地区全称
            formjson += '\"address\":\"' + address + '\",';//详细地址
            formjson += '\"zipCode\":\"' + zipCode + '\"';//邮编
            formjson += '}';
            $.ajax({
                url: '${base}/myaddress/saveAddress',
                type: 'post',
                data: {'data': formjson},
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
						location.href = location.href.replace("delivery","0").replace("#","")+"&delivery="+spopobd;
                    } else {
                        layer.msg('Не удалось добавить адрес', {icon: 2});
                    }
                }, error: function (data) {
                    layer.msg('Сбой связи', {icon: 2});
                }
            });
        }
    }

    function update_address(spopobd) { 
		var spopobd = spopobd;
        if ($('#update_address_form').valid()) {
            var addressId = $('#addressId').val(); //收货地址id
            var provinceId = $('#area_id').val(); //省的id
            var cityId = $('#city_id').val(); //城市id
            var areaId = $('#qu').val(); //区的id
            var address = $('#address').val(); //具体地址
            var zipCode = $('#zipCode').val(); //邮政编码
            var trueName = $('#trueName').val(); //收货人
            var mobPhone = $('#mobPhone').val(); //收货人手机号
            var areaInfo = $('#cityX').val();

           if (provinceId == '' || provinceId == '0') {
				layer.msg('Укажите город!');
                return false;
            } 
			if (trueName == '') {
				layer.msg('Укажите Имя и Фимилию!');
                return false;
            } 
			if (mobPhone == '') {
				layer.msg('Укажите телефон!');
                return false;
            } 
			if (address == '') {
				layer.msg('Укажите адрес');
                return false;
            } 
			
            var formjson = '{';
            formjson += '\"addressId\":\"' + addressId + '\",';//收货地址id
            formjson += '\"trueName\":\"' + trueName + '\",';//分类id
            formjson += '\"provinceId\":\"' + provinceId + '\",';//省id
            formjson += '\"cityId\":\"' + cityId + '\",';//城市id
            formjson += '\"mobPhone\":\"' + mobPhone + '\",';//手机号
            formjson += '\"areaInfo\":\"' + areaInfo + '\",';//地区全称
            formjson += '\"address\":\"' + address + '\",';//详细地址
            formjson += '\"zipCode\":\"' + zipCode + '\"';//邮编
            formjson += '}';
            $.ajax({
                url: '${base}/myaddress/updateAds',
                type: 'post',
                data: {'data': formjson},
                dataType: 'json',
                success: function (data) {
                    if (data.success == 'true') { 
						location.href = location.href.replace("delivery","0").replace("#","")+"&delivery="+spopobd;
                    } else {
                        layer.msg('Проблемы модификации данных', {icon: 2});
                    }
                }, error: function (data) {
                    layer.msg('Сбой связи', {icon: 2});
                }
            });
        }
    }
    function delete_address() {
        var id = $('#addressId').val();
        var addressId = "address_" + id;
        layer.confirm('Действительно удалить ?', function () {
            $.ajax({
                type: "post",
                url: "${base}/myaddress/deleteAddress?id=" + id,
                data: null,
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.success == "true") {
                        layer.msg('Успешно удалено', {icon: 1}, initDataList());
                    } else {
                        layer.msg('Не удалось удалить');
                    }
                }
            });
        });
    }

    window.onload = function () {
        splitaddress($('#address').val());
    };

</script>
</body> 