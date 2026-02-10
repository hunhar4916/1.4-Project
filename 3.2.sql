-- Hunter Harwood

-- Question 1 part 1
ALTER TABLE ORDERS
ADD CONSTRAINT orders_user_fk
FOREIGN KEY (USERID)
REFERENCES userbase(USERID);

-- Part 2
ALTER TABLE REVIEWS
ADD CONSTRAINT reviews_user_fk
FOREIGN KEY (USERID)
REFERENCES userbase(USERID);

-- Part 3
ALTER TABLE userlibrary
ADD CONSTRAINT userlibrary_user_fk
FOREIGN KEY (USERID)
REFERENCES userbase(USERID);

-- Question 2

SELECT
    FIRSTNAME || ' ' || LASTNAME AS full_name,
    USERNAME
FROM USERBASE
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) >= 18;

-- Question 3

SELECT
    MAX(LENGTH(username)) AS max_username_length,
    ROUND(AVG(LENGTH(username)), 2) AS avg_username_length
FROM userbase;

-- Question 4

SELECT question
FROM securityquestion
WHERE question LIKE 'What is%'
   OR question LIKE 'What was%';

   -- Question 5

   SELECT
    productcode,
    MIN(rating) AS lowest_rating,
    COUNT(*) AS review_count
FROM reviews
GROUP BY productcode
ORDER BY review_count DESC;

-- Question 6

SELECT
    productcode,
    COUNT(*) AS user_count
FROM wishlist
WHERE position = 1
GROUP BY productcode;

-- Question 7
SELECT
    USERID,
    SUM(PRICE) AS total_spent
FROM ORDERS
GROUP BY USERID;

-- Question 8
SELECT
    PURCHASEDATE,
    SUM(PRICE) AS gross_profit
FROM ORDERS
GROUP BY PURCHASEDATE
ORDER BY gross_profit DESC;


-- Question 9
SELECT
    productcode,
    SUM(hoursplayed) AS total_hours_played
FROM userlibrary
GROUP BY productcode
ORDER BY total_hours_played DESC
FETCH FIRST 5 ROWS ONLY;


-- Question 10
CREATE OR REPLACE VIEW user_infraction_counts AS
SELECT
    userid,
    COUNT(*) AS infraction_count
FROM infractions
GROUP BY userid
ORDER BY infraction_count DESC;

-- Question 11

CREATE OR REPLACE VIEW user_rule_infraction_counts AS
SELECT
    userid,
    rulenum,
    COUNT(*) AS infraction_count
FROM infractions
GROUP BY userid, rulenum
ORDER BY userid;

-- Question 12

SELECT
    rulenum,
    penalty,
    COUNT(*) AS penalty_count
FROM infractions
GROUP BY rulenum, penalty
ORDER BY rulenum, penalty;

-- Question 13

SELECT
    ROUND(AVG(dateupdated - datesubmitted), 2) AS avg_turnaround_days,
    ROUND(MAX(dateupdated - datesubmitted), 2) AS max_turnaround_days,
    ROUND(MIN(dateupdated - datesubmitted), 2) AS min_turnaround_days
FROM vw_active_support_tickets
WHERE status = 'CLOSED';

-- Question 14

SELECT
    email,
    issue,
    COUNT(*) AS issue_count
FROM vw_active_support_tickets
WHERE status = 'NEW'
GROUP BY
    email,
    issue,
    datesubmitted
ORDER BY issue_count DESC;

-- Question 15
SELECT
    userid,
    firstname,
    lastname,
    username
FROM userbase
WHERE UPPER(password) LIKE '%' || UPPER(firstname) || '%'
   OR UPPER(password) LIKE '%' || UPPER(lastname) || '%';


   -- Question 16
   SELECT
    publisher,
    ROUND(AVG(price), 2) AS avg_price
FROM productlist
GROUP BY publisher
ORDER BY publisher;

-- Question 17
CREATE OR REPLACE VIEW vw_discounted_products AS
SELECT
    productname,
    ROUND(price * 0.75, 2) AS discounted_price
FROM productlist
WHERE releasedate <= ADD_MONTHS(SYSDATE, -60);

-- Question 18
SELECT
    genre,
    MAX(price) AS max_price,
    MIN(price) AS min_price
FROM productlist
GROUP BY genre
ORDER BY genre;


-- Question 19
CREATE OR REPLACE VIEW vw_recent_chatlog AS
SELECT *
FROM chatlog
WHERE datesent BETWEEN SYSDATE - 7 AND SYSDATE;


-- Question 20
CREATE OR REPLACE VIEW vw_recent_penalties AS
SELECT
    userid,
    dateassigned,
    penalty
FROM infractions
WHERE penalty IS NOT NULL
  AND dateassigned >= ADD_MONTHS(SYSDATE, -1);