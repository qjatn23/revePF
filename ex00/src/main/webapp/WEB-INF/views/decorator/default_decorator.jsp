<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<!DOCTYPE html>
<html>
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

<!-- AOS  -->
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<!-- swiper -->
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />


<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- loginForm JS -->
<script src="/resources/js/loginForm.js"></script>

<!-- icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<!-- web-font [pretendard] -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />

<!-- 공통 CSS -->
<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/brand_list.css?ver=8.0">
<link rel="stylesheet" href="/resources/styles/product_list.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/eventpage.css?ver=4.0">
<link rel="stylesheet" href="/resources/styles/review.css?ver=1.0">
<link rel="stylesheet" href="/resources/styles/mypage.css?ver=1.0">
<link rel="stylesheet" href="/resources/styles/view.css?ver=1.0">


<!-- Main js -->
<script type="text/javascript" src="/resources/js/common.js"></script>
<style type="text/css">


.slide-menu {
    position: fixed;
    top: 0;
    left: -300px; 
    width: 300px;
    height: 100%;
    background-color: var(--gray);
    color: white;
    transition: 0.3s; 
    padding-top: 60px;
    z-index: 1000; 
    opacity: 0.8
}

.slide-menu ul {
    list-style-type: none;
    padding: 0;
}

.slide-menu ul li {
    padding: 30px 15px;
    text-align: left;
}

.slide-menu ul li a {
    color: #000;
    text-decoration: none;
    font-size: 18px;
    display: block;
}

.slide-menu .close-btn {
    position: absolute;
    top: 10px;
    right: 25px;
    font-size: 36px;
    color: #000;
    background: none;
    border: none;
    cursor: pointer;
}

.slide-menu.active {
    left: 0;
}
.search-bar {
    position: fixed;
    top: -200px; /* 화면 위에 숨김 */
    left: 0;
    width: 100%;
    height: 200px;
    background-color: #f8f8f8;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: top 0.3s ease; /* 애니메이션 효과 */
    z-index: 1000;
}

.search-bar input {
    width: 90%;
    height: 40px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 0 10px;
    font-size: 16px;
}

</style>

<title>Reve : <decorator:title />
</title>


