--to use previous db :- use dbname

create database db_student
create table table_student ( 
names varchar(20) null,
roll_no int primary key,
cgpa float 
)

--to rename db:

 exec sp_renamedb 'db_student', 'db_stud'

--to rename table:

exec sp_rename 'table_student','tb_stud' 

-- to rename column:

exec sp_rename 'tb_stud.roll_no','reg_no'

insert into tb_stud values('Ali','1',3.3)
select * from tb_stud

-- clearing table for adding not null condition
truncate table tb_stud


--adding clmn

alter table tb_stud
--if tb already exist u cant add 'not null' column in it , it will show error
add CNIC int not null;


--dropping clmn

alter table tb_stud
drop column CNIC

--change datatype of clmn

-- it doesnt work on null type as it voilate the condition
alter table tb_stud
alter column names text not null;

-- update row data
insert into tb_stud values ('Ali', 1, 3.3)
insert into tb_stud values ('Ali', 2, 3.2)
insert into tb_stud values ('Ahmad', 3, 3.1)
insert into tb_stud values ('Ahmad', 4, 3.4)
select * from tb_stud


-- if you dont put where column then it will automatically update all the column data so specification is required where changing is needed
update tb_stud set names = 'Asad' where reg_no =2
update tb_stud set names = 'Arslan' where reg_no =3
update tb_stud set cgpa = 3.2 where reg_no = 3
select * from tb_stud

-- drop complete db :- drop database db_stud
-- drop complete tb:- drop table tb_stud

--to delete specific row
delete from tb_stud where reg_no = 4
select * from tb_stud


-- to add check on column
truncate table tb_stud
alter table tb_stud
add constraint cgpa_check
check (cgpa>0 AND cgpa<10)
INSERT INTO tb_stud (names, reg_no, cgpa) VALUES ('Ali',1,  3);
INSERT INTO tb_stud (names, reg_no, cgpa) VALUES ('Ali',2, 3.2);
INSERT INTO tb_stud (names, reg_no, cgpa) VALUES ('Ahmad',3, 3.1);
INSERT INTO tb_stud (names, reg_no, cgpa) VALUES ('Ahmad',4, 3.4);
select * from tb_stud

/*alter table tb_stud
add constraint default_value
default 'unknown' for names*/


--- new tables ---
--FOREIGN kEY : can have duplicate values , can be apply on null , can be many, dont allow ambigious data in table
-- 1:1 1:M M:M check : check relation from both table then which is higher it is accepted and where M is there foreign key is applied
-- seperate column is made for foreign key pn M side

create table tb_order(
o_id int primary key not null,
p_name varchar(20),
quantity int,
price float 
)


create table tb_customer(
id int primary key not null,
names varchar(20),
quantity int )

alter table tb_customer
drop column quantity




insert into tb_order values(11, 'cake' , 12 , 100,1)
insert into tb_order values(22, 'sweets' , 354, 200,3)
insert into tb_order values(33, 'bottles' , 65 , 300,2)
insert into tb_order values(44, 'chocolates' , 345 , 400,3)
insert into tb_order values(55, 'candies' , 66 , 500,4)
select * from tb_order



insert into tb_customer values(1 , 'Ali')
insert into tb_customer values(2 , 'Bilal')
insert into tb_customer values(3 , 'Ahmad')
insert into tb_customer values(4 , 'Fahad')
insert into tb_customer values(5 , 'Amjad')
select * from tb_customer

truncate table tb_order
alter table tb_order
add  c_id int
alter table tb_order
add constraint fk_cust
foreign key (c_id) references tb_customer(id)

-- Cascading : we cant delete parent customer as it is conected with c_id so go to tb where fk go to keys open fk - insert & update - ctrl+s
delete from tb_customer where id = 3
select * from tb_order
