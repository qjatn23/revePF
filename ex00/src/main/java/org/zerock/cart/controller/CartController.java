package org.zerock.cart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.cart.service.CartService;
import org.zerock.cart.vo.CartDTO;
import org.zerock.cart.vo.CartVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.mycoupon.vo.MyCouponVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

	@Autowired
	@Qualifier("cartServiceImpl")
    private CartService cartService;

	// 장바구니 리스트 조회
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request, HttpSession session) {
        log.info("list() =======");

        // 세션에서 로그인된 사용자 아이디를 가져오기 (예: "id"라는 키로 저장된 경우)
         LoginVO loginVO = (LoginVO) session.getAttribute("login");  // 로그인된 사용자 아이디
        
         String id = loginVO.getId();
         
        if (id == null) {
            // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트하거나 적절한 메시지 처리
            log.warn("사용자가 로그인되지 않았습니다.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트 (예시)
        }
        
        // 페이지 처리를 위한 객체 생성
        PageObject pageObject = PageObject.getInstance(request);
        
        // 장바구니 목록을 가져오되, 로그인된 사용자와 일치하는 항목만 가져오기
        List<CartVO> cartList = cartService.list(pageObject, id);
        
        // 모델에 장바구니 리스트와 페이지 정보를 추가
        model.addAttribute("list", cartList);
        model.addAttribute("pageObject", pageObject);
        
        
        String user_id = loginVO.getId();
        // MyCoupon 목록 가져오기
        List<MyCouponVO> myCouponList = cartService.myCouponList(user_id, pageObject);
        // 모델에 쿠폰 리스트 추가
        model.addAttribute("myCouponList", myCouponList);  
        

        log.info("cart list.do --- end ");

        return "cart/list";
    }
	
    // 장바구니에 상품 추가 (중복 체크 로직 포함)
    @PostMapping("/add")  // '/cart/add' 경로에 대해 POST 요청을 처리
    public String addToCart(
        @RequestParam("goods_no") int goodsNo,
        @RequestParam("goods_name") String goodsName,
        @RequestParam("image_name") String imageName,
        @RequestParam("sale_price") int salePrice,
        @RequestParam("delivery_charge") int deliveryCharge,
        @RequestParam("quantity") int quantity,
        HttpSession session,
        CartVO vo)  {

        // 로그인 정보 가져오기
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        if (loginVO == null) {
            return "redirect:/member/loginForm.do";  // 로그인되지 않은 상태라면 로그인 페이지로 리다이렉트
        }

        String id = loginVO.getId();

        CartDTO cartDTO = new CartDTO();
        cartDTO.setId(id);
        cartDTO.setGoodsno(goodsNo);
        cartDTO.setGoodsname(goodsName);
        cartDTO.setImagename(imageName);
        cartDTO.setSaleprice(salePrice);
        cartDTO.setDeliverycharge(deliveryCharge);
        cartDTO.setQuantity(quantity);

        cartService.addToCart(cartDTO);
        
        String redirectUrl = (String) session.getAttribute("redirectUrl");
        if (redirectUrl != null) {
            session.removeAttribute("redirectUrl"); // 세션에서 URL 제거
            return "redirect:" + redirectUrl;
        }
	    return "redirect:/goods/list.do";  // 성공 시 success 반환 
	    }
    
 // 장바구니에 상품 추가 (중복 체크 로직 포함)
    @PostMapping("/addrecent")  // '/cart/add' 경로에 대해 POST 요청을 처리
    public @ResponseBody String addToCartRecent(
        @RequestParam("goods_no") int goodsNo,
        @RequestParam("goods_name") String goodsName,
        @RequestParam("image_name") String imageName,
        @RequestParam("sale_price") int salePrice,
        @RequestParam("delivery_charge") int deliveryCharge,
        @RequestParam("quantity") int quantity,
        HttpSession session) {

        // 로그인 정보 가져오기
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        if (loginVO == null) {
            return "redirect:/login";  // 로그인되지 않은 상태라면 로그인 페이지로 리다이렉트
        }

        String id = loginVO.getId();

        CartDTO cartDTO = new CartDTO();
        cartDTO.setId(id);
        cartDTO.setGoodsno(goodsNo);
        cartDTO.setGoodsname(goodsName);
        cartDTO.setImagename(imageName);
        cartDTO.setSaleprice(salePrice);
        cartDTO.setDeliverycharge(deliveryCharge);
        cartDTO.setQuantity(quantity);

        try {
            // 장바구니에 상품 추가
            cartService.addToCart(cartDTO);
            return "success";  // 성공 시 success 반환
        } catch (RuntimeException e) {
            return "failure";  // 실패 시 failure 반환
        }
    }

    // 장바구니에 여성 상품 추가
    @PostMapping("/addWoman")
    public @ResponseBody String addToCartWoman(
        @RequestParam("woman_no") int womanNo,
        @RequestParam("woman_name") String womanName,
        @RequestParam("woman_image_name") String imageName,
        @RequestParam("sale_price") int salePrice,
        @RequestParam("delivery_charge") int deliveryCharge,
        @RequestParam("quantity") int quantity,
        HttpSession session) {

        // 로그인 정보 가져오기
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            return "redirect:/login";  // 로그인되지 않은 상태라면 로그인 페이지로 리다이렉트
        }

        String id = loginVO.getId();

        // 장바구니에 추가할 여성 상품 정보
        CartDTO cartDTO = new CartDTO();
        cartDTO.setId(id);
        cartDTO.setGoodsno(womanNo); // 여성 상품 번호
        cartDTO.setGoodsname(womanName); // 여성 상품 이름
        cartDTO.setImagename(imageName); // 여성 상품 이미지
        cartDTO.setSaleprice(salePrice); // 여성 상품 가격
        cartDTO.setDeliverycharge(deliveryCharge); // 배송비
        cartDTO.setQuantity(quantity); // 수량

        try {
            // 장바구니에 여성 상품 추가
            cartService.addToCart(cartDTO);
            return "success";  // 성공 시 success 반환
        } catch (RuntimeException e) {
            return "failure";  // 실패 시 failure 반환
        }
    }


    // 장바구니에 브랜드 상품 추가
    @PostMapping("/addBrand")
    public @ResponseBody String addToCartBrand(
        @RequestParam("brands_no") int brandsNo,
        @RequestParam("brands_name") String brandsName,
        @RequestParam("brands_image_name") String imageName,
        @RequestParam("sale_price") int salePrice,
        @RequestParam("delivery_charge") int deliveryCharge,
        @RequestParam("quantity") int quantity,
        HttpSession session) {

        // 로그인 정보 가져오기
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        // 로그인 상태 확인
        if (loginVO == null) {
            return "redirect:/login"; // 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
        }

        // 로그인 사용자 아이디
        String id = loginVO.getId();

        // CartDTO 객체 생성
        CartDTO cartDTO = new CartDTO();
        cartDTO.setId(id);
        cartDTO.setGoodsno(brandsNo); // 브랜드 상품 번호
        cartDTO.setGoodsname(brandsName); // 브랜드 상품 이름
        cartDTO.setImagename(imageName); // 브랜드 상품 이미지 이름
        cartDTO.setSaleprice(salePrice); // 브랜드 상품 판매가
        cartDTO.setDeliverycharge(deliveryCharge); // 배송비
        cartDTO.setQuantity(quantity); // 수량

        try {
            // 서비스 호출하여 장바구니에 추가
            cartService.addToCart(cartDTO);
            return "success";  // 성공 시 "success" 반환
        } catch (RuntimeException e) {
            return "failure";  // 실패 시 "failure" 반환
        }
    }

 // 선택한 상품들 삭제 처리
 // @RequestMapping(value = "/cart/removeItems", method = RequestMethod.POST)
    @ResponseBody
    @PostMapping(value = "/removeItems",
    		produces = {
    				MediaType.APPLICATION_JSON_UTF8_VALUE
    		})
    public ResponseEntity<Map<String, Object>> removeItems(@RequestBody Map<String, List<Long>> body) {
//    public Map<String, Object> removeItems(@RequestParam("cartNos") List<Long> cartNos) {
        Map<String, Object> response = new HashMap<String, Object>();
        log.info(body);
        List<Long> cartNos = body.get("cartNos");
//        
        try {
            // CartService에서 삭제 처리
            Integer result = cartService.removeItems(cartNos);
            if (result != null && result != 0) response.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        
        return new ResponseEntity<Map<String,Object>>(response, HttpStatus.OK);
//      return response;
    }

    // 장바구니 비우기
    @PostMapping("/clear")
    public String clearCart() {
        cartService.clearCart();
        return "redirect:/cart/list.do"; // 장바구니 비운 후 장바구니 목록으로 리다이렉트
    }
	
}
