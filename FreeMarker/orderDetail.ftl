<@layout.head>
<link href="${base}/res/vpomo/css/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>

<script src="${base}/res/vpomo/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${base}/res/js/jquery-ui/jquery.ui.js"></script>
<script src="${base}/res/vpomo/js/jquery-ui-1.8.21.custom.min.js" type="text/javascript"></script>

<script type="text/javascript" src="${base}/res/js/jquery-ui/i18n/zh-CN.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/jquery.validation.min.js"></script>
<script type="text/javascript" src="${base}/res/js/layer/layer.js"></script>
<script src="${base}/res/js/area.js" charset="utf-8"></script>
<style>
    .transinput {
        background-color: transparent;
        border: none;
        outline: none;
    } 
    .select {
        width: 100px;
        height: 26px;
    }
	.layui-layer-iframe{
		position:absolute;
	}
</style>
</@layout.head>
<@layout.body>
<div class="page">
    <input type="hidden" name="order_Id" id="order_Id" value="0">

    <table class="table tb-type2 order">
        <tbody>
        <tr class="space">
            <th colspan="15">Основная информация о заказе</th>
        </tr>
            <#if order.orderState==20>
            <p><a href="${base}/orders/shipments_deliver?orderSn=${order.orderSn}" class="btn" nctype="del_batch">Подтверждение доставки</a></p>
            </#if>
        <tr>
            <td colspan="2">
                <ul>
                    <li>
                        <strong>Номер заказа: </strong>${order.orderSn}
                        ( <@spring.message "tsn.payment"/>: ${order.paySn} )
                    </li>
                    <li><strong>Статус заказа:</strong>
                  
                <#if order.orderState==10>Ожидание оплаты</#if>
              
				 <#if order.orderState!=10 &&order.orderState!=40 > <#if order.shippingCode != '' && order.shippingCode != '0'>
					Отправлен
				<#else> 
																			<#if order.payMessage != '' &&  order.payMessage  != '0'>
																				<font style="font-weight:600;">Ожидание отправки</font> 
																				<#else>
																				<font style="font-weight:600;"> Заказ содан</font>
																				</#if>
																			</#if> 
				 
				</#if>
               <!-- <#if order.orderState==20>ДОСТАВКА / DELIVERY</#if>
                <#if order.orderState==30>ДОСТАВЛЕН / received</#if>-->
                <#if order.orderState==40>Завершено / finished</#if>
				
					<#if order.payMessage != '' && order.payMessage  != '0'>
					<br>Заказ подтвержден!<br>
					Комментарий менеджера: 
					<Script>
						document.write(decodeURIComponent(escape("${order.payMessage}")));
					</Script> 
					<#else><br>
					<textarea placeholder="Комментарий менедженра" style="width:300px; height:80px" id="managertext"></textarea><br>
					<a href="" onclick="location.href='${base}/orderok/ok.jsp?i=${order.orderId}&p=${order.orderSn}&m='+encodeURIComponent($('#managertext').val())+'&base=${base}'; return false;" >Подтвердить заказ!</a>
					</#if>
                    </li>
                    <li>
                        <strong>Общая стоимость:</strong>
                        <span class="red_common">&#8381;
                    		<script type="text/javascript">
	    						var amount = number_format(${order.orderAmount}, 2);
                                document.write(amount);
	    					</script>
                    	</span>
                        <#if (order.refundAmount > 0)>
                            (Стоимость товара:&#8381;
                            <script type="text/javascript">
                                var amount = number_format(${order.refundAmount}, 2);
                                document.write(amount);
                            </script>
                            )
                        </#if>
                    </li>
                   <#-- <li><strong>Предоплата:</strong>&#8381;
                        <script type="text/javascript">
                            var predepositAmount = number_format(${order.predepositAmount}, 2);
                            document.write(predepositAmount);
                        </script>
                    </li>-->
                    <li><strong>Стоимость товара:</strong>&#8381;
                        <script type="text/javascript">
                            var goodsamount = number_format(${order.goodsAmount}, 2);
                            document.write(goodsamount);
                        </script>
                    </li>
                    <#if order.couponId??>
                        <li><strong>Содержимое введенного купона:</strong>
                            ${order.couponId}
                        </li>
                        <li><strong>Стоимость купона:</strong>
                            ${order.couponPrice}
                        </li>
                    </#if>
                    <li><strong>Способ доставки:</strong>
                    <#if order.shippingName == "CDEK"> Тренспортная компания <#else> ${order.shippingName} </#if>
                    </li>
                    <li><strong>Стоимость доставки:</strong>
                        <#if order.shippingFee??>
                            <#if order.shippingFee!=0>
                                &#8381;
                                <script type="text/javascript">
                                    var ship = number_format(${order.shippingFee}, 2);
                                    document.write(ship);
                                </script>
                            <#else>
                                <@spring.message "not_freight"/>
                            </#if>
                        <#else>
                            <@spring.message "not_freight"/>
                        </#if>
                    </li>

                    <li><strong>Вес и размер посылки:</strong>
                        <script type="text/javascript">
                            var parcel = "${order.tradeSn}";
                            $("#numberUFUN").val(${order.orderSn});
                            $("#order_Id").val('${order.orderId}');
                            tempArray = parcel.split('x');
                            weight_parcel = tempArray[0];
                            length_parcel = tempArray[1];
                            width_parcel = tempArray[2];
                            height_parcel = tempArray[3];
                            var parcelDetail = "Вес(кг): " + weight_parcel + " , Габариты(см) : " + length_parcel
                                    + "x" + width_parcel + "x" + height_parcel;
                            document.write(parcelDetail);
                        </script>
                    </li>
                  <#if order.shippingCode!=null&&order.shippingCode!="">
                    <li>
                        <strong>物流单号:</strong>
                        ${order.shippingCode}
                    </li>
                  </#if>
                </ul>
            </td>
        </tr>

        <tr class="space">
            <th colspan="2">Детальная информация</th>
        </tr>
        <tr>
            <th>информация о заказе</th>
        </tr>
        <tr>
            <td>
                <ul>
                    <li><strong>Покупатель：</strong>${order.buyerName}</li>
                    <#--<li><strong><@spring.message "store"/>：</strong>${order.storeName}</li>-->
                    <li><strong>Метод оплаты：</strong>${order.paymentName}</li>
                    <li><strong>Дата и время заказа:</strong>${order.createTimeStr?string("yyyy-MM-dd HH:mm:ss")}</li>
                    <#if order.paymentTimeStr??>
                        <li><strong><@spring.message "tsn.payment_time"/>
                            ：</strong>${order.paymentTimeStr?string("yyyy-MM-dd HH:mm:ss")}</li>
                    </#if>
                    <#if order.finnshedTimeStr??>
                        <li><strong><@spring.message "tsn.completion_time"/>
                            ：</strong>${order.finnshedTimeStr?string("yyyy-MM-dd HH:mm:ss")}</li>
                    </#if>
                    <#if order.orderMessage != null && order.orderMessage != ''>
                        <li><strong><@spring.message "tsn.buyers_note"/>：</strong>${order.orderMessage}</li>
                    </#if>
                <#--
					<#if order.shippingName == "FREE">
							<#if order.orderState!=40> 
								<li><strong>Подтверждение получения клиентом:</strong>
									<a href="${base}/orderok/state40.jsp?i=${order.orderId}&p=${order.orderSn}">Подтвердить получение клиентом</a>
								</li>
							</#if>
					
							<li>
								<strong>Статус доставки：</strong>
								<#if order.shippingCode != '' && order.shippingCode != '0'>
									Клиент может забирать товар
								<#else >
									После того как заказ сформирован, нажмите <a href="${base}/orderok/?i=${order.orderId}&p=${order.orderSn}">Подтвердить подготовку заказа</a><br>
									После этого клиент сможет приехать и забрать заказ<br>
								</#if>
							</li>
					<#else> 
					-->
					
						<#if order.shippingCode != '' && order.shippingCode != '0'>
							<#if order.orderState!=40> 
								<li><strong>Подтверждение получения клиентом:</strong>
									<a href="${base}/orderok/state40.jsp?i=${order.orderId}&p=${order.orderSn}">Подтвердить получение клиентом</a>
								</li>
							</#if>
							<li> 
								<strong>Номера отправления в ТК <#if order.shippingCode?index_of("TK") < 0 >СДЭК</#if>：</strong>
								<Script>
									document.write(decodeURIComponent(escape("${order.shippingCode}")));
								</Script> 
							</li>  
							<#if order.shippingCode?index_of("TK") < 0 ><li><strong></>Удалить заказ СДЭК：</strong>
								<button id="delete_order_cdek" class="">Удалить заказ СДЭК</button>
							</li>
							<li><strong></>Показать статус заказа：</strong>
								<button id="status_order_cdek">Статус заказа СДЭК</button>
							</li>
							<li><strong></>Печать квитанции к заказу：</strong>
								<button id="print_order_cdek">Просмотр квитанции</button>
							</li>
							</#if>
                            <#if order.bundlingExplain?? >
                                <li><strong></>Адрес и телефон пункта выдачи заказа (ПВЗ)：</strong>
                                ${order.bundlingExplain}
                                </li>
                            </#if>

                        <#else >
							<li><strong></> Выставить заказ СДЭК：</strong>
							<#if order.orderState!=10>    
							
							<button id="make_order_cdek" class="">Создать заказ для CDEK</button>
							<button onclick="p = prompt('Введите трэк номер', ''); if (p) location.href='${base}/orderok/TK.jsp?i=${order.orderId}&p=${order.orderSn}&sn='+p"  >Создать заказ для другой ТК</button>
							
							
							</#if>
							</li>
						</#if>
