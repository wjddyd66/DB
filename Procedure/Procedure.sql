-- 프로시저 (stored procedure): SQL을 프로그래밍 하는 것

create table aaa (bun number, munja varchar2(20), su number); -- 결과 확인용 테이블

-- 변수 선언
set serveroutput on;

declare 
  no number:=0;
begin
  no:=100+200;
  insert into aaa(bun) values(no);
  dbms_output.put_line(no);
end;
/
select * from aaa;

-- 배열 처리
declare 
  type result is record (a number, b number);
  type test is varray(100) of result;
  test1 test :=test(); -- 객체 생성 및 초기화
begin
  test1.extend(50); -- extend: 공간확보
  test1(1).a := 10;
  test1(1).b := 20;
  dbms_output.put_line(test1(1).a);
  dbms_output.put_line(test1(1).b);
 end;
/

-- Exception
declare -- 선언부
  counter number(3) :=10;
  re number;
begin -- 실행부
  re:=counter/0;
  dbms_output.put_line(re);
exception -- 예외부 
  when zero_divide then -- 익셉션부: 익셉션의 종류는 검색으로 찾아볼 것
  dbms_output.put_line('나누기에러');
  when others then
  dbms_output.put_line('기타에러');
end;
/

-- 해당 테이블 레코드 type의 변수 선언
declare 
  v_a trtest%rowtype;
begin
  select * into v_a from trtest where jikwon_no=1; 
  -- 현재 값을 하나밖에 못 받는 상태이므로 where 조건에서 >=등을 이용해봤자 값을 받을 수 없다.
  dbms_output.put_line(v_a.jikwon_no || v_a.jikwon_name || v_a.jikwon_pay);
end;
/

-- 해당 테이블 칼럼 type의 변수 선언
declare 
  aa trtest.jikwon_no%type;
  bb trtest.jikwon_name%type;
  cc trtest.jikwon_pay%type;
begin
  select jikwon_no, jikwon_name, jikwon_pay into aa,bb,cc from trtest where jikwon_no=7;
  dbms_output.put_line(aa||' '||bb||' '||cc);
end;
/

-- 조건판단문 if
declare
  v_a trtest%rowtype;
  v_str varchar2(20);
begin
  select * into v_a from trtest where jikwon_no=11;
  if(v_a.buser_num=10) then 
    v_str:=concat(v_a.jikwon_name, ' 10');
  elsif(v_a.buser_num=20) then -- 여기서는 else if에서 가운데 e가 빠진다... : elsif
    v_str:=concat(v_a.jikwon_name, ' 20');
  elsif(v_a.buser_num=30) then 
    v_str:=concat(v_a.jikwon_name, ' 30');
  elsif(v_a.buser_num=40) then 
    v_str:=concat(v_a.jikwon_name, ' 40');
  end if;
  dbms_output.put_line('결과는 ' || v_str);
end;
/

-- 반복문 for
declare 
  dan number(2) := 2;
  i number(2) := 0;
  tot number:=0;
begin
  for i in 1..9 loop
    tot:=dan*i;
    dbms_output.put_line(dan || '*' || i || '=' || tot);
  end loop;
end;
/

-- 반복문 while
declare 
  v_count number:=1;
begin
  while(v_count<=10) loop
    dbms_output.put_line(v_count);
    exit when v_count=5;
    v_count:=v_count+1;
  end loop;
end;
/

-- 무한루프 loop~end loop : while(true) 형태
declare 
  v_count number:=1;
begin
  loop
    dbms_output.put_line(v_count);
    exit when v_count=5;
    v_count:=v_count+1;
  end loop;
end;
/

-- if+while 함께 써보기
declare
  va number:=0;
  vb number:=0;
begin
  while va<10 loop
    va:=va+1;
    if mod(va,2)=0 then
      vb:=vb+10;
      dbms_output.put_line(va || '짝' || vb);
    else
      vb:=vb+3;
      dbms_output.put_line(va || '홀' || vb);
    end if;
  end loop;
end;
/

-- 함수 작성
select round(12/3.7) from dual; -- 내장함수

create or replace function func1(no number) return number is
  pay number(9);
begin 
  pay:=0;
  select jikwon_pay*0.05 into pay from jikwon where jikwon_no=no;
  return pay;
end;
/
select jikwon_no, jikwon_name, jikwon_pay, func1(jikwon_no) as tex from jikwon;