<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 데이터는 DispatcherServlet에 담겨있다.(request) -->

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- 결제 연동 처리를 위한 iamport 라이브러리 삽입 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	
	<!-- datepicker: jquery는 bootstrap에서 정의한 라이브러리 사용 -->
	<link rel="stylesheet"
		href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="/resources/styles/reset.css?after">
	<link rel="stylesheet" href="/resources/styles/common.css?after">
	<link rel="stylesheet" href="/resources/styles/root.css?after">
	<link rel="stylesheet" href="/resources/styles/main.css?after">
	<link rel="stylesheet" href="/resources/styles/reponsive.css?after">

	<title>장바구니 리스트</title>
	
<style type="text/css">
    /* 전체 페이지 배경과 텍스트 스타일 */
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f9; /* 부드러운 회색 배경 */
        color: #333; /* 텍스트 색상 */
        line-height: 1.6;
    }

    /* 장바구니 컨테이너 */
    .cart-container {
        width: 90%;
        max-width: 1200px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* 헤더 부분 */
    h1 {
        font-size: 2rem;
        color: #007BFF;
        margin-bottom: 20px;
        margin-top: 60px;
        font-weight: bold;
        text-align: center;
    }

    .header-row {
        font-weight: bold;
        background-color: #f7f7f7;
        padding: 15px;
        text-align: center;
        border-radius: 8px;
        margin-bottom: 20px;
    }

    /* 장바구니 항목 스타일 */
	.cart-item {
	    display: flex;
	    align-items: center;
	    justify-content: space-between; /* 항목들 간의 공간을 균등하게 배치 */
	    padding: 10px;
	    margin: 10px 0;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    background-color: #fafafa;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	}
	/* 항목 텍스트 스타일 */
	.cart-item .text-center {
	    text-align: center; /* 항목의 텍스트 중앙 정렬 */
	}

    /* 수량 입력 스타일 */
	.cart-item input[type="number"] {
	    width: 60px;
	    padding: 5px;
	    border-radius: 4px;
	    border: 1px solid #ccc;
	    text-align: center;
	}

    /* 상품 이미지 스타일 */
    .cart-item img {
        width: 60px;
        height: 60px;
        border-radius: 10%;
        object-fit: cover;
        box-shadow: 0 4px 6px rgba(0, 123, 255, 0.2);
        margin-left: 50px;
    }

    /* 상품명, 가격, 수량 등 스타일 */
    .cart-item .item-name,
    .cart-item .item-price,
    .cart-item .total-price {
        font-size: 1rem;
        font-weight: bold;
        color: #333;
    }

    .cart-item .item-price {
        color: #black;
    }


    /* 수량 입력 필드 스타일 */
    .cart-item input[type="number"] {
        width: 60px;
        padding: 8px;
        border-radius: 4px;
        border: 1px solid #ccc;
        text-align: center;
        margin-left: 10px;
    }

    /* 결제 버튼 스타일 */
	.checkout-btn {
	    display: block;
	    width: 250px; /* 버튼의 너비를 250px로 지정 (원하는 크기로 조정 가능) */
	    padding: 12px 20px; /* 좌우 패딩을 줄여서 버튼 크기를 줄임 */
	    background-color: black; /* 기본 파랑색 배경 */
	    color: white;
	    font-size: 18px;
	    font-weight: bold;
	    border: none;
	    border-radius: 8px;
	    cursor: pointer;
	    transition: background-color 0.3s, transform 0.2s ease;
	    box-shadow: 0 4px 6px rgba(0, 123, 255, 0.2);
	    text-transform: uppercase;
	    letter-spacing: 1px;
	    margin: 0 auto; /* 수평으로 가운데 정렬 */
	}

	/* 호버 시 버튼 스타일 */
	.checkout-btn:hover {

	    transform: translateY(-2px); /* 살짝 위로 떠오르는 효과 */
	}
	
	/* 체크된 상태일 때 버튼 색상 */
	.checkout-btn.checked {
	    background-color: #333; /* 검은색 배경 */
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* 더 강한 그림자 */
	}
	
	/* 체크된 상태에서 호버 시 */
	.checkout-btn.checked:hover {
	    background-color: #444; /* 조금 더 어두운 검은색 */
	    transform: translateY(-2px); /* 버튼을 위로 올리는 효과 */
	}
	
	/* 비활성화된 버튼 스타일 */
	.checkout-btn:disabled {
	    background-color: #ddd;
	    cursor: not-allowed;
	    box-shadow: none;
	}


    /* 상품 삭제 버튼 스타일 */
	#delete-btn {
	    background-color: #f8f9fa;  /* 부드러운 회색 배경 */
	    color: #333;  /* 어두운 텍스트 색상 */
	    border: 1px solid #ccc;  /* 회색 테두리 */
	    padding: 12px 24px;  /* 버튼 크기 좀 더 크게 */
	    border-radius: 50px;  /* 둥근 모서리 */
	    font-size: 16px;
	    font-weight: 600;  /* 굵은 폰트 */
	    cursor: pointer;
	    transition: all 0.3s ease;  /* 부드러운 변화 */
	    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);  /* 부드러운 그림자 */
	    margin-top: 10px;
	    /* 오른쪽 정렬 */
	    float: right;
	    text-transform: uppercase;  /* 텍스트 대문자로 */
	    letter-spacing: 1px;  /* 글자 간격 약간 넓게 */
	}
	
	/* 호버 시 버튼 스타일 */
	#delete-btn:hover {
	    background-color: #e2e6ea;  /* 밝은 회색으로 변경 */
	    border-color: #adb5bd;  /* 테두리 컬러 살짝 어두워짐 */
	    color: #dc3545;  /* 텍스트 색상 빨간색으로 변경 */
	    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);  /* 그림자 깊이감 증가 */
	}
	
	/* 클릭 시 버튼 스타일 */
	#delete-btn:active {
	    background-color: #dae0e5;  /* 클릭 시 배경 색상 살짝 더 어두운 회색 */
	    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);  /* 클릭 시 그림자 줄어듬 */
	    transform: translateY(2px);  /* 클릭 시 버튼 약간 눌리는 효과 */
	}

    /* 합계 영역 스타일 */
    .summary {
        margin-top: 30px;
        padding: 15px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		margin-bottom: 20px;
    }

    .summary div {
        font-size: 1.2rem;
        margin: 5px 0;
    }

    /* 최종 결제 금액 스타일 */
    .total-price {
        font-weight: bold;
        color: #007BFF;
    }

    /* 쿠폰 리스트 테이블 스타일 */
    .table th,
    .table td {
        text-align: center;
        padding: 12px;
        font-size: 1rem;
    }

    .table th {
        background-color: #007BFF;
        color: white;
    }

    .table td {
        background-color: #f9f9f9;
    }

    .coupon-radio {
        width: 20px;
        height: 20px;
    }
    .custom-heading {
	    color: #000000; /* 검은색 */
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* 고급스러운 서체 */
	    font-weight: 700; /* 굵은 폰트 */
	    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2); /* 가벼운 그림자 효과 */
	    background: linear-gradient(135deg, #000000, #434343); /* 그라데이션 배경 */
	    -webkit-background-clip: text; /* 텍스트 배경 그라데이션 */
	    color: transparent; /* 텍스트 색상 투명 */
	    padding: 5px;
	    text-align: center; /* 텍스트를 가운데로 정렬 */
	    display: block; /* block 요소로 설정 */
	    width: fit-content; /* 너비를 컨텐츠에 맞추기 */
	    margin: 20px auto; /* 수평 가운데 정렬 */
	}
	.custom-hood {
	    color: #000000; /* 검은색 */
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* 고급스러운 서체 */
	    font-weight: 700; /* 굵은 폰트 */
	    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2); /* 가벼운 그림자 효과 */
	    background: linear-gradient(135deg, #000000, #434343); /* 그라데이션 배경 */
	    -webkit-background-clip: text; /* 텍스트 배경 그라데이션 */
	    color: transparent; /* 텍스트 색상 투명 */
	    padding: 5px;
	    text-align: center; /* 텍스트를 가운데로 정렬 */
	    display: block; /* block 요소로 설정 */
	    width: fit-content; /* 너비를 컨텐츠에 맞추기 */
	    margin: 40px auto; /* 수평 가운데 정렬 */
	}
   