<#--
					</#if>
-->
                </ul>
            </td>
        </tr>
        <tr>
            <th>Адрес доставки</th>
        </tr>
        <tr>
            <td>
                <ul>
                    <#if order.address??>
                        <form action="#" id="addressForm">
                            <input name="addressId" value="${order.address.addressId}" type="hidden"/>
                            <li>
                                <em style="color:red;display:none;">*</em>
                                <strong>Получатель заказа：</strong>
                                <span id="trueNameSp">${order.address.trueName}</span>
                                <input name="trueName" value="${order.address.trueName}" style="display: none;"/>
                            </li>
                            <li>
                                <em style="color:red;display:none;">*</em>
                                <strong>Номер мобильного телефона：</strong>
                                <span id="mobPhoneSp">${order.address.mobPhone}</span>
                                <input name="mobPhone" value="${order.address.mobPhone}" style="display: none;"/>
                            </li>
                            <li>
                                <em style="color:red;display:none;">*</em>
                                <strong>Почтовый индекс：</strong>
                                <span id="zipCodeSp">${order.address.zipCode}</span>
                                <input name="zipCode" value="${order.address.zipCode}" style="display: none;"/>
                            </li>
                            <li>
                                <em style="color:red;display:none;">*</em>
                                <strong>Область, регион：</strong>
                                <div id="region" style="display: none;">
                                    <input id="city_id" type="hidden" name="cityId" value="">
                                    <input id="area_id" class="area_ids" type="hidden" name="areaId" value="">
                                    <input id="area_info" class="area_names" type="hidden" name="areaInfo" value="">
                                    <span id="spanarea">

								</span>
                                    <span id="spancity"></span>
                                    <span id="spanqu"></span>
                                    <span class="areaMsg" style="color: red"></span>
                                </div>
                                <span id="areaInfoSp">${order.address.areaInfo}&nbsp;</span>
                            </li>
                            <li>
                                <em style="color:red;display:none;">*</em>
                                <strong>Улица, Дом, Квартира：</strong>
                                <span id="addressSp">${order.address.address}</span>
                                <input name="address" value="${order.address.address}"
                                       style="width: 200px;display: none;"/>
                            </li>
                        </form>
                    </#if>
                </ul>
            </td>
        </tr>
         
        <tr>
            <th>Содержимое заказа</th>
        </tr>
        <tr>
            <td>
                <table class="table tb-type2 goods ">
                    <tbody>
                    <tr>
                        <th></th>
                        <th>Список товаров</th>
                        <th class="align-center">Цена за ед.</th>
                        <th class="align-center">Кол-во</th>
                        <th class="align-center">Стоимость</th>
                    </tr>
                        <#list order.orderGoodsList as goods>
                        <tr>
                            <td class="w60 picture">
                                <div class="size-56x56"><span class="thumb size-56x56"><i></i><a href="javascript:;"
                                                                                                 target="_blank"><img
                                        src="${imgServer}${goods.goodsImage}"
                                        onload="DrawImage(this,60,60);"/> </a></span></div>
                            </td>
                            <td class="w50pre"><p><a href="${frontServer}/product/${goods.specId}.html"
                                                     target="_blank">${goods.goodsName}</a></p>
                                <p>
                               Аттрибуты： ${goods.specInfo}
                                </p>
                            <#if goods.goodsSerial!="">
                                <p>
                               Артикул： ${goods.goodsSerial}
                                </p>
                            </#if>
                            <#if goods.specGoodsSerial!="">
                                <p>
                               Артикул атрибута： ${goods.specGoodsSerial}
                                </p>
                            </#if>
                            </td>
                            <td class="w96 align-center">
                        	<span class="red_common">&#8381;
                        		<script type="text/javascript">
		    						var price = number_format(${goods.goodsPrice}, 2);
                                    document.write(price);
		    					</script>
                        	</span>
                            </td>
                            <td class="w96 align-center">${goods.goodsNum}</td>
                            <td class="w96 align-center">
                        	<span class="red_common">&#8381;
                        		<script type="text/javascript">
		    						var payprice = number_format(${goods.goodsPrice*goods.goodsNum}, 2);
                                    document.write(payprice);
		    					</script>
                        	</span>
                            </td>

                        </tr>
                        </#list>
                    </tbody>
                </table>
            </td>
        </tr>
            <#if vo.refundList?? && vo.refundList?size != 0>
            <tr>
                <th>История операций с заказом</th>
            </tr>
                <#list vo.refundList as refund>
                <tr>
                    <td><@spring.message "occurrence_time"/>
                        ：${refund.addTimeStr?string("yyyy-MM-dd HH:mm:ss")}&emsp;&emsp;<@spring.message ""/>Статус：${refund.refundSn}&emsp;&emsp;<@spring.message ""/>Сумма: ${refund.refundAmount}&emsp;<@spring.message ""/>Товар：${refund.goodsName}</td>
                </tr>
                </#list>
            </#if>
            <#if vo.returnList?? && vo.returnList?size != 0>
            <tr>
                <th><@spring.message "tsn.return_record"/></th>
            </tr>
                <#list vo.returnList as return>
                <tr>
                    <td><@spring.message "occurrence_time"/>
                        ：${return.addTimeStr?string("yyyy-MM-dd HH:mm:ss")}&emsp;&emsp;<@spring.message ""/>Возврат
                        No.：${return.refundSn}&emsp;&emsp;<@spring.message ""/>Сумма
                        возмещения：￥${return.refundAmount}&emsp;<@spring.message ""/>замечание：${return.goodsName}</td>
                </tr>
                </#list>
            </#if>
            <#if order.orderLogList?? && order.orderLogList?size != 0>
            <tr>
                <th><@spring.message "operation_history"/></th>
            </tr>
                <#list order.orderLogList as log>
                <tr>
                    <td>
                        ${log.operator}&emsp;于&emsp;${log.createTimeStr?string("yyyy-MM-dd HH:mm:ss")}&emsp;${log.stateInfo}
                    </td>
                </tr>
                </#list>
            </#if>
        </tbody>
        <tfoot>
        <tr class="tfoot">
            <td><a href="JavaScript:void(0);" class="btn"
                   onclick="history.go(-1)"><span><@spring.message "button.back"/></span></a></td>
        </tr>
        </tfoot>
    </table>

