package org.zerock.mycoupon.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.member.vo.LoginVO;
import org.zerock.mycoupon.service.MyCouponService;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mycoupon")
public class MyCouponController {
	
	@Autowired
    @Qualifier("myCouponServiceImpl")
    private MyCouponService service;

	@GetMapping("/list.do")
	public String MyCoupons(Model model, HttpServletRequest request) {
    	
    	log.info("list() =======");
    	
    	PageObject pageObject = PageObject.getInstance(request);
    	
    	 // 세션에서 로그인된 사용자 ID를 가져옴
        HttpSession session = request.getSession();
        // 세션에서 로그인된 사용자 아이디를 가져오기 (예: "id"라는 키로 저장된 경우)
        LoginVO loginVO = (LoginVO) session.getAttribute("login");  // 로그인된 사용자 아이디
       
        String user_id = loginVO.getId();

        if (user_id == null) {
            log.warn("User is not logged in");
            return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }
        
        model.addAttribute("list", service.list(user_id, pageObject)); // 사용자 ID를 서비스 메서드에 전달
        model.addAttribute("pageObject", pageObject);
		
	    return "mycoupon/list";
	}
	
	// 쿠폰번호 인증 후 데이터 처리 및 보여주기
	// /mycoupon/validate URL을 처리하는 메서드
	@PostMapping(value = "/validate.do",
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
    @ResponseBody
    public ResponseEntity<Map<String, Object>> validateCoupon(@RequestParam("code") String code, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        LoginVO loginVO = (LoginVO) session.getAttribute("login");  // 로그인된 사용자 아이디
        
        String user_id = loginVO.getId();
        
        try {
            // 쿠폰번호 인증 및 데이터베이스 저장
            boolean isValid = service.validateCoupon(user_id, code);
            
            log.info("isValid : " + isValid);
            
            if (isValid) {
                response.put("status", "success");
            } else {
                response.put("status", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
        }
        
        log.info(response);
        
        return new ResponseEntity<Map<String,Object>>(response, HttpStatus.OK);
    }
}
