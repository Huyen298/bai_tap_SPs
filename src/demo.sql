create database demo;
use demo;
create table product1(
    id int auto_increment not  null primary key ,
    pCode varchar(30),
    pName varchar(50),
    pPrice int,
    pAmount int,
    pDescription varchar(50),
    pStatus bit
);
insert into product1(id, pCode, pName, pPrice, pAmount, pDescription, pStatus) VALUES (1,'001','Bàn',15000,10,'Đồ dùng',1);
insert into product1( pCode, pName, pPrice, pAmount, pDescription, pStatus) VALUES ('002','Nồi cơm điện',3000,100,'Đồ điện',1);
insert into product1( pCode, pName, pPrice, pAmount, pDescription, pStatus) VALUES ('003','Máy sấy tóc',50000,10,'Đồ điện',1);
insert into product1( pCode, pName, pPrice, pAmount, pDescription, pStatus) VALUES ('004','Tủ bếp',500000,10,'Đồ dùng',1);
insert into product1( pCode, pName, pPrice, pAmount, pDescription, pStatus) VALUES ('005','Bếp điện',5000,10,'Đồ điện',1);
select * from product1;

create unique index ind_code on product1(pCode);
select pCode from product1 where pCode='003';
explain select pCode from product1 where pCode='003';
alter table product1 drop index ind_code;

create unique index ind_name_price on product1(pName,pPrice);
select pName,pPrice from product1 where pName='Bếp điện' and pPrice=5000;
explain select pName,pPrice from product1 where pName='Bếp điện' and pPrice=5000;
alter table product1 drop index ind_name_price;

create view product_in4 as
    select pCode, pName, pPrice, pStatus from product1;
select * from product_in4;

create or replace view product_in4 as
    select pCode, pName,pAmount, pPrice, pStatus from product1 where pAmount = 10;
drop view product_in4;

DELIMITER //
CREATE PROCEDURE findAllProduct()
begin
    select * from product1;
end //
call findAllProduct();
delimiter //
drop procedure if exists `findAllProduct`//
# Tạo store procedure thêm một sản phẩm mới
    insert into product1(id,pCode,pName,pPrice,pAmount,pDescription,pStatus) values (6,'006','Quạt',250000,15,'Đồ điện',1);
    insert into product1(id,pCode,pName,pPrice,pAmount,pDescription,pStatus) values (7,'007','Gương',200000,15,'Đồ dùng',1);
    insert into product1(id,pCode,pName,pPrice,pAmount,pDescription,pStatus) values (8,'008','Gju',240000,15,'Đồ dùng',1);

delimiter //
create procedure editById(id1 int,pCode1 varchar(30),pName1 varchar(50), pPrice1 int,pAmount1 int, pDescription1 varchar(50), pStatus1 bit)
begin
    update product1
        set pCode = pCode1, pName = pName1, pPrice= pPrice1, pAmount = pAmount1, pDescription = pDescription1, pStatus = pStatus1
        where id = id1;
end //
call editById(5,010,'Máy tính',355000,30,'Đồ điện',1);

delimiter //
create procedure deleteP(id2 int)
begin
    delete from product1 where id2 = id;
end //
call deleteP(8);