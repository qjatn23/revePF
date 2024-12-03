<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- datepicker: jquery는 bootstrap에서 정의한 라이브러리 사용 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>



<title>상품 정보</title>




<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/view.css?after">
</head>
<body>
	<div class="container" style="padding-top: 200px;">
		<div class="card" style="border: none;">
			<div class="card-body">
				<div class="row">
					<div class="col-md-6 description-box">

						<div id="bigImageDiv" class="img-thumbnail">
							<img src="${vo.image_name }">
						</div>
						<div id="smallImageDiv">
							<img src="${vo.image_name }" class="img-thumbnail">
							<c:if test="${!empty imageList }">
								<c:forEach items="${imageList}" var="imageVO">
									<img src="${imageVO.image_name }" class="img-thumbnail">
								</c:forEach>
							</c:if>
						</div>
					</div>
					<div class="col-md-6" id="goodsDetailDiv">
						<h5 class="product_no">${vo.goods_no }</h5>
						<h2 class="product_brand">${vo.cate_name }</h2>
						<h3 class="product_title">${vo.goods_name }</h3>
						<h3 class="product_sale">
							₩ ${vo.sale_price } <span class="product_price">${vo.price }</span>
						</h3>
						<p class="product_content">${vo.content }</p>


						<div class="form-group size-color-container">

							<div class="size-container">
								<c:forEach items="${sizeList}" var="sizeVO">
									<label> <input type="radio" name="size_name"
										value="${sizeVO.size_name}" class="size-radio" /> <span
										class="size-label">${sizeVO.size_name}</span>
									</label>
								</c:forEach>
							</div>
							<div class="color-container">
								<c:forEach items="${colorList}" var="colorVO">
									<!-- 라벨을 클릭하여 사용 -->
									<label class="color-label"
										style="background-color: ${colorVO.color_name};"> <input
										type="radio" name="color_name" value="${colorVO.color_name}"
										class="color-radio" id="color_${colorVO.color_name}" />
									</label>
								</c:forEach>
							</div>
						</div>
						<div class="product_view_btn">
							<form action="/cart/add" method="POST" class="cart-form">
								<input type="hidden" name="id" value="${login.id}" /> <input
									type="hidden" name="goods_no" value="${vo.goods_no}" /> <input
									type="hidden" name="goods_name" value="${vo.goods_name}" /> <input
									type="hidden" name="image_name" value="${vo.image_name}" /> <input
									type="hidden" name="sale_price" value="${vo.sale_price}" /> <input
									type="hidden" name="delivery_charge"
									value="${vo.delivery_charge}" /> <input type="number"
									name="quantity" class="quantity-input" min="1" value="1"
									required placeholder="수량 입력" />


								<button type="submit" class="btn-cart">장바구니에 추가</button>
							</form>

							<form action="/cart/list.do">
								<button class="cart_btn" type="submit">결제하기</button>
							</form>
						</div>
					</div>
					<section
						class="section section-width__limit section-no__margin media-community" style="margin-left: -15px;">
						<div class="comm-inner">
					
							<ul class="tabs">
								<li class="tab" id="reviewTab">Review</li>
								<li class="tab" id="qaTab" class="active">Q&A</li>
							</ul>

						
							<div class="tab-content" id="formContent" style="padding-right:95px;  margin-left: -145px;">
							
							</div>
						</div>
					</section>



				</div>


			</div>
			<div class="card-footer">
				<button class="btn btn-primary" id="listBtn">리스트</button>
				<button class="btn btn-success" id="updateBtn">수정</button>
				<form action="${pageContext.request.contextPath}/goods/delete.do"
					method="post">
					<input type="hidden" name="goods_no" value="${vo.goods_no}" />
					<button type="submit" class="btn btn-danger">삭제</button>
				</form>
			</div>

		</div>
	</div>

	<script type="text/javascript">
	function loadQnaContent(id) {
	    $.ajax({
		url : '/qnagoods/list.do', 
		method : 'GET',
		data : {
		    id : id
		}, 
		success : function(data) {
		    $('#formContent').html(data); 
		},
		error : function() {
		    $('#formContent').html('<p>Q&A 내용을 불러오는 데 실패했습니다.</p>');
		}
	    });
	}


	$('#qaTab').on('click', function() {
	    var id = 'qnaSection';
	    loadQnaContent(id); 
	});


	$('.tabs .tab').on('click', function() {
	    $('.tabs .tab').removeClass('active'); 
	    $(this).addClass('active'); 
	});
    </script>


	<script type="text/javascript">
	function loadReviewContent(id) {
	    $.ajax({
		url : '/myreviewgoods/list.do', 
		method : 'GET',
		data : {
		    id : id
		}, 
		success : function(data) {
		    $('#formContent').html(data); 
		},
		error : function() {
		    $('#formContent').html('<p>Q&A 내용을 불러오는 데 실패했습니다.</p>');
		}
	    });
	}


	$('#reviewTab').on('click', function() {
	    var id = 'review_view';
	    loadReviewContent(id); 
	});


	$('.tabs .tab').on('click', function() {
	    $('.tabs .tab').removeClass('active'); 
	    $(this).addClass('active'); 
	});
    </script>

	<script type="text/javascript">
	$(function() {

	    $("#smallImageDiv img").click(function() {
		$("#bigImageDiv img").attr("src", $(this).attr("src"));
	    });

	    $("#listBtn").click(
		    function() {
			location = "list.do?page=${param.page}"
				+ "&perPageNum=${param.perPageNum}"
				+ "&${goodsSearchVO.searchQuery}";
		    });

	    $("#updateBtn")
		    .click(
			    function() {
				location = "updateForm.do?goods_no=${vo.goods_no}&page=${param.page}"
					+ "&perPageNum=${param.perPageNum}"
					+ "&${goodsSearchVO.searchQuery}";
			    });

	});
    </script>
</body>
</html>