﻿-- View
-- 형식) create [or replace] view 뷰파일명 as select문~

-- View 생성
create or replace view vie1 as select * from trtest where jikwon_jik='사원'; -- 1)
select * from vie1; -- 2)
select * from vie1 where jikwon_gen='여';
select count(*) from vie1 where jikwon_gen='여';
desc vie1;

-- View 변경
rename trtest to abc; -- 원본테이블명 변경
select * from vie1; 
-- 테이블명이 변경되었으므로 셀렉트 되지 않는다. 
-- 원본 테이블에 전적으로 의존하고 있다.
rename abc to trtest;
select * from vie1; -- 다시 된다.

--View 삭제
drop view vie2; 

-- View 연습
select * from vie2;
select sum(jikwon_pay) as tot from vie2;

create view vie3 as select * from trtest where jikwon_name like '김%' or jikwon_name like '이%';
select * from vie3;

create view vie4 as select * from trtest order by jikwon_pay;
select * from vie4;

create view vie5 as select jikwon_name, jikwon_pay * 10000 as ypay from trtest;
select * from vie5;

-- view로 new view를 생성하는 것도 가능하다.
create view vie6 as select jikwon_name, ypay from vie5 where ypay>=50000000;
select * from vie6;

delete from vie6 where jikwon_name='채송화';
-- 뷰 파일의 데이터를 삭제하면, 원본파일의 데이터 또한 삭제된다!
select * from vie6;
select * from vie5;
select * from trtest;

select * from vie6;
update vie6 set ypay=80000000 where jikwon_name='이미라';
-- 실존하지 않는 칼럼인 ypay(단순 계산결과를 보여주기 위한 가상의 테이블)에 대하여 수정이 불가하다. 
update vie6 set jikwon_name='공기밥' where jikwon_name='이미라';
-- jikwon_name은 실존하는 칼럼이므로, 뷰를 통한 수정이 가능하다. 
select * from vie6;
select * from vie5;
select * from trtest;

create or replace view vie7 as select
jikwon_no, jikwon_name, buser_num, jikwon_pay from trtest 
-- not null인 칼럼 데이터를 포함해주지 않으면 뷰 파일로 insert 불가
where jikwon_pay>=5000;
select * from vie7; 
select * from trtest;
insert into vie7 values(20, '마당쇠', 20, 8000);
insert into vie7 values(21, '고로쇠', 30, 4000); 
-- 뷰 파일로 추가하는 것 가능하지만, 조심해야 할 부분이 있다는 것을 보여주는 예시!
-- vie7에서는 안보이지만, trtest에는 분명히 들어가있는 로쇠...

create or replace view vie8 as select
jikwon_jik, sum(jikwon_pay) as 연봉합, round(avg(jikwon_pay)) as 연봉평균 from trtest
group by jikwon_jik; -- select만 하고 있는 중. 얘를 가지고 결과 변형 불가.
select * from vie8;

create or replace view vie9 as select
jikwon_no, jikwon_name, buser_name, jikwon_jik from trtest
inner join buser on trtest.buser_num=buser.buser_no
where buser_num in (10,20);

select * from vie9;
delete from vie9 where jikwon_no=20;
update vie9 set jikwon_name='손오공' where jikwon_no=1;