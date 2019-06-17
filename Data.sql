-- 데이터 
create table buser(
buser_no number(4)  primary key, 
buser_name varchar2(10) not null,
buser_loc varchar2(10),
buser_tel varchar2(15));

insert into buser values(10,'총무부','서울','02-100-1111');
insert into buser values(20,'영업부','서울','02-100-2222');
insert into buser values(30,'전산부','서울','02-100-3333');
insert into buser values(40,'관리부','인천','032-200-4444');

create table jikwon(
jikwon_no  number(4) primary key,
jikwon_name varchar2(10) not null,
buser_num number(4) not null,
jikwon_jik  varchar2(10) default '사원', 
jikwon_pay number,
jikwon_ibsail date default sysdate,
jikwon_gen  varchar2(4));

insert into jikwon values(1,'홍길동',10,'사장',9900,'1999/09/01','남');
insert into jikwon values(2,'한국남',20,'부장',8200,'2003/12/03','남');
insert into jikwon values(3,'이순신',20,'과장',6500,'2011/03/03','남');
insert into jikwon values(4,'이미라',30,'대리',5500,'2010/11/04','여');
insert into jikwon values(5,'이순라',20,'사원',3000,'2013/08/05','여');
insert into jikwon values(6,'김이화',20,'사원',2950,'2014/08/05','여');
insert into jikwon values(7,'김부만',40,'부장',8000,'2004/01/05','남');
insert into jikwon values(8,'김기만',20,'과장',7000,'2009/01/01','남');
insert into jikwon values(9,'채송화',30,'대리',5500,'2011/03/02','여');
insert into jikwon values(10,'박치기',10,'사원',3700,'2014/03/02','남');
insert into jikwon values(11,'김부해',30,'사원',2900,'2015/09/06','남');
insert into jikwon values(12,'박별나',40,'과장',5300,'2010/03/05','여');
insert into jikwon values(13,'박명화',10,'대리',4900,'2012/05/01','남');
insert into jikwon values(14,'박궁화',40,'사원',2800,'2017/01/05','여');
insert into jikwon values(15,'채미리',20,'사원',3200,'2015/01/03','여');
insert into jikwon values(16,'이유가',10,'사원',3900,'2013/02/01','여');

create table gogek(
gogek_no  number(4) primary key,
gogek_name  varchar2(10) not null,
gogek_tel  varchar2(20),
gogek_jumin char(14),
gogek_damsano  number(4),
CONSTRAINT fk_gogek_damsano foreign key(gogek_damsano) references jikwon(jikwon_no)
);

create sequence gogek_gogek_no_seq increment by 1 start with 1;

insert into gogek values(gogek_gogek_no_seq.nextval,'이가은','02-535-2580','880612-1156789',7);
insert into gogek values(gogek_gogek_no_seq.nextval,'김혜순','02-375-6946','750101-1054225',3);
insert into gogek values(gogek_gogek_no_seq.nextval,'최부자','02-692-8926','890305-1065773',3);
insert into gogek values(gogek_gogek_no_seq.nextval,'김해자','032-393-6277','870412-2028677',1);
insert into gogek values(gogek_gogek_no_seq.nextval,'차일호','02-294-2946','790509-1062677',2);
insert into gogek values(gogek_gogek_no_seq.nextval,'박상운','02-631-1204','790623-1023566',6);
insert into gogek values(gogek_gogek_no_seq.nextval,'이분','02-546-2372','880323-2558021',2);
insert into gogek values(gogek_gogek_no_seq.nextval,'신영래','031-948-0283','790908-1063765',5);
insert into gogek values(gogek_gogek_no_seq.nextval,'장도리','02-496-1204','870206-2063245',4);
insert into gogek values(gogek_gogek_no_seq.nextval,'강나루','032-341-2867','780301-1070425',12);
insert into gogek values(gogek_gogek_no_seq.nextval,'이영희','02-195-1764','880103-2070245',3);
insert into gogek values(gogek_gogek_no_seq.nextval,'이소리','02-296-1066','910609-2046266',9);
insert into gogek values(gogek_gogek_no_seq.nextval,'배용중','02-691-7692','820920-1052677',12);
insert into gogek values(gogek_gogek_no_seq.nextval,'김현진','031-167-1884','880128-2062665',2);
insert into gogek values(gogek_gogek_no_seq.nextval,'송나리','02-887-9344','830301-2013345',2);


create table sangdata(code number primary key, sang varchar2(20) not null,
su number, dan number);`data`
insert into sangdata values(1,'마우스',5,5000);
insert into sangdata values(2,'물티슈',12,2000);
insert into sangdata values(3,'볼펜',7,1000);

commit;