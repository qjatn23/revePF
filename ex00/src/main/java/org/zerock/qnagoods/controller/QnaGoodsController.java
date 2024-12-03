package org.zerock.qnagoods.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.member.vo.LoginVO;
import org.zerock.qna.service.QnaService;
import org.zerock.qna.vo.QnaVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/qnagoods")
public class QnaGoodsController {

	//서비스 선언
	@Qualifier("qnaServiceImpl")
	@Autowired
	private QnaService service;
	
	
	// 파일 저장 경로
	String path = "/upload/qnagoods";
	
	// QNA 리스트
	@SuppressWarnings("unused")
	@GetMapping("/list.do")
	public String list(Model model,QnaVO vo,String id, HttpServletRequest request,HttpSession session) throws Exception {
		
		PageObject pageObject = PageObject.getInstance(request);
		
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		if (loginVO == null) {
			model.addAttribute("id", "");
		}
		else {
			model.addAttribute("id", loginVO.getId());
			model.addAttribute("gradeNo", loginVO.getGradeNo());
		}
		
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		
		
		
		return "qnagoods/list";
	}
	
	
}
