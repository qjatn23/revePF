<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 요약</title>

    <!-- 고급스러운 폰트 사용 -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Lora:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
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

        /* 헤더 */
        .order-summary h2 {
            font-size: 2.5rem;
            font-weight: 600;
            color: #222;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 15px;
        }

        /* 각 항목 */
        .summary-item {
            font-size: 1.15rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f1f1f1;
            color: #555;
        }

        .summary-item strong {
            color: #333;
            font-weight: 600;
        }

        /* 상품 목록 */
        .items-list ul {
            list-style-type: none;
            padding: 0;
        }

        .items-list ul li {
            font-size: 1.05rem;
            padding: 12px 0;
            border-bottom: 1px solid #ddd;
            color: #444;
        }

        .items-list li span {
            color: #007bff;
            font-weight: 500;
        }

        /* 결제 버튼 */
        .final-button {
            text-align: center;
            margin-top: 30px;
        }

        .btn-custom {
            background: linear-gradient(135deg, #2C3E50, #34495E); /* 세련된 그라데이션 */
            border: none;
            color: white;
            font-size: 1.4rem;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
            width: auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-custom:hover {
            background: linear-gradient(135deg, #34495E, #2C3E50); /* 마우스 오버 시 색상 변화 */
            transform: translateY(-3px) scale(1.05); /* 버튼 확대 및 이동 효과 */
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }

        /* 모바일 반응형 */
        @media (max-width: 767px) {
            .order-summary {
                padding: 20px;
            }

            .order-summary h2 {
                font-size: 1.8rem;
            }

            .btn-custom {
                font-size: 1.2rem;
            }
        }

        /* 마지막 항목의 border 없애기 */
        .summary-item:last-child {
            border-bottom: none;
        }

        /* 상품 리스트 항목 스타일 */
        .items-list li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1rem;
            padding: 15px 0;
            border-bottom: 1px solid #f1f1f1;
        }

        .items-list li span {
            font-weight: 500;
        }

        .items-list li .item-price {
            color: #16a085;
            font-weight: 600;
        }

    </style>
</head>

<body>
    <div class="container">
        <div class="order-summary">
            <h2>주문 요약</h2>

            <div class="summary-item">
                <strong>주문 번호:</strong> ${order.orderNo}
            </div>

            <div class="summary-item">
                <strong>이름:</strong> ${order.name}
            </div>

            <div class="summary-item">
                <strong>주소:</strong> ${order.address}
            </div>

            <div class="summary-item">
                <strong>전화번호:</strong> ${order.phoneNumber}
            </div>

            <div class="summary-item">
                <strong>할인 금액:</strong> ₩ ${order.discount}
            </div>

            <div class="summary-item">
                <strong>총 금액:</strong> ₩ ${order.totalPrice}
            </div>

            <div class="summary-item items-list">
                <strong>주문 상품:</strong>
                <ul>
                    <c:forEach items="${itemList}" var="item">
                        <li>
                            <span>${item.name}</span> 
                            <span>(${item.quantity}개)</span> 
                            <span class="item-price">₩ ${item.totalPrice}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div class="summary-item">
                <strong>쿠폰 코드:</strong> ${order.code}
            </div>

            <div class="summary-item">
                <strong>주문 상태:</strong> ${order.orderStatus}
            </div>

            <div class="summary-item">
                <strong>주문 날짜:</strong> ${order.orderDate}
            </div>

            <div class="final-button">
                <button class="btn-custom" onclick="requestPay()">결제하기</button>
            </div>
        </div>
    </div>

    <script>
        function requestPay() {
            IMP.init('imp85504633'); // "가맹점 식별코드"로 대체

            IMP.request_pay(
                {
                    pg: "html5_inicis",
                    pay_method: "card",
                    merchant_uid: "${order.orderNo}",
                    name: "${order.name}의 주문 상품",
                    amount: ${order.totalPrice},
                    buyer_email: "none", 
                    buyer_name: "${order.name}",
                    buyer_tel: "${order.phoneNumber}",
                    buyer_addr: "${order.address}",
                    buyer_postcode: "none"
                },
                function (response) {
                    if (response.success) {
                        fetch('/payment/complete', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                imp_uid: response.imp_uid,
                                merchant_uid: response.merchant_uid
                            })
                        })
                            .then(res => res.json())
                            .then(data => {
                                if (data.success) {
                                    alert('결제가 완료되었습니다.');
                                    window.location.href = `/order/complete?orderNo=${response.merchant_uid}`;
                                } else {
                                    alert('결제 검증에 실패했습니다. 고객센터에 문의하세요.');
                                }
                            });
                    } else {
                        alert(`결제에 실패했습니다. 에러 메시지: ${response.error_msg}`);
                    }
                }
            );
        }
    </script>
</body>
</html>
