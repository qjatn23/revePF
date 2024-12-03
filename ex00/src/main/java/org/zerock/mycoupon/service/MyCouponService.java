package org.zerock.mycoupon.service;

import java.util.List;

import org.zerock.mycoupon.vo.MyCouponVO;
import org.zerock.util.page.PageObject;

public interface MyCouponService {
	
	// 쿠폰 목록 조회
		public List<MyCouponVO> list(String user_id, PageObject pageObject);

	// 쿠폰 인증
	    public boolean validateCoupon(String user_id, String code); 
}
