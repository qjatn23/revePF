<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/styles/common.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reset.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/reponsive.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/root.css?ver=5.0">
<link rel="stylesheet" href="/resources/styles/normalize.css?ver=5.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function deleteRecentItem(goodsId) {
        console.log("deleteRecentItem called with goodsId:", goodsId); // 디버깅용 로그
        if (confirm("이 상품을 최근 본 상품 목록에서 삭제하시겠습니까?")) {
            $.ajax({
                url: '/recent/delete',
                type: 'POST',
                data: { goodsId: goodsId },
                success: function(response) {
                    console.log("Response from server:", response); // 서버 응답 확인
                    if (response === "success") {
                        alert("상품이 삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("삭제에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function() {
                    alert("서버와의 통신에 실패했습니다.");
                }
            });
        }
    }
	 // 우먼 삭제 함수
    function deleteRecentWoman(womanId) {
        console.log("deleteRecentWoman called with womanId:", womanId); // 디버깅용 로그
        if (confirm("이 여성 상품을 최근 본 상품 목록에서 삭제하시겠습니까?")) {
            $.ajax({
                url: '/recent/deleteWoman',
                type: 'POST',
                data: { womanId: womanId },
                success: function(response) {
                    console.log("Response from server:", response); // 서버 응답 확인
                    if (response === "success") {
                        alert("여성 상품이 삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("삭제에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function() {
                    alert("서버와의 통신에 실패했습니다.");
                }
            });
        }
    }
 	// 최근 본 브랜드 상품 삭제
    function deleteRecentBrand(brandsId) {
        console.log("deleteRecentBrand called with brandsId:", brandsId); // 디버깅용 로그
        if (confirm("이 브랜드 상품을 최근 본 상품 목록에서 삭제하시겠습니까?")) {
            $.ajax({
                url: '/recent/deleteBrand',
                type: 'POST',
                data: { brandsId: brandsId },
                success: function(response) {
                    console.log("Response from server:", response); // 서버 응답 확인
                    if (response === "success") {
                        alert("브랜드 상품이 삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("삭제에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function() {
                    alert("서버와의 통신에 실패했습니다.");
                }
            });
        }
    }

    function addToCart(goodsNo, goodsName, imageName, salePrice, deliveryCharge, quantity) {
        $.ajax({
            url: '/cart/addrecent',  // '/cart/add'로 요청
            type: 'POST',  // 반드시 'POST'로 설정해야 합니다.
            data: {
                goods_no: goodsNo,
                goods_name: goodsName,
                image_name: imageName,
                sale_price: salePrice,
                delivery_charge: deliveryCharge,
                quantity: quantity,
            },
            success: function(response) {
                if (response === "success") {
                    alert("장바구니에 상품이 추가되었습니다.");
                } else if (response === "failure") {
                    alert("장바구니 추가에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                // 요청 실패 시 알림 출력
                alert("서버와의 통신에 실패했습니다.");
            }
        });
    }
    
 	// 우먼 장바구니 추가 함수
    function addToCartWoman(womanNo, womanName, womanImageName, salePrice, deliveryCharge, quantity) {
    $.ajax({
        url: '/cart/addWoman',  // '/cart/addWoman'으로 요청
        type: 'POST',  // 반드시 'POST'로 설정해야 합니다.
        data: {
            woman_no: womanNo,
            woman_name: womanName,
            woman_image_name: womanImageName,
            sale_price: salePrice,
            delivery_charge: deliveryCharge,
            quantity: quantity,
        },
        success: function(response) {
            if (response === "success") {
                alert("장바구니에 여성 상품이 추가되었습니다.");
            } else {
                alert("장바구니 추가에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버와의 통신에 실패했습니다.");
        }
    });
}

 	// 브랜드 상품 장바구니 추가
    function addToCartBrand(brandsNo, brandsName, BrandsImageName, salePrice, deliveryCharge, quantity) {
    $.ajax({
        url: '/cart/addBrand',  // 요청 URL
        type: 'POST',  // HTTP 메서드는 POST로 설정
        data: {
            brands_no: brandsNo,
            brands_name: brandsName,
            brands_image_name: BrandsImageName,
            sale_price: salePrice,
            delivery_charge: deliveryCharge,
            quantity: quantity,
        },
        success: function(response) {
            console.log("Response from server:", response);  // 서버 응답 확인
            if (response === "success") {
                alert("장바구니에 브랜드 상품이 추가되었습니다.");
            } else {
                alert("장바구니 추가에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버와의 통신에 실패했습니다.");
        }
    });
}

</script>
    <title>최근 본 상품</title>
    <style>
							article {
	width: 100%;
	height: 100%;
	max-width: 1920px;
	margin: 0 auto;
	padding-top: 100px;
	min-height: 860px;
}
        /* 기본 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 15px;
            text-align: center;
            vertical-align: middle;
        }
        th {
            background-color: #f8f8f8;
            font-weight: bold;
        }
        /* 이미지 스타일 */
        td img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
        /* 버튼 스타일 */
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }
        .order-button, .cart-button {
		    width: 90px;
		    height: 30px;
		    font-size: 12px;
		    font-weight: bold;
		    cursor: pointer;
		    border-radius: 5px;
		    text-align: center;
		}
		
		.order-button {
		    background-color: black;
		    color: white;
		    border: none;
		}
		
		.cart-button {
		    background-color: white;
		    color: black;
		    border: 1px solid black;
		}
		
		.order-button:hover {
		    background-color: #333;
		}
		
		.cart-button:hover {
		    background-color: #f0f0f0;
		}

        .delete-button {
            background-color: transparent;
            color: #888;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }
        .delete-button:hover {
            color: #333;
        }
        /* 사이드 메뉴 스타일 */
		/* 리스트의 기본 스타일 제거 */
		.side-menu ul {
		    list-style: none; /* 불릿 포인트 제거 */
		    padding: 0; /* 패딩 제거 */
		}
		
		/* 사이드 메뉴 아이템 간격 조정 */
		.side-menu ul li {
		    padding: 10px 0; /* 각 항목 위아래로 10px 간격 추가 */
		}
		
		/* 사이드 메뉴 링크 기본 스타일 */
		.side-menu ul li a {
		    color: #555; /* 기본 링크 색상 */
		    text-decoration: none; /* 링크 밑줄 제거 */
		    font-size: 1.1em; /* 링크 텍스트 크기 */
		}
		
		/* 사이드 메뉴 링크에 마우스를 올렸을 때 색상 변경 */
		.side-menu ul li a:hover {
		    color: #000; /* 호버 시 색상: 검정 */
		}
		/* 레이아웃 */
		/* 전체 컨테이너 스타일 */
		.container {
		    max-width: 1200px; /* 최대 너비를 1200px로 제한 */
		    margin: 50px auto; /* 수직으로 50px 간격, 수평 중앙 정렬 */
		}
		/* 제목 스타일 */
		/* 페이지 제목 디자인 */
		.title {
		    font-size: 1.8rem; /* 제목 폰트 크기 */
		    font-weight: bold; /* 제목 굵게 */
		    margin-bottom: 50px; /* 아래쪽 여백 */
		    border-bottom: 2px solid #000; /* 제목 하단에 검은색 선 추가 */
		    padding-bottom: 25px; /* 제목 하단 여백 */
		    margin-top: 20px; /* 위쪽 여백 */
		}
        /* 메인 콘텐츠 */
        .main-content {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        /* 옵션 스타일 */
        .input-group {
            margin: 5px 0;
        }
        .input-group span {
            font-weight: bold;
            margin-right: 5px;
        }
        select {
            padding: 5px;
            font-size: 14px;
        }
        
    </style>
</head>
<body>
    <div class="container" >
	    <h1 class="title">최근본 상품</h1>
		<div class="row">
        <!-- 사이드 메뉴 -->
        <div class="col-md-2 side-menu">
            <ul>
                <li><a href="/myreview/list.do">상품 리뷰</a></li>
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
            <table>
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th>상품명</th>
                        <th>옵션정보</th>
                        <th>판매가</th>
                        <th>주문</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recentGoods}" var="goods">
                        <tr>
                            <td><img src="${goods.image_name}" alt="${goods.goods_name}"></td>
                            <td>${goods.goods_name}</td>
                            <td>
							    <div class="input-group" style="margin-bottom: 10px;">
							        <span style="display: inline-block; font-weight: bold; margin-bottom: 5px;">사이즈</span>
							        <select style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ddd; border-radius: 5px;">
							            <option>선택</option>
							            <c:forEach items="${goods.sizeList}" var="sizeVO">
							                <option>${sizeVO.size_name}</option>
							            </c:forEach>
							        </select>
							    </div>
							    <div class="input-group">
							        <span style="display: inline-block; font-weight: bold; margin-bottom: 5px;">색상</span>
							        <select style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ddd; border-radius: 5px;">
							            <option>선택</option>
							            <c:forEach items="${goods.colorList}" var="colorVO">
							                <option>${colorVO.color_name}</option>
							            </c:forEach>
							        </select>
							    </div>
							</td>

                            <td>₩ <fmt:formatNumber value="${goods.sale_price}" /></td>
                            <td style="position: relative;">
							    <div class="button-container">
							        <button class="order-button">주문하기</button>
							        <button class="cart-button" onclick="addToCart(${goods.goods_no}, '${goods.goods_name}', '${goods.image_name}', ${goods.sale_price}, ${goods.delivery_charge}, 1)">
							            장바구니
							        </button>
							    </div>
							    <button class="delete-button" onclick="deleteRecentItem(${goods.goods_no})" style="position: absolute; top: 50%; right: 10px; transform: translateY(-50%);">
							        ✖
							    </button>
							</td>
                        </tr>
                    </c:forEach>
                    <c:forEach items="${recentWomen}" var="woman">
					    <tr>
					        <td><img src="${woman.woman_image_name}" alt="${woman.woman_name}"></td>
					        <td>${woman.woman_name}</td>
					        <td>
					            <div class="input-group" style="margin-bottom: 10px;">
					                <span style="display: inline-block; font-weight: bold; margin-bottom: 5px;">사이즈</span>
					                <select style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ddd; border-radius: 5px;">
					                    <option>선택</option>
					                    <c:forEach items="${woman.sizeList}" var="sizeVO">
					                        <option>${sizeVO.woman_size_name}</option>
					                    </c:forEach>
					                </select>
					            </div>
					            <div class="input-group">
					                <span style="display: inline-block; font-weight: bold; margin-bottom: 5px;">색상</span>
					                <select style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ddd; border-radius: 5px;">
					                    <option>선택</option>
					                    <c:forEach items="${woman.colorList}" var="colorVO">
					                        <option>${colorVO.woman_color_name}</option>
					                    </c:forEach>
					                </select>
					            </div>
					        </td>
					        <td>₩ <fmt:formatNumber value="${woman.sale_price}" /></td>
					        <td style="position: relative;">
					            <div class="button-container">
					                <button class="order-button">주문하기</button>
					                <button class="cart-button" onclick="addToCartWoman(${woman.woman_no}, '${woman.woman_name}', '${woman.woman_image_name}', ${woman.sale_price}, ${woman.delivery_charge}, 1)">
					                    장바구니
					                </button>
					            </div>
					            <button class="delete-button" onclick="deleteRecentWoman(${woman.woman_no})" style="position: absolute; top: 50%; right: 10px; transform: translateY(-50%);">
					                ✖
					            </button>
					        </td>
					    </tr>
					</c:forEach>	
					<c:forEach items="${recentBrands}" var="brands">
					    <tr>
					        <td><img src="${brands.brands_image_name}" alt="${brands.brands_name}"></td>
					        <td>${brands.brands_name}</td>
					        <td>
					            <div class="input-group" style="margin-bottom: 10px;">
					                <span style="display: inline-block; font-weight: bold; margin-bottom: 5px;">사이즈</span>
					                <select style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ddd; border-radius: 5px;">
					                    <option>선택</option>
					                    <c:forEach items="${brands.sizeList}" var="sizeVO">
					                        <option>${sizeVO.brands_size_name}</option>
					                    </c:forEach>
					                </select>
					            </div>
					            <div class="input-group">
					                <span style="display: inline-block; font-weight: bold; margin-bottom: 5px;">색상</span>
					                <select style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ddd; border-radius: 5px;">
					                    <option>선택</option>
					                    <c:forEach items="${brands.colorList}" var="colorVO">
					                        <option>${colorVO.brands_color_name}</option>
					                    </c:forEach>
					                </select>
					            </div>
					        </td>
					        <td>₩ <fmt:formatNumber value="${brands.sale_price}" /></td>
					        <td style="position: relative;">
					            <div class="button-container">
					                <button class="order-button">주문하기</button>
					                <button class="cart-button" onclick="addToCartBrand(${brands.brands_no}, '${brands.brands_name}', '${brands.brands_image_name}', ${brands.sale_price}, ${brands.delivery_charge}, 1)">
					                    장바구니
					                </button>
					            </div>
					            <button class="delete-button" onclick="deleteRecentBrand(${brands.brands_no})" style="position: absolute; top: 50%; right: 10px; transform: translateY(-50%);">
					                ✖
					            </button>
					        </td>
					    </tr>
					</c:forEach>					
                </tbody>
            </table>
        </div>
        </div>
    </div>
</body>
</html>
