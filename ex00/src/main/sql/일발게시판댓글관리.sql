-- 일반게시판 댓글허용
-- 댓글도 하나의 테이블로 관리합니다.
-- 일반게시판 댓글 스키마 작성
-- 댓글번호(PK), 글번호(어디에 달린 댓글인지, FK, board.no)
-- 내용, 작성자, 작성일, 비밀번호

-- 1. 객체제거
drop table board_reply cascade CONSTRAINTS purge;
drop SEQUENCE board_reply_seq;

create table board_reply (
    rno number primary key,
    no number REFERENCES board(no) not null,
    content varchar(600) not null,
    writer varchar(30) not null,
    writeDate date default sysdate,
    pw varchar2(20) not null
);

create SEQUENCE board_reply_seq;

-- 댓글 샘플데이터
-- 댓글에는 글넘버가 들어갑니다.
select no from board;
insert into board_reply (rno, no, content, writer, pw)
values (board_reply_seq.nextval, 1, '질문있습니다','홍길동','1111');

insert into board_reply (rno, no, content, writer, pw)
values (board_reply_seq.nextval, 2, '일반게시판 댓글','이순신','1111');
commit;

select * from board_reply;