--create database CSDL_session05_01
create database CSDL_session05_01;
--create table products
create table products(
    product_id serial primary key,
	product_name varchar(50) not null,
	category varchar(100)
);

create table orders(
    order_id serial primary key,
	product_id int not null references products(product_id),
	quantity int,
	total_price int
);

select * from products;
insert into products(product_id, product_name, category) values
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Bàn học gỗ', 'Furniture'),
(4, 'Ghế xoay', 'Furniture');

select * from orders;
insert into orders (order_id, product_id, quantity, total_price) values
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

select sum(o.total_price) as total_sales, sum(o.quantity) as total_quantity, p.category
from products p join orders o on p.product_id = o.product_id
group by p.category
having sum(total_price) > 2000
order by total_sales desc;


select p.product_name, sum(o.total_price) as total_revenue
from products p join orders o on p.product_id = o.product_id
group by p.product_id, p.product_name
having sum(o.total_price) = (
	select max(revenue)
	from ( 
		select sum(total_price) as revenue
		from orders
		group by product_id
	)
);

select p.category, sum(o.total_price) as total_sales
from products p
join orders o on p.product_id = o.product_id
group by p.category;

select p.category
from products p join orders o on p.product_id = o.product_id
group by p.product_id, p.category
having sum(o.total_price) = (
	select max(revenue)
	from (
		select max(total_price) as revenue
		from orders
		group by product_id
	)
)
intersect

select p.category
from products p join orders o on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 3000;