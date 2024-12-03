-- review 테이블

-- 테이블 & 시퀀스 제거
drop table review cascade CONSTRAINTS purge;
drop SEQUENCE review_seq;

-- 테이블 생성
create table review (
    rno number primary key,
    title varchar2(600) not null,   
    content varchar2(3000) not null,
    id varchar2(300) not null,
    filename VARCHAR2(300),
    writeDate date default sysdate,
    stars number(1) not null
);

-- 시퀀스 생성
create SEQUENCE review_seq;

insert into review(rno, title, content, id, filename, stars)
values (review_seq.nextval, 'title', 'content', 'admin', '/upload/myreview/a3.jpg', 1);
commit;

select * from review;

select * from goods;