<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>리뷰 및 게시글 관리</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
/* 기본 스타일 */
article {
	width: 100%;
	height: 100%;
	max-width: 1920px;
	margin: 0 auto;
	padding-top: 200px;
	min-height: 700px;
}

.title {
	font-size: 1.8rem;
	font-weight: bold;
	margin-bottom: 50px; /* 제목과 라인 사이 여백 */
	border-bottom: 2px solid #000; /* 밑줄 */
	padding-bottom: 25px; /* 텍스트와 밑줄 사이 간격 추가 */
	margin-top: 20px; /* 제목 위쪽 여백 추가 */
}

.tabs {
	margin-top: 30px; /* 라인 아래쪽 공간 추가 */
	display: flex;
	border-bottom: 2px solid #ccc;
}

.tabs a {
	text-decoration: none;
	color: #555;
	padding: 10px 20px;
	margin-right: 10px;
}

.tabs a.active {
	font-weight: bold;
	color: #000;
	border-bottom: 2px solid #000;
}

.empty-message {
	margin-top: 10px; /* 이전 30px에서 50px로 늘림 */
	color: #999;
	text-align: center;
	font-size: 1.2rem;
}

.reviewCan {
	margin-top: 100px; /* 기존 20px에서 40px로 증가 */
}

.sub-message {
	color: #aaa;
	margin-top: 10px;
}

.side-menu ul {
	list-style: none;
	padding: 0;
}

.side-menu ul li {
	padding: 10px 0;
}

.side-menu ul li a {
	color: #555;
	text-decoration: none;
	font-size: 1.1em;
}

.side-menu ul li a:hover {
	color: #000;
}
</style>
<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
</head>
<body class="body" id="body">
	<div class="container" style="padding-top: 100px;">
		<h1 class="title">리뷰 및 게시글 관리</h1>

		<div class="row">
			<!-- 사이드 메뉴 -->
			<div class="col-md-2 side-menu">
				<ul>
					<li><a href="/myreview/list.do" class="active">상품 리뷰</a></li>
					<li><a href="/myorder/list.do">주문내역</a></li>
					<li><a href="/qna/list.do">Q&A</a></li>
					<li><a href="/mycoupon/list.do">쿠폰</a></li>
					<li><a href="/myrate/list.do">적립금</a></li>
					<li><a href="/mygiftcard/list.do">상품권</a></li>
					<li><a href="/member/addr.do">배송지 관리</a></li>
					<li><a href="/recent/list.do">최근 본 상품</a></li>
					<li><a href="/member/update.do">개인정보 수정</a></li>
				</ul>
			</div>

			<!-- 메인 콘텐츠 -->
			<div class="col-md-10">
				<!-- 탭 -->
				<div class="tabs">
					<a href="#available-reviews" class="active">작성 가능한 리뷰 (0)</a> <a
						href="#written-reviews">작성한 리뷰 (${myPostCount })</a>
				</div>
				<!-- 작성 가능한 리뷰 -->
				<div id="available-reviews" class="content-section reviewCan">
					<div class="empty-message">
						작성 가능한 리뷰가 없습니다.
						<div class="sub-message">마음에 드는 상품을 구매하시고, 리뷰를 남겨보세요.</div>
					</div>
				</div>

				<!-- 작성한 리뷰 -->
				<div id="written-reviews" class="content-section">
					<section class="review_list" id="review_view">
						<c:if test="${empty list}">
							<h4>작성된 리뷰가 없습니다.</h4>
						</c:if>
						<c:if test="${!empty list}">

							<div class="review_row">

								<c:forEach items="${list}" var="vo" varStatus="vs">
									<c:if test="${id == vo.id }">

										<c:if test="${(vs.index != 0) && (vs.index % 3 == 0)}">
                            ${"</div>"}
                            ${"<div class='review_row'>"}
                        </c:if>
										<!-- 개별 상품 표시 -->

										<div class="review_gallery dataRow">

											<div>
												<div class="review_gallery_list">
													<img src="${vo.filename}">
												</div>
												<div class="gallery-text">
													<input type="hidden" class="rno" data-rno="${vo.rno}">
													<span style="font-size: 15px;">${vo.title}</span> <br>
													<span>${vo.id }</span> &emsp;<span
														style="color: gray; font-size: 10px;"><fmt:formatDate
															value="${vo.writeDate }" /></span> <br>
													<div class="stars">
														<span>평점 :</span>
														<c:forEach var="i" begin="1" end="5">
															<img
																src="<c:choose>
							                <c:when test='${i <= vo.stars}'>
							                    /resources/images/icons/star.svg
							                </c:when>
							                <c:otherwise>
							                    /resources/images/icons/star_empty.png
							                </c:otherwise>
							            </c:choose>"
																alt="별" style="width: 20px; height: 20px;">
														</c:forEach>
													</div>
												</div>

											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</c:if>


					</section>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
	    $(".tabs a").on("click", function(e) {
		e.preventDefault();

		// 탭 활성화 상태 변경
		$(".tabs a").removeClass("active");
		$(this).addClass("active");

		// 탭에 따라 컨텐츠 변경
		const target = $(this).attr("href");
		$(".content-section").hide(); // 모든 섹션 숨기기
		$(target).show(); // 선택한 섹션만 표시
	    });

	    // 기본으로 첫 번째 탭의 내용 표시
	    $(".content-section").hide();
	    $("#available-reviews").show();
	});
    </script>
	<script type="text/javascript">
	$(function() {

	    // 이벤트 처리 - 리스트에서 상품을 클릭했을때
	    $(".dataRow").click(
		    function() {
			let rno = $(this).find(".rno").data("rno");
			location = "/myreview/view.do?rno=" + rno
				+ "&${pageObject.pageQuery}";
		    });

	    // perPageNum 값이 변경되었을 때 이벤트 처리
	    $("#perPageNum").change(function() {
		//alert("change perPageNum");
		$("#searchForm").submit();
	    });

	    // 검색 데이터 세팅
	    // key 값이 없으면 '제목' 으로 세팅
	    $("#key").val('${(empty pageObject.key)?"t":pageObject.key}');
	    // perPageNum 세팅
	    // perPageNum 이 없으면 '10' 으로 세팅
	    $("#perPageNum")
		    .val(
			    '${(empty pageObject.perPageNum)?"8":pageObject.perPageNum}');

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
</body>
</html>
