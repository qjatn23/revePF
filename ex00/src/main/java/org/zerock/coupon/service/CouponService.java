package org.zerock.coupon.service;

import java.util.List;

import org.zerock.coupon.vo.CouponVO;
import org.zerock.util.page.PageObject;

public interface CouponService {
	
	// 쿠폰 목록 조회
	public List<CouponVO> list(PageObject pageObject);
	
	// 쿠폰 등록
	public Integer write(CouponVO vo);
	
	// 쿠폰삭제
	public void delete(List<Long> selectedCoupons);

    // 사용자 쿠폰 받기
	public void addCouponToUser(CouponVO vo);
	
}
