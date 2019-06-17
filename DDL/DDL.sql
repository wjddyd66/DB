-- DDL: Insert, Select, Update, Delete
-- 1) Insert
-- 자료추가
insert into test(no,name,tel,inwon,addr) values(1,'인사과','111-1111',5,'강남구 역삼동');
select * from test;
insert into test values(2,'영업과','111-2222',10,'강남구 방배동'); -- 이처럼 순서가 같을 때는 칼럼명 생략 가능
insert into test(no,name) values(3,'자재과'); -- 이처럼 순서가 바뀌었을 때는, 칼럼명을 꼭! 써줘야 한다. 
insert into test values(4,'영업2과','111-2222',10,null);
insert into test(name, no) values('자재2과',5); -- 들어오는 데이터가 순서가 다를 때도, 반드시 칼럼명 써주어야 한다. 
select no,name from test; -- no, name만 보여준다.

-- 2) Select
-- Basic
-- select [distinct] 소유자명, 테이블명, 칼럼명, [as 별명]... [into 테이블명] from 테이블명...
-- where 조건... order by 기준칼럼 asc[desc]...

select * from jikwon; -- 전체 자료 읽기
select jikwon_no, jikwon_name, jikwon_pay from jikwon; -- 일부 칼럼만 선택
select jikwon_no as 사번, jikwon_name as 직원명 from jikwon; -- as를 이용하여 칼럼명에 별명 부여
select 10, '안녕', 12/3 as result from dual;
select jikwon_no, jikwon_name || '님' from jikwon; -- '||' : SQL문에서의 문자열 더하기
select jikwon_no, jikwon_name as imsi from jikwon; 
select jikwon_name as 이름, jikwon_pay as 연봉, jikwon_pay*0.05 as 세금 from jikwon; 
-- 사실은 오라클 내에서 연산 시키는 것은 그리 바람직 하지 않다... 왠만하면 자바로 데려와서 자바에서 작업을 하도록!
-- 오라클은 항상 바쁘다! 연산까지는 맡기지 마라.

select * from &table_name; -- 치환변수. 있기는 있다. 
select * &column_name from jikwon;

select distinct jikwon_jik from jikwon; -- distinct를 이용하여 중복데이터 제거
select distinct buser_num from jikwon;
select distinct buser_num, jikwon_no from jikwon; --x

-- 정렬하기
select * from jikwon order by jikwon_no desc; 내림차순 정렬 하->가, 9->0, Z->A 순으로 정렬
select * from jikwon order by jikwon_no asc; -- asc(오름차순)는 기본적으로 생략가능
select * from jikwon order by jikwon_pay asc;
select * from jikwon order by buser_num asc, jikwon_pay desc;
-- 오름차순, 내림차순을 각각 따로 써서 정렬할 수도 있다.
select jikwon_no, jikwon_name from jikwon order by jikwon_no desc, jikwon_name asc;
select jikwon_no, jikwon_name from jikwon order by 1 desc, 2 asc; 
-- 1: 첫번째 언급된 레코드명. 2: 두번째로 언급된 레코드명.
-- 1차, 2차, 3차, 4차... 계속 가능. 그러나 아주 권장하지는 않는다.

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

-- 3) Update
update jikwon set jikwon_name ='이한나' where jikwon_no = 2

-- 4) Delete
delete from jikwon where jikwon_no=2