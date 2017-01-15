 <link rel="shortcut icon" href="${base}/res_v4.0/images/favicon.ico"/>
    <link href="${base}/res_v4.0/css/common.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/res_v4.0/css/commonality.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/res_v4.0/css/head.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/res_v4.0/css/fonts/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/res_v4.0/css/style.css" rel="stylesheet" type="text/css"/>
    <!-- 楼层底部轮播 -->
    <link href="${base}/res_v4.0/css/lrtk0.css" rel="stylesheet" type="text/css"/> 
    <script src="${base}/res_v4.0/js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
    <SCRIPT src="${base}/res_v4.0/js/lrscroll0.js" type=text/javascript charset=utf-8></SCRIPT>
    <script src="${base}/res_v4.0/js/common.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/common_js.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/header.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/footer.js" type="text/javascript"></script>
    <script src="${base}/res_v4.0/js/goods-detail.js"></script>

	   <script type="text/javascript" src="${base}/res_v4.0/js/layer/layer.js"></script>
        <link rel="stylesheet" href="${base}/res_v4.0/css/public.css"/>
        <link rel="stylesheet" href="${base}/res_v4.0/css/circle.css"/>
        <link rel="stylesheet" href="${base}/res_v4.0/css/circle_head.css"/>
        <link href="${base}/res_v4.0/css/fonts/iconfont.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="${base}/res_v4.0/ticket.css"/>

 <Script>
  var BASE_SERVICE = '${base}';
        var isLogin = false;
        var IMGSERVER = '${imgServer}'; 
 </Script>


<link href="${base}/res_v4.0/css/cart.css" rel="stylesheet" type="text/css"/>
<script src="${base}/res_v4.0/js/cart/cart.js"></script>


<!DOCTYPE html>
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="${base}/res_v4.0/kusto/css/basket.css">
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />


  <title>Корзина</title>
   <style>
	   @font-face {
		font-family: MuseoSansBlack;
		src: url(${base}/res_v4.0/kusto/fonts/MuseoSansBlack.ttf);
	   }
		@font-face {
		font-family: MuseoSansLight;
		src: url(${base}/res_v4.0/kusto/fonts/MuseoSansLight.ttf);
	   }
       .goods_info {
           position: relative;
           display: none;
           float: left;
           left: 20px;
       }
       .control_button {
           position: relative;
           display: block;
           top: 10px;
           left: 100px;
           float: left;
       }
       .line_spec {
           position:relative ;
           margin: 2px 10px 0px 10px;
           border-top: 2px dashed #bfbaba;
           height: 2px;
           display: block;
       }
       .goods_in_cart {
           margin: -42px 0px 0px 160px;
           position:relative ;
           width: 393px;
           height: 44px;
           border: 3px solid #f4f4f4;
           background-color: #bfbaba;
       }
   </style>
<script>
function show_pass()
{
if ($('#password').get(0).type=='password') $('#password').get(0).type='text'; else $('#password').get(0).type='password';
} 
</script>
 </head>

