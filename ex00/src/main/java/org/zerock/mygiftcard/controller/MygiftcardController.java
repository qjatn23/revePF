package org.zerock.mygiftcard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import org.zerock.mygiftcard.service.MygiftcardService;
import org.zerock.mygiftcard.vo.MygiftcardVO;

@Log4j
@Controller
@RequestMapping("/mygiftcard")
public class MygiftcardController {

    @Autowired
    private MygiftcardService mygiftcardService;

    /**
     * 상품권 목록 페이지
     */
    @GetMapping("/list.do")
    public String listPage(Model model, HttpSession session) {
        // 세션에서 memberId 가져오기
        String memberId = (String) session.getAttribute("memberId");
        log.info("상품권 페이지 요청 - 세션에 저장된 memberId: " + memberId);

        // 사용자 ID 확인
        if (memberId == null) {
            return "redirect:/member/loginForm.do"; // 로그인 페이지로 리다이렉트
        }

        try {
        	// 만료된 상품권 상태 업데이트
            mygiftcardService.updateExpiredGiftCards(memberId);
            // 사용 가능한 상품권 조회
            List<MygiftcardVO> availableCards = mygiftcardService.getAvailableGiftCards(memberId);
            // 만료된 상품권 조회
            List<MygiftcardVO> expiredCards = mygiftcardService.getExpiredGiftCards(memberId);
            // 총 잔액 계산
            int totalBalance = mygiftcardService.getTotalBalance(memberId);
            // 만료 예정 금액 계산
            int expiringSoonBalance = mygiftcardService.getExpiringSoonBalance(memberId);

            // 모델에 데이터 추가
            model.addAttribute("availableCards", availableCards);
            model.addAttribute("expiredCards", expiredCards);
            model.addAttribute("totalBalance", totalBalance);
            model.addAttribute("expiringSoonBalance", expiringSoonBalance);
            model.addAttribute("loggedInUser", memberId); // 추가

        } catch (Exception e) {
            log.error("상품권 목록 로드 중 오류 발생: ", e);
            model.addAttribute("errorMessage", "상품권 정보를 불러오는 중 오류가 발생했습니다.");
        }
        return "mygiftcard/list";
    }

    @PostMapping("/register")
    public String registerGiftCard(
        @RequestParam("cardNumber") String cardNumber,
        HttpSession session,
        RedirectAttributes redirectAttributes) {

        String memberId = (String) session.getAttribute("memberId");
        log.info("상품권 등록 요청 - 카드번호: " + cardNumber + ", 사용자 ID: " + memberId);

        if (memberId == null) {
            return "redirect:/member/loginForm.do"; // 로그인 페이지로 리다이렉트
        }

        try {
            // 서비스 호출로 상품권 등록
            Long generatedCardId = mygiftcardService.registerGiftCard(cardNumber, memberId);

            // 성공 메시지 추가
            redirectAttributes.addFlashAttribute("successMessage", 
                "상품권이 성공적으로 등록되었습니다! 생성된 상품권 ID: " + generatedCardId);
        } catch (IllegalArgumentException e) {
            log.error("상품권 등록 실패 - 중복된 상품권 번호: ", e);
            redirectAttributes.addFlashAttribute("errorMessage", "이미 등록된 상품권 번호입니다.");
        } catch (Exception e) {
            log.error("상품권 등록 실패: ", e);
            redirectAttributes.addFlashAttribute("errorMessage", "상품권 등록 중 오류가 발생했습니다.");
        }

        return "redirect:/mygiftcard/list.do";
    }
}