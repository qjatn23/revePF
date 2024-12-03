package org.zerock.order.controller;

import java.net.URLDecoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.member.vo.LoginVO;
import org.zerock.order.service.OrderService;
import org.zerock.order.vo.OrderVO;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    
    @GetMapping("/form.do")
    public String orderForm(
    		HttpSession session,
    		 @RequestParam(value = "items", required = false, defaultValue = "[]") String itemsEncoded,
    	     @RequestParam(value = "discount", required = false, defaultValue = "0.0") String discount,
    	     @RequestParam(value = "finalAmount", required = false, defaultValue = "0.0") String finalAmount,
    	     Model model) throws Exception {
        // URL 디코딩 처리
        String itemsJson = URLDecoder.decode(itemsEncoded, "UTF-8");
        
     // 세션에서 로그인된 사용자 아이디를 가져오기 (예: "id"라는 키로 저장된 경우)
        LoginVO loginVO = (LoginVO) session.getAttribute("login");  // 로그인된 사용자 아이디
        String id = loginVO.getId();
        
     // JSON 문자열 -> Java 객체로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> items;
        try {
            items = objectMapper.readValue(itemsJson, List.class);
        } catch (Exception e) {
            log.warn("Failed to parse items JSON. Defaulting to empty list.", e);
            items = List.of(); // 빈 리스트로 초기화
        }
        
     // 주문번호 생성: 시간 + 아이디 조합
        String orderNo = generateOrderNo(id);
        
     // OrderVO 생성 및 데이터 설정
        OrderVO order = new OrderVO();
        order.setOrderNo(orderNo);
        order.setId(id); // 로그인된 사용자 ID 추가
        
     // 모델에 데이터 추가
        model.addAttribute("order", order); // 주문 정보
        model.addAttribute("selectedItems", items);
        model.addAttribute("discount", discount);
        model.addAttribute("finalAmount", finalAmount);
     
        log.info("Order Form loaded with OrderNo: " + orderNo);
        // JSP 파일 이름 리턴 (예: orderForm.jsp)
        System.out.println("orderForm()----");
        return "order/orderForm";
        
    }


 // 주문 저장 (주문하기 -> 주문정보 저장)
    @PostMapping("/save")
    public String saveOrder(
    		@ModelAttribute OrderVO order, 
    		@RequestParam(value = "items", required = false, defaultValue = "[]") String itemsEncoded,
    		@RequestParam(value = "couponCode", required = false) String couponCode,
            @RequestParam(value = "discount", required = false, defaultValue = "0.0") double discount,
            @RequestParam(value = "finalAmount", required = false, defaultValue = "0.0") double finalAmount) {
        try {
            // URL 디코딩 및 JSON 변환
            ObjectMapper objectMapper = new ObjectMapper();
            String itemsJson = URLDecoder.decode(itemsEncoded, "UTF-8");

            // JSON 문자열 설정
            if (itemsJson == null || itemsJson.isEmpty()) {
                itemsJson = "[]"; // 기본값 설정: 빈 배열
            }
            List<Map<String, Object>> items = objectMapper.readValue(itemsJson, List.class);

         // OrderVO에 데이터 설정
            order.setItems(itemsJson);       // JSON 문자열로 설정
            order.setDiscount(discount);     // 할인 금액 설정
            order.setTotalPrice(finalAmount); // 최종 결제 금액 설정
            order.setOrderDate(LocalDateTime.now()); // 현재 시간 설정
         // 쿠폰 코드 설정
            order.setCode(couponCode != null ? couponCode : "NO_COUPON");
         
         // 상태 및 기타 기본값 설정
            order.setOrderStatus("주문완료"); // 주문 상태 기본값 설정

            // 주문 저장
            String orderNo = orderService.saveOrder(order);
            log.info("Order Saved Successfully: " + order);

         // 저장 후 Summary 페이지로 리다이렉트
            return "redirect:/order/summary.do?orderNo=" + orderNo;
        } catch (Exception e) {
            log.error("Error while saving order: ", e);
            throw new RuntimeException("주문 저장 중 오류가 발생했습니다.");
        }
    }
    
    @GetMapping("/summary.do")
    public String showOrderSummary(Model model, @RequestParam("orderNo") String orderNo) {
    	OrderVO order = orderService.getOrderByOrderNo(orderNo); // 주문 데이터 가져오기
    	if (order == null) {
            throw new RuntimeException("Order not found for orderNo: " + orderNo);
        }

        // items를 JSON 문자열에서 Java 객체로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            List<Map<String, Object>> itemList = objectMapper.readValue(order.getItems(), List.class);
            model.addAttribute("itemList", itemList);
        } catch (Exception e) {
            log.error("Failed to parse items JSON", e);
            model.addAttribute("itemList", List.of()); // 빈 리스트 설정
        }

        model.addAttribute("order", order);
        return "order/summary";
    }

    
    
    // 주문 상태 업데이트 (결제 완료)
    @PostMapping("/updateStatus")
    public String updateOrderStatus(@RequestParam int orderNo, @RequestParam String status) {
        orderService.updateOrderStatus(orderNo, status);
        return "주문 상태가 " + status + "로 업데이트되었습니다.";
    }

    // 주문 삭제 (결제 취소)
    @DeleteMapping("/delete/{orderNo}")
    public String deleteOrder(@PathVariable int orderNo) {
        orderService.deleteOrder(orderNo);
        return "주문이 삭제되었습니다.";
    }
    
    /**
     * 주문번호 생성 메서드: 시간 + 아이디 조합
     * @param userId 사용자 아이디
     * @return 고유한 주문번호
     */
    private String generateOrderNo(String userId) {
        // 현재 시간 가져오기
        LocalDateTime now = LocalDateTime.now();
        // 시간 형식 지정 (예: yyyyMMddHHmmss)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String orderTime = now.format(formatter);

        // 주문번호 생성 (시간 + 아이디)
        return orderTime + "-" + userId;
    }
}