<body <#if RequestParameters.go??>style="display:none"</#if>  >
	<div class="main_div">
		<div class="basket_title" name="basket_title">
			КОРЗИНА
		</div>
		<div class="line"></div>

        <input type="hidden" id="goodsId" value=""/>
        <input type="hidden" id="goodsSpecId" value=""/>
        <input type="hidden" id="quantity" value=""/>
        <input type="hidden" id="cartId" value=""/>

    <#assign nogoods = 1>
		
		
 <#assign cartTag = newTag("cartTag") />
            <#assign cartMap = cartTag() />
            <#if cartMap.get("cartVoList")??>
                <#list cartMap.get("cartVoList") as cartVo> 
                <div style="display:none" class="fl df fb f12 ml20 storediv">
                    <a>
                        <input type="checkbox" name="store_select" value="checkbox" class="fl" checked="true" storeId="${cartVo.storeId}"> 
                    </a>
                    <div class="huangou">

                        <div class="mydiv1" name="mydiv1">
                            <div class="cuxiao_price_yincang" style="background:＃fff;">
                               
                               <div class="cuxiao_xialaneirong">
	                                    <ul>
                                            <li><input type="radio" name="promotion_${cartVo.storeId}" title="不使用优惠" activity_limit="" activity_name="" activity_type="" rule_source="" value="">不使用优惠</li>
	                                    </ul>
	                                    <div class="cuxiao_anniu" style="text-align:center;">
	                                        <a href="javascript:void(0)" class="btn_1">确定</a>&nbsp;&nbsp;
	                                        <a href="javascript:void(0)" class="btn_2">取消</a>
	                                    </div>
	                                </div>
                            </div>
                        </div>
                        <div class="cuxiao_price" >促销优惠<em><img src="${base}/res_v4.0/images/jian_b.png"/></em></div>
                    </div>
                </div>

             	
                    <#if cartVo.list??>
					<div class="all_goods">
                        <#list cartVo.list as cart>
						<#assign nogoods = 0>	
                            <ul style="display:none"  class="ulList bor_line bor_lr clearfix" >
                                <li class="my_info">
                                    <dl>
                                        <div class="fl df fb mt40">
                                            <a><input type="checkbox" name="secondpro" goodsnowstorage="${cart.goodsNowStorage}" value="${cart.cartId}" class="fl" checked="true" storeId="${cartVo.storeId}"></a>
                                        </div>
                                        <dt>
                                            <a href="${base}/product/${cart.specId}.html" target="_blank">
                                                <img style="width:50px" src="${imgServer}${cart.goodsImages}" alt=""/>
                                            </a>
                                        </dt>
                                        <dd class="d1 font_color pt20 goodsname">
                                            <a href="${base}/product/${cart.specId}.html" target="_blank">
                                                ${cart.goodsName}
                                            </a>
                                        </dd>
                                        <dd class="d1 font_color spec">${cart.specInfo}</dd>
                                    </dl>
                                </li>
                                <li class="my_price tc mt20">
                                    <input type="hidden" value="${cart.goodsPrice}" id="cart_goods_price_${cart.cartId}" name="cart_goods_price">


                                    <b class="price font_color">
                                        <#if cart.promotionType==50>
                                           <font color="red"> 团购价</font>
                                            <input type="hidden" value="${cart.maxBuyNum}" id="maxBuyNum_${cart.cartId}" >
                                        <#elseif cart.promotionType==60>
                                                <font color="red"> 抢购价</font>
                                            <input type="hidden" value="${cart.maxBuyNum}" id="maxBuyNum_${cart.cartId}">
                                        <#else >
                                            <input type="hidden" value="100" id="maxBuyNum_${cart.cartId}" name="cart_goods_price">
                                        </#if>
                                        <script type="text/javascript">
                                            var price = number_format(${cart.goodsPrice},2);
                                            document.write("&yen;" + price);
                                        </script>
                                    </b>
                                </li>
                                <li class="my_amount tc mt20">
                                    <span>
                                      <input class="min" name="" id="minus${cart.cartId}" type="button" cartid="${cart.cartId}" value="-"/>
                                      <input class="text_box" name="goodsNum" id="cart_goods_num_${cart.cartId}" type="text" value="${cart.goodsNum}" maxlength="2"
                                        cartGoodsPrice = "${cart.goodsPrice}" cartStoreId="${cartVo.storeId}" cartId="${cart.cartId}" cartSpecid="${cart.specId}" cartGoodsNowStorage="${cart.goodsNowStorage}"/>
                                      <input class="add" name="" id="plus${cart.cartId}" type="button" cartid="${cart.cartId}" value="+" style="border-right:#e5e5e5 1px solid; border-left: 0px;"/>
                                    </span>
                                    <div style="clear: both; padding-top: 5px;">
                                        <#if cart.goodsNowStorage gt 0>
                                            <p style="color: #aaa;">В наличии</p>
                                        <#else>
                                            <p style="color: rgb(228, 57, 60);">Нет на складе</p>
                                        </#if>
                                    </div>
                                </li>
                                <li class="my_subtotal tc mt20" id="total_price_${cart.cartId}">
                                    <b class="total f20">
                                        <script type="text/javascript">
                                            var goodsprice = number_format(${cart.goodsNum*cart.goodsPrice},2);
                                            document.write("&yen;" + goodsprice);
                                        </script>
                                    </b>
                                </li>
                                <li class="my_handle tc mt25">
                                    <a href="javascript:void(0);" title="删除" id="delete${cart.cartId}" cartid="${cart.cartId}">
                                        <img src="${base}/res_v4.0/images/ddlb_12.png" style="width:16px;height:16px;"/>
                                    </a>
                                </li>
                            </ul>

                            <div class="row1_div" id="row1_div${cart.cartId}">
			<div class="discription_div">
				${cart.goodsName}
			</div>
			<div class="artikul_div">
				${cart.goodsSerial}
			</div>
			<div class="fon_img">
			
				<a href="#"><img src=${imgServer}${cart.goodsImages} height="108px" width="84px"></a>
			</div>
			
			<div class="goods_in_cart">
				<div class="text_button_info">
				${cart.specInfo}
				<a onclick="showGoodsInfo('${cart.goodsId}','${cart.specId}','${cart.goodsNum}','${cart.cartId}');" href="#" id="edit_button${cart.cartId}" class="edit_button"><img src="${base}/res_v4.0/kusto/images_basket/pensil.png" height="16px" width="16px">Редактировать</a>
				</div>
			</div>
			<div class="img_vertical">
				<img src="${base}/res_v4.0/kusto/images_basket/vertical3.png">
			</div>
			<div class="count_div_text">
			КОЛИЧЕСТВО:
			</div>
			<div class="minus_div"  >
				<a href="#" onclick="$('#minus${cart.cartId}').trigger('click'); return false;"><img src="${base}/res_v4.0/kusto/images_basket/minus.png" height="44px" width="44px">
				
				</a>
			</div>
			<div id="Ecart_goods_num_${cart.cartId}"  class="count_product">
			${cart.goodsNum}
			</div>
			<div class="plus_div">
				<a href="#" onclick="$('#plus${cart.cartId}').trigger('click'); return false;"><img src="${base}/res_v4.0/kusto/images_basket/plus.png" height="44px" width="44px"></a>
			</div>
			<div class="price_div_text">
			ЦЕНА:
			</div>
			<div class="price">
				${cart.goodsPrice} РУБ.
			</div>
			<a href="#"><img class="exit1" onclick="$('#delete${cart.cartId}').trigger('click'); return false;" src="${base}/res_v4.0/kusto/images_basket/exit.png"></a>

                            <div id="goods_info${cart.cartId}" class="goods_info"></div>
                            <div id="control_button${cart.cartId}" class="control_button">

                                <span id="goods__in_stock2${cart.cartId}" class="goods__in_stock2" style="display:none; float:left;">Сейчас в наличии: &nbsp;</span>
                                <div id="in_stock${cart.cartId}" class="in_stock"></div>
                                <br></br>
                                <a onclick="saveGoodsSpec();" href="#" id="save_button${cart.cartId}" class="save_button" style="display:none"><img src="${base}/res_v4.0/images/save-goods.png" height="16px" width="16px">&nbsp;Сохранить</a>
                                <br></br>
                                <a onclick="cancelGoodsSpec();" href="#" id="cancel_button${cart.cartId}" class="cancel_button" style="display:none"><img src="${base}/res_v4.0/images/undo-goods.png" height="16px" width="16px">&nbsp;Отмена</a>
                            </div>


                        </div>
                        </#list>
						</div>
						<div class="row3_div" style="display:none">
			<a href="#"><img class="promocode" src="${base}/res_v4.0/kusto/images_basket/promocode.png" height="16px" width="16px">
			<div class="promocode_text">У ВАС ЕСТЬ ПРОМОКОД?</div>
			</a>
		</div>
                    
                    </#if>
                </#list> 
            </#if>
        <div id="line_spec" class="line_spec"></div>

    <#if nogoods == 1><center>Товаров нет!</center><br><Br></#if>
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
				Промеж. сумма&nbsp&nbsp<span id="totalprrr1"></span><br>
				Предпологаемая&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 0,0 РУБ.<br>
				стоимость доставки<br>
				<div class="line2"></div>
				<br>
				ИТОГО:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id="totalprrr2"></span>
			</div>
		</div>
		<div class="row5_div">
			<div class="left_button">
				<a onclick="parent.location.href='/'" href="#"><img class="left_button" src="${base}/res_v4.0/kusto/images_basket/left_button.png"><div class="inner_black">ПРОДОЛЖИТЬ ПОКУПКИ</div></a>
			</div>
			<div class="right_button">
				
			</div>
			<a href="#"><img class="right_button"  src="${base}/res_v4.0/kusto/images_basket/checkout_black.png"><div onclick="subMit()"  class="inner_white">ОФОРМИТЬ ЗАКАЗ</div></a>
			<!-- <div class="right_button">
				<a href="#"><img class="right_button" src="images_basket/checkout_green.png"><div class="inner_white">ОФОРМИТЬ ЗАКАЗ</div></a>
			</div> -->
		</div>
	</div>
		