</div>
<script>
    $(function () {
        $(document).on("click", "#make_order_cdek", function () {
            var orderId = $("input[name='order_Id']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Редактирование данных нового заказа на доставку СДЭК',
                content: ['${base}/cdek/editorder?orderid=' + orderId, 'no'],
                area: ['800px', '640px']
            });
        });

        $(document).on("click", "#delete_order_cdek", function () {
            var orderId = $("input[name='order_Id']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Работа с заказом в СДЭК',
                content: ['${base}/cdek/deleteorder?orderid=' + orderId, 'no'],
                area: ['300px', '290px']
            });
        });

        $(document).on("click", "#status_order_cdek", function () {
            var orderId = $("input[name='order_Id']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Cтатус заказа в компании СДЭК',
                content: ['${base}/cdek/statusorder?orderid=' + orderId, 'no'],
                area: ['650px', '600px']
            });
        });

        $(document).on("click", "#print_order_cdek", function () {
            var orderId = $("input[name='order_Id']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Печать квитанции СДЭК',
                content: ['${base}/cdek/printorder?orderid=' + orderId, 'no'],
                area: ['350px', '300px']
            });
        });

        formValidate();
        init_area('${order.address.provinceId}', '${order.address.cityId}', '${order.address.areaId}');
    });

    jQuery.validator.addMethod("isMobPhone", function (value, element) {
        var pattern = /^[8][0-9]{10}$/;
        return this.optional(element) || (pattern.test(value));
    }, "11-значный номер телефона, должен начинаться с 8");

    var formValidate = function () {
        $('#addressForm').validate({
            errorPlacement: function (error, element) {
                $(element).next('.field_notice').hide();
                $(element).after(error);
            },
            rules: {
                trueName: {
                    required: true
                },
                mobPhone: {
                    required: true,
                    isMobPhone: true
                },
                address: {
                    required: true
                },
                zipCode: {
                    required: true
                }
            },
            messages: {
                trueName: {
                    required: '<@spring.message "tsn.prompt2"/>'
                },
                mobPhone: {
                    required: '<@spring.message "tsn.prompt1"/>',
                    isMobPhone: '<@spring.message "tsn.prompt4"/>'
                },
                address: {
                    required: '<@spring.message "tsn.prompt5"/>'
                },
                zipCode: {
                    required: '<@spring.message "tsn.prompt6"/>'
                }
            }
        });
    };

    function saveAddress(obj) {
        if ($('#addressForm').valid()) {
            $(obj).attr("onclick", "");
            var provinceId = $('#area').val(); //省的id
            var cityId = $('#city').val(); //城市id
            var areaId = $('#qu').val(); //区的id
            if (cityId == '' || cityId == '0') {
                $(".areaMsg").html('<@spring.message "tsn.prompt8"/>');
                return false;
            }
            if (areaId == '' || areaId == '0') {
                $(".areaMsg").html('<@spring.message "tsn.prompt9"/>');
                return false;
            } else {
                $(".areaMsg").html('');
            }

            var quval = $('#qu').find("option:selected").html(); 	 //区的值
            $('#area_info').val(areaInfo);
            var address = $("#addressForm").serialize();
            $.ajax({
                url: '${base}/orders/updateOrderAddress',
                type: 'post',
                data: address,
                dataType: 'json',
                success: function (data) {
                    if (data.result == 1) {
                        layer.msg('<@spring.message "tsn.save_success"/>', {icon: 1, time: 500}, function () {
                            location.reload();
                        });
                    } else {
                        //保存,取消链接标签设置为显示
                        $(obj).attr("onclick", "saveAddress();");
                    }
                }, error: function () {
                    //保存,取消链接标签设置为显示
                    $(obj).attr("onclick", "saveAddress();");
                    cancel();
                    layer.msg('<@spring.message "website.communication"/>', {icon: 2});
                }
            });
        }
    }

    //修改收货地址
    function updateAddress() {
        //获取收货地址form表单下的所有input
        var transin = $("#addressForm").find("input");
        //获取收货地址form表单下的所有<em>
        var formems = $("#addressForm").find("em");
        //获取收货地址form表单下的所有<span>
        var formsp = $("#addressForm").find("span");
        //收货地址form表单下的所有input设置为显示
        transin.css("display", "inline");
        //收货地址form表单下的所有<em>设置为显示
        formems.css("display", "inline");
        //收货地址form表单下的所有<span>设置为隐藏
        formsp.css("display", "none");
        //修改收货地址链接标签设置为隐藏
        $("#update_address").css("display", "none");
        //保存,取消链接标签设置为显示
        $("#save_address").css("display", "inline");
        //收货地区选择显示
        $("#region").css("display", "inline");
        $("#region").find("span").css("display", "inline");
    }

    //取消修改
    function cancel() {
        //获取收货地址form表单下的所有input
        var transin = $("#addressForm").find("input");
        //获取收货地址form表单下的所有<em>
        var formems = $("#addressForm").find("em");
        //获取收货地址form表单下的所有<span>
        var formsp = $("#addressForm").find("span");
        //获取收货地址form表单下的所有<label>
        var formlab = $("#addressForm").find("label");
        //收货地址form表单下的所有input设置为隐藏
        transin.css("display", "none");
        //收货地址form表单下的所有<em>设置为隐藏
        formems.css("display", "none");
        //收货地址form表单下的所有<span>设置为显示
        formsp.css("display", "inline");
        //修改收货地址链接标签设置为显示
        $("#update_address").css("display", "inline");
        //保存,取消链接标签设置为隐藏
        $("#save_address").css("display", "none");
        //收货地区选择隐藏
        $("#region").css("display", "none");
        //删除validation的错误label
        formlab.remove();
    }
</script>
</@layout.body>