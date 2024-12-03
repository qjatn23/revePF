package org.zerock.order.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.order.mapper.OrderMapper;
import org.zerock.order.vo.OrderVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public String saveOrder(OrderVO order) {
        try {
            // 주문번호가 없을 경우 생성
            if (order.getOrderNo() == null || order.getOrderNo().isEmpty()) {
                order.setOrderNo(generateOrderNo(order.getId()));
            }

            // items 값 검증 및 기본값 설정
            if (order.getItems() == null || order.getItems().isEmpty()) {
                order.setItems("[]"); // 기본값: 빈 배열
            }

            // 주문 정보 저장
            orderMapper.insertOrder(order);

            log.info("Order saved successfully. OrderNo: " + order.getOrderNo());
            return order.getOrderNo(); // 저장된 주문번호 반환
        } catch (Exception e) {
            log.error("Error while saving order: ", e);
            throw new RuntimeException("주문 저장 중 오류 발생", e);
        }
    }

    @Override
    public void updateOrderStatus(int orderNo, String status) {
    	try {
            orderMapper.updateOrderStatus(orderNo, status);
            log.info("Order status updated successfully. OrderNo: " + orderNo + ", Status: " + status);
        } catch (Exception e) {
            log.error("Error while updating order status: " + e.getMessage(), e);
            throw new RuntimeException("Order 상태 업데이트 중 오류 발생", e);
        }
    }

    @Override
    public void deleteOrder(int orderNo) {
        // 주문 삭제
        orderMapper.deleteOrder(orderNo);
    }
    
    @Override
    public OrderVO getOrderByOrderNo(String orderNo) {
        // 주문 번호로 주문 조회
        return orderMapper.selectOrderByOrderNo(orderNo);
    }
    
    /**
     * 주문번호 생성 메서드: 주문시간 + 아이디 조합
     * @param userId 사용자 아이디
     * @return 생성된 주문번호
     */
    private String generateOrderNo(String userId) {
        // 현재 시간 가져오기
        LocalDateTime now = LocalDateTime.now();
        // 시간 형식 지정 (YYYYMMDDHHMMSS)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String orderTime = now.format(formatter);

        // 주문번호 생성 (주문시간-아이디)
        return orderTime + "-" + userId;
    }
}