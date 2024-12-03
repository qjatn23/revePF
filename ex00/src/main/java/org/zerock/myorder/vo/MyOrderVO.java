package org.zerock.myorder.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MyOrderVO {

	private String orderNo;          // 주문번호
    private String user_id;           // 사용자 ID
    private String name;    // 배송받는 사람
    private String address;  // 배송지 주소
    private String phoneNumber;      // 연락처
    private double discount;         // 할인 금액
    private double totalPrice;       // 총 결제 금액
    private String items;            // 주문 상품 정보 (JSON 등으로 처리 가능)
    private String couponCode;       // 쿠폰 코드
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderDate;          // 주문일
    private String orderStatus;      // 주문 상태


    @Data
    public static class OrderItem {
        private String name;
        private int quantity;
        private double totalPrice;
    }
}

