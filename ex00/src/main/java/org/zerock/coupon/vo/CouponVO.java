package org.zerock.coupon.vo;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CouponVO {
	
    private Long no;
    private String code;
    private String name;
    private int quantity;  
    private String discount_type; // PERCENT or AMOUNT
    private BigDecimal discount_value; 
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date valid_from;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date valid_until;
    
    //사용자 쿠폰함에 쿠폰을 넣기위한 객체 선언
    private String user_id;  // 사용자 ID

}
