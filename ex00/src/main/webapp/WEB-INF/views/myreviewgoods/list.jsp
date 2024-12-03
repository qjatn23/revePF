<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap 스타일 및 스크립트 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery UI 스타일 및 스크립트 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>

<!-- 커스텀 스타일 -->
<!-- 공통 CSS -->
<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/review.css?ver=9.0">
<title>Review</title>

<style type="text/css">

.review_container {
	width: 1200px;
	margin-left: 92px;
	padding: 0;
}
.review_row {
	
}

</style>
</head>
<body class="body" id="body">
	<div class="review_container">
		<section class="review_list" id="review_view">
			<c:if test="${empty list}">
				<h4>작성된 리뷰가 없습니다.</h4>
			</c:if>
			<c:if test="${!empty list}">
				<div class="review_row">
					<c:forEach items="${list}" var="vo" varStatus="vs">
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
									<span style="font-size:15px;">${vo.title}</span> <br>
									<span>${vo.id }</span> 
									&emsp;<span style="color:gray; font-size:10px;"
									><fmt:formatDate value="${vo.writeDate }" /></span> <br>
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
					</c:forEach>
				</div>
			</c:if>

			<!-- 상품 등록 버튼 -->
			<div class="review_btn">
				<a href="/myreview/writeForm.do?perPageNum=" ${pageObject.perPageNum }
					class="btn btn-primary">등록</a>
			</div>

			<!-- 페이지 네비게이션 -->
			<div>
				<pageNav:pageNav listURI="/myreviewgoods/list.do" pageObject="${pageObject}"></pageNav:pageNav>
			</div>
		</section>
	</div>


	<script type="text/javascript" src="/resources/js/mainslider.js?after"></script>
	<script type="text/javascript" src="/resources/js/product.js?after"></script>







	<script type="text/javascript">
	$(function() {

	    // 이벤트 처리 - 리스트에서 상품을 클릭했을때
	    $(".dataRow").click(function() {
		let rno = $(this).find(".rno").data("rno");
		location = "/myreview/view.do?rno=" + rno + "&${pageObject.pageQuery}";
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