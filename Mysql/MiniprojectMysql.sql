CREATE DATABASE bookstore;


CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  book_title VARCHAR(255),
  publication_year INT,
  author_id INT,
  stock_count INT
);



INSERT into books(book_title, publication_year, stock_count, author_id)
VALUES
('The Namesake', 2003, 32, 8),
('Norse Mythology',2016, 43, 15),
('American Gods',2001, 12, 6),
('Interpreter of Maladies', 1996, 97, 2),
('A Hologram for the King: A Novel',2012, 154, 7),
('The Circle', 2013, 26, 16),
('The Amazing Adventures of Kavalier & Clay', 2000, 68,13),
('Just Kids', 2010, 55, 9),
('A Heartbreaking Work of Staggering Genius', 2001, 104, 1),
('Coraline', 2003, 100, 3),
('What We Talk About When We Talk About Love: Stories', 1981, 23, 10),
("Where I'm Calling From: Selected Stories", 1989, 12, 12),
('White Noise', 1985, 49, 14),
('Cannery Row', 1945, 95, 11),
('Oblivion: Stories', 2004, 172, 4),
('Consider the Lobster',  2005, 92, 5);





CREATE TABLE authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  author_fname VARCHAR(255),
  author_lname VARCHAR(255)
);

INSERT INTO authors(author_fname, author_lname)
VALUES
('Jhumpa', 'Lahiri'),
('Nila', 'Kanner'),
('Neil', 'Gaiman'),
('Jhumpa', 'Lahiri'),
('Mad', 'Grager'),
('Dave', 'Eggers'),
('Michael', 'Chabon'),
('Patti', 'Smith'),
('Varl', 'Rade'),
('loler', 'Boot'),
('Raymond', 'Carver'),
('Crayon', 'Ziter'),
('Don', 'DeLillo'),
('John', 'Steinbeck'),
('David', 'Foster'),
('David', 'Wallace');




CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(255),
  customer_email VARCHAR(255)
);


INSERT INTO customers(customer_name, customer_email)
VALUES
('Alfreds','Alfredsfu@example.com'),
('Antonio','Antoniomo@example.com'),
('Consolidated','Consolidatedh@example.com'),
('Drachenblut','Drachenblutd@example.com'),
('Eastern','Easternc@example.com'),
('Ernst','Ernsth@example.com'),
('Folies','Foliesg@example.com'),
('France','Francer@example.com'),
('Franken','Frankenv@example.com'),
('Alice','alice@example.com'),
('Bob','bob@example.com'),
('Evan','eves@example.com'),
('Gourmet','Gourmetl@example.com'),
('Smith','Smitht@example.com'),
('Davis','Davise@example.com'),
('Johnson','Johnsonb@example.com');




  CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  book_id INT,
  order_date DATE,
  total_amount DECIMAL(10, 2),
  sale_order INT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO orders(customer_id, book_id, order_date, total_amount, sale_order)
VALUES
(1, 1, '2022-11-11', 189.00, 9),
(2, 2, '2023-01-02', 89.00, 5),
(3, 8, '2019-02-04', 25.00, 10),
(4, 4, '2020-01-01', 78.00, 3),
(5, 5, '2021-05-03', 12.00, 6),
(6, 3, '1990-05-30', 13.00, 13),
(7, 1, '2001-10-14', 10.00, 4),
(8, 2, '2005-11-10', 13.00, 2),
(9, 3, '2003-09-03', 45.00, 11),
(10, 1, '2015-05-01', 31.00, 8),
(11, 9, '2013-05-19', 22.00, 34),
(12, 6, '2000-05-03', 16.00 ,2),
(13, 4, '1996-11-04', 1.00, 7),
(14, 2, '2002-09-19',15.00, 7),
(15, 3, '2003-04-03', 16.00,12),
(16, 3, '2018-05-03', 14.00, 4);





CREATE TABLE genres (
  genre_id INT PRIMARY KEY,
  genre_name VARCHAR(255)
);

INSERT INTO genres (genre_id, genre_name)
VALUES (1, 'Fantasy'),
       (2, 'Science Fiction'),
       (3, 'Romance'),
       (4, 'Fantasy'),
       (5, 'Thriller'),
       (6, 'Biography'),
       (7, 'Historical Fiction'),
       (8, 'Horror'),
       (9, 'Adventure'),
       (10, 'Contemporary'),
       (11, 'Young Adult'),
       (12, 'Drama'),
       (13, 'Non-fiction'),
       (14, 'Poetry'),
       (15, 'Self-Help'),
       (16, 'Business');





CREATE TABLE bookprices (
  bookprice_id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT,
  price DECIMAL(10, 2),
  genre_id INT,
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO bookprices (book_id, price)
VALUES (1, 10.99),
       (2, 8.99),
       (3, 12.99),
       (4, 14.99),
       (5, 9.99),
       (6, 11.99),
       (7, 13.99),
       (8, 7.99),
       (9, 15.99),
       (10, 12.49),
       (11, 9.49),
       (12, 11.49),
       (13, 14.49),
       (14, 8.49),
       (15, 13.49),
       (16, 10.49);

#list all the books in database.
select book_title from books;

#find book by a spcific author first name and last name.
select author_fname, author_lname, book_title, publication_year
from books
inner join authors on books.book_id = authors.author_id
where authors.author_fname = 'John';

#get the total number of books in stock_count
select sum(stock_count) as Books_In_Stock from books;

#find the top-selling books based on the sale orders.
select books.book_id, books.book_title, max(orders.sale_order) as total_sale_orders
from books 
inner join orders on books.book_id = orders.book_id
where orders.sale_order
group by books.book_id, books.book_title
order by total_sale_orders desc limit 3;

#retrieve all orders placed by a specific customer.
select order_id, (customers.customer_name), sale_order
from orders
inner join customers on orders.order_id = customers.customer_id
where customers.customer_name = 'Bob';

#calculate the total revenue generated from book sales.
select sum(books.stock_count * bookprices.price) as Total_revenue
from books
join bookprices on books.book_id = bookprices.book_id;

#calculate total revenue for a specific time period.
select sum(books.stock_count * bookprices.price) as Total_revenue
from books
join bookprices on books.book_id = bookprices.book_id
join orders on books.book_id = orders.book_id
where orders.order_date >= '2002-09-19' and orders.order_date <= '2022-11-11';