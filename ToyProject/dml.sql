
-- ToyProject > dml.sql

-- 회원
insert into tblUser (id, pw, name, email, lv, pic, intro, ing) values ('hong', '1111', '홍길동', 'hong@gmail.com', '1', default, '자바를 공부하는 학생입니다.', default);
insert into tblUser (id, pw, name, email, lv, pic, intro, ing) values ('admin', '1111', '관리자', 'hong@gmail.com', '2', default, '자바를 공부하는 학생입니다.', default);

select * from tblUser;

update tbluser set ing = 'y';

commit;

-- 게시판
insert into tblBoard (seq, subject, content, regdate, readcount, id) values (seqBoard.nextval, '게시판입니다', '내용입니다.', default, default, 'hong');
    
select * from tblBoard;

delete from tblBoard where seq = 2;

commit;

select * from vwBoard; -- 목록 보기

select * from vwBoard where subject like '%안녕%';

update tblBoard set regdate = regdate - 1 where seq <= 5;


select tblBoard.*, (select name from tblUser where id = tblBoard.id) as name from tblBoard where seq = 8;

update tblBoard set readcount = readcount + 1 where seq = 1;