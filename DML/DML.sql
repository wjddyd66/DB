﻿-- DML: Insert, Select, Update, Delete
-- 1)Select

-- 레코드 제한: 각종 범위를 지정해줄 수 있다.
select * from jikwon where jikwon_jik='대리';
select * from jikwon where jikwon_no=1;
select * from jikwon where jikwon_no>=10;
select * from jikwon where jikwon_no<10;
select * from jikwon where jikwon_jik<>'대리'; !=과 같은 표현. 부정.
select * from jikwon where jikwon_no=1+5; -- 산술연산 사용가능
select * from jikwon where jikwon_jik='사원' and jikwon_gen='남' and jikwon_pay>=2000+1000;
select * from jikwon where jikwon_jik='사원' or jikwon_gen='여';

select * from jikwon where jikwon_no>=5 and jikwon_no<=10;
select * from jikwon where jikwon_no between 5 and 10; -- 서로 같은 결과 반환
select * from jikwon where not jikwon_no between 5 and 10; -- not을 붙여주면 결과의 반대값 반환 
-- not을 썼을 때는 안 썼을 때보다 결과값 반환 속도가 다소 느리다. 
-- 가급적 not을 쓰지 말고 조건을 다르게 설정해주자. 그러나 너무 급하면 쓰자.

select * from jikwon where jikwon_ibsail between '2000-1-1' and '2010-12-31';
-- between A and B를 이용한 필터링

select * from jikwon where jikwon_name='홍길동';
select * from jikwon where jikwon_name>='박'; -- 사전 상으로 '박'씨 이후의 사람들 출력
select * from jikwon where jikwon_name<'박'; -- '박'씨 이전의 사람들 출력
select ascii('a'), ascii('b'), ascii('가'), ascii('나') from dual;
select * from jikwon where jikwon_name between '김' and '장'; -- 문자에 대한 between 또한 가능.
-- '김'~'장' 사이의 성씨를 가진 사람들 출력

select * from jikwon where jikwon_jik='대리' or jikwon_jik='과장' or jikwon_jik='부장'; 
select * from jikwon where jikwon_jik in('대리', '과장', '부장'); -- in연산자의 이용. 이 둘은 서로 같은 결과를 반환.
select * from jikwon where buser_num in(10,30); -- 부서넘버가 10 or 30인 직원 반환

-- like 연산자 %(현재 이후는 아무 문자...) _(현재 한 지점에 대해서만 아무 문자나...)
select * from jikwon where jikwon_name like '이%'; -- '이'로 시작되는 문자열 아무나
select * from jikwon where jikwon_name like '%라'; -- '라'로 끝나는...
select * from jikwon where jikwon_name like '이%라'; -- 첫 글자는 이, 마지막 글자는 라 찾기, 사이에 몇 글자 포함인지는 상관X
select * from jikwon where jikwon_name like '%순%'; -- '순'이 포함되어 있는
select * from jikwon where jikwon_pay like '3%' -- 연봉이 3으로 시작되는 직원만 반환

select * from jikwon where jikwon_name like '이_라'; -- 반드시 세글자 인것만 찾는다.
select * from jikwon where jikwon_name like '이__'; -- '이'로 시작되는 세글자인 것만 찾는다. 
select * from gogek where gogek_name like '__'; -- 두글자짜리만 반환

-- 고객 중에 남자만 나오게 하기
select * from gogek;
select * from gogek where gogek_jumin like '%-1%' or gogek_jumin like '%-3%';



-- 단일행 함수
-- 문자 함수
select 'Hello', lower('Hello'), upper('Hello') from dual;
select concat ('hello', 'world'), 'hello' || 'world' from dual;
select substr ('hello world', 3), substr ('hello world', 3, 5), substr ('hello world', -3, 2) from dual; 
-- substr 함수 : 꽤 쓰인다. 지정해준 위치부터 문자를 잘라 반환한다.
select length ('hello world') from dual; -- 문자 길이 반환
select instr ('hello world', 'e'), instr ('hello world', 'o', 6) from dual; -- 찾는 문자의 위치값 반환
select lpad ('hello', 10, '*') from dual;
select replace ('010.111.1111', '.', '-') from dual; -- 지정한 부분을 대체한다. 

