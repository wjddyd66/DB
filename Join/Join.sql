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