package com.leimingtech.front.module.cart.controller;

import com.google.common.collect.Maps;
import com.leimingtech.core.base.BaseController;
import com.leimingtech.core.common.Constants;
import com.leimingtech.core.common.NumberUtils;
import com.leimingtech.core.entity.Area;
import com.leimingtech.core.entity.GoodsSpec;
import com.leimingtech.core.entity.Order;
import com.leimingtech.core.entity.PayCommon;
import com.leimingtech.core.entity.base.*;
import com.leimingtech.core.entity.vo.CartVo;
import com.leimingtech.extend.module.payment.module.alipay.pc.china.pay.service.AlipayService;
import com.leimingtech.extend.module.payment.module.alipay.pc.internation.service.AlipayInternaService;
import com.leimingtech.extend.module.payment.module.unionopay.pc.pay.service.UnionpayService;
import com.leimingtech.extend.module.payment.module.whchat.h5.pay.scan.WechatScanService.WechatScanService;
import com.leimingtech.service.module.area.service.AreaService;
import com.leimingtech.service.module.cart.service.CartService;
import com.leimingtech.service.module.goods.service.GoodsService;
import com.leimingtech.service.module.goods.service.GoodsSpecService;
import com.leimingtech.service.module.member.service.MemberService;
import com.leimingtech.service.module.trade.common.OrderState;
import com.leimingtech.service.module.trade.common.PaymentTallyState;
import com.leimingtech.service.module.trade.service.OrderGoodsService;
import com.leimingtech.service.module.trade.service.OrderService;
import com.leimingtech.service.module.trade.service.PayService;
import com.leimingtech.service.module.trade.service.PaymentTallyService;
import com.leimingtech.service.utils.sessionkey.seller.CacheUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 项目名称：leimingtech-front
 * 类名称：CartAction
 * 类描述：
 * 创建人：liuhao
 * 创建时间：2014年12月24日 下午10:05:34
 * 修改备注：
 */
@Controller
@RequestMapping("/cart")
@Slf4j
public class CartAction extends BaseController {

    String message = "success";
    @Resource
    private CartService cartService;

    @Resource
    private AreaService areaService;

    @Resource
    private OrderService orderService;

    @Resource
    private GoodsSpecService goodsSpecService;

    @Resource
    private UnionpayService Unionpayservice;

    @Resource
    private AlipayService alipayService;

    @Resource
    private AlipayInternaService alipayinternaservice;

    @Resource
    private PayService payService;
    @Resource
    private WechatScanService wechatScanService;
    @Resource
    private PaymentTallyService paymentTallyService;
    @Resource
    private OrderGoodsService orderGoodsService;

    @Resource
    private GoodsService goodsService;

    @Resource
    private MemberService memberService;

