<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>


<!DOCTYPE html>
<html class="no-js">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, 
                initial-scale=1.0, 
                minimum-scale=1.0, 
                maximum-scale=1.0, 
                user-scalable=no, 
                viewport-fit=cover" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!-- 공통 CSS -->


<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js?ver=1"></script>




<!-- Bootstrap 스타일 및 스크립트 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css?ver=1">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js?ver=1"></script>

<!-- jQuery UI 스타일 및 스크립트 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>



<!-- 커스텀 스타일 -->
<style type="text/css">
.search_box {
	padding-top: 30px;
	width: 50%;
	margin: 0 auto;
}

.form-control {
	border-width: 0 0 1px;
	background-color: transparent;
}

.search {
	background-color: #f0ebe7;
}

.search:hover {
	background-color: #e4ddd7;
	border-color: #b3aea8;
	color: #333;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}
.form-check label:hover {
	background-color: #e4ddd7;
	border-color: #b3aea8;
	color: #333;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

</style>
<title>Man Shop</title>

<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">


</head>
<body class="body" id="body">
	<div class="wrap">
		<main class="main" role="main">
			<div class="main-wrap">
				<section
					class="section section-width__wide productpage-naviarea display-flex">
					<h2 class="title">MAN</h2>
				</section>

				<section
					class="section section-width__wide productpage-banner__visual swiper">
					<ul class="productpage-banner__list swiper-wrapper">
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_balenciaga.png"
							alt=""></li>
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_bottega.png"
							alt=""></li>
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_chanel.png"
							alt=""></li>
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_gucci.png"
							alt=""></li>
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_miumiu.png"
							alt=""></li>
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_saint.png"
							alt=""></li>
						<li class="productpage-banner__item swiper-slide"><img
							src="/resources/images/product_page_woman/pw_banner_vuitton.png"
							alt=""></li>
					</ul>
					<div class="swiper-button-prev prev-no-bg"></div>
					<div class="swiper-button-next next-no-bg"></div>
				</section>
				<section class="section section-width__limit productpage-timedeal"
					style="margin: 5rem auto;">
					<h2 class="title">Time Deal</h2>
					<p class="subtitle">놓치면 후회하는 12시간 한정특가 아이템</p>
					<div class="timedeal-wrap swiper" style="min-height: 400px;">
						<ul class="product-list product-list__discount swiper-wrapper"
							id="discountProductList" style="max-height: 400px;">

						</ul>
					</div>

				</section>


			</div>
		</main>


		<!-- 상품 검색 및 필터 -->
		<div class="container-xl">
			<form action="list.do" id="searchForm">
				<input type="hidden" name="page" value="${pageObject.page }">
				<!-- 검색 옵션 -->
				<div class="gallery_list">
					<div>
						<!-- 대분류 -->
						<div id="cate_code1" class="category-radio-group">
							<c:forEach items="${listBig }" var="vo">
								<div class="form-check">
									<input class="form-check-input" type="submit" name="cate_code1"
										value="${vo.cate_code1 } " id="cate_code1_${vo.cate_code1 }"
										<c:if test="${ goodsSearchVO.cate_code1 == vo.cate_code1 }">checked</c:if>>
									<label class="form-check-label"
										for="cate_code1_${vo.cate_code1 }"> ${vo.cate_name }</label>
								</div>
							</c:forEach>
						</div>

						<!-- 중분류 -->
						<button id="cate_code2" class="category-radio-group" type="submit"
							style="display: none;"></button>

						<!-- 검색창 -->
						<div class="input-group-prepend search_box">
							<input type="text" class="form-control" placeholder="상품명 검색"
								id="goods_name" name="goods_name"
								value="${goodsSearchVO.goods_name }">

							<button type="submit" class="btn search">
								<i class="fa fa-search"></i>
							</button>
						</div>

						<input type="hidden" name="sortBy" id="sortBy"
							value="${param.sortBy}" /> <input type="hidden" name="sortOrder"
							id="sortOrder" value="${param.sortOrder}" />

						<div class="sort-radio-buttons">
							<input type="submit" name="sort" id="sort_default"
								value="default" ${param.sortBy == null ? 'checked' : ''} /> <label
								for="sort_default" onclick="setSort('default')">신상품</label> <input
								type="submit" name="sort" id="sort_price_asc" value="price_asc"
								${param.sortBy == 'price' && param.sortOrder == 'asc' ? 'checked' : ''} />
							<label for="sort_price_asc" onclick="setSort('price_asc')">최저가격순</label>

							<input type="submit" name="sort" id="sort_price_desc"
								value="price_desc"
								${param.sortBy == 'price' && param.sortOrder == 'desc' ? 'checked' : ''} />
							<label for="sort_price_desc" onclick="setSort('price_desc')">최고가격순</label>
						</div>
					</div>
				</div>
			</form>
		</div>

		<section class="brands_items_list" style="padding-top: 10px;">
			<c:if test="${empty list}">
				<h4>상품이 존재하지 않습니다.</h4>
			</c:if>
			<c:if test="${!empty list}">
				<div class="gallery_list">
					<!-- 이미지 list의 데이터가 있는 만큼 표시 -->
					<c:forEach items="${list}" var="vo" varStatus="vs">
						<!-- 4개씩 상품 -->
						<c:if test="${(vs.index != 0) && (vs.index % 4 == 0)}">
                    ${"</div>"}
                    ${"<div class='gallery_list'>"}
                </c:if>
						<!-- 상품 데이터 표시 시작 -->
						<div class="gallery dataRow">
							<div>
								<div class="gallery-item">
									<img src="${vo.image_name}">
								</div>
								<div class="gallery-text">
									<span class="goods_no" data-goods_no="${vo.goods_no}">${vo.goods_no}</span>
									<br> <span class="cate_name"> ${vo.cate_name }</span><br>
									<span class="goods_name"> ${vo.goods_name}</span> <br>

									<div class="sale_price">
										<span class="sale"><fmt:formatNumber value="${vo.sale_price}" /> 원 </span>
										<span class="price"><fmt:formatNumber value="${vo.price}" /> 원 </span> 
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="discount">${vo.discount_rate}%</span> 
									</div>

								</div>
							</div>
							<!-- end of card -->
						</div>
						<!-- 데이터 표시 끝 -->
					</c:forEach>
					<!-- 이미지 데이터 반복 표시 끝 -->
				</div>
			</c:if>
			<%-- 	<c:if test="${!empty login }"> --%>
			<!-- 로그인이 되어있으면 등록버튼이 보이게 처리 -->
			<div>
				<a href="writeForm.do?perPageNum=" ${pageObject.perPageNum }
					class="btn btn-primary">등록</a>
			</div>
			<%-- 	</c:if> --%>
			<div>
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav>
			</div>
		</section>
	</div>
	<script src="/resources/js/product.js"></script>
	<script src="/resources/js/product_page.js"></script>
	<script src="/resources/js/swipers.js"></script>
	<script src="/resources/js/common.js"></script>



	<!-- 선택된 상태를 반영하는 코드 -->
	<script>
	function setSort(option) {
	    const sortByInput = document.getElementById('sortBy');
	    const sortOrderInput = document.getElementById('sortOrder');

	    if (option === 'default') {
		sortByInput.value = ''; // 기본값 (신상품)
		sortOrderInput.value = ''; // 정렬순서 없음
	    } else {
		sortByInput.value = 'price';
		sortOrderInput.value = option === 'price_asc' ? 'asc' : 'desc';
	    }

	    // 폼을 제출하여 페이지를 갱신
	    document.getElementById('sortForm').submit();
	}
    </script>


	<script type="text/javascript">
	$(function() {

	    // 이벤트 처리 - 리스트에서 상품을 클릭했을때
	    $(".dataRow").click(
		    function() {
			let goods_no = $(this).find(".goods_no").data(
				"goods_no");
			location = "view.do?goods_no=" + goods_no
				+ "&${pageObject.pageQuery}"
				+ "&${goodsSearchVO.searchQuery}";
		    });

	    $("#perPageNum").change(function() {
		$("#searchForm").submit();
	    });

	    // 검색데이터 세팅
	    $("#key").val("${(empty pageObject.key)?'t':pageObject.key}");
	    $("#perPageNum")
		    .val(
			    "${(empty pageObject.perPageNum)?'10':pageObject.perPageNum}");

	    // 대분류 리스트 변경
	    $("#cate_code1").change(function() {
		let cate_code1 = $(this).val();

		$.ajax({
		    type : "get",
		    url : "/goods/getCategory.do?cate_code1=" + cate_code1,
		    success : function(result, status, xhr) {
			console.log("==== 중분류데이터 ====");
			console.log("result : " + JSON.stringify(result));
			console.log("status : " + status);
			console.log("xhr : " + xhr);

			let str = '<option value="0">All</option>';

			result.forEach(function(item) {
			    console.log(item.cate_name);
			    str += '<option value="' + item.cate_code2 + '">';
			    str += item.cate_name + '</option>\n';
			});

			console.log(str);

			$("#cate_code2").html(str);
		    },
		    error : function(xhr, status, err) {
			console.log("중분류 가져오기 오류 *************");
			console.log("xhr : " + xhr);
			console.log("status : " + status);
			console.log("err : " + err);
		    }
		});

	    });
	    // 대분류 리스트 변경 끝

	});
    </script>
	<script>
	var swiper = new Swiper(".mySwiper", {
	    spaceBetween : 30,
	    effect : "fade",
	    autoplay : {
		delay : 5000,
		disableOnInteraction : false,

	    },
	});
    </script>

	<script>
	$(document).ready(
		function() {
		    $("button, a ,input").click(
			    function(event) {
				sessionStorage.setItem("scrollPosition", $(
					window).scrollTop());
			    });

		    var savedScrollPosition = sessionStorage
			    .getItem("scrollPosition");
		    if (savedScrollPosition !== null) {
			$(window).scrollTop(savedScrollPosition);
			sessionStorage.removeItem("scrollPosition");
		    }
		});
    </script>

	<script type="text/javascript">
	$(document)
		.ready(
			function() {
			    // 대분류 라디오 버튼 클릭 시 처리
			    $("input[name='cate_code1']")
				    .change(
					    function() {
						var selectedCateCode1 = $(this)
							.val(); // 선택된 대분류 값

						// AJAX 요청 보내기
						$
							.ajax({
							    type : "GET",
							    url : "/goods/getCategory.do", // 중분류를 가져오는 URL
							    data : {
								cate_code1 : selectedCateCode1
							    },
							    success : function(
								    result) {
								// 중분류 라디오 버튼 동적으로 생성
								var str = '';
								str += '<div class="form-check"><input type="radio" class="form-check-input" name="cate_code2" value="0" id="cate_code2_0"><label class="form-check-label" for="cate_code2_0">All</label></div>';

								result
									.forEach(function(
										item) {
									    str += '<div class="form-check">';
									    str += '<input type="radio" class="form-check-input" name="cate_code2" value="' + item.cate_code2 + '" id="cate_code2_' + item.cate_code2 + '">';
									    str += '<label class="form-check-label" for="cate_code2_' + item.cate_code2 + '">'
										    + item.cate_name
										    + '</label>';
									    str += '</div>';
									});

								// 중분류 div 업데이트
								$("#cate_code2")
									.html(
										str);
							    },
							    error : function(
								    xhr,
								    status, err) {
								console
									.log("중분류 가져오기 오류");
								console
									.log("xhr: "
										+ xhr);
								console
									.log("status: "
										+ status);
								console
									.log("err: "
										+ err);
							    }
							});
					    });
			});
    </script>
</body>
</html>