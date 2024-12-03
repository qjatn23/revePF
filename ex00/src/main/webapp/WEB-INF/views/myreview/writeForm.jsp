<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review 등록</title>
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
<link rel="stylesheet" href="/resources/styles/reponsive.css?after">
<style>
.container {
	padding-top: 130px;
}
#star-display img {
	width: 30px;
	height: 30px;
}
</style>
</head>
<body>
<div class="container">
  <h2><i class="fa fa-edit"></i> Review 등록</h2>
  <br>
  <form action="write.do" method="post" enctype="multipart/form-data">
  	<input type="hidden" name="perPageNum" value="${param.perPageNum }">
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" class="form-control" id="title"
      	pattern="^[^ .].{2.99}$" required
      	title="맨앞에 공백문자 불가, 3~100자입력"
       placeholder="제목 입력" name="title">
    </div>
    <div class="form-group">
      <label for="content">내용</label>
      <textarea class="form-control" rows="7" id="content" required
      	name="content" placeholder="내용 입력"></textarea>
    </div>
    <div class="form-group">
      <label for="imageName">첨부이미지</label>
      <input type="file" class="form-control" id="imageFile"
      	name="imageFile">
    </div>
    <div class="form-group">
    <label for="stars">별점</label>
    <input type="number" class="form-control" id="stars" name="stars" min="1" max="5" 
           placeholder="1에서 5 사이의 숫자를 입력">
    <!-- 별점 미리보기 -->
    <div id="star-display" style="margin-top: 10px;"></div>
</div>
    <button type="submit" class="btn btn-primary">등록</button>
    <button type="reset" class="btn btn-secondary">새로입력</button>
    <button type="button" class="btn btn-success" onclick="history.back();"
    	id="cancelBtn">취소</button>
  </form>
</div>

<script>
document.getElementById("stars").addEventListener("input", function () {
    const starsInput = parseInt(this.value, 10); 
    const starDisplay = document.getElementById("star-display"); 
    starDisplay.innerHTML = ""; 
    if (starsInput >= 1 && starsInput <= 5) {
        for (let i = 0; i < starsInput; i++) {
            const star = document.createElement("img");
            star.src = "/resources/images/icons/star.svg"; 
            star.alt = "별";
            star.style.width = "30px"; 
            star.style.height = "30px";
            starDisplay.appendChild(star);
        }
    } else if (starsInput) {
        starDisplay.textContent = "1에서 5 사이의 숫자를 입력해주세요.";
    }
});
</script>

</body>
</html>
