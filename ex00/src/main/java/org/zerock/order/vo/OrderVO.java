package org.zerock.order.vo;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {
	
    private String orderNo; // 주문번호
    private String id; // 주문자 ID
    private String name; // 배송받는 사람
    private String address; // 배송지 주소
    private String phoneNumber; // 연락처
    private double discount = 0.0; // 할인 금액
    private double totalPrice = 0.0; // 최종 결제 금액
    private String items= "[]"; // 상품 목록
    private String code; // 쿠폰 코드
    private LocalDateTime orderDate; // 주문 날짜
    private String orderStatus = "대기"; // 주문 상태
    
    // 상품 정보(상품번호, 상품명, 수량 등)을 담을 List
    private List<OrderItemVO> orderItems;
    


}