-- 숫자 함수
select round(45.678, 2), round(345.678, 0), round(345.678,-2) from dual; -- 반올림 할 수, 자릿수 
select jikwon_name, jikwon_pay, round(jikwon_pay*0.025,-1) as tax from jikwon; -- 반올림 활용예시
select trunc(345.678, 2), trunc(345.678) from dual; -- 버림
select ceil(345.678), floor(345.678) from dual; -- ceil: 근사치 정수 중 큰 값 반환/ floor: 근사치 정수 중 작은 값 반환
select mod(15,2) from dual; -- 나머지 

-- 날짜 함수
select sysdate from dual;  -- 시스템이 가지고 있는 현재 날짜 (오라클만), 마리아DB는 now함수 
select sysdate, sysdate+10, sysdate-10 from dual; -- 날짜에 대해 연산 가능 (윤년까지 체크)
-- B.C4712년~A.D9999년까지...
select round ((sysdate - jikwon_ibsail)/7) as weeks from jikwon; -- 입사한지 몇 주 되었는지
select jikwon_name from jikwon where (sysdate-jikwon_ibsail)*24>100000; -- 입사한지 10만시간이 초과된 직원
select months_between('2019-1-1', '2018-5-31') from dual; -- 월차 반환
select add_months(sysdate, 3), add_months(sysdate, -3) from dual; -- sysdate에 값 만큼 더한 月 반환
select sysdate, last_day(sysdate), next_day(sysdate, '금') from dual;

-- 형변환 함수: 많이 쓰인다!
select sysdate-to_date('2017-05-12') from dual; -- to_date: 날짜형으로 변환시켜준다.
select to_char(sysdate+1, 'yyyy"년" mm"월" dd"일"') from dual; -- 이렇게 문자형으로 바꿔줄 수 있다.
select to_char(sysdate+1, 'yyyy') from dual;
select to_char(sysdate, 'ww') from dual; -- 현재는 2019년의 4주차
select to_char(sysdate, 'dd') from dual; -- 현재는 2019년의 24일차
select to_char(sysdate,'day'), to_char(sysdate,'dy') from dual;
select to_char(123.456), to_char(123123.456, '999,999.99') from dual;

-- 기타 함수
select jikwon_no, jikwon_name, jikwon_pay from jikwon order by jikwon_pay desc;
select jikwon_no, jikwon_name, jikwon_pay, rank() over (order by jikwon_pay desc) from jikwon; -- rank(): 순위 반환
select jikwon_no, jikwon_name, jikwon_pay, dense_rank() over (order by jikwon_pay desc) from jikwon; 
-- dense_rank(): rank와 같으나, 동점자 처리 가능. 동점자 발생 시 등수 동일 부여.

select jikwon_name, jikwon_jik, nvl (jikwon_jik, '임시직') from jikwon; -- null값 존재 시 '임시직'으로 대체
select jikwon_name, jikwon_jik, nvl2 (jikwon_jik, '정규직', '일용직') from jikwon; 
-- null값 존재시 '일용직' 그 외는 전부 '정규직'

select nullif(length('abcd'), length('123')), nullif(length('abcd'), length('1234')) from dual;
-- nullif:두 값이 다를 경우: 첫번째 값 반환, 같을 경우: null 반환
select jikwon_name, jikwon_jik, nullif(jikwon_jik,'대리') from jikwon;
-- 직급과 '대리'를 비교 후 값이 다르면 직급 반환, '대리'면 null 반환


-- Order By
select * from jikwon order by jikwon_no desc; 내림차순 정렬 하->가, 9->0, Z->A 순으로 정렬
select * from jikwon order by jikwon_no asc; -- asc(오름차순)는 기본적으로 생략가능
select * from jikwon order by jikwon_pay asc;
select * from jikwon order by buser_num asc, jikwon_pay desc;
-- 오름차순, 내림차순을 각각 따로 써서 정렬할 수도 있다.
select jikwon_no, jikwon_name from jikwon order by jikwon_no desc, jikwon_name asc;
select jikwon_no, jikwon_name from jikwon order by 1 desc, 2 asc; 
-- 1: 첫번째 언급된 레코드명. 2: 두번째로 언급된 레코드명.
-- 1차, 2차, 3차, 4차... 계속 가능. 그러나 아주 권장하지는 않는다.

