<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<meta charset="UTF-8">
<title>Review 보기</title>
<style>
</style>
<script type="text/javascript">
let id = "${id}";// id를 하드코딩 - member table에 등록된 id중 - 로그인 id
let rno = ${vo.rno};
let gradeNo = ${gradeNo};
</script>
<!-- 2. 날짜 및 시간 처리함수 선언 -->
<script type="text/javascript" src="/js/dateTime.js"></script>

<!-- 댓글 페이지네이션 함수 선언 -->
<script type="text/javascript" src="/js/util.js"></script>

<!-- 3. 댓글 객체 (replySerive) 를 선언 : Ajax 처리부분 포함 -->
<!-- 댓글 처리하는 모든 곳에 사용하는 부분을 코딩 -->
<script type="text/javascript" src="/js/qnaReply.js"></script>
<script type="text/javascript" src="/js/qnaReplyProcess.js"></script>
<!-- 2.라이브러리 확인 -->
<script type="text/javascript">
// jquery: $(ducument).ready(function(){~~~});
// 페이지가 로딩완료 후 세팅이 진행된다.
$(function(){
	console.log("jquery loading......");
	
	$('[data-toggle="tooltip"]').tooltip();   
	
	$("#deleteBtn").click(function(){
		console.log("deleteBtn event......");
		if (!confirm("정말삭제하시겠습니까?")) return false;
	});
	
		$(".card-header").on("change", ".status", function() {
			// 변경된 값을 알아내는 것
			let changeData = $(this).val();
			let data = $(this).data("data");
			console.log("원래데이터=" + data + ", 변경데이터=" + changeData);
			if (changeData == data) {
				$(this).next().find("button").prop("disabled", true);
			}
			else {
				$(this).next().find("button").prop("disabled", false);
			}
		});
		
	
});
</script>
<style>
.rvoCard{
	margin: 0 0 15px 0;
}
.container {
	padding-top : 200px;
	width: 100%;
	height: 100%;
	min-height: 100vh;
}

</style>
<link rel="stylesheet" href="/resources/styles/reset.css?after">
<link rel="stylesheet" href="/resources/styles/common.css?after">
<link rel="stylesheet" href="/resources/styles/root.css?after">
<link rel="stylesheet" href="/resources/styles/reponsive.css?after">
<link rel="stylesheet" href="/resources/styles/main.css?after">
</head>
<body>
	<div class="container">
		<input type="hidden" name="rno" value="${vo.rno }"> <input
			type="hidden" name="id" value="${vo.id }">
		<div class="card">
			<div class="card">
				<div class="card-header">
					<b>${vo.title }</b>
				</div>
				<div class="card-body">
					<div class="card">
						<div class="card-body">
							<c:forEach items="${vo.filename }">
								<div class="col-md-3">
									<div class="img-thumbnail">
									<a href="${vo.filename}" target="_blank">
										<img class="card-img-top" src="${vo.filename }" alt="image">
									</a>
									</div>
									
								</div>
							</c:forEach>
						</div>
						<div class="card-body">
							<p class="card-text">
							<pre>${vo.content }</pre>
							</p>
						</div>
					</div>
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
				<div class="card-footer">
					${vo.id} <span style="color: gray"> &emsp;<fmt:formatDate
							value="${vo.writeDate }" pattern="yyyy-MM-dd" />
					</span>
				</div>
			</div>
		</div>
		<!-- a tag : 데이터를 클릭하면 href 정보를 가져와서 페이지이동 -->
			<button type="button" class="btn btn-info" onclick="history.back()">이전으로</button>
		<c:if test="${(gradeNo == 9 || id == vo.id) && id != null }">
			<a href="updateForm.do?rno=${param.rno }" class="btn btn-secondary">수정</a>
			<form action="delete.do?rno=${param.rno }" method="post"
				style="display: inline;">
				<button class="btn btn-danger" id="deleteBtn">삭제</button>
			</form>
		</c:if>

	</div>
	<!-- end of class="container" -->
</body>
</html>