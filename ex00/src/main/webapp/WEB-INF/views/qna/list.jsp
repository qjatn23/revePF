<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
<style>
.dataRow>.card-header {
	background: #e0e0e0;
}

.dataRow:hover {
	border-color: #000000;
	cursor: pointer;
}


article {
	width: 100%;
	max-width: 1920px;
	margin: 0 auto;
	height: 700px;
	padding-top: 100px;
}

.title {
	font-size: 1.8rem;
	font-weight: bold;
	margin-bottom: 50px; /* 제목과 라인 사이 여백 */
	border-bottom: 2px solid #000; /* 밑줄 */
	padding-bottom: 25px; /* 텍스트와 밑줄 사이 간격 추가 */
	margin-top: 20px; /* 제목 위쪽 여백 추가 */
}

.nav-tabs {
	margin-top: 30px; /* 라인 아래쪽 공간 추가 */
	display: flex;
	border-bottom: 2px solid #ccc;
}

.nav-tabs a {
	text-decoration: none;
	color: #555;
	padding: 10px 20px;
	margin-right: 10px;
}

.nav-tabs a.active {
	font-weight: bold;
	color: #000;
	border-bottom: 2px solid #000;
}

.empty-message {
	margin-top: 20px; /* 이전 30px에서 50px로 늘림 */
	color: #999;
	text-align: center;
	font-size: 1.2rem;
}

.content-section {
	margin-top: 20px; /* 기존 20px에서 40px로 증가 */
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

.tab-pane {
	margin-top: 15px;
}

.QNAbtn {
	border: 1px solid black;
}

.QNAbtn:hover {
	background: black;
	color: white;
}
</style>
</head>
<body>
	<div class="container" >
		<h1 class="title">Q&A</h1>

		<div class="row">
			<!-- 사이드 메뉴 -->
			<div class="col-md-2 side-menu">
				<ul>
					<li><a href="/myreview/list.do" class="active">상품 리뷰</a></li>
					<li><a href="/myorder/list.do">주문내역</a></li>
					<li><a href="/qna/list.do">Q&A</a></li>
					<li><a href="/mycoupon/list.do">쿠폰</a></li>
					<li><a href="/member/points">적립금</a></li>
					<li><a href="/member/giftcards">상품권</a></li>
					<li><a href="/member/addr.do">배송지 관리</a></li>
					<li><a href="/recent/list.do">최근 본 상품</a></li>
					<li><a href="/member/update.do">개인정보 수정</a></li>
				</ul>
			</div>

			<!-- 메인 콘텐츠 -->
			<div class="col-md-10">
				<!-- 탭 -->
				<ul class="nav nav-tabs">

					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#myQNA">내가 작성한 글</a></li>

				</ul>

				<!-- Tab panes -->
				<div class="tab-content">
					<div id="myQNA" class="container tab-pane active">
						<!-- 본인 글 여부 판단 -->
						<!-- 본인 글 여부 판단 -->
						<c:set var="hasMyPosts" value="false" />
						<c:forEach items="${list}" var="vo">
							<c:if test="${id == vo.writer}">
								<!-- 본인 글이 있으면 플래그를 true로 설정 -->
								<c:set var="hasMyPosts" value="true" />
							</c:if>
						</c:forEach>

						<c:if test="${hasMyPosts}">
							<span>최근 10개의 Q&A(답변포함)을 보여드립니다.</span>
							<c:forEach items="${list }" var="vo">
								<c:if test="${id == vo.writer || id == vo.parent_writer}">
									<div class="card dataRow" data-no="${vo.no }"
										style="${(vo.ans == 0)?'margin-top:10px;':''}">

										<!-- 작성글(ans==0)이면 상태 출력 -->
										<c:if test="${vo.ans == 0 }">
											<div class="card-header">상태 : ${vo.status }</div>
										</c:if>
										<!-- 작성글: 제목출력 -->
										<c:if test="${vo.ans == 0 }">
											<div class="card-body">
												${vo.title } <span style="color: gray; font-size: 10px;">${(vo.secret == 1)?'(비공개)':'' }</span>
											</div>
										</c:if>
										<!-- 답글: 제목 앞 답글기호 -->
										<c:if test="${vo.ans == 1 }">
											<div class="card-body" style="background: #E2E1EE">
												└ ${vo.title } <span style="color: gray; font-size: 10px;">${(vo.secret == 1)?'(비공개)':'' }</span>
											</div>
										</c:if>

										<div class="card-footer">
											${vo.writer }
											<!-- 작성일 -->
											<span style="color: gray"> &emsp;<fmt:formatDate
													value="${vo.writeDate }" pattern="yyyy-MM-dd" />
											</span>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<br>
							<a href="allList.do" class="btn QNAbtn">Q&A 글 더보기</a>
							<!-- 글등록 버튼 -->
						</c:if>

						<c:if test="${not hasMyPosts}">
							<div class="empty-message">
								작성하신 글이 없습니다.
								<div class="sub-message">궁금하신 점을 Q&A로 문의해보세요.</div>
							</div>
						</c:if>
						<a href="writeForm.do" class="btn QNAbtn">글등록</a> <br>
					</div>

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
	$(document).ready(
		function() {

		    // jquery 이벤트 코드는 이안에 작성한다.
		    $(".dataRow").click(
			    function() {
				// tag에 적힌 data-no="${vo.no}"
				let no = $(this).data("no");
				//alert(no);
				location = "/qna/view.do?no=" + no
					+ "&${pageObject.pageQuery}";
				// pageObject의 getPageQuery()를 가져와서
				// page, perPageNum, key, word를 붙인다.
			    });

		    // 검색 데이터 세팅
		    // key 값이 없으면 '제목' 으로 세팅
		    $("#key").val(
			    '${(empty pageObject.key)?"t":pageObject.key}');

		});
    </script>
</body>
</html>