-- Group By
-- group 함수: 전체자료를 그룹별로 구분하여 소계 결과를 얻기 위한 함수
-- 형식) select 그룹칼럼명, 계산함수... from 테이블명 where 조건 group by 그룹칼럼명 having 출력결과조건
-- 그룹칼럼에 order by 할 수 없다. (그룹 안에는 내부적으로 이미 order by가 포함되어 있다.)

-- 성별 급여의 평균과 인원수 출력
select * from jikwon order by jikwon_gen;
select jikwon_gen, avg(jikwon_pay), count(*) from jikwon group by jikwon_gen;

-- 부서별 급여합
select buser_num, sum(jikwon_pay) from jikwon group by buser_num;

-- 부서별 급여합: 급여합이 15000 이상만 출력
select buser_num, sum(jikwon_pay) from jikwon group by buser_num having sum(jikwon_pay)>=15000;

-- 부서별 금여합: 남자만
select buser_num, sum(jikwon_pay) from jikwon where jikwon_gen='남' group by buser_num;

-- 부서별 급여합: 급여합이 10000 이상인 남자만
select buser_num, sum(jikwon_pay) from jikwon 
where jikwon_gen='남' group by buser_num having sum(jikwon_pay)>=10000;

--
select buser_num, sum(jikwon_pay) from jikwon order by buser_num group by buser_num; 
-- 그룹바이 전에 오더바이가 올 수 없다.
select buser_num, sum(jikwon_pay) from jikwon group by buser_num order by buser_num; 
-- 그러나 그룹바이 이후에 오더바이가 오는 것은 가능

select max(avg(jikwon_pay)) from jikwon group by jikwon_jik; -- 그룹함수 중첩

-- rollup: 중간중간 소계를 출력해준다. 소계 부분에는 null이 출력된다.
select buser_num, jikwon_jik, 
sum(jikwon_pay), avg(jikwon_pay)
from jikwon
where jikwon_pay is not null and jikwon_jik is not null
group by rollup(buser_num, jikwon_jik);

-- cube: rollup과 같으나, 소계를 먼저 출력해준다. 
select buser_num, jikwon_jik, 
sum(jikwon_pay), avg(jikwon_pay)
from jikwon
where jikwon_pay is not null and jikwon_jik is not null
group by cube(buser_num, jikwon_jik);


-- 2) Insert
-- 자료추가
insert into test(no,name,tel,inwon,addr) values(1,'인사과','111-1111',5,'강남구 역삼동');
insert into test values(2,'영업과','111-2222',10,'강남구 방배동'); -- 이처럼 순서가 같을 때는 칼럼명 생략 가능
insert into test(no,name) values(3,'자재과'); -- 이처럼 순서가 바뀌었을 때는, 칼럼명을 꼭! 써줘야 한다. 
insert into test values(4,'영업2과','111-2222',10,null);
insert into test(name, no) values('자재2과',5); -- 들어오는 데이터가 순서가 다를 때도, 반드시 칼럼명 써주어야 한다. 

-- 에러상황 의도적 연출
insert into test(no,name) values(5,'비서실'); -- err! 무결성 제약조건에 위배된다.
insert into test values(6,'영업을 엄청 잘하는 우리 회사 효자과','111-2222',10,'강남구 방배동'); 
-- err! 10자까지만 가능한데 넘어서 에러.
insert into test values(6,'비서실','111-2222',123456789,'강남구 방배동'); -- err!
insert into test values(6,null,'111-2222',12,'강남구 방배동'); -- err: not null이라고 지정 된 레코드에 null을 주면 에러
insert into test values('육번','비서실','111-2222',12,'강남구 방배동'); -- err

-- 3) Update
-- 자료 업데이트
-- 칼럼의 순서는 달라도 상관 없다.
-- Where를 이용해 변경하고 싶은 자료만 선택적으로 변경 가능하다.
-- Where를 붙이지 않으면 데이터 전체가 다 같은 값으로 갱신된다.(주의!)
update test set inwon=2 where no=1;
update test set inwon=11, tel='333-3333' where no=3;

-- 4) Delete
-- 자료삭제
delete from test where no=3; -- where 안 붙였다가는 홀랑 날아가버리니 주의할 것.
delete from test; -- rollback을 통해 다시 살릴 수 있다.
select * from test;
rollback test;
truncate table test; -- 이 경우, rollback 사용이 불가. 위험한 기능이니 가급적 사용하지 말 것.
desc test;

drop table test; -- 테이블의 구조 자체를 제거