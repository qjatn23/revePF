package org.zerock.coupon.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.coupon.service.CouponService;
import org.zerock.coupon.vo.CouponVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/coupon")
public class CouponController {

    @Autowired
    @Qualifier("couponServiceImpl")
    private CouponService service;

    // 쿠폰 리스트 보기
    @GetMapping("/list.do")
    public String listCoupons(Model model, HttpServletRequest request) {
    	
    	log.info("list() =======");
    	
    	PageObject pageObject = PageObject.getInstance(request);

    	model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		
        return "coupon/list";
    }
    
    // 쿠폰 등록 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
    	log.info("writeForm() =======");
		//service.write();
		return "coupon/write";
    }

    // 쿠폰 등록 처리
    @PostMapping("/write.do")
    public String write(CouponVO vo, RedirectAttributes rttr) {
    	log.info("write() =======");
		
		service.write(vo);
		
		rttr.addFlashAttribute("msg", "일반게시판에 글등록이 되었습니다.");
		
		return "redirect:list.do";
    }
    
    // 쿠폰 삭제 처리
    @PostMapping("/deleteCoupons.do")
    @ResponseBody
    public String deleteCoupons(@RequestParam("selectedCoupons") List<Long> selectedCoupons) {
        // 선택된 쿠폰 리스트를 서비스에 전달하여 삭제
        try {
            service.delete(selectedCoupons);
            return "삭제되었습니다.";
        } catch (Exception e) {
            e.printStackTrace();
            return "삭제 실패";
        }
    }

//    // 사용자에게 쿠폰 추가
    @PostMapping("/addCouponToUser")
    public String addCouponToUser(@RequestParam("selectedCoupons") String[] selectedCoupons, 
    		HttpServletRequest request, 
    		HttpSession session) {
    	
    	// 세션에서 로그인된 사용자 아이디를 가져오기 (예: "id"라는 키로 저장된 경우)
        LoginVO loginVO = (LoginVO) session.getAttribute("login");  // 로그인된 사용자 아이디
       
        String id = loginVO.getId();
        
       if (id == null) {
           // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트하거나 적절한 메시지 처리
           log.warn("사용자가 로그인되지 않았습니다.");
           return "redirect:/login"; // 로그인 페이지로 리다이렉트 (예시)
       }

        // 쿠폰 정보를 저장할 CouponVO 객체 생성
       
        for (String code : selectedCoupons) {
            CouponVO vo = new CouponVO();
            vo.setUser_id(id);   // 로그인한 사용자 ID 설정
            vo.setCode(code);  // 선택한 쿠폰 ID 설정

            // 서비스 호출하여 쿠폰을 사용자 쿠폰함에 저장
            service.addCouponToUser(vo);
            
        }

        // 쿠폰 저장 후 쿠폰 리스트 페이지로 리다이렉트
        return "redirect:/coupon/list.do";  
    }
}