    /**
     * 跳转至购物车页面
     *
     * @param @return 设定文件
     * @return ModelAndView    返回类型
     * @throws
     * @Title: index
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/index")
    public ModelAndView index(HttpSession session) {
        try {
            ModelAndView model = new ModelAndView("/cart/cart");
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }


    /**
     * ajax 添加购物车
     *
     * @param goodsId 商品id
     * @param count   加入商品数量
     * @param specId  商品规格id
     * @return Map<String,String>    返回类型
     * @Title: saveCart
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping(value = "/saveCart", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, String> saveCart(@RequestParam(value = "goodsId") String goodsId,
                                 @RequestParam(value = "count", defaultValue = "0") String count,
                                 @RequestParam(value = "specId") String specId,
                                 HttpSession session) {

        Map<String, String> map = Maps.newHashMap();
        //加载购物车标识,根据标识判断错误,默认为0,商品数量大于100
        String result = "0";
        //判断是否登录,登录存表,不登录将信息存入session
        Subject subject = SecurityUtils.getSubject();
        if (Integer.valueOf(count) > 100) { //数量超过100
            map.put(message, "false");
            map.put("msg", "加入相同商品数量过多,请购买不超过100件");
            return map;
        }
        if (subject.isAuthenticated()) {
            String memberId = CacheUtils.getCacheUser().getMember().getMemberId(); //用户id
            Member member = memberService.findMemberById(memberId);
            if (member.getIsBuy() == 1) {
                result = cartService.saveCart(goodsId, memberId, Integer.valueOf(count), specId, 0);
            } else {
                map.put(message, "false");
                map.put("msg", "该会员无购买权限");
                return map;
            }
        } else {
            //将商品信息存入cart实体中
            Cart cart = cartService.copyGoodsToCart(goodsId, specId);
            cart.setGoodsNum(Short.valueOf(count)); //商品数量
            cart.setSpecId(specId);  //重新为规格赋值,原来值为默认规格值
            //将cart信息先放入超类中
            CartVo cartVo = (CartVo) session.getAttribute(Constants.CART_KEY);
            if (cartVo == null) {
                cartVo = new CartVo();
                cartVo.add(cart);
                result = "1";
            } else {
                result = cartVo.update(cart);
            }
            //将超类放入session
            session.setAttribute(Constants.CART_KEY, cartService.getCartVoByCart(cartVo.getList()));
        }
        //判断加入购物车是否成功
        if ("0".equals(result)) { //数量超过100
            map.put(message, "false");
            map.put("msg", "加入相同商品数量过多,请购买不超过100件");
        } else if (NumberUtils.isInt(result) && Integer.parseInt(result) > 1) { //数量超过100
            map.put(message, "false");
            map.put("msg", "该商品最多购买不超过" + result + "件");
        } else if ("-1".equals(result)) {
            map.put(message, "false");
            map.put("msg", "请勿购买自己店铺下的商品");
        } else {
            map.put(message, "true");
        }
        return map;
    }


    @RequestMapping(value = "/saveCarts", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, String> saveCarts(@RequestParam(value = "orderid") String orderid,
                                  HttpSession session) {
        ModelAndView model = new ModelAndView("/cart/cart");
        Map<String, String> map = Maps.newHashMap();
        try {
            String buyerId = CacheUtils.getCacheUser().getMember().getMemberId();
            Order order = orderService.findOrderDetail(orderid, buyerId, null);
//        List<Cart> carts = new ArrayList<Cart>();
            for (OrderGoods o : order.getOrderGoodsList()) {
                Goods goods = goodsService.findGoodById(o.getGoodsId());
                cartService.saveCart(goods.getGoodsId(), buyerId, 1, o.getSpecId(), 0);
                /*List<Cart> c = cartService.queryBuyCart(CacheUtils.getCacheUser().getMember().getMemberId());
                if (c.size()==0){
                    Cart cart = new Cart();
                    Goods goods = goodsService.findGoodById(o.getGoodsId());
                    cart.setMemberId(CacheUtils.getCacheUser().getMember().getMemberId());
                    cart.setCartId(IdGen.uuid());
                    cart.setStoreId(goods.getStoreId());
                    cart.setStoreName(goods.getStoreName());
                    cart.setGoodsId(o.getGoodsId());
                    cart.setGoodsName(o.getGoodsName());
                    cart.setSpecId(o.getSpecId());
                    cart.setSpecInfo(o.getSpecInfo());
                    cart.setGoodsPrice(o.getGoodsPrice().doubleValue());
                    cart.setGoodsNum(o.getGoodsNum().shortValue());
                    cart.setGoodsImages(o.getGoodsImage());
                    cart.setFirstGcId(goods.getGcId());
                    carts.add(cart);
                }*/

            }
            map.put("message", "true");
            map.put("msg", "加入购物车成功");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("再次购买出错", e.getMessage());
            map.put("message", "false");
            map.put("msg", "再次购买出错");
        }
        return map;
    }


    /**
     * 导航加载购物车
     *
     * @param @param  model
     * @param @return
     * @param @throws JsonGenerationException
     * @param @throws JsonMappingException
     * @param @throws Exception    设定文件
     * @return Map<String,String>    返回类型
     * @throws
     * @Title: cart
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping(value = "/cart", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> cart(HttpSession session) {
        Map<String, Object> map = Maps.newHashMap();
        //判断是否登录,登录存表,不登录将信息存入session
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            //若登录,查表
            List<Cart> list = cartService.queryBuyCart(CacheUtils.getCacheUser().getMember().getMemberId());
            map.put("result", cartService.getCartVoByCart(list));
        } else {
            //若未登录,在session中获取
            CartVo cartVo = (CartVo) session.getAttribute(Constants.CART_KEY);
            if (cartVo != null) {
                map.put("result", cartService.getCartVoByCart(cartVo.getList()));
            } else {
                CartVo vo = new CartVo();
                vo.setGoodsNum(0);
                map.put("result", vo);
            }
        }
        map.put(message, "true");
        return map;
    }


    /**
     * 删除购物车数据,导航部分删除
     *
     * @param @param  cartId
     * @param @param  model
     * @param @return
     * @param @throws Exception    设定文件
     * @return Map<String,String>    返回类型
     * @throws
     * @Title: deletecart
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> deleteCart(@RequestParam(value = "goodsId") String goodsId,
                                   @RequestParam(value = "specId") String specId,
                                   HttpSession session) throws Exception {

        Map<String, Object> map = Maps.newHashMap();
        //判断是否登录,登录存表,不登录将信息存入session
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) { //登陆后删除表中数据
            //根据用户id,商品id,商品规格id删除购物车
            cartService.deleteByMGS(CacheUtils.getCacheUser().getMember().getMemberId(),
                    goodsId, specId);
            //重新查询集合插入CartVo后返回
            map.put("result", cartService.getCartVoByCart(cartService.queryBuyCart(CacheUtils.getCacheUser().getMember().getMemberId())));
        } else { //未登录,删除session中数据
            //从session中获取购物车数据
            CartVo cartVo = (CartVo) session.getAttribute(Constants.CART_KEY);
            //通过物品的id和规格的id删除session中数据
            cartVo.delete(goodsId, specId);
            //获得集合重新插入CartVo后返回
            map.put("result", cartService.getCartVoByCart(cartVo.getList()));
        }
        map.put("success", true);
        return map;
    }

    /**
     * 删除购物车数据,列表删除根据id,批量删除
     *
     * @param @param  cartId
     * @param @param  model
     * @param @return
     * @param @throws Exception    设定文件
     * @return Map<String,String>    返回类型
     * @throws
     * @Title: deletecart
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> delete(@RequestParam(value = "cartId") String cartId,
                               HttpSession session) throws Exception {
        Map<String, Object> map = Maps.newHashMap();
        try {
            String[] cartIds = cartId.split(",");
            for (String id : cartIds) {
                cartService.deleteCart(id);
            }
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
        return map;
    }


    /**
     * 更新购物车数量
     *
     * @param cartId  购物车id
     * @param count   购物车商品数量
     * @param storeId 店铺id
     * @param specId  商品规格id
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateCartCount", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateCart(@RequestParam(value = "cartId") String cartId,
                                   @RequestParam(value = "count") String count,
                                   @RequestParam(value = "storeId") String storeId,
                                   @RequestParam(value = "specId") String specId, HttpSession session) throws Exception {

        Map<String, Object> map = Maps.newHashMap();
        try {
            //根据商品规格id查询商品规格
            GoodsSpec goodsSpec = goodsSpecService.findByGoodsSpecId(specId);
            if (null == goodsSpec) {
                map.put("success", false);
                map.put("msg", "商品价格变动,请重新加入购物车!");
                return map;
            }
            if (Integer.valueOf(count) > goodsSpec.getSpecGoodsStorage()) {
                map.put("success", false);
                map.put("msg", "商品库存不足!");
            } else {
                //修改购物车数量
                Integer result = cartService.updatecart(cartId, Integer.valueOf(count));
                if (result > 1) { //数量超过100
                    map.put("msg", "该商品最多购买不超过" + result + "件");
                    map.put("success", false);
                    return map;
                }
                //根据用户id查询用户购物车集合
                List<Cart> list = cartService.queryBuyCart(CacheUtils.getCacheUser().getMember().getMemberId());
                map.put("result", cartService.getCartVoByCart(list));
                map.put("success", true);
                map.put("msg", "修改购物车成功");
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("修改购物车出错", e.getMessage());
            map.put("success", false);
            map.put("msg", "修改购物车出错");
        }
        return map;
    }

    /**
     * V.Pomogalov
     *
     * @param cartId  购物车id
     * @param count   购物车商品数量
     * @param specId  商品规格id
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateCartSpec", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateCartSpec(@RequestParam(value = "cartId") String cartId,
                                   @RequestParam(value = "count") String count,
                                   @RequestParam(value = "goodsId") String goodsId,
                                   @RequestParam(value = "specId") String specId, HttpSession session) throws Exception {

        Map<String, Object> map = Maps.newHashMap();
        try {
            //Характеристики товара в соответствии с идентификатором запроса
            GoodsSpec goodsSpec = goodsSpecService.findByGoodsSpecId(specId);
            if (null == goodsSpec) {
                map.put("success", false);
                map.put("msg", "Ассортимент товаров изменился. Пожалуйста введите корректные данные!");
                return map;
            }
            if (Integer.valueOf(count) > goodsSpec.getSpecGoodsStorage()) {
                map.put("success", false);
                map.put("msg", "Такого товара больше нет!");
            } else {
                //Изменение цвета и/или размера товара
                Integer result = cartService.updateCartSpec(goodsId, specId, cartId);
                if (result > 1) { //товаров больше 100
                    map.put("msg", "Нельзя превышать максимальное число купленных товаров. У Вас " + result + " шт.");
                    map.put("success", false);
                    return map;
                }

                List<Cart> list = cartService.queryBuyCart(CacheUtils.getCacheUser().getMember().getMemberId());
                map.put("result", cartService.getCartVoByCart(list));
                map.put("success", true);
                map.put("msg", "Данные о (цвете и/или размере) успешно изменены");
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("Ошибка модификации корзины", e.getMessage());
            map.put("success", false);
            map.put("msg", "Ошибка модификации корзины");
        }
        return map;
    }


    /**
     * 购物车 结算 显示订单页
     *
     * @param @param  cartId 为多个选中的购物车id组成的字符串,中间以逗号分隔
     * @param @return 设定文件
     * @return ModelAndView    返回类型
     * @throws
     * @Title: cartOrder
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/cartOrder")
    public ModelAndView cartOrder(@RequestParam(value = "cartIds") String cartIds, @RequestParam(value = "activityIds") String activityIds) {
        try {
            ModelAndView model = new ModelAndView("/cart/cart_order");
            model.addObject("cartIds", cartIds);
            model.addObject("activityIds", activityIds);
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("去结算地址页加载失败！", e.toString());
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 新增收货地址页面
     *
     * @return
     */
    @RequestMapping("/addresslist")
    public ModelAndView addresslist() {
        try {
            ModelAndView model = new ModelAndView("/cart/cart_address");
            if (CacheUtils.getCacheUser() != null) {
                List<Area> areas = areaService.queryAll();
                model.addObject("areas", areas);
                model.addObject("memberId", CacheUtils.getCacheUser().getMember().getMemberId());
                model.addObject("titleName", "Адрес доставки");
                model.addObject("cur", "address");
            }
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("去结算地址页加载失败！", e.toString());
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 加载运费
     *
     * @param cityId
     * @return
     */
    @RequestMapping("/addShipping")
    @ResponseBody
    public Map<String, Object> addShipping(@RequestParam(value = "cartIds") String cartIds,
                                           @RequestParam(value = "cityId", required = false, defaultValue = "") String cityId) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Map<String, Object> storeMap = new HashMap<String, Object>();
            //判断城市id是否存在
            if (StringUtils.isNotBlank(cityId)) { //若存在传值
                storeMap = cartService.queryFreightByCartIds(cityId, cartIds);
            } else { //不在传null
                storeMap = cartService.queryFreightByCartIds(null, cartIds);
            }

            map.put("result", storeMap);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            e.printStackTrace();
        }
        return map;
    }


    /**
     * 计算订单应付金额
     *
     * @param cartIds  多个购物车id
     * @param cityId   城市id
     * @param freight  运费信息
     * @param couponId 优惠券id
     * @return
     */
    @RequestMapping("/getTotalPrice")
    @ResponseBody
    public Map<String, Object> getTotalPrice(@RequestParam(value = "cartIds") String cartIds,
                                             @RequestParam(value = "couponId", required = false, defaultValue = "") String couponId,
                                             @RequestParam(value = "freight", required = false, defaultValue = "") String freight,
                                             @RequestParam(value = "cityId", required = false, defaultValue = "") String cityId,
                                             @RequestParam(value = "isPd", required = false, defaultValue = "0") String isPd,
                                             @RequestParam(value = "activityIds", required = false, defaultValue = "") String activityIds
    ) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Map<String, Object> priceMap = cartService.queryTotalPrice(cartIds, freight, couponId, cityId, isPd, CacheUtils.getCacheUser().getMember().getMemberId(), activityIds);
            map.put("result", priceMap);
            map.put("success", true);
        } catch (Exception e) {
            map.put("success", false);
            e.printStackTrace();
        }
        return map;
    }


    /**
     * 表单提交之前验证,验证商品的库存或者商品价格变动
     *
     * @param cartIds
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/orderVal", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> orderVal(@RequestParam(value = "cartIds") String cartIds) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        //验证商品库存或者商品价格变动,Map<String,Object>,键为类型:understock:库存不足,pricechange:价格变动
        Map<String, Object> valMap = cartService.orderValidation(cartIds);
        //如果两个list有数据返回map
        if (((List<Cart>) valMap.get("understock")).size() != 0 || ((List<Cart>) valMap.get("pricechange")).size() != 0
                || ((List<Cart>) valMap.get("specnotfund")).size() != 0 || ((List<Cart>) valMap.get("goodsshow")).size() != 0) {
            map.put("result", valMap);
            map.put("success", true);
        } else {
            map.put("success", false);
        }
        return map;
    }


    /**
     * 提交订单
     *
     * @param cartIds  多个购物车id
     * @param phoneNum 手机号
     * @param paytype  支付方式 1:在线支付,2:货到付款
     * @param couponId 优惠券id
     * @param isPd     是否余额支付 1为是
     */
    @RequestMapping(value = "/subVirtualsOrder")
    public ModelAndView subVirtualsOrder(@RequestParam(value = "cartIds") String cartIds,
                                         @RequestParam(value = "paytype") String paytype,
                                         @RequestParam(value = "phoneNum") String phoneNum,
                                         @RequestParam(value = "couponId", required = false, defaultValue = "") String couponId,
                                         @RequestParam(value = "isPd", required = false, defaultValue = "0") Integer isPd,
                                         HttpServletRequest request) throws Exception {
        ModelAndView model = new ModelAndView("/cart/cart_pay");
        //获取用户信息
        Member member = CacheUtils.getCacheUser().getMember();
        //提交订单,返回订单支付实体
        OrderPay orderPay = orderService.addOrderReturnPaySn(cartIds, member.getMemberId(), paytype, couponId, isPd, phoneNum);
        //根据payId查询订单列表
        List<Order> orderList = orderService.findByPayId(orderPay.getPayId());
        String goodsNames = ""; //所有商品名称
        Double ordersAmount = 0.00; //应付金额
        Double showOrderAmount = 0.00;    //liudongjie 页面显示金额
        for (Order order : orderList) {
            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                goodsNames += orderGoods.getGoodsName() + "&nbsp;&nbsp;&nbsp;&nbsp;";
            }
            ordersAmount = order.getOrderAmount().doubleValue();
            if (ordersAmount == 0) {    // 如果应付金额为0，页面显示金额为订单总金额
                showOrderAmount += order.getOrderTotalPrice().doubleValue();
            } else {    //否则的话，显示金额 = 应付金额 = 订单总金额 - 余额支付金额
                showOrderAmount += ordersAmount;
            }
        }

        model.addObject("member", member);
        model.addObject("orderType", OrderState.ORDER_TYPE_VIRTUAL);
        model.addObject("paytype", paytype);
        model.addObject("orderPaySn", orderPay.getPaySn());
        model.addObject("orderList", orderList);
        model.addObject("goodsNames", goodsNames);
        model.addObject("ordersAmount", ordersAmount);
        model.addObject("showOrderAmount", showOrderAmount);
        return model;
    }


    /**
     * 提交订单
     *
     * @param cartIds   多个购物车id
     * @param storeIds  购买商品店铺id
     * @param addressId 收货地址id
     * @param paytype   支付方式 1:在线支付,2:货到付款
     * @param couponId  优惠券id
     * @param invoiceId 发票id
     * @param isPd      是否余额支付 1为是
     * @param activityIds
     * @param parcel
     */
    @RequestMapping(value = "/subOrder")
    public ModelAndView subOrder(@RequestParam(value = "cartIds") String cartIds,
                                 @RequestParam(value = "storeId") String[] storeIds,
                                 @RequestParam(value = "address_options") String addressId,
                                 @RequestParam(value = "paytype") String paytype,
                                 @RequestParam(value = "couponId", required = false, defaultValue = "") String couponId,
                                 @RequestParam(value = "invoiceId", required = false, defaultValue = "") String invoiceId,
                                 @RequestParam(value = "transport_type", required = false, defaultValue = "") String[] transportType,
                                 @RequestParam(value = "isPd", required = false, defaultValue = "0") Integer isPd,
                                 @RequestParam(value = "activityIds", required = false, defaultValue = "0") String activityIds,
                                 @RequestParam(value = "parcel", required = false, defaultValue = "0") String parcel,
                                 HttpServletRequest request) throws Exception {
        ModelAndView model = new ModelAndView("/cart/cart_pay");
        String shippingFee = "";
        //获取订单买家备注信息
        Map<String, String> map = new HashMap<String, String>();
        for (String storeId : storeIds) {
            map.put(storeId, request.getParameter("orderMessage_" + storeId));
        }

        //获取用户信息
        Member member = CacheUtils.getCacheUser().getMember();

        //新建一个运费信息
        String freight = "";
        //转换运费信息格式
        for (String str : transportType) {
            freight += str + ",";
        }

        //提交订单,返回订单支付实体
        OrderPay orderPay = orderService.addOrderReturnPaySn(cartIds, member.getMemberId(), map, addressId, paytype, freight, couponId, invoiceId, isPd, activityIds, shippingFee, parcel);

        //根据payId查询订单列表
        List<Order> orderList = orderService.findByPayId(orderPay.getPayId());
        String goodsNames = ""; //所有商品名称
        Double ordersAmount = 0.00; //应付金额
        Double showOrderAmount = 0.00;    //liudongjie 页面显示金额
        for (Order order : orderList) {
            for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                goodsNames += orderGoods.getGoodsName() + "&nbsp;&nbsp;&nbsp;&nbsp;";
            }
            ordersAmount = order.getOrderAmount().doubleValue();
            if (ordersAmount == 0) {    // 如果应付金额为0，页面显示金额为订单总金额
                showOrderAmount += order.getOrderTotalPrice().doubleValue();
            } else {    //否则的话，显示金额 = 应付金额 = 订单总金额 - 余额支付金额
                showOrderAmount += ordersAmount;
            }
        }

        model.addObject("member", member);
        model.addObject("paytype", paytype);
        model.addObject("orderPaySn", orderPay.getPaySn());
        model.addObject("orderList", orderList);
        model.addObject("goodsNames", goodsNames);
        model.addObject("ordersAmount", ordersAmount);
        model.addObject("showOrderAmount", showOrderAmount);
        return model;
    }


    /**
     * 订单列表跳转支付页面
     *
     * @return
     */
    @RequestMapping("/goToPay")
    public ModelAndView goToPay(@RequestParam("orderId") String orderId) {
        ModelAndView model = new ModelAndView("/cart/cart_pay");
        //根据id查询订单信息
        String buyerId = CacheUtils.getCacheUser().getMember().getMemberId();
        Order order = orderService.findOrderDetail(orderId, buyerId, null);
        //获取用户信息
        Member member = CacheUtils.getCacheUser().getMember();
        String goodsNames = ""; //所有商品名称
        for (OrderGoods orderGoods : order.getOrderGoodsList()) {
            goodsNames += orderGoods.getGoodsName() + "&nbsp;&nbsp;&nbsp;&nbsp;";
        }
        List<Order> orderList = new ArrayList<Order>();
        orderList.add(order);

        model.addObject("member", member);
        model.addObject("paytype", 1); //支付方式,在线支付
        model.addObject("orderPaySn", order.getOrderSn());
        model.addObject("orderList", orderList);
        model.addObject("goodsNames", goodsNames);
        model.addObject("ordersAmount", order.getOrderAmount());
        model.addObject("showOrderAmount", order.getOrderAmount());

        return model;
    }


    /**
     * 去付款
     *
     * @param @param  paysn
     * @param @return 设定文件
     * @return ModelAndView    返回类型
     * @throws
     * @Title: orderpay
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/orderpay")
    public ModelAndView orderpay(@RequestParam(value = "paysn") String paysn,
                                 @RequestParam("paymentCode") String paymentCode,
                                 @RequestParam("paymentId") String paymentId,
                                 HttpServletRequest request, HttpServletResponse response) {
        try {
            Pay pay = payService.findPayBySn(paysn);
            PayCommon payCommon = new PayCommon();
            payCommon.setOutTradeNo(pay.getPaySn());
            payCommon.setPayAmount(pay.getPayAmount());
            String sHtmlText = "";
            if (StringUtils.isNotEmpty(paysn) && paymentCode.equals("ZFB")) {
                payCommon.setNotifyUrl("/payment/payback");
                payCommon.setReturnUrl("/payment/payfront");
                orderService.updateOrderPaymentByPaySn(paysn, paymentId);
                //保存支付流水记录
                System.out.println("dd:" + PaymentTallyState.PAYMENTTALLY_TREM_PC);
                paymentTallyService.savePaymentTally(paymentCode, "支付宝", pay, PaymentTallyState.PAYMENTTALLY_TREM_PC);
                //修改订单付款信息
                sHtmlText = alipayService.toPay(payCommon);
            } else if (StringUtils.isNotEmpty(paysn) && paymentCode.equals("YL")) {
                //修改订单付款信息
                payCommon.setNotifyUrl("/Unionpayment/Unionpayback");
                payCommon.setReturnUrl("/Unionpayment/Unionpayfront");
                orderService.updateOrderPaymentByPaySn(paysn, paymentId);
                //保存支付流水记录
                paymentTallyService.savePaymentTally(paymentCode, "银联", pay, PaymentTallyState.PAYMENTTALLY_TREM_PC);
                sHtmlText = Unionpayservice.toUnionpay(payCommon);//构造提交银联的表单
            } else if (StringUtils.isNotEmpty(paysn) && paymentCode.equals("GJZFB")) {
                //修改订单付款信息
                payCommon.setNotifyUrl("/payinternament/payback");
                payCommon.setReturnUrl("/payinternament/payfront");
                orderService.updateOrderPaymentByPaySn(paysn, paymentId);
                //保存支付流水记录
                paymentTallyService.savePaymentTally(paymentCode, "国际支付宝", pay, PaymentTallyState.PAYMENTTALLY_TREM_PC);
                sHtmlText = alipayinternaservice.toPay(paysn);//构造提交国际支付宝的表单
            } else if (StringUtils.isNotEmpty(paysn) && paymentCode.equals("weiscan")) {
                //修改订单付款信息
                payCommon.setNotifyUrl("/weChatScanpayment/updateorderstate");
                orderService.updateOrderPaymentByPaySn(paysn, paymentId);
                //保存支付流水记录
                paymentTallyService.savePaymentTally(paymentCode, "微信支付", pay, PaymentTallyState.PAYMENTTALLY_TREM_PC);
                String tocodeurl = wechatScanService.toPay(payCommon);//微信扫码url
                ModelAndView model = new ModelAndView();
                model.addObject("paysn", paysn);//订单号
                model.addObject("tocodeurl", tocodeurl);
                model.addObject("payCommon", payCommon);//支付单
                model.setViewName("/weiscan/native_weichatscan");
                return model;
            }
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(sHtmlText);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("提交付款页加载失败！");
            throw new RuntimeException("导航失败!");
        }
        return null;
    }


    /**
     * 跳到支付页面
     *
     * @return
     */
    @RequestMapping("/pay")
    public ModelAndView payindex(HttpServletRequest request) {
        try {
            ModelAndView model = new ModelAndView();
            String appId = request.getParameter("appId");
            String timeStamp = request.getParameter("timeStamp");
            String nonceStr = request.getParameter("nonceStr");
            String packageValue = request.getParameter("packageValue");
            String paySign = request.getParameter("paySign");
            model.addObject("appId", appId);
            model.addObject("timeStamp", timeStamp);
            model.addObject("nonceStr", nonceStr);
            model.addObject("packageValue", packageValue);
            model.addObject("paySign", paySign);
            model.setViewName("/cart/pay");
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 跳到支付错误页面
     *
     * @return
     */
    @RequestMapping("/payerror")
    public ModelAndView payerrorindex() {
        try {
            ModelAndView model = new ModelAndView();
            model.setViewName("/cart/pay_errer");
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 商品详情，直接购买，
     * ---如果购物车有，现在直接购买 ， 就把购物车的数据值更新之后 显示出来，不然就变成了 把之前加载进去的数量都带进去了
     *
     * @param goodsId 商品id
     * @param count   商品数量
     * @param specId  规格id
     * @return
     */
    @RequestMapping("/buyNow")
    @ResponseBody
    public Map<String, String> buyNow(@RequestParam(value = "goodsId") String goodsId,
                                      @RequestParam(value = "count", defaultValue = "0") String count,
                                      @RequestParam(value = "specId") String specId
    ) {
        try {
            Map<String, String> map = new HashMap<String, String>();
            if (Integer.valueOf(count) > 100) { //数量超过100
                map.put(message, "false");
                map.put("msg", "加入相同商品数量过多,请购买不超过100件");
                return map;
            }
            //加载购物车标识,根据标识判断错误,默认为0,商品数量大于100
            String result = "0";
            String memberId = CacheUtils.getCacheUser().getMember().getMemberId(); //用户id
            Member member = memberService.findMemberById(memberId);
            if (member != null) {
                if (member.getIsBuy() == 1) {
                    result = cartService.saveCart(goodsId, memberId, Integer.valueOf(count), specId, 1);
                } else {
                    map.put(message, "false");
                    map.put("msg", "该会员无购买权限");
                    return map;
                }
            }

            //判断加入购物车是否成功
            if (result.equals("0")) { //数量超过100
                map.put(message, "false");
                map.put("msg", "加入相同商品数量过多,请购买不超过100件");
            } else if (NumberUtils.isInt(result) && Integer.parseInt(result) > 0) { //数量超过100
                map.put(message, "false");
                map.put("msg", "该商品最多购买不超过" + result + "件");
            } else if (result.equals("-1")) { //自己店铺下的商品不能被购买
                map.put(message, "false");
                map.put("msg", "请勿购买自己店铺下的商品");
            } else {
                map.put(message, "true");
                map.put("cartIds", result + "");
            }
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("立即购买加入购物车失败！", e.toString());
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 直接购买，跳转至结算页面
     *
     * @param @param  cartIds
     * @param @return 设定文件
     * @return ModelAndView    返回类型
     * @throws
     * @Title: gotoOrder
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/gotoOrder")
    public ModelAndView gotoOrder(@RequestParam(value = "cartIds") String cartIds,
                                  @RequestParam(value = "goodsVirtuals") Integer goodsVirtuals) {
        try {
            if (goodsVirtuals != 1) {
                ModelAndView model = new ModelAndView("/cart/cart_order");
                model.addObject("cartIds", cartIds);
                return model;
            } else {
                ModelAndView model = new ModelAndView("/cart/virtual_order");
                model.addObject("cartIds", cartIds);
                return model;
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("去结算地址页加载失败！", e.toString());
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 跳到微信扫码支付页面
     *
     * @param
     * @return
     */
    @RequestMapping("/towhatscan")
    public ModelAndView towhatscan(ModelAndView model) {
        try {
            model.setViewName("/weiscan/native_weichatscan");
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 保存支付流水记录
     */
   /* public void savepayLog(String paytype,String payname,Pay pay){
          //根据支付单号获取订单信息
    	  List<Order> orderlist=orderService.findByPaySn(pay.getPaySn());
    	  if(orderlist.size()!=0){
    		  Order order=orderlist.get(0);
    		  PaymentTally paymentTally=new PaymentTally();
    		  paymentTally.setPaymentCode(paytype);//保存支付类型
    		  paymentTally.setPaymentName(payname);//支付名称
    		  paymentTally.setPaymentSn(pay.getPaySn());//商城内部交易号
    		  paymentTally.setPaymentAmount(pay.getPayAmount());// 订单交易金额
    		  if(pay.getPaySn().contains("R")){//充值
    			  paymentTally.setTradeType(PaymentTallyState.PAYMENTTALLY_RECHARGE_PAY);
    		  }else{//订单支付
    			  paymentTally.setTradeType(PaymentTallyState.PAYMENTTALLY_ORDER_PAY);
    		  }
    		  //支付状态
    		  paymentTally.setPaymentState(PaymentTallyState.PAYMENTTALLY_STATE_NOSUCCESS);
    		  //支付终端类型 1:PC;2:APP;3:h5
    		  paymentTally.setPaymentFrom(PaymentTallyState.PAYMENTTALLY_TREM_PC);
    		  //用户id
    		  paymentTally.setBuyerId(order.getBuyerId());
    		  //用户名
    		  paymentTally.setBuyerName(order.getBuyerName());
    		  //保存生成时间
    		  paymentTally.setCreateTime(System.currentTimeMillis());
    		  //保存流水表记录
    		  paymentTallyService.savePaymentTally(paymentTally);
    		  //释放资源
    		  paymentTally=null;
    	  }
    }*/
    @RequestMapping("/liu")
    public void toliu() {
        PaymentTally paymentTally = paymentTallyService.findPaymentTally("P20151229172720785");
        System.out.println("*****" + paymentTally);
    }


    @RequestMapping("/checkcartid")
    @ResponseBody
    public Map<String, Object> checkcartid(
            @RequestParam(value = "cartIds", required = false, defaultValue = "") String cartIds
    ) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            List<CartVo> list = cartService.queryVOListByCartIds(cartIds);
            if (list.size() == 0) {
                map.put("success", false);
                map.put("msg", "获取订单信息失败");
            } else {
                map.put("success", true);
                map.put("msg", "");
            }
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("失败！", e.toString());
            throw new RuntimeException("导航失败!");
        }
    }


    /**
     * 提交订单
     *
     * @param cartIds   多个购物车id
     * @param storeIds  购买商品店铺id
     * @param addressId 收货地址id
     * @param paytype   支付方式 1:在线支付,2:货到付款
     * @param couponId  优惠券id
     * @param invoiceId 发票id
     * @param isPd      是否余额支付 1为是
     */
    @RequestMapping(value = "/addOrder")
    @ResponseBody
    public String addOrder(@RequestParam(value = "cartIds") String cartIds,
                           @RequestParam(value = "storeId") String[] storeIds,
                           @RequestParam(value = "address_options") String addressId,
                           @RequestParam(value = "paytype") String paytype,
                           @RequestParam(value = "couponId", required = false, defaultValue = "") String couponId,
                           @RequestParam(value = "invoiceId", required = false, defaultValue = "") String invoiceId,
                           @RequestParam(value = "transport_type", required = false, defaultValue = "") String[] transportType,
                           @RequestParam(value = "isPd", required = false, defaultValue = "") Integer isPd,
                           @RequestParam(value = "activityIds", required = false, defaultValue = "") String activityIds,
                           @RequestParam(value = "shippingFee", required = false, defaultValue = "") String shippingFee,
                           @RequestParam(value = "parcel", required = false, defaultValue = "") String parcel,
                           HttpServletRequest request) throws Exception {


        //List<Cart> queryCartByIds

        //获取用户信息
        Member member = CacheUtils.getCacheUser().getMember();

        List<Cart> cartList = cartService.queryCartByIds(cartIds, member.getMemberId(), "");
        if (null != cartList && cartList.size() > 0) {
            //获取订单买家备注信息
            Map<String, String> map = new HashMap<String, String>();
            for (String storeId : storeIds) {
                map.put(storeId, request.getParameter("orderMessage_" + storeId));
            }

            //新建一个运费信息
            String freight = "";
            //转换运费信息格式
            for (String str : transportType) {
                freight += str;
            }

            //提交订单,返回订单支付实体
            OrderPay orderPay = orderService.addOrderReturnPaySn(cartIds, member.getMemberId(), map, addressId, paytype, freight, couponId, invoiceId, isPd, activityIds, shippingFee, parcel);

            if (null != orderPay) {
                this.showSuccessJson(orderPay.getPaySn());
            } else {
                this.showErrorJson("订单提交失败");
            }
        } else {
            this.showErrorJson("订单提交失败，所选购物车商品不属于此用户。");
        }

        return this.json;
    }

    /**
     * 订单提交成功后跳转到订单支付界面
     *
     * @param paySn    支付单号
     * @param memberId 购买商品店铺id
     * @param payType  支付方式：在线支付=1、货到付款=2
     */
    @RequestMapping(value = "/orderToPay")
    public ModelAndView orderToPay(@RequestParam(value = "paySn") String paySn,
                                   @RequestParam(value = "payType") String payType,
                                   @RequestParam(value = "memberId") String memberId,
                                   HttpServletRequest request) throws Exception {
        ModelAndView model = new ModelAndView("/cart/cart_pay");
        //获取用户信息
        Member member = CacheUtils.getCacheUser().getMember();
        if (!memberId.equals(member.getMemberId())) {
            model.addObject("message", "订单不属于此用户,无法操作");
        } else {
            Order o = new Order();
            o.setBuyerId(memberId);
            int orderCount = orderService.findOrderCount(null);
            if (orderCount > 0) {
                //根据payId查询订单列表
                List<Order> orderList = orderService.findByPaySn(paySn);
                String goodsNames = ""; //所有商品名称
                Double ordersAmount = 0.00; //应付金额
                Double showOrderAmount = 0.00;    //liudongjie 页面显示金额
                for (Order order : orderList) {
                    for (OrderGoods orderGoods : order.getOrderGoodsList()) {
                        goodsNames += orderGoods.getGoodsName() + "";
                    }
                    ordersAmount = order.getOrderAmount().doubleValue();
                    if (ordersAmount == 0) {    // 如果应付金额为0，页面显示金额为订单总金额
                        showOrderAmount += order.getOrderTotalPrice().doubleValue();
                    } else {    //否则的话，显示金额 = 应付金额 = 订单总金额 - 余额支付金额
                        showOrderAmount += ordersAmount;
                    }
                }

                model.addObject("member", member);
                model.addObject("paytype", payType);
                model.addObject("orderPaySn", paySn);
                model.addObject("orderList", orderList);
                model.addObject("goodsNames", goodsNames);
                model.addObject("ordersAmount", ordersAmount);
                model.addObject("showOrderAmount", showOrderAmount);
                model.addObject("message", "");
            } else {
                model.addObject("message", "订单不属于此用户,无法操作");
            }
        }

        return model;
    }
}