<decorator:head />
</head>
<body>

	<!-- header -->
	<header class="header">
		<div class="header-topbanner">
			<a href="/member/loginForm.do">신규 회원가입 시 50,000원 웰컴쿠폰 즉시 발급</a>
		</div>
		<div class="header-wrap display-flex">
			<div class="header-contents display-flex">
				<h1 class="logo">
					<a href="/main/main.do"><img src="/resources/images/logo.svg"
						alt="REVE로고"></a>
				</h1>
				<nav class="gnb">
					<ul class="display-flex">
						<li><a href="/brands/list.do">BRAND</a></li>
						<li><a href="/woman/list.do">WOMAN</a></li>
						<li><a href="/goods/list.do">MAN</a></li>
						<li><a href="/myreview/allList.do">REVIEW</a></li>
						<li><a href="/member/view.do">MYPAGE</a></li>
					</ul>
				</nav>
				<div class="header-icons display-flex">
					<ul class="display-flex">
						<li class="search-icon">
							<button>
								<img src="/resources/images/icons/search.svg" alt="검색 아이콘">
							</button>
						</li>
						<li class="userpage-icon"><a href="/member/view.do"> <img
								src="/resources/images/icons/usericon.svg" alt="유저 아이콘">
						</a></li>
						<li class="shoppingbag-icon"><a href="/cart/list.do"> <img
								src="/resources/images/icons/cart.svg" alt="카트 아이콘">
						</a></li>
					</ul>
					<!-- 로그인/로그아웃 버튼 -->
					<c:choose>
						<c:when test="${not empty login}">
							<span class="login-icon"> <a href="/member/logout.do">
									<img alt="로그아웃" src="/resources/images/icons/unlock.svg">
							</a>
							</span>
						</c:when>
						<c:otherwise>
							<span class="login-icon"> <a href="/member/loginForm.do"><img
									src="/resources/images/icons/lock.svg" alt="자물쇠 아이콘" /></a>
							</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="header-contents__Mobile">
				<div class="m-header__wrap display-flex">
					<h1 class="logo display-flex">
						<a href="/main/main.do"> <img
							src="/resources/images/logo_light.svg" alt="REVE로고"
							class="logo-white"> <img src="/resources/images/logo.svg"
							alt="REVE로고" class="logo-black">
						</a>
					</h1>
					<span class="m-login-icon"> <a href="/member/loginForm.do">
							<img src="/resources/images/icons/lock.svg" alt=""
							class="m-lockicon-black"> <img
							src="/resources/images/icons/lock_white.svg" alt=""
							class="m-lockicon-white">
					</a>
					</span>
				</div>
			</div>
		</div>
	</header>
	<!-- /header -->

	<article>
		<!-- 여기에 개발자 작성한 body 태그 안에 내용이 들어온다. -->
		<decorator:body />
	</article>

	<!-- footer -->
	<footer class="footer">
		<div class="footer-wrap">
			<div class="footer-contents display-flex">
				<div class="footer-company">
					<ul class="footer-contents__list display-flex">
						<li><a href="#">회사소개</a></li>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">이용약관</a></li>
						<li><a href="#">개인정보처리방침</a></li>
						<li><a href="#">제휴상담</a></li>
					</ul>
					<div class="company-infowrap display-flex">
						<p>(주)레브</p>
						<ul class="company-info__list">
							<li><strong class="txt-bold">대표자명</strong></li>
							<li><strong class="txt-bold">사업자등록번호</strong> 201-86-12345 <a
								href="#" style="display: inline-block;">[사업자정보확인]</a></li>
							<li><strong class="txt-bold">통신판매업신고번호</strong>
								205-경기고양-1234</li>
							<li><strong class="txt-bold">주소</strong> (12345) 경기도 고양시
								일산서구</li>
							<li><strong class="txt-bold">개인정보보호책임자</strong></li>
						</ul>
					</div>
				</div>
				<a class="logo" href="index.html"> <img
					src="/resources/images/logo_light.svg" alt="로고">
				</a>
				<div class="footer-service display-flex">
					<p class="csnumber">
						고객센터 <a href="tel:01011112222" style="display: inline-block;">1588-1125</a>
					</p>
					<p>
						<strong class="txt-bold">운영시간</strong> 10:00 ~ 17:00 (토,일요일 / 공휴일
						휴무)
					</p>
					<p>
						<strong class="txt-bold">E-mail</strong> <a
							href="mailto:123412345@gmail.com" style="display: inline-block;">11112222@gmail.com</a>
					</p>
					<div class="footer-snsicons">
						<ul class="snsicons-list display-flex">
							<li><a href="#"> <img
									src="/resources/images/icons/sns_instagram.svg" alt="인스타그램">
							</a></li>
							<li><a href="#"> <img
									src="/resources/images/icons/sns_x.svg" alt="엑스">
							</a></li>
							<li><a href="#"> <img
									src="/resources/images/icons/sns_youtube.svg" alt="유튜브">
							</a></li>
						</ul>
					</div>
				</div>
			</div>
			<p class="footer-copyright">COPYRIGHT © REVE ALL RIGHT RESERVED.
			</p>
		</div>

		<div class="footer-wrap__mobile">
			<a class="logo" href="index.html"> <img
				src="/resources/images/logo_light.svg" alt="로고">
			</a>
			<div class="m-footer__contents">
				<div class="m-footer-infolist">
					<button class="m-footer__contenttitle display-flex">
						Company Info <span><img
							src="/resources/images/icons/arrow-down.svg" alt=""></span>
					</button>
					<div class="m-footer__contentinner">
						<ul class="company-info__list">
							<li><strong class="txt-bold">대표자명</strong></li>
							<li><strong class="txt-bold">사업자등록번호</strong> 201-86-12345 <a
								href="#" style="display: inline-block;">[사업자정보확인]</a></li>
							<li><strong class="txt-bold">통신판매업신고번호</strong>
								205-경기고양-1234</li>
							<li><strong class="txt-bold">주소</strong> (12345) 경기도 고양시
								일산서구</li>
							<li><strong class="txt-bold">개인정보보호책임자</strong></li>
						</ul>
					</div>
				</div>
				<div class="m-footer-infolist">
					<button class="m-footer__contenttitle display-flex">
						Community <span><img
							src="/resources/images/icons/arrow-down.svg" alt=""></span>
					</button>
					<div class="m-footer__contentinner">
						<ul class="company-info__list">
							<li><a href="#"><strong class="txt-bold">공지사항</strong></a></li>
							<li><a href="#"><strong class="txt-bold">QNA</strong></a></li>
							<li><strong class="txt-bold">고객센터</strong> <a
								href="tel:01047829909" style="display: inline-block;">1588-1125</a></li>
						</ul>
					</div>
				</div>

				<div class="m-footer-infolist">
					<button class="m-footer__contenttitle display-flex">
						Terms of service <span><img
							src="/resources/images/icons/arrow-down.svg" alt=""></span>
					</button>
					<div class="m-footer__contentinner">
						<ul class="company-info__list">
							<li><a href="#"><strong class="txt-bold">이용약관</strong></a></li>
							<li><a href="#"><strong class="txt-bold">개인정보
										처리방침</strong></a></li>
						</ul>
					</div>
				</div>
				<div class="m-footer-infolist">
					<button class="m-footer__contenttitle display-flex">
						Social Media <span><img
							src="/resources/images/icons/arrow-down.svg" alt=""></span>
					</button>
					<div class="m-footer__contentinner">
						<ul class="company-info__list">
							<li><a href="#"><strong class="txt-bold">Instagram</strong></a></li>
							<li><a href="#"><strong class="txt-bold">X
										(Twitter)</strong></a></li>
							<li><a href="#"><strong class="txt-bold">Youtube</strong></a></li>
						</ul>
					</div>
				</div>
			</div>
			<p class="footer-copyright">COPYRIGHT © REVE ALL RIGHT RESERVED.
			</p>
		</div>
	</footer>
	<!-- /footer -->

	<div class="navbar-only__mobile">
		<ul class="display-flex">
			<li><a href="#" class="menu-button" onclick="toggleMenu()"> <img
					src="/resources/images/icons/category.svg" alt="">
					<p>카테고리</p>
			</a></li>
			<li><a href="#" onclick="toggleSearchBar()"> <img
					src="/resources/images/icons/search02.svg" alt="">
					<p>검색</p>
			</a></li>
			<li><a href="/main/main.do"> <img
					src="/resources/images/icons/home.svg" alt="">
					<p>홈</p>
			</a></li>
			<li><a href="/member/view.do"> <img
					src="/resources/images/icons/usericon02.svg" alt="">
					<p>마이페이지</p>
			</a></li>
			<li><a href="/cart/list.do"> <img
					src="/resources/images/icons/cart02.svg" alt="">
					<p>장바구니</p>
			</a></li>
		</ul>
	</div>

