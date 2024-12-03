-- QnA 테이블

-- 테이블&시퀀스 삭제
drop table qna cascade constraints purge;
drop SEQUENCE qna_seq;

--객체 생성
create table qna (
    no number primary key, -- 글번호
    rno number(9) not null,
    ans number(1) default 0,
    title varchar2(300) not null, -- 제목
    content varchar2(2000) not null, -- 내용
    writer varchar2(300) REFERENCES member(id)not null, -- 작성자 아이디
    writeDate date default sysdate, -- 작성일
    filename varchar2(200), -- 첨부파일 이름
    status varchar2(20) default '접수', -- 처리상태
    parent_writer VARCHAR(300),
    secret number(1) default 0
);

-- qna 시퀀스 생성
create SEQUENCE qna_seq;

-- 샘플데이터
insert into qna(no, rno, title, content, writer)
values (qna_seq.nextval, qna_seq.nextval, 'qna질문제목샘플', 'qna내용샘플','test1');
commit;
select * from qna;