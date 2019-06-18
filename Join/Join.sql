-- Join: Inner Join, Cross Join, Outer join, Self Join

-- cross join: 두 테이블에서 곱집합을 반환한다.
-- m개의 열을 가진 테이블과, n열을 가진 테이블이 교차 조인되면 m*n개의 열을 생성
select jikwon_name, buser_name from jikwon, buser; -- 직원이름(16)과 부서이름(4)이 1:1 대응. 16*4 = 64개.

-- self join: 자기 자신을 조인하는 것
select a.jikwon_name, b.jikwon_jik from jikwon a, jikwon b where a.jikwon_no=b.jikwon_no; 
-- 'a, b'라는 별명을 줄 수 있다.

-- outer join
-- left outer join
select jikwon_name, buser_name from jikwon, buser where buser_num=buser_no (+); 
-- 없는 값 null
select jikwon_name, buser_name from jikwon inner join buser on buser_num=buser_no (+); 

-- right outer join
select jikwon_name, buser_name from jikwon, buser where buser_num(+)=buser_no; 
-- 없는 값 null
select jikwon_name, buser_name from jikwon inner join buser on buser_num(+)=buser_no;

-- full outer join
select jikwon_name, buser_name from jikwon, buser where buser_num(+)=buser_no(+); -- X
select jikwon_name, buser_name from jikwon full join buser on buser_num=buser_no; 
-- 전부 다 출력

-- inner join
select jikwon_name, buser_name from jikwon, buser where buser_num=buser_no; 
-- 오라클용 (다른데 가서 이렇게 쓰면 안될 수가 있다.)
select jikwon_name, buser_name from jikwon inner join buser on buser_num=buser_no; 
-- 표준SQL용

-- 세 개 이상의 테이블 조인: 세 개를 동시에 조인X. (1번+2번 조인)+3번 조인O
select jikwon_name, buser_name, gogek_name from jikwon, buser, gogek
where buser_num=buser_no and jikwon_no=gogek_damsano;

select jikwon_name, buser_name, gogek_name 
from jikwon inner join buser on buser_num=buser_no 
inner join gogek on jikwon_no=gogek_damsano;

-- union: 구조가 일치하는 두 개 이상의 테이블 자료 합쳐보기
create table pum1(bun int, pummok varchar2(10));
insert into pum1 values(1, '한라봉');
insert into pum1 values(2, '귤');
insert into pum1 values(3, '천혜향');
insert into pum1 values(50, '자몽');
select * from pum1;
drop table pum1;

create table pum2 (num int, sangpum varchar2(10));
insert into pum2 values(10, '사과');
insert into pum2 values(20, '배');
insert into pum2 values(30, '포도');
insert into pum2 values(40, '딸기');
insert into pum2 values(50, '자몽');
select * from pum2;

-- 합집합: 두 테이블을 합쳐서 보여준다. 
select bun, pummok from pum1
union
select num, sangpum from pum2;

-- 유니온하되, 중복 있게 보여준다.
select bun, pummok from pum1
union all
select num, sangpum from pum2;

-- 차집합: pum1-pum2. 자몽이 제외된다. 
select bun, pummok from pum1
minus
select num, sangpum from pum2;

-- 교집합: 두 테이블 사이에 중복되는 데이터만 반환
select bun, pummok from pum1
intersect
select num, sangpum from pum2;