</style>
	

<script>
	// 기존 JavaScript 코드 계속 유지
	// 페이지 로딩 후 세팅
	        let selectedTotal = 0;
	
	function updateSummary() {
	        let total = 0;
	        let checkoutEnabled = false;
	        selectedTotal = 0;
	        
	        // 각 상품별로 체크박스와 수량을 반영하여 계산
	        document.querySelectorAll('.cart-item').forEach((item) => {
	            const checkbox = item.querySelector('.item-checkbox');
	            const quantityInput = item.querySelector('.item-quantity');
	            const itemPrice = parseInt(item.querySelector('.item-price').textContent.replace('₩ ', '').replace(',', ''));
	            const itemQuantity = parseInt(quantityInput.value);
	            const totalPriceElement = item.querySelector('.total-price');
	            
	            const itemTotalPrice = itemPrice * itemQuantity;
	            totalPriceElement.textContent = '₩ '+itemTotalPrice.toLocaleString();

	            // 체크박스가 선택된 상품만 합산
	            if (checkbox.checked) {
	                selectedTotal += itemTotalPrice;
	            }

	            // 체크박스가 하나라도 선택되면 결제 가능
	            if (checkbox.checked) {
	                checkoutEnabled = true;
	            }

	            total += itemPrice * itemQuantity;
	        });

        // 합계 업데이트
        document.getElementById('selected-total').textContent = '₩ ' + selectedTotal.toLocaleString();
        document.getElementById('total-amount').textContent = '₩ ' + total.toLocaleString();

        // 결제 버튼 활성화/비활성화
        const checkoutButton = document.getElementById('checkout-btn');
        checkoutButton.disabled = !checkoutEnabled;
        
        
	}

	$(function() {
		// 페이지 로딩 시 초기 합계 업데이트
	    updateSummary();
	    
	    $(document).on('change', '.item-checkbox', function() {
	        updateSummary();  // 체크박스를 변경할 때마다 합계를 업데이트
	    });
    
		 // 수량 변경 시 합계 업데이트
	    $('input.item-quantity').change(function() {
	        updateSummary();
	    });
 
		// 삭제 버튼 클릭 시 선택된 항목 삭제
	    $('#delete-btn').click(function() {
	    	console.log('Delete button clicked');  // 버튼 클릭 확인
        	let selectedCartNos = [];

	        document.querySelectorAll('.cart-item').forEach((item) => {
	            const checkbox = item.querySelector('.item-checkbox');
	            console.log('Checkbox checked:', checkbox.checked);  // 체크박스 상태 확인
	            if (checkbox.checked) {
	                const cartNoElement = item.querySelector('.cartNo');
	                if (cartNoElement) {
	                    const cartNo = cartNoElement.textContent.trim();
	                    console.log('cartNo:', cartNo);  // cartNo가 제대로 출력되는지 확인
	                    if (cartNo) {
	                        selectedCartNos.push(cartNo);
	                    } else {
	                        console.warn('cartNo is empty for item:', item);
	                    }
	                } else {
	                    console.error('cartNo element is missing for item:', item);
	                }
	            }
	        });

        console.log('Selected Cart Nos:', selectedCartNos);  // 삭제할 항목 확인
        if (selectedCartNos.length === 0) {
            alert('삭제할 상품을 선택하세요.');
            return;
        }
	
	        // Ajax 요청으로 서버에 삭제 요청
	        $.ajax({
	            url: '/cart/removeItems',  // 서버에서 처리할 URL
	            type: 'POST',
	            contentType: 'application/json',  // JSON 형식으로 전송
	            data: JSON.stringify({ cartNos: selectedCartNos }),  // 배열을 JSON 문자열로 변환
	            success: function(response, status, xhr) {
	            	console.log (response);
	            	console.log (status);
	            	console.log (xhr);
	                if (response.success) {
	                    // 서버에서 성공적으로 삭제되면 화면에서 삭제
	                    document.querySelectorAll('.cart-item').forEach((item) => {
	                        const checkbox = item.querySelector('.item-checkbox');
	                        if (checkbox.checked) {
	                            item.remove();
	                        }
	                    });
	
	                    // 삭제 후 합계 업데이트
	                    updateSummary();
	                } else {
	                    alert('상품 삭제 실패');
	                }
	            },
	            error: function(xhr, status, error) {
	                alert('삭제 중 오류가 발생했습니다.');
	            }
	        });
	    }); // end of $('#delete-btn').click(function() 
    }); // end of function() 
    
    
 // 쿠폰 할인 금액을 계산하는 함수
    function calculateCouponDiscount() {
    	updateSummary();  // 쿠폰 할인 계산 전에 합계 업데이트
	 
        const selectedCoupon = document.querySelector('input[name="coupon"]:checked');  // 선택된 쿠폰
        let couponDiscount = 0;  // 쿠폰 할인 금액 초기화
        
        if (selectedCoupon) {
            const discountType = selectedCoupon.getAttribute('data-discount-type');
            const discountValue = parseFloat(selectedCoupon.getAttribute('data-discount-value'));

            if (discountType === 'percent') {
                // 할인율 퍼센트 적용
                couponDiscount = (selectedTotal * discountValue) / 100;
            } else if (discountType === 'amount') {
                // 금액 할인 적용
                couponDiscount = discountValue;
            }
        }

        // 쿠폰 할인 금액을 화면에 표시
        document.getElementById('coupon-discount').textContent = '₩' + couponDiscount.toLocaleString();
        updateFinalAmount(couponDiscount);  // 최종 결제 금액 업데이트
    } //end of 쿠폰 할인 금액을 계산하는 함수
    

    // 최종 결제 금액을 계산하여 화면에 표시
    function updateFinalAmount(couponDiscount) {
        const finalAmount = selectedTotal - couponDiscount;
        document.getElementById('final-amount').textContent = '₩' + finalAmount.toLocaleString();
    }

    // 쿠폰 선택 시 할인 금액 계산
    document.querySelectorAll('input[name="coupon"]').forEach(radio => {
        radio.addEventListener('change', calculateCouponDiscount);
    });
    
 	// 체크박스를 변경했을 때 실행되는 함수
    function handleCheckboxChange() {
        updateSummary();           // 상품 합계 업데이트
        calculateCouponDiscount(); // 쿠폰 할인 금액 계산
    }
 		
