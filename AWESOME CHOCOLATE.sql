show tables;
desc sales;
select* from sales;
select SaleDate, Amount, Customers  from sales;
select Amount, Customers, GeoID from sales;
select SaleDate, Amount, Boxes, Amount/Boxes    from sales;
select SaleDate, Amount, Boxes, Amount/Boxes  'amount per box'  from sales;
select SaleDate, Amount, Boxes, Amount/Boxes   as 'amount per box' from sales;
select * from sales
where Amount>10000
order by Amount desc;
select * from sales
where Amount>10000
order by Amount;
select * from sales
where Amount>10000
order by Amount desc;
select * from sales
where GeoID='G1'
order by PID desc, Amount desc;
select * from sales
where Amount>10000 and SaleDate>='2022-01-01'
order by Amount desc;
select SaleDate ,Amount from sales
where amount> 10000 and year(SaleDate)=2022;
select * from sales
where Boxes>0 and  boxes<=50;
select * from sales
where Boxes between 0 and 50;
select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of week'
from sales
where weekday(SaleDate) = 4;
select * from people
where Team= 'delish' or Team= 'jucies';



