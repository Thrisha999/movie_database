create database Movies
use Movies
create table Customers(
cid int primary key,
cname varchar(30) not null,
cmobile varchar(30) not null,
age int null,
crating int not null
)
drop table customers
create table movie(
mid int primary key,
mname varchar(30) not null,
mlanguage varchar(30) not null,
rating int not null
)
create table Reserve(
cid int foreign key (cid) references Customers(cid),
mid int foreign key (mid) references movie(mid),
rdate date not null)

insert into Customers values(1,'Trisha','6475434',18,9)
insert into Customers values(2,'Riya','324567',20,8)
insert into Customers values(3,'sailaja','43743',28,10)
insert into Customers values(4,'Hruthik','798435',25,9)
insert into Customers values(5,'Avinash','12356',30,9)
insert into Customers values(6,'Gowtham','63245',42,8)
insert into Customers values(7,'Ajay','903455',17,6)
insert into Customers values(8,'gowtham','198433',20,7)
insert into Customers values(9,'Sidharth','4557332',28,3)
insert into Customers values(10,'Suvarna','333333',18,4)
insert into Customers values(11,'Deva','2222222',8,2)
insert into Customers values(12,'Amar','2111111',18,9)
insert into Customers values(13,'Anusha','67321',48,7)
insert into Customers values(14,'Anshu','555555',27,5)
insert into Customers values(15,'saina','999999',7,10)
insert into Customers values(16,'madhu','664221',18,9)
insert into Customers values(17,'Shreya','761234',19,8)
insert into Customers values(18,'Vamshi','665342',18,10)
insert into Customers values(19,'prem','03695577',20,1)
insert into Customers values(20,'Divya','872245',33,10)
insert into Customers values(21,'Bobby','341297',45,9)
insert into Customers values(22,'Venkat','99943765',28,9)
insert into Customers values(23,'Rohit','5774734',25,10)
insert into Customers values(24,'Triveni','67222233',18,6)
insert into Customers values(27,'sakitha','9235770',18,5)
insert into Customers values(28,'nikitha','99776433',18,9)
insert into Customers values(29,'jashu','875333',13,8)
insert into Customers values(25,'rishi','82355666',18,7)
insert into Customers values(26,'priya','56777774',18,3)
insert into Customers values(30,'Preeti','23456666',48,4)
select * FROM customers
insert into movie values(101,'tholiprema','telugu',9)
insert into movie values(102,'Ghaaji','telugu',10)
insert into movie values(103,'Saaho','telugu',6)
insert into movie values(104,'pati patni aur woah','hindi',7)
insert into movie values(105,'luka chuppi','hindi',8)
insert into movie values(106,'Avatar','english',4)
insert into movie values(107,'No time to Die','english',9)
insert into movie values(108,'Vampire diaries','english',8)
insert into movie values(109,'The Godfather','english',9)
insert into movie values(110,'Bhaagi','hindi',10)
insert into movie values(112,'spider-man','english',3)
insert into movie values(113,'varisu','tamil',9)
insert into movie values(114,'Brahmastra','hindi',7)
insert into movie values(115,'Kantara','kannada',10)
insert into movie values(116,'Hrudayam','malayalam',10)
select * from movie

insert into Reserve values(1,101,'2023-03-03')
insert into Reserve values(1,103,'2023-03-07')
insert into Reserve values(2,101,'2023-03-07')
insert into Reserve values(2,101,'2023-03-13')
insert into Reserve values(30,116,'2023-03-03')
insert into Reserve values(14,101,'2023-03-09')
insert into Reserve values(1,101,'2023-04-07')
insert into Reserve values(6,110,'2023-03-19')
insert into Reserve values(27,115,'2023-08-28')
insert into Reserve values(1,104,'2023-06-08')
insert into Reserve values(7,103,'2022-12-23')
insert into Reserve values(8,104,'2022-11-29')
insert into Reserve values(19,105,'2023-01-01')
insert into Reserve values(20,106,'2022-12-31')
insert into Reserve values(21,107,'2024-09-16')
insert into Reserve values(15,108,'2025-10-31')
insert into Reserve values(18,109,'2023-03-23')
insert into Reserve values(1,101,'2023-03-05')
insert into Reserve values(2,112,'2023-04-03')
insert into Reserve values(8,113,'2023-07-03')
insert into Reserve values(10,114,'2023-03-14')
insert into Reserve values(11,115,'2023-07-28')
insert into Reserve values(30,116,'2023-03-03')
insert into Reserve values(10,116,'2023-03-03')
insert into Reserve values(1,101,'2022-03-03')
insert into Reserve values(2,102,'2023-06-09')
insert into Reserve values(4,103,'2023-03-03')
insert into Reserve values(3,104,'2022-03-03')
insert into Reserve values(5,105,'2021-03-03')
insert into Reserve values(6,106,'2020-03-03')
insert into Reserve values(23,112,'2023-09-07')
select * from Reserve

--find the names of movies with 2nd highest rating in telugu language
select mname
from movie
where mlanguage='telugu'
and rating=(
               select min(rating)
			   from movie
			   where rating in(
			                   select distinct top 2 rating 
							   from movie
							   order by rating desc
			                  )
           )
   

--find the average rating of movies for each rating level that has atleast 2 movies
select avg(rating) as AVERAGE
from movie
group by rating
having count(rating)>2

--find the names of customers whose names ends with 'h' and atleast 3 characters and who reserved english movies
select distinct cname 
from Customers as c,movie as m,Reserve as r
where c.cid=r.cid and r.mid=m.mid and
c.cname like '__%h' 
 and m.mlanguage='english' 


--find the names of customer who reserved movie Avatar and age between 30 and 50
select cname
from Customers as c,movie as m,reserve as r
where c.cid=r.cid and m.mid=r.mid and m.mname='Avatar'
and c.age>30 and c.age<50;

--find the names of customers who have reserved both 2movies Ghaaji and spider-man
select distinct cname
from customers as c,movie as m,reserve as r
where c.cid=r.cid and m.mid=r.mid and m.mname in ('Ghaaji','spider-man')

--find the avg age of customers who reserved telugu movies
select avg(age) as average_age
from customers c,movie m,reserve r
where c.cid=r.cid and r.mid=m.mid and m.mlanguage='telugu'

--find the avg rating given by individual customer for english movies
select cname,avg(rating) as average_rating
from customers as c,reserve as r,movie as m
where c.cid=r.cid and r.mid=m.mid and m.mlanguage='english'
group by cname


--find the total number of telugu movies reserved between the  age group 20 and 30 with movie rating between 7 and 9
select count(m.mname) as total_count
from customers as c,movie as m,reserve as r
where c.cid=r.cid and r.mid=m.mid and
(c.age>=20 and c.age<=30) and (m.rating>=7 and m.rating<=9)
and m.mlanguage='telugu'

--find the customer names reserved movie saaho on 31st march 2023
select cname from
customers as c,movie as m,reserve as r
where c.cid=r.cid and r.mid=m.mid and m.mname='Saaho' and r.rdate='2023-03-31'
--(OR)
select cname from customers
where cid in
(select cid from reserve where rdate='2023-03-31' and 
mid in (select mid from movie where mname='Saaho'))

--find the total number of movies under rating 8 and the language is not english
select count(*) as total_count
from movie
where rating<8 and not mlanguage='english'

--create a view that contains all the telugu movies with the reservstion dates and cid
create view telugu_mve
as select rdate,c.cid from reserve r,customers c,movie m
where r.cid=c.cid and m.mid=r.mid and m.mlanguage='telugu'

select * from telugu_mve