package org.zerock.order.service;

import org.zerock.order.vo.OrderVO;

public interface OrderService {
	
	// 주문 저장
	String saveOrder(OrderVO order); 
	
	// 주문 상태 업데이트
    void updateOrderStatus(int orderNo, String status); 
    
    // 주문 삭제
    void deleteOrder(int orderNo);

    // 주문 확인(결제하기 직전)
	OrderVO getOrderByOrderNo(String orderNo);
    
}
