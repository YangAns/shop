package com.yang.controller.front;

import com.alipay.api.AlipayApiException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yang.bean.*;
import com.yang.service.*;
import com.yang.utils.CartDto;
import com.yang.utils.DataGridViewResult;
import com.yang.utils.SystemConstant;
import com.yang.vo.OrderVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Component
@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;
    @Autowired
    private CartService cartService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private OrderDetailService orderDetailService;


    @Autowired
    private PayService payService;



    @RequestMapping("/saveOrder")
    @ResponseBody
    public Map<String, Object> saveOrder(@RequestBody List<CartDto> cartDtos, HttpSession session) {
        HashMap<String, Object> map = new HashMap<>();
        //取到session里的值 b
        User u = (User) session.getAttribute("user");
        if (u == null) {
            map.put(SystemConstant.MESSAGE, "SessionError");
        } else {
            //判断用户是否填写地址
            User user = userService.findUserById(u.getId());
            if (StringUtils.isEmpty(user.getAddress())) {
                System.out.println("--->地址" + u.getAddress());
                map.put(SystemConstant.MESSAGE, "addressNull");
            } else {
                //接收前台购物车里的商品
                ArrayList<Integer> ids = new ArrayList<>();
                BigDecimal to = new BigDecimal(0);
                //计算订单总价
                for (CartDto cartDto : cartDtos) {
                    ids.add(cartDto.getId());
                    Cart cart = cartService.findCartById(cartDto.getId());
                    to = to.add(BigDecimal.valueOf(cart.getPrice()).multiply(new BigDecimal(cartDto.getNum())));
                }
                //往订单表添加数据
                Order order = new Order();
                order.setOrderCode(getOrderCode(u.getId()));
                order.setUid(u.getId());
                order.setAddTime(new Date());
                order.setOrderPrice(to.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                //order.setStatus(-1);
                orderService.addOrder(order);
                //往订单详情表添加数据
                if (!CollectionUtils.isEmpty(ids)) {
                    for (CartDto cartDto : cartDtos) {
                        Cart cart = cartService.findCartById(cartDto.getId());
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.setGid(cart.getGid());
                        orderDetail.setOrderId(order.getId());
                        orderDetail.setDetailNum(cartDto.getNum());
                        orderDetail.setDetailPrice(cartDto.getNum() * cart.getPrice());
                        orderDetail.setStatus(0);
                        orderDetailService.addOrderDetail(orderDetail);
                    }
                }
                map.put(SystemConstant.MESSAGE, "true");
                map.put("orderId", order.getId());
            }
        }
        return map;
    }

    //跳转到提交订单页面
    @RequestMapping("submitOrder/{orderId}")
    public String submitOrder(@PathVariable("orderId") Integer orderId, Model model, HttpSession session) {
        Order order = orderService.findOrderById(orderId);
        User u = (User) session.getAttribute("user");
        if (order == null || u == null) {
            model.addAttribute("msg", "未登录或者页面过期");
            return "front/timeOut";
        } else {
            List<OrderDetail> orderDetails = orderDetailService.findOrderDetailListByOrderId(orderId);
            User user = userService.findUserById(u.getId());
            model.addAttribute("order", order);
            model.addAttribute("user", user);
            model.addAttribute("orderDetails", orderDetails);
        }
        return "front/front_order/submitOrder";
    }
    //定时删除无用的数据  添加定时任务,每天凌晨0点更新一次
    @Scheduled(cron = "0 0 0 * * ?")
    public void delStatusIsNull() {
        List<Integer> orderIds = orderService.findStatusIsNull();
        if (!CollectionUtils.isEmpty(orderIds)) {
            for (Integer orderId : orderIds) {
                orderService.deleteById(orderId);
                List<OrderDetail> orderDetails = orderDetailService.findOrderDetailListByOrderId(orderId);
                for (OrderDetail orderDetail : orderDetails) {
                    orderDetailService.deleteById(orderDetail.getOrderId());
                }
            }
        }
    }

    //分段提交第二段 支付
    @RequestMapping("/pay")
    @ResponseBody
    public String alipay(int orderId) throws AlipayApiException {
        //删除购物车里的商品
        List<OrderDetail> orderDetails = orderDetailService.findOrderDetailListByOrderId(orderId);
        for (OrderDetail orderDetail : orderDetails) {
            cartService.deleteByGId(orderDetail.getGid());
        }
        //修改订单状态为待付款
        orderService.updateStatus(0, orderId);
        //接收前台购物车里的商品
        Order order = orderService.findOrderById(orderId);
        //log.info("商户订单号为{},订单名称为{},付款金额为{},商品描述{}", outTradeNo, subject, totalAmount, body);
        AliPayBean alipayBean = new AliPayBean();
        alipayBean.setOut_trade_no(order.getOrderCode());
        alipayBean.setSubject("YangAns乐享数码产品");
        alipayBean.setTotal_amount(String.valueOf(order.getOrderPrice()));
        alipayBean.setBody("数码产品");
        return payService.aliPay(alipayBean);
    }

    /**
     * 支付回调
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws AlipayApiException
     */
    @RequestMapping("/success")
    public String success(HttpServletRequest request) throws UnsupportedEncodingException, AlipayApiException {
        log.info("支付成功, 进入同步通知接口...");
        //获取支付宝GET过来反馈信息
        Map<String, String> params = new HashMap<String, String>();
        Map<String, String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        System.out.println("参数为：" + params);
        //boolean signVerified = AlipaySignature.rsaCheckV1(params, aliPayConfig.getPublicKey(), aliPayConfig.getCharset(), aliPayConfig.getSignType()); //调用SDK验证签名
        //ModelAndView mv = new ModelAndView("alipaySuccess");
        //——请在这里编写您的程序（以下代码仅作参考）——
        //商户订单号
        String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");

        //支付宝交易号
        String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");

        //付款金额
        String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"), "UTF-8");

        // 修改叮当状态，改为 支付成功，已付款; 同时新增支付流水
        //orderService.updateOrderStatus(out_trade_no, trade_no, total_amount);

        System.out.println("订单编号为：" + out_trade_no);
        Order order = orderService.findOrderByOrderCode(out_trade_no);
        orderService.updateStatus(1, order.getId());

        List<OrderDetail> orderDetails = orderDetailService.findOrderDetailListByOrderId(order.getId());
        for (OrderDetail orderDetail : orderDetails) {
            Goods goods = goodsService.findGoodsById(orderDetail.getGid());
            goods.setBuyNum(goods.getBuyNum() + orderDetail.getDetailNum());
            //修改商品库存
            goods.setNum(goods.getNum() - orderDetail.getDetailNum());
            goodsService.updateGoods(goods);
        }
        log.info("********************** 支付成功(支付宝同步通知) **********************");
        log.info("* 订单号: {}", out_trade_no);
        log.info("* 支付宝交易号: {}", trade_no);
        log.info("* 实付金额: {}", total_amount);
        log.info("***************************************************************");
        return "redirect:/cart/showMyCart";
    }
    //***************************************

    /**
     * 查询订单列表
     *
     * @param orderVo
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridViewResult list(OrderVo orderVo) {
        //设置分页信息
        PageHelper.startPage(orderVo.getPage(), orderVo.getLimit());
        //调用分页查询的方法
        List<Order> orderLIst = orderService.findOrderLIst(orderVo);
        //创建分页对象
        PageInfo<Order> pageInfo = new PageInfo<>(orderLIst);
        return new DataGridViewResult(pageInfo.getTotal(), pageInfo.getList());
    }


    /**
     * 前台通过超链接删除订单
     * @param id
     * @return
     */
    @RequestMapping("/fDeleteById/{id}")
    public String fDeleteById( int id) {
        orderService.deleteById(id);
        return "redirect:/order/myOrder";
    }


    /**
     * 后台通过ajax post请求删除订单
     *
     * @param id
     * @return
     */
    @RequestMapping("/deleteById")
    @ResponseBody
    public Map<String, Object> deleteById(int id) {
        //System.out.println(id);
        Map<String, Object> map = new HashMap<>();
        if (orderService.deleteById(id) > 0) {
            map.put(SystemConstant.SUCCESS, true);//成功
            map.put(SystemConstant.MESSAGE, "删除成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);//失败
            map.put(SystemConstant.MESSAGE, "删除失败");
        }
        return map;
    }


    /**
     * 跳转到我的订单页面
     *
     * @return
     */
    @RequestMapping("myOrder")
    public String myOrder(Model model, HttpSession session) {
        User u = (User) session.getAttribute("user");
        if (u != null) {
            int uid = u.getId();
            //根据用户查询所有订单信息
            List<Order> orderList = orderService.findOrderListByUid(uid);
            model.addAttribute("orderList", orderList);
            //根据用户查询待发货的订单信息
            List<Order> dfhOrderList = orderService.findDfhOrderListByUid(uid);
            model.addAttribute("dfhOrderList", dfhOrderList);
            //根据用户查询待付款的订单信息
            List<Order> dfkOrderList = orderService.findDfkOrderListByUid(uid);
            model.addAttribute("dfkOrderList", dfkOrderList);
            //根据用户查询待收货的订单信息
            List<Order> dshOrderList = orderService.findDshOrderListByUid(uid);
            model.addAttribute("dshOrderList", dshOrderList);
            //根据用户查询已收货的订单信息
            List<Order> yshOrderList = orderService.findYshOrderListByUid(uid);
            model.addAttribute("yshOrderList", yshOrderList);
            return "front/front_order/showOrder";
        } else {
            return "redirect:/user/toLogin";
        }
    }



    /**
     * 前台购物车结算
     * 此方法已不使用
     * @param cartDtos
     * @return
     */
    @RequestMapping("addOrder")
    @ResponseBody
    public Map<Object, Object> addOrder(@RequestBody List<CartDto> cartDtos, HttpSession session) {
        Map<Object, Object> map = new HashMap<>();
        //取到session里的值 b
        User u = (User) session.getAttribute("user");
        if (u == null) {
            map.put(SystemConstant.MESSAGE, "SessionError");
        } else {
            //判断用户是否填写地址
            User user = userService.findUserById(u.getId());
            if (StringUtils.isEmpty(user.getAddress())) {
                System.out.println("--->地址" + u.getAddress());
                map.put(SystemConstant.MESSAGE, "addressNull");
            } else {
                //接收前台购物车里的商品
                ArrayList<Integer> ids = new ArrayList<>();
                BigDecimal to = new BigDecimal(0);
                //计算订单总价
                for (CartDto cartDto : cartDtos) {
                    ids.add(cartDto.getId());
                    Cart cart = cartService.findCartById(cartDto.getId());
                    to = to.add(BigDecimal.valueOf(cart.getPrice()).multiply(new BigDecimal(cartDto.getNum())));
                }
                //往订单表添加数据
                Order order = new Order();
                order.setOrderCode(getOrderCode(u.getId()));
                order.setUid(u.getId());
                order.setAddTime(new Date());
                order.setOrderPrice(to.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                order.setStatus(0);
                if (orderService.addOrder(order) > 0) {
                    //往订单详情表添加数据
                    if (!CollectionUtils.isEmpty(ids)) {
                        for (CartDto cartDto : cartDtos) {
                            Cart cart = cartService.findCartById(cartDto.getId());
                            OrderDetail orderDetail = new OrderDetail();
                            orderDetail.setGid(cart.getGid());
                            orderDetail.setOrderId(order.getId());
                            orderDetail.setDetailNum(cartDto.getNum());
                            orderDetail.setDetailPrice(cartDto.getNum() * cart.getPrice());
                            orderDetail.setStatus(0);
                            orderDetailService.addOrderDetail(orderDetail);
                            //修改商品购买数量
                            Goods goods = goodsService.findGoodsById(cart.getGid());
                            goods.setBuyNum(goods.getBuyNum() + cartDto.getNum());
                            //修改商品库存
                            goods.setNum(goods.getNum() - cartDto.getNum());
                            goodsService.updateGoods(goods);
                            //删除购物车
                            cartService.deleteById(cartDto.getId());
                        }
                    }
                    map.put(SystemConstant.MESSAGE, "true");
                } else {
                    map.put(SystemConstant.MESSAGE, "false");
                }
            }
        }
        return map;
    }


    //生成订单编号
    public static synchronized String getOrderCode(Integer userId) {
        //时间（精确到毫秒）
        DateTimeFormatter ofPattern = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
        String localDate = LocalDateTime.now().format(ofPattern);
        //3位随机数
        String randomNumeric = RandomStringUtils.randomNumeric(3);
        //5位用户id
        int subStrLength = 5;
        String sUserId = userId.toString();
        int length = sUserId.length();
        String str;
        if (length >= subStrLength) {
            str = sUserId.substring(length - subStrLength, length);
        } else {
            str = String.format("%0" + subStrLength + "d", userId);
        }
        String orderNum = localDate + randomNumeric + str;
        log.info("订单号:{}", orderNum);
        return orderNum;
    }

    /**
     * 后台管理员发货
     *
     * @param id
     * @return
     */
    @RequestMapping("/deliverOrder")
    @ResponseBody
    public Map<Object, Object> deliverOrder(int id) {
        Map<Object, Object> map = new HashMap<>();
        if (orderService.deliverOrder(id) > 0) {
            map.put(SystemConstant.SUCCESS, true);
            map.put(SystemConstant.MESSAGE, "发货成功");
        } else {
            map.put(SystemConstant.SUCCESS, false);
            map.put(SystemConstant.MESSAGE, "发货失败");
        }
        return map;
    }


    /**
     * 前台用户确认收货
     *
     * @param id
     * @return
     */
    @RequestMapping("confirmReceipt")
    public String confirmReceipt(int id) {
        orderService.confirmReceipt(id);
        return "redirect:/order/myOrder";
    }


    /**
     * 前台用户取消订单
     *
     * @param id
     * @return
     */
    @RequestMapping("cancelOrder")
    public String cancelOrder(int id) {
        orderService.cancelOrder(id);
        return "redirect:/order/myOrder";
    }

    /**
     * 查询订单总量
     * 查询待发货订单数量
     *
     * @return
     */
    @RequestMapping("/findToDo")
    @ResponseBody
    public Map<String, Object> findToDo() {
        Map<String, Object> map = new HashMap<>();
        int totalOrder = orderService.findTotalOrder();
        int totalDeliverOrder = orderService.findTotalDeliverOrder();
        map.put("total", totalOrder);
        map.put("deliver", totalDeliverOrder);
        return map;
    }
}
