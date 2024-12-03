package org.zerock.myorder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.zerock.myorder.vo.MyOrderVO;
import org.zerock.util.page.PageObject;

@Mapper
public interface MyOrderMapper {
	
	// 주문목록 조회
	public Integer getTotalRow(PageObject pageObject); // 쿠폰 리스트처리를 위한 전체 데이터 개수를 가져온다.
	public List<MyOrderVO> list(
			@Param("user_id") String user_id,
			@Param("pageObject") PageObject pageObject);
}