</body>
</html>

<Script>
    function showGoodsInfo(goodsId, scecId, goodsNum, cartId) {
        $( '#row1_div'+cartId ).css({"height":"270px","border":"3px solid red"});
        $("#goodsId").val(goodsId);
        $("#goodsSpecId").val(scecId);
        $("#quantity").val(goodsNum);
        $("#cartId").val(cartId);
        var urlLoad = '/product/goodsinfo?goodsId=' + goodsId + '&specId=' + scecId + '&p=' + Math.random();
        $('#goods_info'+cartId).load(urlLoad);

        $('#save_button'+cartId).show();
        $('#cancel_button'+cartId).show();
        $('#edit_button'+cartId).hide();
        $('#goods_info'+cartId).show();
        getSku();
    }

    function saveGoodsSpec() {
        var cartId = $("#cartId").val();
        var specId = $("#goodsSpecId").val();
        var goodsId = $("#goodsId").val();
        var goodsNum = parseInt($("#quantity").val());

        if (specId != '') {
                $.ajax({
                    url: "${base}/cart/updateCartSpec",
                    type: 'post',
                    data: {'cartId': cartId, 'count': goodsNum, 'goodsId': goodsId, 'specId': specId},
                    dataType: 'json',
                    success: function (data) {
                        if (data.success) {
                            location.reload();
                            layer.alert(data.msg, {icon: 1, time: 2000, closeBtn: 0});
                        }
                    },error:function(data){
                        layer.msg('Сбой связи', {icon: 2});
                    }
                });
        } else {
            layer.alert("Пожалуйста, выберите характеристики товара", {icon: 2, time: 2000, closeBtn: 0});
        }
        cancelGoodsSpec();
    }

    function cancelGoodsSpec() {
        var cartId = $("#cartId").val();

        $('#row1_div'+cartId ).css({"height":"145px","border":"3px solid #f4f4f4"});
        $('#save_button'+cartId).hide();
        $('#cancel_button'+cartId).hide();
        $('#edit_button'+cartId).show();
        $('#goods_info'+cartId).hide();
    }

    $(function () {

        getSku(function () {
            var tatolStorage = 0;
            if (specQty == 1) {
                tatolStorage = specs[0].stock;
            } else {
                for (var i = 0; i < specQty; i++) {
                    tatolStorage += parseInt(specs[i].stock);
                }
            }
            $("[nctype=goods_stock]").val(tatolStorage);
        });

    });
    <#if RequestParameters.go??>
	subMit();
    </#if>

    /* spec对象 */
    function spec(id, spec, price, market_price, stock) {
        this.id = id;
        this.spec = spec;
        this.price = price;
        this.stock = stock;
        this.market_price = market_price;
    }
    /* goodsspec对象 */
    function goodsspec(specs, specQty, defSpec) {
        this.specs = specs;
        this.specQty = specQty;
        this.defSpec = defSpec;
        this.spec1 = null;
        this.spec2 = null;
        this.spec3 = null;
        this.spec4 = null;
        this.spec5 = null;
        if (this.specQty >= 1) {
            for (var i = 0; i < this.specs.length; i++) {
                if (this.specs[i].id == this.defSpec) {
                    this.spec1 = this.specs[i].id;
                    this.spec2 = this.specs[i].spec;
                    this.spec3 = this.specs[i].price;
                    this.spec4 = this.specs[i].stock;
                    this.spec5 = this.specs[i].market_price;
                    break;
                }
            }
        }


        // 取得选中的spec
        this.getSpec = function () {
            for (var i = 0; i < this.specs.length; i++) {
                if (this.specs[i].spec != this.spec2) continue;
                $("#in_stock").html($("[nctype=goods_stock]").val());
                return this.specs[i];
            }
            return null;
        }

    }

    var specs = new Array();
    var ncspec = $("#goods_info").find(".buy_list3").html();
    var specQty;
    var defSpec = $("#goodsSpecId").val();
    var goodsspecc;

    function getSku(callbackfunction) {
        var url = "${base}/product/goodsSpecs";
        var args = {"goodsId": $("#goodsId").val()};
        $.post(url, args, function (data) {
            console.log(data);
            //goodsSpecs是个list
            var goodsSpecs = data.goodsSpecs;
            for (var i = 0; i < goodsSpecs.length; i++) {
                var goodsSpec = goodsSpecs[i];
                if (goodsSpec.specValueIdStr == null) {
                    specs.push(new spec(goodsSpec.goodsSpecId,
                            "",
                            goodsSpec.specGoodsPrice,
                            goodsSpec.specMarketPrice,
                            goodsSpec.specGoodsStorage
                            )
                    );
                } else {
                    specs.push(new spec(goodsSpec.goodsSpecId,
                            goodsSpec.specValueIdStr.split(","),
                            goodsSpec.specGoodsPrice,
                            goodsSpec.specMarketPrice,
                            goodsSpec.specGoodsStorage));
                }

            }
            specQty = goodsSpecs.length;
            goodsspecc = new goodsspec(specs, specQty, defSpec);
            if (callbackfunction != undefined) {
                callbackfunction();
            }
        });
    }

</Script>   

           
 
            <div class="my_cart_hand" style="border:#e5e5e5 1px solid; width:1200px;height:60px; display:none;">
                <div style="display:none" class="fl df fb f14  ml20" style="margin-top:21px;">
                    <a>
                        <input type="checkbox" name="selectAllGoods" value="checkbox" style="float:left;margin-top: 2px;" checked="true">
                        <em class="fl pl10">全选</em>
                    </a> 
                </div>
                <div class="fr dto f14 cart_goods_total_price" style="margin-top:21px; display:none;">
                    <a href="javascript:void(0);" title="" onclick="subMit()" class="checkOut no_unl f14 fb fr"
                       style="text-align: center;line-height: 57px;margin-top: -21px;">оформить заказ</a>
                    商品总价（不含运费）：
                    <b class="f20">¥0.00</b>
                </div>
            </div>
       