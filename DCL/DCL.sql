-- DML: Grant, Revoke, Commit, RollBack

-- ROLE
create role role_name;
grant role_name to user1,user2...

-- Commit, RollBack
create table trtest as select * from jikwon;
select * from trtest;
commit;
delete from trtest; 
drop table trtest;
rollback;

-- Transaction
select * from trtest where jikwon_no=1;
update trtest set jikwon_pay=100000 where jikwon_no=1;
savepoint a; -- 이것을 이용하여 부분적으로 커밋/롤백 할 수 있다.
update trtest set jikwon_pay=110000 where jikwon_no=2;
select * from trtest where jikwon_no=2;
rollback to savepoint a; -- savepoint까지는 유지하고, 그 이후만 rollback
select * from trtest where jikwon_no in (1,2);
rollback; -- 전체 다 rollback
select * from trtest where jikwon_no in (1,2);
update trtest set jikwon_pay=120000 where jikwon_no=3;
commit;
select * from trtest where jikwon_no in (1,2,3);
-- update, insert, delete가 들어가는 순간 Lock이 걸린다. 
-- 이것을 푸는 방법: Commit, RollBack
-- 그 와중에 저장 포인트를 지정해주는 방법: savepoint
-- 작업이 끝난 뒤에는 Commit을 꼭 해주어야 한다.


-- deadlock: 두 개의 트랜잭션이 서로의 진행을 막고 충돌하는 현상
-- 트랜잭션의 마무리로 커밋/롤백을 그때 그때 해줘라! 안 그러면 데드락에 빠지고 만다...
update trtest set jikwon_pay=777 where jikwon_no=3;
select * from trtest;
commit;
delete from trtest where jikwon_no=5;