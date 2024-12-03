package org.zerock.myreviewgoods.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.myreview.service.MyreviewService;
import org.zerock.myreview.vo.MyreviewVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;
import org.zerock.woman.vo.WomanVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/myreviewgoods")
public class MyreviewGoodsController {

	@Qualifier("myreviewServiceImpl")
	@Autowired
	private MyreviewService service;
	
	String path = "/upload/myreview";
	
	
	@GetMapping("/list.do")
	public String list(HttpServletRequest request, Model model, MyreviewVO vo) {
	    
	    PageObject pageObject = PageObject.getInstance(request);
		
	    model.addAttribute("list", service.list(pageObject));
	    model.addAttribute("pageObject", pageObject);
	    
	    return "myreviewgoods/list";
	}
	
}
