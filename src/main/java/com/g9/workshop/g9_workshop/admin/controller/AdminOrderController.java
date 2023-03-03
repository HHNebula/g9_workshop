package com.g9.workshop.g9_workshop.admin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.g9.workshop.g9_workshop.admin.service.AdminMemberService;
import com.g9.workshop.g9_workshop.admin.service.AdminOrderService;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

    @Autowired
    AdminOrderService adminOrderService;

    // [GYEONG] 유저리스트 pagination
    @GetMapping("/orderList/{currentPage}")
    public ModelAndView userListWithPagination(@RequestParam Map params, @PathVariable String currentPage,
            ModelAndView modelAndView) {
        params.put("currentPage", Integer.parseInt(currentPage));
        Object resultMap = adminOrderService.getOrderListWithPagination(params);
        modelAndView.addObject("resultMap", resultMap);
        modelAndView.setViewName("admin/order/list");
        return modelAndView;
    }

    // [GYEONG] 주문 상세내역 출력
    @GetMapping("/orderDetail/{orderUid}")
    public ModelAndView orderDetail(@RequestParam Map params, @PathVariable String orderUid,
            ModelAndView modelAndView) {
        params.put("ORDER_UID", orderUid);
        Object resultMap = adminOrderService.getOrdeDetailList(params);
        modelAndView.addObject("resultMap", resultMap);
        Object address = adminOrderService.getOrdeDetailAddress(params);
        modelAndView.addObject("address", address);
        modelAndView.setViewName("admin/order/detaillist");
        return modelAndView;
    }

    // [GYEONG] 주문 취소내역
    @GetMapping("/cancelOrder/{currentPage}")
    public ModelAndView cancelOrder(@RequestParam Map params, @PathVariable String currentPage,
            ModelAndView modelAndView) {
        params.put("currentPage", Integer.parseInt(currentPage));
        Object resultMap = adminOrderService.getCancelOrderListWithPagination(params);
        modelAndView.addObject("resultMap", resultMap);
        Object statistics = adminOrderService.getCancelOrderStatistics(params);
        modelAndView.addObject("statistics", statistics);
        modelAndView.setViewName("admin/order/cancel_list");
        return modelAndView;
    }

    // @PostMapping("/search")
    // public ModelAndView userSearch(@RequestParam Map params, ModelAndView
    // modelAndView) {
    // params.put("currentPage", 1);
    // Object resultMap =
    // adminMemberService.getUserSearchListWithPagination(params);
    // modelAndView.addObject("resultMap", resultMap);
    // modelAndView.setViewName("admin/member/searchlist");
    // return modelAndView;
    // }

    // // [GYEONG] 유저 정보 수정
    // @GetMapping("/editUserInfo/{userUid}")
    // public ModelAndView editUserInfo(@RequestParam Map params, @PathVariable
    // String userUid,
    // ModelAndView modelAndView) {
    // params.put("USER_UID", userUid);
    // Object resultMap = adminMemberService.getUserInfo(params);
    // Object userConditions = adminMemberService.getUserConditions(params);
    // modelAndView.addObject("resultMap", resultMap);
    // modelAndView.addObject("userConditions", userConditions);
    // modelAndView.setViewName("admin/member/edituserinfo");
    // return modelAndView;
    // }

    // @PostMapping("/editProcessUserInfo")
    // public ModelAndView editProcessUserInfo(@RequestParam Map params,
    // ModelAndView modelAndView) {
    // params.put("currentPage", 1);
    // Object resultMap = adminMemberService.updateUserInfoAndGetList(params);
    // modelAndView.addObject("resultMap", resultMap);

    // modelAndView.setViewName("admin/member/list");
    // return modelAndView;
    // }

    // @GetMapping("/deleteUserInfo/{userUid}")
    // public ModelAndView deleteUserInfo(@RequestParam Map params, @PathVariable
    // String userUid,
    // ModelAndView modelAndView) {
    // params.put("currentPage", 1);
    // params.put("USER_UID", userUid);
    // Object resultMap = adminMemberService.deleteUserInfoGetList(params);
    // modelAndView.addObject("resultMap", resultMap);

    // modelAndView.setViewName("admin/member/list");
    // return modelAndView;
    // }

    // @GetMapping(value = "/adminList")
    // public ModelAndView adminList(@RequestParam Map params, ModelAndView
    // modelAndView) {
    // Object resultMap = adminMemberService.getAdminList(params);
    // modelAndView.addObject("resultMap", resultMap);
    // modelAndView.setViewName("admin/member/adminlist");
    // return modelAndView;
    // }

    // @GetMapping("/deleteAdminInfo/{adminUid}")
    // public ModelAndView deleteAdminInfo(@RequestParam Map params, @PathVariable
    // String adminUid,
    // ModelAndView modelAndView) {
    // params.put("ADMIN_UID", adminUid);
    // Object resultMap = adminMemberService.deleteAdminInfoGetList(params);
    // modelAndView.addObject("resultMap", resultMap);

    // modelAndView.setViewName("admin/member/adminlist");
    // return modelAndView;
    // }

    // // [SOO] 유저 리스트
    // @GetMapping("/detail/{userUid}")
    // public ModelAndView userStatus(@PathVariable String userUid, ModelAndView
    // modelAndView) {
    // /*
    // * TO-DO
    // * 사용자 정보 add
    // * 주문 내역 add - 상품명 전달 시 통신방법 고민 필요
    // * 리뷰 내역 add
    // * 문의 내역 add
    // */

    // modelAndView.setViewName("admin/member/detail");
    // return modelAndView;
    // }

}
