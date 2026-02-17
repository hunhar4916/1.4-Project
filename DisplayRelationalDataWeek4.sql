-- Hunter Harwood

-- Question 1
SELECT u.username,
       MIN(r.rating) AS lowest_rating
FROM   UserBase u
JOIN   Reviews r
       ON u.userid = r.userid
GROUP BY u.username
ORDER BY u.username;

-- Question 2
SELECT email,
       issue,
       status
FROM   usersupport
ORDER BY email;

-- Question 3
SELECT u.firstname,
       u.email,
       u.walletfunds
FROM   UserBase u
WHERE  NOT EXISTS (
       SELECT 1
       FROM   UserLibrary ul
       WHERE  ul.userid = u.userid
);

-- Question 4
SELECT u.username,
       COUNT(o.productcode) AS number_of_products_ordered
FROM   UserBase u
LEFT JOIN Orders o
       ON u.userid = o.userid
GROUP BY u.username
ORDER BY u.username;

-- Question 5
SELECT DISTINCT
       FLOOR(MONTHS_BETWEEN(SYSDATE, u.birthday) / 12) AS age
FROM   UserBase u
JOIN   Orders o
       ON u.userid = o.userid
WHERE  o.purchasedate >= ADD_MONTHS(SYSDATE, -6);

-- Question 6
SELECT username,
       birthday
FROM   (
        SELECT u.username,
               u.birthday,
               COUNT(f.friendid) AS friend_count
        FROM   UserBase u
        LEFT JOIN FriendsList f
               ON u.userid = f.userid
        GROUP BY u.username, u.birthday
        ORDER BY friend_count DESC
       )
WHERE  ROWNUM = 1;

-- Question 7
SELECT p.productname,
       p.releasedate,
       p.price,
       p.description
FROM   ProductList p
JOIN   UserLibrary ul
       ON p.productcode = ul.productcode
ORDER BY p.productname;

-- Question 8
SELECT p.productname,
       MAX(r.rating)   AS highest_rating,
       COUNT(r.rating) AS number_of_reviews
FROM   Reviews r
JOIN   ProductList p
       ON r.productcode = p.productcode
GROUP BY p.productname
ORDER BY highest_rating DESC;

-- Question 9
CREATE VIEW vw_extreme_ratings AS
SELECT p.productname,
       p.genre,
       r.rating
FROM   Reviews r
JOIN   ProductList p
       ON r.productcode = p.productcode
WHERE  r.rating IN (1, 5)
ORDER BY r.rating ASC;

-- Question 10
SELECT p.genre,
       COUNT(o.productcode) AS products_ordered
FROM   Orders o
JOIN   ProductList p
       ON o.productcode = p.productcode
GROUP BY p.genre
ORDER BY p.genre ASC;

-- Question 11
CREATE VIEW vw_publisher_stats AS
SELECT p.publisher,
       AVG(p.price)       AS average_price,
       SUM(ul.hoursplayed) AS total_hours_played
FROM   ProductList p
JOIN   UserLibrary ul
       ON p.productcode = ul.productcode
GROUP BY p.publisher;

-- Question 12
SELECT p.publisher,
       SUM(o.price) AS total_money_spent
FROM   Orders o
JOIN   ProductList p
       ON o.productcode = p.productcode
GROUP BY p.publisher
ORDER BY total_money_spent DESC;

-- Question 13
SELECT ticketid,
       email,
       issue
FROM   vw_active_support_tickets
ORDER BY dateupdated DESC;

-- Question 14
SELECT email,
       COUNT(ticketid) AS ticket_count
FROM   UserSupport
GROUP BY email
ORDER BY email;

-- Question 15
SELECT DISTINCT u.userid,
       u.email
FROM   UserBase u
JOIN   UserSupport us
       ON u.email = us.email
WHERE  LOWER(u.email) LIKE '%' || LOWER(u.firstname) || '%'
   OR  LOWER(u.email) LIKE '%' || LOWER(u.lastname) || '%'
   OR  LOWER(u.email) LIKE '%' || LOWER(u.firstname || u.lastname) || '%';

-- Question 16
SELECT DISTINCT us.email
FROM   UserSupport us
WHERE  us.status IN ('NEW', 'IN PROGRESS')
AND    us.email NOT IN (
       SELECT u.email
       FROM   UserBase u
);

-- Question 17
SELECT us.ticketid,
       u.firstname,
       u.lastname,
       u.username
FROM   UserSupport us
JOIN   UserBase u
       ON LOWER(us.issue) LIKE '%' || LOWER(u.username) || '%'
ORDER BY us.ticketid;

-- Question 18
SELECT DISTINCT u.username,
       u.password
FROM   UserSupport us
JOIN   UserBase u
       ON u.email = us.email
ORDER BY u.username;

-- Question 19
CREATE OR REPLACE VIEW vw_recent_penalties AS
SELECT u.username,
       i.dateassigned,
       i.penalty
FROM   Infractions i
JOIN   UserBase u
       ON i.userid = u.userid
WHERE  i.penalty IS NOT NULL
AND    i.dateassigned >= ADD_MONTHS(SYSDATE, -1);

-- Question 20
SELECT u.username,
       u.email
FROM   UserBase u
WHERE  FLOOR(MONTHS_BETWEEN(SYSDATE, u.birthday) / 12) >= 18
AND    NOT EXISTS (
       SELECT 1
       FROM   Infractions i
       WHERE  i.userid = u.userid
       AND    i.dateassigned >= ADD_MONTHS(SYSDATE, -4)
);

--Question 21
SELECT u.username,
       i.dateassigned,
       c.rulenum || ' ' || c.title AS full_guideline_name
FROM userbase u
JOIN infractions i
     ON u.userid = i.userid
JOIN communityrules c
     ON i.rulenum = c.rulenum
ORDER BY u.username, i.dateassigned;

-- Question 22
SELECT u.userid,
       u.username,
       u.email,
       SUM(c.severitypoint) AS total_severity_points
FROM userbase u
JOIN infractions i
     ON u.userid = i.userid
JOIN communityrules c
     ON i.rulenum = c.rulenum
GROUP BY u.userid, u.username, u.email
ORDER BY u.userid;


-- Question 23
SELECT c.title,
       c.description,
       i.penalty
FROM infractions i
JOIN communityrules c
     ON i.rulenum = c.rulenum
ORDER BY c.title;

-- Question 24
SELECT u.username,
       COUNT(i.infractionid) AS infraction_count
FROM userbase u
JOIN infractions i
     ON u.userid = i.userid
GROUP BY u.username
HAVING COUNT(i.infractionid) >= 15
ORDER BY infraction_count DESC;