</script>

</head>		

<body>	
	<div class="container" style="padding-top: 200px;">
		<h1 class="custom-heading">장바구니 리스트</h1>
	
	<c:if test="${empty list }">
		<h4>장바구니가 비었습니다.</h4>
	</c:if>	   
	<c:if test="${!empty list }">
	    <div class="row header-row">
	        <div class="col-sm-1 text-center">선택</div>
	        <div class="col-sm-2 text-center">상품번호</div>
	        <div class="col-sm-2 text-center">상품사진</div>
	        <div class="col-sm-2 text-center">상품명</div>
	        <div class="col-sm-2 text-center">상품가격</div>
	        <div class="col-sm-1 text-center">수량</div>
	        <div class="col-sm-2 text-center">합계금액</div>
	    </div>
	
	    <c:forEach items="${list}" var="vo" varStatus="vs">
	        <div class="row cart-item">
	            <!-- 체크박스 -->
	            <div class="col-sm-1 text-center">
	                <input type="checkbox" class="item-checkbox" onchange="handleCheckboxChange()">
	            </div>
	
	            <!-- 상품번호 -->
	            <div class="col-sm-2 text-center cartNo">${vo.cartNo}</div>
	
	            <!-- 상품사진 -->
	            <div class="col-sm-2 text-center">
	                <img src="${vo.imageName}" style="width:40px; height:40px;" alt="상품이미지">
	            </div>
	
	            <!-- 상품명 -->
	            <div class="col-sm-2 text-center item-name">${vo.goodsName}</div>
	
	            <!-- 상품가격 -->
	            <div class="col-sm-2 text-center item-price">₩ ${vo.saleprice}</div>
	
	            <!-- 수량 -->
	            <div class="col-sm-1 text-center">
	                <input type="number" value="${vo.quantity}" class="item-quantity" onchange="handleCheckboxChange()">
	            </div>
	
	            <!-- 합계금액 -->
	            <div class="col-sm-2 text-center total-price">₩ ${vo.saleprice * vo.quantity}</div>
	        </div>
	    </c:forEach>
	</c:if>

	<button id="delete-btn" class="btn btn-danger" style="margin-bottom: 15px;">삭제</button>
	
	
	<h1 class="custom-hood">내 쿠폰 리스트</h1>
    	<c:if test="${empty myCouponList }">
		    <h4>적용할 쿠폰이 없습니다.</h4>
		</c:if>	   
				
		<c:if test="${!empty myCouponList}">
		    <table class="table table-bordered">
		        <thead class="thead-dark">
		            <tr>
		                <th scope="col">선택</th>
		                <th scope="col">쿠폰명</th>
		                <th scope="col">쿠폰혜택</th>
		                <th scope="col">사용가능 기간</th>
		                <th scope="col">쿠폰적용 상품</th>
		                <th scope="col">사용여부</th>
		                <th scope="col">사용일</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach items="${myCouponList}" var="coupon" varStatus="vs">
		                <tr>
		                    <!-- 선택 -->
		                    <td>
		                        <input type="radio" class="coupon-radio" name="coupon" 
		                        data-coupon-id="${coupon.no}"
		                        data-discount-type="${coupon.discount_type}"
		                        data-discount-value="${coupon.discount_value}"
		                        onchange="calculateCouponDiscount()"
		                        />
		                    </td>
		                    
		
		                    <!-- 쿠폰명 -->
		                    
		                    <td>${coupon.name}</td>
		
		                    <!-- 쿠폰혜택 -->
		                    <td>
		                    <c:choose>
						        <c:when test="${coupon.discount_type == 'percent'}">
						            ${coupon.discount_value}% 할인 <!-- percent일 때 -->
						        </c:when>
						        <c:when test="${coupon.discount_type == 'amount'}">
						            ${coupon.discount_value}원 할인 <!-- amount일 때 -->
						        </c:when>
						    </c:choose>
						    </td>
						    		
		                    <!-- 사용가능 기간 -->
		                    <td>
		                        <fmt:formatDate value="${coupon.valid_from}" pattern="yyyy-MM-dd" />
		                        ~
		                        <fmt:formatDate value="${coupon.valid_until}" pattern="yyyy-MM-dd" />
		                    </td>
		
		                    <!-- 쿠폰적용 상품 -->
		                    <td>제한없음</td> <!-- 이 부분은 실제 적용된 상품 정보로 수정 필요 -->
		
		                    <!-- 사용여부 -->
		                    <td>${(coupon.is_used == 1) ? '사용' : '미사용'}</td>
		
		                    <!-- 사용일 -->
		                    <td>
		                        <fmt:formatDate value="${coupon.used_at}" pattern="yyyy-MM-dd" />
		                    </td>
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>
		</c:if>
    	
		<div class="summary">
	        <div> 
	            <span>전체 상품 금액: </span>
	            <span id="total-amount">₩ 0</span>
	        </div>
	        <div>
	            <span>선택한 상품 금액 합계: </span>
	            <span id="selected-total">₩ 0</span>
	        </div>
	        <div>
	            <span>쿠폰 적용 금액: </span>
	            <span id="coupon-discount">₩ 0</span>
	        </div>
	        <div>
	            <span>최종 결제 금액: </span>
	            <span id="final-amount">₩ 0</span>
	        </div>
    	</div>

    	<button class="checkout-btn" id="checkout-btn" disabled>주문하기</button>
		</div>
					
	<script>				
	// 주문하기 버튼 클릭 시 처리
	document.getElementById('checkout-btn').addEventListener('click', function () {
	    const selectedItems = [];

	    // 선택된 상품 정보 수집
	    document.querySelectorAll('.cart-item').forEach(item => {
	        const checkbox = item.querySelector('.item-checkbox');
	        if (checkbox.checked) {
	            const cartNo = item.querySelector('.cartNo').textContent;
	            const name = item.querySelector('.item-name').textContent;
	            const quantity = item.querySelector('.item-quantity').value;
	            const totalPrice = item.querySelector('.total-price').textContent
                .replace('₩', '')
                .replace(/\s/g, '')
                .replace(',', ''); // ₩와 쉼표 제거
	            selectedItems.push({ cartNo, name, quantity, totalPrice });
	        }
	    });

	    if (selectedItems.length === 0) {
	        alert('주문할 상품을 선택하세요.');
	        console.log("Selected Items:", selectedItems);
	        return;
	    }

		 // 쿠폰 정보 가져오기
	    const selectedCoupon = document.querySelector('input[name="coupon"]:checked');
	    const couponCode = selectedCoupon ? selectedCoupon.getAttribute('data-coupon-id') : null;

	    // 쿠폰 할인 금액 및 최종 금액 가져오기
	    const couponDiscountText = document.getElementById('coupon-discount').textContent.replace('₩', '').replace(/,/g, '').trim();
	    const finalAmountText = document.getElementById('final-amount').textContent.replace('₩', '').replace(/,/g, '').trim();
	    const couponDiscount = parseInt(couponDiscountText, 10) || 0;
	    const finalAmount = parseInt(finalAmountText, 10);

	    if (isNaN(finalAmount) || finalAmount <= 0) {
	        alert('최종 결제 금액이 올바르지 않습니다.');
	        return;
	    }
	    
	    console.log(JSON.stringify(selectedItems));
	    console.log('쿠폰 할인 금액:', couponDiscount);
	    console.log('최종 결제 금액:', finalAmount);
	    
	 // URL에 데이터 추가
	    const params = new URLSearchParams({
	        items: JSON.stringify(selectedItems),
	        discount: String(couponDiscount),
	        finalAmount: String(finalAmount),
	        couponCode: String(couponCode) // 쿠폰 코드 추가
	    });
	    
	    const queryString = params.toString(); // params를 문자열로 변환
	    const urlhead = '/order/form.do?';
	    

	    console.log('Selected Items:', selectedItems);
	    console.log('Selected Coupon Code:', couponCode);
	    console.log('Generated Query String:', params.toString());
	    console.log(queryString); 
	    console.log(urlhead); 
	    console.log('Generated URL:', `/order/form?${params.toString()}`);
	    console.log('Generated URL:', urlhead + queryString);
	    
	    window.location.href = urlhead + queryString;
	    // 새로운 페이지로 이동
	});
	</script>
	
</body>
</html>