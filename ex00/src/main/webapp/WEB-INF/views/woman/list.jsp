<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
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






<title>Woman Shop</title>

<style type="text/css">
.category-radio-group {
	display: flex;
	gap: 10px;
	width: 100%;
	height: auto;
	
}

.form-check {
	display: flex;
	align-items: center;
	width: 100px;
	justify-content: center;
}

.form-check input {
	margin: 0;
	display: none;
	padding: 2rem 0rem;
}

.form-check label {
	font-size: 1.6rem;
	color: #000;
	padding: 0rem 2rem;
}

.form-check label:hover {
	background-color: #e4ddd7;
	border-color: #b3aea8;
	color: #333;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

#woman_cate_code2 {
	display: flex;
}

.search_box {
	padding-top: 30px;
	width: 50%;
	margin: 0 auto;
}

.form-control:focus {
	outline: none;
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
</style>
<link rel="stylesheet" href="/resources/styles/common.css">
<link rel="stylesheet" href="/resources/styles/reset.css">
<link rel="stylesheet" href="/resources/styles/reponsive.css">
<link rel="stylesheet" href="/resources/styles/root.css">



</head>
<body class="body" id="body">
	<div class="wrap">
		<main class="main" role="main">
			<div class="main-wrap">
				<section
					class="section section-width__wide productpage-naviarea display-flex">
					<h2 class="title">WOMAN</h2>
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


		<!-- 상품리스트 -->
		<!-- 기존 코드의 선택 박스 부분 -->
		<div class="container-xl" style="width: 100%; height: auto;">
			<form action="list.do" id="searchForm">
				<input type="hidden" name="page" value="${pageObject.page }">
				<!-- 상품검색 시작 -->
				<div class="gallery_list">
					<div>

						<!-- 대분류 라디오 버튼을 flex로 스타일링 -->
						<div id="woman_cate_code1" class="category-radio-group">
							<c:forEach items="${listBig }" var="vo">
								<div class="form-check">
									<input class="form-check-input" type="submit"
										name="woman_cate_code1" value="${vo.woman_cate_code1 } "
										id="woman_cate_code1_${vo.woman_cate_code1 }"
										<c:if test="${ womanSearchVO.woman_cate_code1 == vo.woman_cate_code1 }">checked</c:if>>
									<label class="form-check-label"
										for="woman_cate_code1_${vo.woman_cate_code1 }">
										${vo.woman_cate_name }</label>
								</div>
							</c:forEach>




						</div>
						<!-- 중분류 라디오 버튼 위치 -->
						<button id="woman_cate_code2" class="category-radio-group"
							type="submit" style="display: none;"></button>

						<!-- 검색 버튼 -->
						<div class="input-group-prepend search_box">
							<!-- 텍스트 입력 -->
							<input type="text" class="form-control" placeholder="상품명 검색"
								id="woman_name" name="woman_name"
								value="${womanSearchVO.woman_name }">
							<button type="submit" class="btn search">
								<i class="fa fa-search"></i>
							</button>
						</div>
						<input type="hidden" name="sortBy" id="sortBy"
							value="${param.sortBy}" /> <input type="hidden" name="sortOrder"
							id="sortOrder" value="${param.sortOrder}" />

						<div class="sort-radio-buttons">
							<label><input type="submit" name="sort" value="default"
								${param.sortBy == null ? 'checked' : ''}
								onclick="setSort('default')" /> 신상품 </label> <label> <input
								type="submit" name="sort" value="price_asc"
								${param.sortBy == 'price' && param.sortOrder == 'asc' ? 'checked' : ''}
								onclick="setSort('price_asc')" /> 최저가격순
							</label> <label> <input type="submit" name="sort"
								value="price_desc"
								${param.sortBy == 'price' && param.sortOrder == 'desc' ? 'checked' : ''}
								onclick="setSort('price_desc')" /> 최고가격순
							</label>
						</div>
					</div>
				</div>
			</form>
		</div>

		<section class="brands_items_list" style="padding-top: 10px;">
			<c:if test="${empty list}">
				<h4>상품이 업데이트 중 입니다.</h4>
			</c:if>
			<c:if test="${!empty list}">
				<div class="gallery_list">
					<c:forEach items="${list}" var="vo" varStatus="vs">
						<c:if test="${(vs.index != 0) && (vs.index % 4 == 0)}">
                    ${"</div>"}
                    ${"<div class='gallery_list'>"}
                </c:if>
						<!--상품 표시 시작 -->
						<div class="gallery dataRow">
							<div>
								<div class="gallery-item">
									<img src="${vo.woman_image_name}">
								</div>
								<div class="gallery-text">
									<span class="woman_no" data-woman_no="${vo.woman_no}">${vo.woman_no}</span>
									<br> <span class="woman_cate_name"> ${vo.woman_cate_name }</span><br>
									<span class="woman_name"> ${vo.woman_name}</span> <br> <br>

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
					</c:forEach>
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
			let woman_no = $(this).find(".woman_no").data(
				"woman_no");
			location = "view.do?woman_no=" + woman_no
				+ "&${pageObject.pageQuery}"
				+ "&${womanSearchVO.searchQuery}";
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
	    $("#woman_cate_code1")
		    .change(
			    function() {
				let woman_cate_code1 = $(this).val();

				$
					.ajax({
					    type : "get",
					    url : "/woman/getwomanCategory.do?woman_cate_code1="
						    + woman_cate_code1,
					    success : function(result, status,
						    xhr) {
						console.log("==== 중분류데이터 ====");
						console
							.log("result : "
								+ JSON
									.stringify(result));
						console.log("status : "
							+ status);
						console.log("xhr : " + xhr);

						let str = '<option value="0">All</option>';

						result
							.forEach(function(item) {
							    console
								    .log(item.woman_cate_name);
							    str += '<option value="' + item.woman_cate_code2 + '">';
							    str += item.woman_cate_name
								    + '</option>\n';
							});

						console.log(str);

						$("#woman_cate_code2")
							.html(str);
					    },
					    error : function(xhr, status, err) {
						console
							.log("중분류 가져오기 오류 *************");
						console.log("xhr : " + xhr);
						console.log("status : "
							+ status);
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
			    $("input[name='woman_cate_code1']")
				    .change(
					    function() {
						var selectedWomanCateCode1 = $(
							this).val(); // 선택된 대분류 값

						// AJAX 요청 보내기
						$
							.ajax({
							    type : "GET",
							    url : "/woman/getwomanCategory.do", // 중분류를 가져오는 URL
							    data : {
								woman_cate_code1 : selectedWomanCateCode1
							    },
							    success : function(
								    result) {
								// 중분류 라디오 버튼 동적으로 생성
								var str = '';
								str += '<div class="form-check"><input type="radio" class="form-check-input" name="woman_cate_code2" value="0" id="woman_cate_code2_0"><label class="form-check-label" for="woman_cate_code2_0">All</label></div>';

								result
									.forEach(function(
										item) {
									    str += '<div class="form-check">';
									    str += '<input type="radio" class="form-check-input" name="woman_cate_code2" value="' + item.woman_cate_code2 + '" id="woman_cate_code2_' + item.woman_cate_code2 + '">';
									    str += '<label class="form-check-label" for="woman_cate_code2_' + item.woman_cate_code2 + '">'
										    + item.woman_cate_name
										    + '</label>';
									    str += '</div>';
									});

								// 중분류 div 업데이트
								$(
									"#woman_cate_code2")
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