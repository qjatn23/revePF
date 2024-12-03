<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>쿠폰 관리</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
    <style>


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
            margin-bottom: 50px;
            border-bottom: 2px solid #000;
            padding-bottom: 25px;
            margin-top: 20px;
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

        .main-content {
            padding-left: 20px;
        }

        .coupon-management h5 {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .coupon-section .form-control {
            border: 2px solid #000; /* 테두리 두께를 2px로 설정 */
            box-shadow: none; /* 기본 브라우저 그림자 제거 */
            border-radius: 4px; /* 둥근 테두리 */
        }

        .coupon-section .btn-dark {
            background-color: #333; /* 기본 배경색 */
            color: #fff; /* 텍스트 색상 */
            padding: 10px 20px; /* 버튼 크기 조정 */
            border-radius: 4px; /* 둥근 모서리 */
        }

        .coupon-section .btn-dark:hover {
            background-color: #555; /* 호버 시 밝은 색상으로 변경 */
            color: #fff; /* 텍스트 유지 */
        }

        .coupon-input {
            border: 2px solid #000; /* 두꺼운 테두리 */
            padding: 10px;
            font-size: 1rem;
            border-radius: 4px;
            margin-right: 5px;
            width: 250px; /* 입력창 너비 */
        }

        .btn-coupon {
            background-color: #000; /* 검은색 버튼 */
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-coupon:hover {
            background-color: #555; /* 호버 시 색상 */
        }

        .input-group span {
            margin: 0 5px;
            font-size: 1.2rem;
            font-weight: bold;
        }
        /* 조건부 시리얼 쿠폰 박스 스타일 */
		.serial-coupon h5 {
		    font-size: 1.5rem;
		    font-weight: bold;
		    margin-bottom: 15px;
		}
		
		.serial-coupon .input-group {
		    display: flex;
		    align-items: center; /* 수직 가운데 정렬 */
		    gap: 10px; /* 입력 필드 간 간격 */
		}
		
		.serial-coupon .input-group span {
		    font-size: 1.5rem; /* 구분선 크기 */
		    color: #333; /* 구분선 색상 */
		}
		
		.serial-coupon .coupon-input {
		    width: 100px; /* 입력 필드 너비 */
		    height: 50px; /* 입력 필드 높이 */
		    border: 2px solid #333; /* 두꺼운 테두리 */
		    border-radius: 4px; /* 모서리 둥글게 */
		    text-align: center; /* 텍스트 가운데 정렬 */
		    font-size: 1.2rem; /* 입력 텍스트 크기 */
		}
		
		.serial-coupon .btn-coupon {
		    width: 150px; /* 버튼 너비 */
		    height: 50px; /* 버튼 높이 */
		    background-color: #333; /* 버튼 배경색 */
		    color: #fff; /* 버튼 텍스트 색상 */
		    border: none; /* 버튼 테두리 제거 */
		    border-radius: 4px; /* 버튼 모서리 둥글게 */
		    font-size: 1.2rem; /* 버튼 텍스트 크기 */
		    cursor: pointer; /* 커서를 손가락 모양으로 변경 */
		}
		
		.serial-coupon .btn-coupon:hover {
		    background-color: #555; /* 호버 시 배경색 변경 */
		}

        

        .coupon-section {
            margin-bottom: 30px;
        }
		.coupon-section:nth-of-type(3) { 
		    margin-top: 30px; /* 마이쿠폰 위쪽 여백 추가 */
		}

        .info-text {
            font-size: 1rem;
            color: #999;
            margin-top: 5px;
        }

        /* 테이블 스타일 */
        .table-bordered th {
            background-color: #333;
            color: #fff;
            font-size: 1rem;
        }

        .table-bordered td {
            font-size: 0.9rem;
        }

        /* 쿠폰 이용 안내 */
        .coupon-guide h5 {
            font-size: 1.2rem; /* 제목 크기 */
            font-weight: bold; /* 굵게 */
            margin-bottom: 15px;
        }

        .coupon-guide ul {
            list-style-type: disc; /* 점 스타일 */
            margin-left: 20px; /* 왼쪽 여백 */
            font-size: 1rem; /* 글씨 크기 */
        }

        .coupon-guide li {
            line-height: 1.5; /* 줄 간격 */
            margin-bottom: 10px; /* 항목 간 간격 */
        }

        .small-text {
            font-size: 0.85rem;
            color: #999;
        }

        .btn-sm {
            padding: 5px 10px;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <h1 class="title">쿠폰 관리</h1>
        
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
            <div class="col-md-10 main-content">
                <div class="coupon-management">
                    <!-- 쿠폰 인증번호 등록 -->
                    <div class="coupon-section">
					    <h5>쿠폰인증번호 등록하기</h5>
					    <form action="/mycoupon/validate.do" method="post">
					        <div class="input-group">
					            <input type="text" name="code" class="coupon-input" required>
					            <button type="submit" class="btn-coupon">쿠폰번호 인증</button>
					        </div>
					    </form>
					    <p class="info-text">- 반드시 쇼핑몰에서 발행한 쿠폰번호만 입력해주세요. (4~10자 알파벳 및 숫자)</p>
					</div>

                    <!-- 마이 쿠폰 -->
                    <div class="coupon-section">
                        <h5>마이쿠폰</h5>
                        <table class="table table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">쿠폰명</th>
                                    <th scope="col">쿠폰혜택</th>
                                    <th scope="col">사용가능 기간</th>
                                    <th scope="col">쿠폰적용 상품</th>
                                    <th scope="col">사용여부</th>
                                    <th scope="col">사용일</th>
                                </tr>
                            </thead>
                            <tbody>
                               <c:forEach items="${list}" var="vo" varStatus="vs">
           						<tr>
						                <!-- NO -->
						                <td>${vo.no}</td>
						
						                <!-- 쿠폰명 -->
						                <td>${vo.name}</td>
						
						                <!-- 쿠폰혜택 -->
						                <td>
										     <c:choose>
										        <c:when test="${vo.discount_type == 'percent'}">
										            ${vo.discount_value}% 할인 <!-- percent일 때 -->
										        </c:when>
										        <c:when test="${vo.discount_type == 'amount'}">
										            ${vo.discount_value}원 할인 <!-- amount일 때 -->
										        </c:when>
										    </c:choose>
						                </td>
						
						                <!-- 사용가능 기간 -->
						                <td>
						                    <fmt:formatDate value="${vo.valid_from}" pattern="yyyy-MM-dd" />
						                    ~
						                    <fmt:formatDate value="${vo.valid_until}" pattern="yyyy-MM-dd" />
						                </td>
						
						                <!-- 쿠폰적용 상품 -->
						                <td>제한없음</td> <!-- This can be dynamic if you have the actual products in your data -->
						
						                <!-- 사용여부 -->
						                <td>${(vo.is_used == 1) ? '사용' : '미사용'}</td> <!-- Assuming there's a used field in your data -->
						
						                <!-- 사용일 -->
						                <td>
						                    <fmt:formatDate value="${vo.used_at}" pattern="yyyy-MM-dd" />
						                </td>
						            </tr>
						        </c:forEach>
						    </tbody>
                        </table>
                    </div>


                    <!-- 쿠폰 이용 안내 -->
                    <div class="coupon-guide">
                        <h5>쿠폰 이용 안내</h5>
                        <ul>
                            <li>구매 취소/교환, 반품 진행에 따라 구매에 적용한 쿠폰은 자동으로 복구됩니다.</li>
                            <li>등록된 쿠폰은 고객 본인만 사용할 수 있습니다.</li>
                            <li>사용 가능 기간 내에서만 사용이 가능합니다.</li>
                            <li>쿠폰은 세일 상품에는 적용되지 않을 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
	<script>
    $(document).ready(function(){
        $(".btn-coupon").click(function(){
            var code = $(".coupon-input").val(); // 입력된 쿠폰 번호
            if(code) {
                $.ajax({
                    url: "/mycoupon/validate.do", // 서버의 URL
                    method: "POST",
                    data: { code: code }, // 쿠폰 번호 전달
                    success: function(result, status, xhr) {
                    	console.log("result: " + JSON.stringify(result));
                    	console.log("status: " + status);
                    	console.log("xhr: " + xhr);
                    	console.log(result.status);
                        if(result.status === "success") {
                            alert("쿠폰 인증 성공!");
                            location.reload(); // 인증 후 테이블을 갱신
                        } else {
                            alert("쿠폰 인증 실패! 쿠폰 번호를 확인하세요.");
                        }
                    },
                    error: function() {
                        alert("서버 오류 발생!");
                    }
                });
            } else {
                alert("쿠폰 번호를 입력해주세요.");
            }
            return false;
        });
    });
</script>
</body>
</html>
