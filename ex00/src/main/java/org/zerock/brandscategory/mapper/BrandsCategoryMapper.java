package org.zerock.brandscategory.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.brandscategory.vo.BrandsCategoryVO;

@Repository
public interface BrandsCategoryMapper {

	// 1. 카테고리 리스트 조회
	// 대분류 코드에 해당하는 중분류 리스트를 반환
	public List<BrandsCategoryVO> list(@Param("brands_cate_code1")  Integer brands_cate_code1);

	// 2. 카테고리 등록
	// 2-1. 대분류 카테고리 등록
	public Integer writeBig(BrandsCategoryVO vo);

	// 2-2. 중분류 카테고리 등록
	public Integer writeMid(BrandsCategoryVO vo);

	// 3. 카테고리 수정
	// 카테고리 정보를 수정하는 메소드
	public Integer update(BrandsCategoryVO vo);

	// 4. 카테고리 삭제
	// 카테고리를 삭제하는 메소드
	public Integer delete(BrandsCategoryVO vo);
}
