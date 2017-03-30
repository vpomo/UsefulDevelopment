<@layout.head>
<script type="text/javascript" src="${base}/res/js/jquery-ui/jquery.ui.js"></script>
<script type="text/javascript" src="${base}/res/js/jquery-ui/i18n/zh-CN.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/res/js/layer/layer.js" charset="utf-8"></script>

<link rel="stylesheet" type="text/css" href="${base}/res/js/jquery-ui/themes/ui-lightness/jquery.ui.css"  />
</@layout.head>
<@layout.body>
<div class="page">
	<div class="fixed-bar">
        <div class="item-title">
            <h3><@spring.message "tsn.barter"/></h3>
            <ul class="tab-base">
                <li><a href="${base}/orders/returnList"><span><@spring.message "manage"/></span></a></li>
                <li><a href="JavaScript:void(0);" class="current"><span><@spring.message "tsn.barter_detail"/></span></a></li>
            </ul>
        </div>
    </div>
    <div class="fixed-empty"></div>
    <input type="hidden" name="barterId1" value="${barterDetail.barterId}">
  <#--  <#if barterDetail.sellerState==30>
        <a href="JavaScript:void(0);" class="btn" onclick="Hquerenshouhuo()"><span>确认收货</span></a>
    </#if>-->
    <table class="table tb-type2 order">
        <thead>
        <input type="hidden" name="shopBarterId" value="${barterDetail.barterId}">
        </thead>

        <tbody>
            <#if barterDetail.sellerState==10>
            <form id="barterForm" name="barterForm" action="${base}/orders/huanhuosh" method="post">
                <input type="hidden" name="barterId" value="${barterDetail.barterId}">
                <tr>
                    <th>退货审核</th>
                </tr>
                <tr>
                    <td>
                        <label >
                            <input id="sellerState" name="sellerState" value="20" checked="checked" type="radio"  onclick="$('#refundRejectReason').hide();"/>
                            通过
                        </label>
                        <label>
                            <input id="sellerState" name="sellerState" value="21" type="radio" onclick="$('#refundRejectReason').show();"/>
                            不通过
                        </label>
                    </td>
                </tr>
                <dl id="refundRejectReason" style="display: none;">
                    <dd>拒绝原因：</dd>
                    <dt>
                    <p>
                        <textarea name="reasonInfo" rows="6" class="tarea" id="reason_Info"></textarea>
                    </p>
                    </dt>
                </dl>
            </form>
            </#if>
        <tr class="space">
            <th colspan="15"><@spring.message "tsn.barter_state"/></th>
        </tr>
        <tr>
            <td colspan="2">
                <ul>
                    <li>
                        <strong><@spring.message "tsn.barter_number"/>：</strong>${barterDetail.barterSn}
                    </li>
                    <li><strong><@spring.message "checkstate"/>：</strong>
                        <#if barterDetail.sellerState==10>
                            Состояние ожидания
                        <#elseif barterDetail.sellerState==20>
                            Покупатель заплатил
                        <#elseif barterDetail.sellerState==21>
                            Проверка данных
                        <#elseif barterDetail.sellerState==30>
                            Покупатель товар отправил, ждем получения
                        <#elseif barterDetail.sellerState==40>
                            Товар от покупателя получен продавцом
                        <#elseif barterDetail.sellerState==50>
                            Продавец отправил замененный товар покупателю
                        <#elseif barterDetail.sellerState==60>
                            Покупатель подтвердил окончание обмена товара
                        </#if>
                    </li>
                    <#if barterDetail.buyerInvoiceNo!=null&&barterDetail.buyerInvoiceNo!="">
                        <li>
                            <strong>买家物流单号:</strong>
                        ${barterDetail.buyerInvoiceNo}
                        </li>
                    </#if>
                    <#if barterDetail.sellerInvoiceNo!=null&&barterDetail.sellerInvoiceNo!="">
                        <li>
                            <strong>平台物流单号:</strong>
                        ${barterDetail.sellerInvoiceNo}
                        </li>
                    </#if>
                </ul>
            </td>
        </tr>
        <tr class="space">
            <th colspan="2"><@spring.message "tsn.barter_detail"/></th>
        </tr>
        <tr>
            <th><@spring.message "tsn.goods"/></th>
        </tr>
        <tr>
            <td><table class="table tb-type2 goods ">
                <tbody>
                <tr>
                    <th></th>
                    <th><@spring.message "tsn.goods"/></th>
                    <th class="align-center"><@spring.message "tsn.barter_quantity"/></th>
                </tr>

                <tr>
                    <td class="w60 picture">
                        <div class="size-56x56">
                                <a href="${frontServer}/product/${orderGoods.specId}.html" target="_blank"><img src="${imgServer}${orderGoods.goodsImage}" onload="javascript:DrawImage(this,60,60);" /> </a>
                           </div></td>
                    <td class="w50pre">
                        <p>
                            <a href="${frontServer}/product/${orderGoods.specId}.html" target="_blank">${orderGoods.goodsName}</a>
                        </p>
                        <p>
                            Cпецификация： ${orderGoods.specInfo}
                        </p>
                        <#if orderGoods.goodsSerial!="">
                            <p>
                                Номер товара： ${orderGoods.goodsSerial}
                            </p>
                        </#if>
                        <#if orderGoods.specGoodsSerial!="">
                            <p>
                                Артикул： ${orderGoods.specGoodsSerial}
                            </p>
                        </#if>
                    </td>
                    <td class="w96 align-center">${orderGoods.goodsNum}</td>
                </tr>

                </tbody>
            </table></td>
        </tr>
        <tr>
            <th><@spring.message "tsn.barter1"/></th>
        </tr>
        <tr>
            <td><ul>
                <li><strong><@spring.message "tsn.buyers"/>：</strong>${barterDetail.buyerName}</li>
                <#if member ??&& member!=null>
                   <li><strong><@spring.message "real_name"/>：</strong>${member.memberTruename}<strong><@spring.message "manage"/>Телефон：</strong>${member.memberMobile}</li>
                </#if>
                
                <li><strong><@spring.message "store"/>：</strong>${barterDetail.storeName}</li>
                <li>
                    <@spring.message "tsn.barter_reason"/>：${barterDetail.buyerMessage}
				</li>
				<#if barterDetail.sellerMessage??>
					<li>
                        <@spring.message "tsn.seller_notes"/>：${barterDetail.sellerMessage}
					</li>
				</#if>
				<#if barterDetail.picInfo!=''>
					<li>
                        <@spring.message "tsn.image"/>：
						<#list barterDetail.picInfo?split(',') as img>
				     		<#if img!=''>
				     			<img width="80px" height="80px" src="${imgServer}${img}"/>
				     		</#if>
				     	</#list>
					</li>
				</#if>

                <#if barterDetail.buyerExpressName == 'CDEK'>
                    <p>Доставка компанией СДЭК</p>
                    <li><strong></>Номер заказа компании СДЭК：</strong>
                    ${barterDetail.buyerExpressId}
                    </li>
                    <li><strong></>Показать статус заказа：</strong>
                        <button id="status_order_cdek">Статус заказа СДЭК</button>
                    </li>
                    <li><strong></>Печать квитанции к заказу：</strong>
                        <button id="print_order_cdek">Просмотр квитанции СДЭК</button>
                    </li>
                </#if>
                <#if barterDetail.sellerState == '30'>
                    <li><strong></>Подтверждение получения, отправленного покупателем товара：</strong>
                        <button id="confirm_from_buyer">Подтвердить получение</button>
                    </li>
                </#if>
                <#if barterDetail.sellerState == '40'>
                    <li><strong></>Создание заказа на доставку товара покупателю транспортной компанией：</strong>
                        <button id="make_cdek_for_buyer">Создать заказ на доставку</button>
                    </li>
                    <li>
                        <p><a href="${base}/orders/Hshipments_deliver?barterId=${barterDetail.barterId}" class="btn" nctype="del_batch">Подтверждение доставки</a></p>
                    </li>
                </#if>
                <#if barterDetail.sellerState == '50'>
                    <p>Доставка покупателю замененного товара компанией СДЭК</p>
                    <li><strong></>Номер заказа компании СДЭК：</strong>
                    ${barterDetail.sellerExpressId}
                    </li>
                    <li><strong></>Показать статус заказа：</strong>
                        <button id="status_seller_order_cdek">Статус заказа СДЭК</button>
                    </li>
                    <li><strong></>Печать квитанции к заказу：</strong>
                        <button id="print_seller_order_cdek">Просмотр квитанции СДЭК</button>
                    </li>
                </#if>

            </ul></td>
        </tr>
        <#if barterDetail.shopBarterLogList?? && barterDetail.shopBarterLogList?size != 0>
        <tr>
            <th><@spring.message "operation_history"/></th>
        </tr>
            <#list barterDetail.shopBarterLogList as log>
            <tr>
                <td>
                    ${log.operator}&emsp;<@spring.message "to"/>&emsp;${log.createTimeStr?string("yyyy-MM-dd HH:mm:ss")}&emsp;${log.stateInfo}
                </td>
            </tr>
            </#list>
        </#if>
        </tbody>
        <tfoot>
        <tr class="tfoot">
            <td><a href="JavaScript:void(0);" class="btn" onclick="subBarterForm()"><span>提交</span></a><a href="JavaScript:void(0);" class="btn" onclick="history.go(-1)"><span><@spring.message "button.back"/></span></a></td>
        </tr>
        </tfoot>
    </table>
