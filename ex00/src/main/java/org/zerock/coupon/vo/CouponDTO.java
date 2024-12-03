package org.zerock.coupon.vo;

import lombok.Data;

@Data
public class CouponDTO {

	private Long no;
    private String user_id;
    private String code;
    private int is_used;  
}
