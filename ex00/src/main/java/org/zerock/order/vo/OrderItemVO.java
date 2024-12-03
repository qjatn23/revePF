package org.zerock.order.vo;

import lombok.Data;

@Data
public class OrderItemVO {
	    private Long productId; // 상품번호
	    private String productName; // 상품명
	    private Integer quantity; // 수량
	    private Double price; // 가격
	    private Double totalPrice; // 총 금액 (수량 * 가격)
	    
}
