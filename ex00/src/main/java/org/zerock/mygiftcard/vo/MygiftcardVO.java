package org.zerock.mygiftcard.vo;

import lombok.Data;

@Data
public class MygiftcardVO {
    private Long cardId;         // SQL의 CARD_ID와 매핑
    private String cardNumber;   // SQL의 CARD_NUMBER와 매핑 (String으로 변경)
    private int balance;         // SQL의 BALANCE와 매핑
    private String expiryDate;   // SQL의 EXPIRY_DATE와 매핑
    private String status;       // SQL의 STATUS와 매핑
    private String registerDate; // SQL의 REGISTER_DATE와 매핑
    private String userId; // 새로운 필드 추가
}
