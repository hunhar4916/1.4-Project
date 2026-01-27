-- Hunter Harwood

-- Question 1

select USER_ID
       USERNAME,
       CREATED,
       PASSWORD_CHANGE_DATE
from USER_USERS;

-- Question 2

select *
from USER_TABLES;

-- Question 3 part 1
desc ORDERS;
-- Question 3 part 2
desc PRODUCTLIST;
-- Question 3 part 3
desc REVIEWS;
-- Question 3 part 4
desc STOREFRONT;
-- Question 3 part 5
desc USERBASE;
-- Question 3 part 6
desc USERLIBRARY;

-- Question 4 part 1
select * from ORDERS;
-- Question 4 part 2
select * from PRODUCTLIST;
-- Question 4 part 3
select * from REVIEWS;
-- Question 4 part 4
select * from STOREFRONT;
-- Question 4 part 5
select * from USERBASE;
-- Question 4 part 6
select * from USERLIBRARY;

-- Question 5
select TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE, STATUS
from USER_CONSTRAINTS;

-- Question 6
select VIEW_NAME, TEXT
FROM USER_VIEWS;

-- Question 7
select username
from USERBASE
order by username;

-- Question 8
select FIRSTNAME, LASTNAME, USERNAME, PASSWORD, EMAIL
from USERBASE
where email like '%yahoo%';

-- Question 9
select USERNAME, BIRTHDAY, WALLETFUNDS
from USERBASE
where WALLETFUNDS < 25;

-- Question 10
select USERID, PRODUCTCODE, HOURSPLAYED
from USERLIBRARY
where HOURSPLAYED > 100;

-- Question 11
select PRODUCTCODE
from USERLIBRARY
where HOURSPLAYED < 10;

-- Question 12
select PUBLISHER 
from PRODUCTLIST;

-- Question 13
select PRODUCTNAME, RELEASEDATE, PUBLISHER, GENRE
from PRODUCTLIST
order by genre;

-- Question 14
select PRODUCTCODE, PUBLISHER
from PRODUCTLIST
where GENRE like 'Strategy';

-- Question 15
select PRODUCTCODE, DESCRIPTION, PRICE
from STOREFRONT
where PRICE > 25
order by PRICE desc;

-- Question 16
select INVENTORYID, PRICE
from STOREFRONT
order by PRICE asc;

-- Question 17
select PRODUCTCODE, REVIEW, RATING
from REVIEWS
where RATING = 1;

-- Question 18
select PRODUCTCODE, REVIEW, RATING
from REVIEWS
where RATING >= 4

-- Question 19
select USERID, ORDERID
from ORDERS;

-- Question 20
select *
from ORDERS
order by PURCHASEDATE asc;
