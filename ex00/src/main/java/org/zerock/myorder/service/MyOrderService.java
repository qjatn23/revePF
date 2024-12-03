package org.zerock.myorder.service;

import java.util.List;

import org.zerock.myorder.vo.MyOrderVO;
import org.zerock.util.page.PageObject;

public interface MyOrderService {
	
	// 주문목록 조회
	public List<MyOrderVO> list(String user_id, PageObject pageObject);
    
}
