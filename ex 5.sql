create database if not exists sakila_demo;
use sakila_demo;
CREATE TABLE actor (select * from sakila.actor)
CREATE TABLE address (select * from sakila.address)
CREATE TABLE category (select * from sakila.category)
CREATE TABLE city (select * from sakila.city)
CREATE TABLE country (select * from sakila.country)
CREATE TABLE customer (select * from sakila.customer)
CREATE TABLE film (select * from sakila.film)
CREATE TABLE film_actor (select * from sakila.film_actor)
CREATE TABLE film_category (select * from sakila.film_category)
CREATE TABLE film_text (select * from sakila.film_text)
CREATE TABLE inventory (select * from sakila.inventory)
CREATE TABLE language (select * from sakila.language)
CREATE TABLE payment (select * from sakila.payment)
CREATE TABLE rental (select * from sakila.rental)
CREATE TABLE staff (select * from sakila.staff)
CREATE TABLE store (select * from sakila.store)


-- 1.Drop column picture from staff.
alter table sakila_demo.staff
drop column picture;

select * from staff

--2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff
select * from customer 
where first_name='tammy'

insert into staff
values (3,'TAMMY','SANDERS',79 ,'TAMMY.SANDERS@sakilastaff.com',2,1,'TAMMY','','2024-06-08 14:08:00');
select * from staff

-- 3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information.
-- For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
-- Use similar method to get inventory_id, film_id, and staff_id.

select * from rental
select * from inventory


insert into rental (rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
values (16050,
		'2024-06-08 14:08:00',
			(select inventory_id
            from (select inventory_id 
				from inventory
				join film using (film_id)
				where title= 'Academy Dinosaur' and store_id=1) s
            limit 1),
			(select customer_id 
			from customer
			where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
		'2024-06-28 14:08:00',
            (select staff_id 
			from sakila.staff
			where store_id =1),
		'2024-06-28 14:08:00' ) ;
        
        select * from rental
        where rental_id=16050

-- 4.Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
use sakila_demo;
CREATE TABLE deleted_users (
  `customer_id` int UNIQUE NOT NULL,
  `email` char(30) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
   CONSTRAINT PRIMARY KEY (customer_id)
   )
   
   
ALTER TABLE deleted_users
MODIFY COLUMN email VARCHAR(40);


insert into deleted_users (customer_id,email,date)
SELECT customer_id, email,create_date FROM CUSTOMER
WHere active=0

select * from deleted_users




