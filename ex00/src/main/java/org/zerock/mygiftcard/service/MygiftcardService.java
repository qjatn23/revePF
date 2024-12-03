package org.zerock.mygiftcard.service;

import org.zerock.mygiftcard.vo.MygiftcardVO;

import java.util.List;

public interface MygiftcardService {
    Long registerGiftCard(String cardNumber, String userId);

    // 사용 가능한 상품권 조회
    List<MygiftcardVO> getAvailableGiftCards(String userId); // 사용자별 조회 추가

    // 만료된 상품권 조회
    List<MygiftcardVO> getExpiredGiftCards(String userId); // 사용자별 조회 추가

    // 상품권 사용 내역 조회
    List<MygiftcardVO> getGiftCardUsageHistory(String userId); // 사용자별 조회 추가

    // 총 잔액 조회 (사용자 기준)
    int getTotalBalance(String userId); // 사용자 ID 기반

    // 만료 예정 금액 조회 (사용자 기준)
    int getExpiringSoonBalance(String userId); // 사용자 ID 기반
    
    // 만료된 상품권 상태 업데이트
    void updateExpiredGiftCards(String userId);

}

