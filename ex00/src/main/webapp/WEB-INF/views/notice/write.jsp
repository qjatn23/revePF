<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link rel="stylesheet" href="/resources/styles/reset.css?after">
<link rel="stylesheet" href="/resources/styles/common.css?after">
<link rel="stylesheet" href="/resources/styles/root.css?after">
<link rel="stylesheet" href="/resources/styles/main.css?after">
<link rel="stylesheet" href="/resources/styles/reponsive.css?after">
<title>공지사항 글쓰기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

</head>
<body>
	<div class="container">
		<h2>공지사항 글쓰기</h2>
		<form action="write.do" method="post">
			<div class="form-group">
				<label for="title">제목</label>
				<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
				<input class="form-control" name="title" id="title" required>
			</div>

			<div class="form-group">
				<label for="content">내용</label>
				<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
				<textarea class="form-control" name="content" id="content" rows="7"
					required></textarea>
			</div>
			<div class="form-group">
				<label for="startDate">게시시작일</label>
				<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
				<input class="form-control datepicker" name="startDate"
					id="startDate" required>
			</div>
			<div class="form-group">
				<label for="endDate">게시종료일</label>
				<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
				<input class="form-control datepicker" name="endDate" id="endDate"
					required>
			</div>
			<!-- form tag에서 <button>에 type이 없으면 submit -->
			<button class="btn btn-primary">등록</button>
			<button type="reset" class="btn btn-warning">새로입력</button>
			<button type="button" class="btn btn-success">취소</button>
		</form>
	</div>
	<script type="text/javascript">
	$(function() {
	    // 이벤트 처리
	    let now = new Date();
	    let startYear = now.getFullYear();
	    let yearRange = (startYear - 10) + ":" + (startYear + 10);

	    // 날짜 입력 설정
	    $(".datepicker").datepicker(
		    {
			// 입력란의 데이터 포맷
			dateFormat : "yy-mm-dd",
			// 월 선택 추가
			changeMonth : true,
			// 년 선택 추가
			changeYear : true,
			// 월 선택 입력(기본:영어->한글)
			monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월",
				"7월", "8월", "9월", "10월", "11월", "12월" ],
			// 달력의 요일 표시 (기본:영어->한글)
			dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
			// 선택할 수 있는 년도의 범위
			yearRange : yearRange
		    });

	});
    </script>
</body>
</html>