<div id="categoryMenu" class="slide-menu">
    <button class="close-btn" onclick="toggleMenu()">×</button>
    <ul>
        <li><a href="/brands/list.do">BRAND</a></li>
        <li><a href="/woman/list.do">WOMAN</a></li>
        <li><a href="/goods/list.do">MAN</a></li>
        <li><a href="/myreview/allList.do">REVIEW</a></li>
        <li><a href="/member/view.do">MYPAGE</a></li>
    </ul>
</div>

<div class="search-bar" id="searchBar">
    <input type="text" placeholder="검색어를 입력하세요">
</div>
	<button class="topbutton">
		<img src="/resources/images/icons/totop.svg" alt="">
	</button>




	<!-- The Modal -->
	<div class="modal fade" id="msgModal" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">${msg}</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<!-- session 담은 msg를 보여주는 모달창 -->
	<c:if test="${!empty msg}">
		<!-- 모달을 보이게하는 javascript -->
		<script type="text/javascript">
	    $(function() {
		$("#msgModal").modal("show");

	    })
	</script>
	</c:if>
	
	<script type="text/javascript">
	function toggleMenu() {
	    var menu = document.getElementById("categoryMenu");
	    menu.classList.toggle("active");
	}

	
	</script>
	<script type="text/javascript">
	
	
	</script>
	
	<script>
	AOS.init();
    </script>
</body>
</html>
<%-- <%session.removeAttribute("msg"); %> --%>







