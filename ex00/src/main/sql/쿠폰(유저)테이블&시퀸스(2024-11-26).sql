-- 쿠폰함(사용자)
-- 테이블 삭제
drop table coupon_user CASCADE CONSTRAINTS;
drop SEQUENCE coupon_user_seq;

-- 테이블 생성
create table coupon_user(
    no number primary key, -- 글번호 - 시퀀스 사용
    user_id VARCHAR(30) NOT NULL,  -- 사용자 ID
    code VARCHAR(50) NOT NULL,  -- 쿠폰 코드
    is_used NUMBER(1) DEFAULT 0,  -- 사용 여부 (0: 미사용, 1: 사용)
    used_at TIMESTAMP,  -- 사용 일시
    FOREIGN KEY (user_id) REFERENCES member(id),  -- member 테이블의 id 컬럼을 참조
    FOREIGN KEY (code) REFERENCES coupon(code)  -- coupon 테이블의 code 컬럼을 참조
);

-- 시퀀스 생성
create SEQUENCE coupon_user_seq;

-- 커밋
commit;