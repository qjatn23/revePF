package org.zerock.mycoupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.mycoupon.mapper.MyCouponMapper;
import org.zerock.mycoupon.vo.MyCouponVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("myCouponServiceImpl")
public class MyCouponServiceImpl implements MyCouponService {

	@Autowired
    private MyCouponMapper mapper;

    // 1. 쿠폰함 조회
    // PageObject를 이용해 페이징 처리된 장바구니 목록을 반환
    public List<MyCouponVO> list(String user_id, PageObject pageObject){
    	// userId를 기준으로 쿠폰을 조회하도록 SQL 수정
    	log.info("list() 실행 =====");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        return mapper.list(user_id, pageObject);
    }
    
    // 2. 쿠폰 코드로 저장하기
    @Transactional
    public boolean validateCoupon(String user_id, String code) {
        // 1. coupon 테이블에서 쿠폰번호로 데이터 조회
        MyCouponVO coupon = mapper.getCouponByCode(code);
        System.out.println("조회된 쿠폰: " + coupon);  // 로그로 출력
        
        if (coupon != null) {
        	// 2. 쿠폰이 이미 존재하면 추가하지 않음
            // 예를 들어, coupon_user 테이블에 이미 존재하는 쿠폰인지 확인하는 로직 추가
            Integer existingCoupon = mapper.checkUserCoupon(user_id, code);
            System.out.println("이미 등록된 쿠폰 갯수: " + existingCoupon);  // 로그로 출력
            
            if (existingCoupon > 0) {
                return false; // 이미 쿠폰이 등록되어 있다면 false 반환
            }
            // 3.쿠폰번호가 존재하면 coupon_user 테이블에 저장
            mapper.saveCouponUser(user_id, coupon);
            return true;
        }
        return false;
    }
}
