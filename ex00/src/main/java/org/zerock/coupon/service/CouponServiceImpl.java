package org.zerock.coupon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.coupon.mapper.CouponMapper;
import org.zerock.coupon.vo.CouponVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

import java.util.List;

@Service
@Log4j
@Qualifier("couponServiceImpl")
public class CouponServiceImpl implements CouponService {

	@Autowired
    private CouponMapper mapper;

    // 1. 쿠폰함 조회
    // PageObject를 이용해 페이징 처리된 장바구니 목록을 반환
    public List<CouponVO> list(PageObject pageObject){
    	log.info("list() 실행 =====");
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        return mapper.list(pageObject);
    }
    
    // 2. 쿠폰 등록
	public Integer write(CouponVO vo) {
		Integer result = mapper.write(vo); 
		log.info("write() 실행 =====");
		return result;
	}

	// 3. 쿠폰 삭제
	public void delete(List<Long> selectedCoupons) {
		log.info("delete() 실행 =====");
		// Mapper를 호출하여 선택된 쿠폰들을 삭제합니다.
        for (Long couponId : selectedCoupons) {
            mapper.delete(couponId);
        }
	}
	
	// 4. 사용자 쿠폰함에 추가
	public void addCouponToUser(CouponVO vo) {  // CouponDTO를 인자로 받아 처리
		log.info("addCouponToUser() 실행 =====");
		mapper.addCouponToUser(vo);  // Mapper 호출하여 쿠폰함에 상품 추가
	}
	
}
    
    

