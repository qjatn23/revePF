<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!-- 데이터는 DispatcherServlet에 담겨있다.(request) -->

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- datepicker: jquery는 bootstrap에서 정의한 라이브러리 사용 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>


	<title>쿠폰함 리스트</title>

<style type="text/css">
	.imageDiv{
		background: black;
	}
            body {
            font-family: Arial, sans-serif;
        }
        .cart-container {
            width: 80%;
            margin: 20px auto;
        }
        .summary {
            margin-top: 20px;
            font-size: 18px;
            text-align: right;
        }
        .summary div {
            margin: 5px 0;
        }
        .checkout-btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            font-size: 18px;
            cursor: pointer;
        }
        .checkout-btn:disabled {
            background-color: #ddd;
        }
        .header-row {
            font-weight: bold;
            background-color: #f7f7f7;
            padding: 10px 0;
            text-align: center;
        }
        .cart-item img {
            width: 60px;
            height: 60px;
        }
        .cart-item input[type="number"] {
            width: 40px;
        }
        .total-price {
            font-weight: bold;
            color: #007BFF;
        }
        /* 가운데 정렬 클래스 */
        .center {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        /* 우측 정렬 클래스 */
        .right-align {
            text-align: right;
        }
        /* 카드 항목 구분 */
        .cart-item {
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
</style>	
<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
</head>		

<body>	
	<div class="container" style="padding-top: 200px;">
		<h1><i class="fa fa-align-justify"></i> 쿠폰등록 리스트 <i class="fa fa-align-justify"></i></h1>
			
	<c:if test="${empty list }">
		<h4>쿠폰함이 비었습니다.</h4>
		</c:if>	   
	<c:if test="${!empty list }">
		
		<div class="row header-row">
			<div class="col-sm-1">선택</div>
			<div class="col-sm-1">쿠폰번호</div>
			<div class="col-sm-1">쿠폰코드</div>
			<div class="col-sm-2">쿠폰명</div>
			<div class="col-sm-1">수량</div>
			<div class="col-sm-1">할인유형</div>
			<div class="col-sm-1">할인금액</div>
			<div class="col-sm-1">유효시작일</div>
			<div class="col-sm-1">유효종료일</div>
			<div class="col-sm-1">다운받기</div>
		</div>
		<form action="deleteCoupons.do" method="post" id="deleteForm">
		<c:forEach items= "${list }" var="vo" varStatus="vs">
			 <div class="row cart-item">
                <!-- 체크박스 -->
                <div class="col-sm-1 center">
                    <input type="checkbox" class="item-checkbox" name="selectedCoupons" value="${vo.no}">
                </div>
              
                <!-- 쿠폰번호 -->
                <div class="col-sm-1 center">${vo.no}</div>
                
                <!-- 쿠폰코드 -->
                <div class="col-sm-1 center">${vo.code}</div>

                <!-- 쿠폰명 -->
                <div class="col-sm-2 center">${vo.name}</div>

                <!-- 수량 -->
                <div class="col-sm-1 center">${vo.quantity}</div>

                <!-- 할인유형 -->
                <div class="col-sm-1 center">${vo.discount_type}</div>
                
                <!-- 할인금액 -->
                <div class="col-sm-1 center">${vo.discount_value}</div>

                <!-- 유효시작일 -->
                <div class="col-sm-1 center">
                <fmt:formatDate value="${vo.valid_from}" pattern="yyyy-MM-dd" />
                </div>
                
                <!-- 유효시작일 -->
                <div class="col-sm-1 center">
                <fmt:formatDate value="${vo.valid_until}" pattern="yyyy-MM-dd" />
				</div>
				
				<!-- 저장 -->
                <div class="col-sm-1 center">
 				    <button type="button" class="btn btn-success save-btn" data-code="${vo.code}" style="margin-bottom: 12px;">저장</button>
				</div>
				
            </div>
		</c:forEach>
		</form>
				
	</c:if>	
	<div class="d-flex">
	    <a href="writeForm.do">
	        <button id="write-btn" class="btn btn-primary" style="margin-bottom: 15px; margin-right: 10px;">등록</button>
	    </a>
	    <button id="delete-btn" class="btn btn-danger" style="margin-bottom: 15px;" onclick="deleteCoupons();">삭제</button>
	</div>
	
	<form action="addCouponToUser" method="post" id="saveForm">
		<input type="hidden" name="selectedCoupons" id="selectedCoupons">
	</form>

 	</div> <!-- end of container  -->


	<script type="text/javascript">
		function deleteCoupons() {
			// 선택된 체크박스 확인
			var selectedCoupons = document.querySelectorAll('input[name="selectedCoupons"]:checked');
			if (selectedCoupons.length > 0) {
				// 삭제를 위한 폼 제출
				var form = document.getElementById('deleteForm');
				form.submit();
			} else {
				alert("삭제할 항목을 선택해주세요.");
			}
		}
		
		// 저장 버튼 클릭 시 선택한 쿠폰 ID만 보내기
		document.querySelectorAll('.save-btn').forEach(function(button) {
        button.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            
            var selectedCoupons = [];
            var cartItem = button.closest('.cart-item');
            // 해당 항목의 체크박스가 체크되어 있는지 확인
            var checkbox = cartItem.querySelector('input[type="checkbox"]:checked');
            
            if (checkbox) {
                selectedCoupons.push(button.getAttribute('data-code'));
            }
            
            // 선택된 쿠폰 ID가 있을 경우
            if (selectedCoupons.length > 0) {
                // form에 배열을 추가하여 제출
                document.getElementById('selectedCoupons').value = selectedCoupons.join(',');
                document.getElementById('saveForm').submit(); // '저장' 폼 제출
            } else {
                alert("저장할 쿠폰을 선택해주세요.");
            }
        });
    });
	</script>

	</body>
</html>