-- QnA ���̺�

-- ���̺�&������ ����
drop table qna cascade constraints purge;
drop SEQUENCE qna_seq;

--��ü ����
create table qna (
    no number primary key, -- �۹�ȣ
    title varchar2(300) not null, -- ����
    content varchar2(2000) not null, -- ����
    id varchar2(20) REFERENCES member(id)not null, -- �ۼ��� ���̵�
    writeDate date default sysdate, -- �ۼ���
    filename varchar2(200)
);

-- qna ������ ����
create SEQUENCE qna_seq;

-- ���õ�����
insert into qna(no, title, content, id, filename)
values (qna_seq.nextval, 'qna�����������', 'qna�������','test1','filesample.jpg');
commit;
select * from qna;