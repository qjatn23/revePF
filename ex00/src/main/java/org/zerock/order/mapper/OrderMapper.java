package org.zerock.order.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.order.vo.OrderVO;


@Mapper
public interface OrderMapper {
   
	// 주문 삽입
	void insertOrder(OrderVO order); 
	
	// 주문 상태 업데이트
    void updateOrderStatus(int orderNo, String status); 
    
    // 주문 삭제
    void deleteOrder(int orderNo); 
    
    // 주문 번호로 주문 조회
    OrderVO selectOrderByOrderNo(String orderNo);
}
