package org.zerock.coupon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.coupon.vo.CouponVO;
import org.zerock.util.page.PageObject;

@Mapper
public interface CouponMapper {

	
    // 쿠폰 조회
	public Integer getTotalRow(PageObject pageObject); // 쿠폰 리스트처리를 위한 전체 데이터 개수를 가져온다.
	public List<CouponVO> list(PageObject pageObject);

	// 사용자 쿠폰 받기
	public void addCouponToUser(CouponVO vo);  // 반환 타입을 void로 수정

	// 쿠폰등록하기
    public Integer write(CouponVO vo);
    
    // 쿠폰삭제하기
    public void delete(Long couponId);


}
