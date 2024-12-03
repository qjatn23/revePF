package org.zerock.mygiftcard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.mygiftcard.mapper.MygiftcardMapper;
import org.zerock.mygiftcard.vo.MygiftcardVO;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import lombok.extern.log4j.Log4j;

import java.util.List;

@Log4j
@Service
public class MygiftcardServiceImpl implements MygiftcardService {

    @Autowired
    private MygiftcardMapper mygiftcardMapper;

    @Override
    public Long registerGiftCard(String cardNumber, String userId) {
        // 만료된 상품권 상태 업데이트 - userId를 전달
        updateExpiredGiftCards(userId);

        MygiftcardVO giftCard = mygiftcardMapper.findGiftCardByNumber(cardNumber);

        if (giftCard == null) {
            throw new IllegalArgumentException("해당 상품권 번호는 존재하지 않습니다.");
        }
        if (!"UNREGISTERED".equals(giftCard.getStatus())) {
            throw new IllegalArgumentException("이미 등록된 상품권 번호입니다.");
        }

        // 만료된 상품권 체크
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date expiryDate = sdf.parse(giftCard.getExpiryDate());
            if (expiryDate.before(new Date())) {
                throw new IllegalArgumentException("만료된 상품권은 등록할 수 없습니다.");
            }
        } catch (ParseException e) {
            throw new IllegalArgumentException("날짜 형식 변환 중 오류가 발생했습니다: " + giftCard.getExpiryDate(), e);
        }

        giftCard.setStatus("AVAILABLE");
        giftCard.setUserId(userId); // USER_ID 설정

        int updatedRows = mygiftcardMapper.updateGiftCardStatus(giftCard);
        if (updatedRows == 0) {
            throw new IllegalStateException("상태 업데이트에 실패했습니다.");
        }

        return giftCard.getCardId();
    }

    @Override
    public void updateExpiredGiftCards(String userId) {
        if (userId == null || userId.isEmpty()) {
            throw new IllegalArgumentException("userId는 null이 될 수 없습니다."); // 강제 조건 추가
        }
        int updatedRows = mygiftcardMapper.updateExpiredGiftCards(userId); // userId 전달
        log.info("만료된 상품권 상태 업데이트 완료 - 업데이트된 행 수: " + updatedRows);
    }

    @Override
    public List<MygiftcardVO> getAvailableGiftCards(String userId) {
        return mygiftcardMapper.getAvailableGiftCards(userId);
    }

    @Override
    public List<MygiftcardVO> getExpiredGiftCards(String userId) {
        return mygiftcardMapper.getExpiredGiftCards(userId);
    }

    @Override
    public List<MygiftcardVO> getGiftCardUsageHistory(String userId) {
        return mygiftcardMapper.selectGiftCardUsageHistoryByUser(userId);
    }

    @Override
    public int getTotalBalance(String userId) {
        Integer balance = mygiftcardMapper.sumBalanceByStatus("AVAILABLE", userId);
        return balance != null ? balance : 0; // null일 경우 0 반환
    }

    @Override
    public int getExpiringSoonBalance(String userId) {
        Integer balance = mygiftcardMapper.sumExpiringSoonBalance(userId);
        return balance != null ? balance : 0; // null일 경우 0 반환
    }
}
