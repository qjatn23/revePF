-- 제거
drop table coupon CASCADE CONSTRAINTS;
drop SEQUENCE coupon_seq;

-- 생성
create table coupon(
    no number primary key, -- 글번호 - 시퀀스 사용
    code VARCHAR(50) NOT NULL UNIQUE,  -- 쿠폰 코드
    name VARCHAR(255) NOT NULL,  -- 쿠폰이름
    quantity number(4,0) NOT NULL,  -- 쿠폰수량(사용시 차감)
    discount_type VARCHAR(20) NOT NULL,  -- 할인 유형 (PERCENT, AMOUNT)
    discount_value DECIMAL(10, 2) NOT NULL,  -- 할인 금액 또는 퍼센트
    valid_from DATE NOT NULL,  -- 유효 시작일
    valid_until DATE NOT NULL  -- 유효 종료일
);

create SEQUENCE coupon_seq;

-- 샘플 데이터
insert into coupon(no, code, name, quantity, discount_type, discount_value, valid_from, valid_until)
values(coupon_seq.nextval, 'test1', 'Dobby is Free쿠폰', '9999', 'percent', '100', '2024-07-22', '2024-12-31');
insert into coupon(no, code, name, quantity, discount_type, discount_value, valid_from, valid_until)
values(coupon_seq.nextval, 'test2', 'help! 도움 쿠폰', '9999', 'amount', '3000', '2024-07-22', '2024-12-31');
insert into coupon(no, code, name, quantity, discount_type, discount_value, valid_from, valid_until)
values(coupon_seq.nextval, 'test3', 'Black Saturday쿠폰', '9999', 'amount', '5000', '2024-07-22', '2024-12-31');
insert into coupon(no, code, name, quantity, discount_type, discount_value, valid_from, valid_until)
values(coupon_seq.nextval, 'test4', '브라더 다메요 Random 할인 쿠폰', '9999', 'amount', '10000', '2024-07-22', '2024-12-31');
commit;