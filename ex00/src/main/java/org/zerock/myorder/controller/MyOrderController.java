package org.zerock.myorder.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.member.vo.LoginVO;
import org.zerock.myorder.service.MyOrderService;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/myorder")
public class MyOrderController {

    @Autowired
    @Qualifier("myOrderServiceImpl")
    private MyOrderService service;
    
    @GetMapping("/list.do")
    public String MyOrders(Model model, HttpServletRequest request) {
    	
    	log.info("list() =======");
    	
        // 페이지 객체 생성
        PageObject pageObject = PageObject.getInstance(request);

        // 세션에서 로그인 정보 가져오기
        HttpSession session = request.getSession();
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        String user_id  = loginVO.getId();

        if (user_id == null) {
            log.warn("User is not logged in");
            return "redirect:/member/loginForm.do"; // 로그인 페이지로 리다이렉트
        }

        // 주문 목록 가져오기
        model.addAttribute("list", service.list(user_id, pageObject)); // 사용자 ID를 서비스 메서드에 전달
        model.addAttribute("pageObject", pageObject);
        
        return "myorder/list"; // JSP 파일 경로
    }
}