</div>
<script type="text/javascript" >
    $(function () {
        $(document).on("click", "#status_order_cdek", function () {
            var shopBarterId = $("input[name='shopBarterId']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Cтатус заказа в компании СДЭК',
                content: ['${base}/cdek/status?shopBarterId=' + shopBarterId, 'no'],
                area: ['650px', '600px']
            });
        });

        $(document).on("click", "#status_seller_order_cdek", function () {
            var shopBarterId = $("input[name='shopBarterId']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Cтатус заказа в компании СДЭК',
                content: ['${base}/cdek/status?shopBarterId=' + shopBarterId + '&homing=1', 'no'],
                area: ['650px', '600px']
            });
        });

        $(document).on("click", "#print_order_cdek", function () {
            var shopBarterId = $("input[name='shopBarterId']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Печать квитанции СДЭК',
                content: ['${base}/cdek/print?shopBarterId=' + shopBarterId, 'no'],
                area: ['350px', '300px']
            });
        });

        $(document).on("click", "#print_seller_order_cdek", function () {
            var shopBarterId = $("input[name='shopBarterId']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Печать квитанции СДЭК',
                content: ['${base}/cdek/print?shopBarterId=' + shopBarterId + '&homing=1', 'no'],
                area: ['350px', '300px']
            });
        });

        $(document).on("click", "#confirm_from_buyer", function () {
            var shopBarterId = $("input[name='shopBarterId']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Подтверждение',
                content: ['${base}/orders/confirmBarterFromBuyer?shopBarterId=' + shopBarterId, 'no'],
                area: ['250px', '200px']
            });
        });

        $(document).on("click", "#make_cdek_for_buyer", function () {
            var shopBarterId = $("input[name='shopBarterId']").val();
            layer.open({
                type: 2,
                move: true,
                shade: false,
                offset: '5px',
                title: 'Подтверждение',
                content: ['${base}/cdek/makeBarterForBuyer?shopBarterId=' + shopBarterId, 'no'],
                area: ['800px', '640px']
            });
        });

    });

    function subBarterForm(){
        var sellerState = $("[name=sellerState]:checked").attr("value");
        var reasonInfo = $("[name=reasonInfo]").val();

        if (sellerState==20){
            if(confirm("您确定审核通过吗?")) {
                $("#barterForm").submit();
            }
        }
        if(sellerState==21){
            if(reasonInfo!=null&&reasonInfo!=""&&reasonInfo!=undefined){
                if(confirm("您确定审核拒绝吗?")) {
                    $("#barterForm").submit();
                }
            }else{
                alert("请填写拒绝原因");
            }
        }
    }

</script>
<script type="text/javascript">
    function Hquerenshouhuo(){
        var barterId1 = $("[name=barterId1]").val();
        if (barterId1==""){
            alert("订单信息错误。");
            return false;
        }
        if(confirm("您确定确认收货吗?")) {
            $.ajax({
                type: "post",
                url: '${base}/orders/Hquerenshouhuo',
                data: {barterId: barterId1},
                dataType: "json",
                success: function (data) {
                    if (data.result == 0) {
                        location.href = '${base}/orders/barterList';
                    } else {
                        alert("确认收货失败");
                    }
                }
            });
        }

    }
</script>
</@layout.body>