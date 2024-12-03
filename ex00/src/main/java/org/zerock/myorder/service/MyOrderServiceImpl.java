package org.zerock.myorder.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.myorder.mapper.MyOrderMapper;
import org.zerock.myorder.vo.MyOrderVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("myCouponServiceImpl")
public class MyOrderServiceImpl implements MyOrderService {

    @Autowired    
    private MyOrderMapper mapper;

    // 1. 주문목록 조회
    // PageObject를 이용해 페이징 처리된 장바구니 목록을 반환
    public List<MyOrderVO> list(String user_id, PageObject pageObject){
    	// userId를 기준으로 쿠폰을 조회하도록 SQL 수정
    	log.info("list() 실행 =====");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        return mapper.list(user_id, pageObject);
    }
}