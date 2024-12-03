package org.zerock.mycoupon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.zerock.mycoupon.vo.MyCouponVO;
import org.zerock.util.page.PageObject;

@Mapper
public interface MyCouponMapper {

	// 쿠폰 조회
		public Integer getTotalRow(PageObject pageObject); // 쿠폰 리스트처리를 위한 전체 데이터 개수를 가져온다.
		public List<MyCouponVO> list(
				@Param("user_id") String user_id,
				@Param("pageObject") PageObject pageObject);

	// 쿠폰 코드로 쿠폰 정보 가져오기
	    public MyCouponVO getCouponByCode(String code);
	    
	// couponuser 테이블에 쿠폰 정보 저장
	    public void saveCouponUser(
	    		@Param("user_id") String user_id, 
	    		@Param("coupon") MyCouponVO coupon);
	    
	 // 사용자와 쿠폰 코드로 이미 등록된 쿠폰이 있는지 확인
	    public Integer checkUserCoupon(
	    		@Param("user_id") String user_id, 
	    		@Param("code") String code);


}
