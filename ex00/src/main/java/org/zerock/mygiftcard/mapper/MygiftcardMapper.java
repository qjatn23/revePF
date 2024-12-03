package org.zerock.mygiftcard.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.mygiftcard.vo.MygiftcardVO;
import java.util.List;

public interface MygiftcardMapper {

    // 상품권 삽입
    Long insertGiftCard(MygiftcardVO giftCard);

    // 특정 상품권 조회 (상품권 번호로 검색)
    MygiftcardVO findGiftCardByNumber(String cardNumber);

    // 상품권 상태 업데이트
    int updateGiftCardStatus(MygiftcardVO giftCard);

    // 만료된 상품권 상태 업데이트
    int updateExpiredGiftCards(@Param("userId") String userId);

    // 사용 가능한 상품권 조회 (사용자 기준 추가)
    List<MygiftcardVO> getAvailableGiftCards(@Param("userId") String memberId);

    // 만료된 상품권 조회 (사용자 기준 추가)
    List<MygiftcardVO> getExpiredGiftCards(@Param("userId") String userId);

    // 상품권 사용 내역 조회 (사용자 기준 추가)
    List<MygiftcardVO> selectGiftCardUsageHistoryByUser(@Param("userId") String userId);

    // 사용자별 사용 가능한 상품권의 총 잔액 계산
    Integer sumBalanceByStatus(@Param("status") String status, @Param("userId") String userId); // 변경됨

    // 사용자별 만료 예정 상품권의 총 잔액 계산
    Integer sumExpiringSoonBalance(@Param("userId") String userId); // 변경됨
}
