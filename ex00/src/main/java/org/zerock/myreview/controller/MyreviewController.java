package org.zerock.myreview.controller;


import java.util.List;

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
@RequestMapping("/myreview")
public class MyreviewController {

	@Qualifier("myreviewServiceImpl")
	@Autowired
	private MyreviewService service;
	
	String path = "/upload/myreview";
	
	@GetMapping("/list.do")
	public String myList(HttpServletRequest request, Model model, MyreviewVO vo,HttpSession session) {
		PageObject pageObject = PageObject.getInstance(request);
		// id, gradeNo - session에서 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		String id = loginVO.getId();
		Integer gradeNo = loginVO.getGradeNo();
		model.addAttribute("id", id);
		model.addAttribute("gradeNo", gradeNo);
		// 전체 리스트 가져오기
	    List<MyreviewVO> list = service.list(pageObject);
	    model.addAttribute("list", list);

	    // 조건에 맞는 항목 개수 계산
	    long count = list.stream()
	                     .filter(voItem -> id.equals(voItem.getId()))
	                     .count();
	    model.addAttribute("myPostCount", count);
	    model.addAttribute("pageObject", pageObject);
		
		return "myreview/list";
	}
	
	@GetMapping("/allList.do")
	public String list(HttpServletRequest request, Model model, MyreviewVO vo) {
	    
	    PageObject pageObject = PageObject.getInstance(request);
		
	    model.addAttribute("list", service.list(pageObject));
	    model.addAttribute("pageObject", pageObject);
	    
	    return "myreview/allList";
	}
	
	@GetMapping("/writeForm.do")
	public String writeForm() {
		return "myreview/writeForm";
	}
	@PostMapping("/write.do")
	public String write(MultipartFile imageFile,
			HttpServletRequest request, MyreviewVO vo, HttpSession session, String id) throws Exception {
		
		if (id == null) {
			// 로그인정보 가져와 id 넣기
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			id = loginVO.getId();
			vo.setId(id);
		}
		
		vo.setFilename(FileUtil.upload(path, imageFile, request));
		
		// 비어있을때 들어가는 기본값 -> null로 변경
		if(vo.getFilename().equals("/upload/qna/noImage.jpg")) {
			vo.setFilename(null);
		}
		service.write(vo);
        
		return "redirect:/myreview/allList.do";
	}
	
	// QNA 글보기
		@GetMapping("/view.do")
		public String view(Model model, Long rno, MyreviewVO vo, HttpSession session) {
			
			LoginVO loginVO = (LoginVO) session.getAttribute("login");
			if (loginVO == null) {
				model.addAttribute("id", null);
			}
			else {
				model.addAttribute("id", loginVO.getId());
				model.addAttribute("gradeNo", loginVO.getGradeNo());
			}
			// service 실행후 id, gradeNo - model에 담기 (페이지처리를 위해)
			vo = service.view(rno);
			model.addAttribute("vo", service.view(rno));
			
			return "myreview/view";
		}
	
	// QnA 글수정 폼
		@GetMapping("/updateForm.do")
		public String updateForm(Long rno, Model model, @ModelAttribute(name="pageObject") PageObject pageObject){
			log.info("/myreview/updateForm.do");
			
			// 글 정보 가져와 model에 담기
			model.addAttribute("vo", service.view(rno));
			return "/myreview/updateForm";
		}
		
		@PostMapping("/update.do")
		public String update(MyreviewVO vo, MultipartFile imageFile, HttpServletRequest request,
				PageObject pageObject) throws Exception {
			
				// 파일이 있으면 새파일로, 없으면 기존 파일로
				if (imageFile != null && !imageFile.isEmpty()) {
			        vo.setFilename(FileUtil.upload(path, imageFile, request));
			    } else {
			        // 새 파일이 없으면 기존 파일 경로 유지
			        vo.setFilename(service.view(vo.getRno()).getFilename());
			    }
				
				// 이미지가 없을때 filename = null 로 변경
				if(vo.getFilename().equals("/upload/qna/noImage.jpg")) {
					vo.setFilename(null);
				}
				log.info("=== filename = " + vo.getFilename() + "===========");
				service.update(vo);
				
			return "redirect:/myreview/view.do?rno="+vo.getRno()+"&"+pageObject.getPageQuery();
		}
		
		@PostMapping("/delete.do")
		public String delete(MyreviewVO vo, PageObject pageObject) throws Exception {
			
			service.delete(vo);
			return "redirect:/myreview/allList.do?"+pageObject.getPageQuery();
		}
}
