<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 정보 입력</title>
    <!-- 부트스트랩 CSS 로드 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet"> <!-- 고급스러운 폰트 -->
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f4f7fc;
            margin-top: 50px;
        }
        a {
            color: #333;
            text-decoration: none;
        }

        a:hover {
            color: #555;
        }

        /* 컨테이너 */
        .container {
            max-width: 900px;
            margin: 90px auto;
            padding: 20px;
        }

        /* 페이지 헤더 */
        h1 {
            font-size: 2.5rem;
            font-weight: 600;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
            
        }

        h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #34495e;
            margin-bottom: 10px;
            margin-top: 10px;
        }

        .form-group label {
            font-weight: 500;
            color: #34495e;
        }

        .form-control {
            font-size: 1rem;
            padding: 15px;
            border-radius: 6px;
            border: 1px solid #ddd;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #2980b9;
            box-shadow: 0 0 8px rgba(41, 128, 185, 0.3);
        }

        .btn-primary {
            background-color: #2980b9;
            border-color: #2980b9;
            padding: 12px 30px;
            font-size: 1.1rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #3498db;
            border-color: #3498db;
        }

        .form-group ul {
            list-style-type: none;
            padding: 0;
        }

        .form-group ul li {
            padding: 8px 0;
            font-size: 1.1rem;
            color: #34495e;
        }

		 /* 섹션 제목 스타일 */
		.section-title {
		    font-size: 2.2rem;
		    font-weight: 700;
		    color: #2c3e50;
		    margin-bottom: 30px;
		    text-align: center;
		    letter-spacing: 0.5px;
		    text-transform: uppercase;
		    border-bottom: 2px solid #e0e0e0;
		    padding-bottom: 10px;
		}
		
		/* 선택한 상품 목록 스타일 */
		.item-list {
		    list-style: none;
		    padding: 0;
		    margin: 0;
		}
		
		.item {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 15px 20px;
		    border-bottom: 1px solid #f4f4f4;
		    font-size: 1.3rem;
		    color: #34495e;
		    transition: background-color 0.3s, transform 0.3s ease;
		}
		
		.item:hover {
		    background-color: #f8f8f8;
		    transform: translateX(5px);
		}
		
		.item-name {
		    font-weight: 600;
		    color: #2c3e50;
		}
		
		.item-quantity {
		    color: #7f8c8d;
		}
		
		.item-price {
		    font-weight: 600;
		    color: #2c3e50;
		}
		
		/* 가격 섹션 스타일 */
		.price-details {
		    margin-top: 40px;
		    font-size: 1.6rem;
		    display: flex;
		    justify-content: space-between;
		    padding: 20px 0;
		    border-bottom: 1px solid #ddd;
		    font-weight: 500;
		}
		
		.price-title {
		    color: #2c3e50;
		    font-size: 1.2rem;
		    letter-spacing: 0.5px;
		    margin-left: 600px;
		}
		
		.price-amount {
		    font-weight: 700;
		    font-size: 1.5rem;
		    color: #2c3e50;
		}
		
		/* 할인 금액 강조 스타일 */
		.discount {
		    color: #2c3e50;
		}
		
		/* 최종 결제 금액 강조 스타일 */
		.total {
		    font-size: 1.8rem;
		    color: #2c3e50;
		    letter-spacing: 1px;
		}

        .btn-custom {
		    background: linear-gradient(135deg, #333333, #555555); /* 검은색 그라데이션 */
		    border: none;
		    color: white;
		    font-size: 1.4rem; /* 글자 크기 조정 */
		    padding: 12px 24px; /* 좌우 패딩을 줄여서 더 간결한 디자인 */
		    border-radius: 8px; /* 버튼 모서리를 약간 둥글게 */
		    cursor: pointer;
		    transition: all 0.3s ease-in-out; /* 부드러운 애니메이션 효과 */
		    width: auto;
		    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
		    text-transform: uppercase; /* 텍스트 대문자화 */
		    letter-spacing: 1px; /* 글자 간격을 넓혀서 세련된 느낌을 추가 */
		    margin-top: 30px;
		}
		
		.btn-custom:hover {
		    background: linear-gradient(135deg, #444444, #666666); /* 마우스를 올렸을 때 버튼 색상 변화 */
		    transform: translateY(-3px) scale(1.05); /* 버튼이 살짝 커지면서 위로 올라가는 효과 */
		    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3); /* 그림자 효과를 더 깊게 */
		}
    </style>
</head>
<body>
    <div class="container">
        <h1>주문 정보 입력</h1>
        <form action="/order/save" method="POST" onsubmit="prepareForm()">
            <!-- 숨겨진 필드 -->
            <input type="hidden" name="orderNo" value="${order.orderNo}">
            <input type="hidden" name="id" value="${order.id}">
            <input type="hidden" id="items" name="items">
            <input type="hidden" name="discount" value="${discount}">
            <input type="hidden" name="finalAmount" value="${finalAmount}">

            <!-- 사용자 입력 필드 -->
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="받으실분 이름을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" class="form-control" placeholder="받으실 주소를 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="phoneNumber">전화번호</label>
                <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="전화번호를 입력하세요" required>
            </div>

            <h2 class="section-title">선택한 상품</h2>
				<div class="form-group">
				    <ul id="selected-items" class="item-list">
				        <c:forEach items="${selectedItems}" var="item">
				            <li class="item">
				                <span class="item-name">${item.name}</span> 
				                <span class="item-quantity">(${item.quantity}개)</span> 
				                <span class="item-price">₩ ${item.totalPrice}</span>
				            </li>
				        </c:forEach>
				    </ul>
				</div>
				
				<div class="price-details">
				    <h3 class="price-title">할인 금액</h3>
				    <span class="price-amount discount">₩ ${discount}</span>
				</div>
				
				<div class="price-details">
				    <h3 class="price-title">최종 결제 금액</h3>
				    <span class="price-amount total">₩ ${finalAmount}</span>
				</div>

            <div class="form-group text-center">
                <button type="submit" class="btn btn-custom">결제하기</button>
            </div>
        </form>
    </div>

    <!-- 부트스트랩 JS 및 의존성 스크립트 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function prepareForm() {
            const items = [
                <c:forEach items="${selectedItems}" var="item">
                    {
                        name: "${item.name}",
                        quantity: ${item.quantity},
                        totalPrice: ${item.totalPrice}
                    }<c:if test="${!itemStatus.last}">,</c:if>
                </c:forEach>
            ];

            document.getElementById("items").value = JSON.stringify(items);
        }
    </script>
</body>
</html>
