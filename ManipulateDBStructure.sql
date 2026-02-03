--Hunter Harwood

--task 1

ALTER TABLE ProductList ADD Description VARCHAR2(250);
ALTER TABLE ProductList ADD Price NUMBER(6,2);

UPDATE ProductList p
SET (p.Price, p.Description) =
    (SELECT s.Price, s.Description
     FROM Storefront s
     WHERE s.ProductCode = 'GAME1')
WHERE p.ProductCode = 'GAME1';

--task 2
CREATE TABLE CHATLOG (
    CHATID     NUMBER(3),
    RECEIVERID NUMBER(3),
    SENDERID   NUMBER(3),
    DATESENT   DATE,
    CONTENT    VARCHAR2(250),

    CONSTRAINT PK_CHATLOG PRIMARY KEY (CHATID),
    CONSTRAINT FK_CHATLOG_RECEIVER FOREIGN KEY (RECEIVERID)
        REFERENCES USERBASE (USERID),
    CONSTRAINT FK_CHATLOG_SENDER FOREIGN KEY (SENDERID)
        REFERENCES USERBASE (USERID)
);

INSERT INTO CHATLOG VALUES (1, 102, 101, DATE '2025-01-10', 'Hey, did you check out the new RPG sale?');
INSERT INTO CHATLOG VALUES (2, 101, 102, DATE '2025-01-10', 'Yeah! Picked up two games already.');
INSERT INTO CHATLOG VALUES (3, 103, 101, DATE '2025-01-11', 'Anyone want to squad up later?');
INSERT INTO CHATLOG VALUES (4, 101, 103, DATE '2025-01-11', 'I am down after 8pm.');
INSERT INTO CHATLOG VALUES (5, 104, 102, DATE '2025-01-12', 'Did you leave a review on VaporGames?');
INSERT INTO CHATLOG VALUES (6, 102, 104, DATE '2025-01-12', 'Not yet, but I will tonight.');
INSERT INTO CHATLOG VALUES (7, 105, 103, DATE '2025-01-13', 'This indie game is way better than expected.');
INSERT INTO CHATLOG VALUES (8, 103, 105, DATE '2025-01-13', 'Agreed, the soundtrack is amazing.');
INSERT INTO CHATLOG VALUES (9, 104, 101, DATE '2025-01-14', 'Your wishlist recommendations were spot on.');
INSERT INTO CHATLOG VALUES (10, 101, 104, DATE '2025-01-14', 'Glad it helped!');
INSERT INTO CHATLOG VALUES (11, 105, 102, DATE '2025-01-15', 'Are you joining the tournament this weekend?');
INSERT INTO CHATLOG VALUES (12, 102, 105, DATE '2025-01-15', 'Yeah, already signed up.');

-- task 3
CREATE TABLE FRIENDSLIST (
    USERID   NUMBER(3),
    FRIENDID NUMBER(3),

    CONSTRAINT PK_FRIENDSLIST PRIMARY KEY (USERID, FRIENDID),
    CONSTRAINT FK_FRIENDSLIST_USER FOREIGN KEY (USERID)
        REFERENCES USERBASE (USERID),
    CONSTRAINT FK_FRIENDSLIST_FRIEND FOREIGN KEY (FRIENDID)
        REFERENCES USERBASE (USERID)
);

INSERT INTO FRIENDSLIST VALUES (101, 102);
INSERT INTO FRIENDSLIST VALUES (101, 103);
INSERT INTO FRIENDSLIST VALUES (102, 101);
INSERT INTO FRIENDSLIST VALUES (102, 104);
INSERT INTO FRIENDSLIST VALUES (103, 101);
INSERT INTO FRIENDSLIST VALUES (103, 105);
INSERT INTO FRIENDSLIST VALUES (104, 102);
INSERT INTO FRIENDSLIST VALUES (104, 105);
INSERT INTO FRIENDSLIST VALUES (105, 103);
INSERT INTO FRIENDSLIST VALUES (105, 104);
INSERT INTO FRIENDSLIST VALUES (106, 101);
INSERT INTO FRIENDSLIST VALUES (107, 108);

-- task 4
CREATE TABLE WISHLIST (
    USERID      NUMBER(3),
    PRODUCTCODE VARCHAR2(5),
    POSITION    NUMBER(3),

    CONSTRAINT PK_WISHLIST PRIMARY KEY (USERID, PRODUCTCODE),
    CONSTRAINT FK_WISHLIST_USER FOREIGN KEY (USERID)
        REFERENCES USERBASE (USERID),
    CONSTRAINT FK_WISHLIST_PRODUCT FOREIGN KEY (PRODUCTCODE)
        REFERENCES PRODUCTLIST (PRODUCTCODE)
);
INSERT INTO WISHLIST VALUES (101, 'GAME1', 1);
INSERT INTO WISHLIST VALUES (101, 'GAME3', 2);
INSERT INTO WISHLIST VALUES (101, 'GAME5', 3);

INSERT INTO WISHLIST VALUES (102, 'GAME2', 1);
INSERT INTO WISHLIST VALUES (102, 'GAME4', 2);

INSERT INTO WISHLIST VALUES (103, 'GAME1', 1);
INSERT INTO WISHLIST VALUES (103, 'GAME6', 2);
INSERT INTO WISHLIST VALUES (103, 'GAME7', 3);

INSERT INTO WISHLIST VALUES (104, 'GAME3', 1);
INSERT INTO WISHLIST VALUES (104, 'GAME5', 2);

INSERT INTO WISHLIST VALUES (105, 'GAME2', 1);
INSERT INTO WISHLIST VALUES (105, 'GAME4', 2);
INSERT INTO WISHLIST VALUES (105, 'GAME8', 3);

--task 5
CREATE TABLE userprofile (
    userid      NUMBER(3),
    imagefile   VARCHAR2(250),
    description VARCHAR2(250),
 
    CONSTRAINT userprofile_pk
        PRIMARY KEY (userid),
 
    CONSTRAINT userprofile_user_fk
        FOREIGN KEY (userid)
        REFERENCES userbase(userid)
);
INSERT INTO userprofile VALUES (101,'avatar101.png','Competitive FPS player and streamer.');
INSERT INTO userprofile VALUES (102,'avatar102.png','Casual gamer who loves RPGs.');
INSERT INTO userprofile VALUES (103,'avatar103.png','Strategy games and speedruns.');
INSERT INTO userprofile VALUES (104,'avatar104.png','Team player, healer main.');
INSERT INTO userprofile VALUES (105,'avatar105.png','Late night ranked grinder.');
INSERT INTO userprofile VALUES (106,'avatar106.png','Indie games enthusiast.');
INSERT INTO userprofile VALUES (107,'avatar107.png','Achievement hunter.');
INSERT INTO userprofile VALUES (108,'avatar108.png','MMO raider and crafter.');
INSERT INTO userprofile VALUES (109,'avatar109.png','Retro games collector.');
INSERT INTO userprofile VALUES (110,'avatar110.png','New player exploring everything.');

-- task 6
CREATE TABLE securityquestion (
    questionid NUMBER,
    userid     NUMBER(3),
    question   VARCHAR2(250),
    answer     VARCHAR2(250),
 
    CONSTRAINT securityquestion_pk
        PRIMARY KEY (questionid),
 
    CONSTRAINT securityquestion_user_fk
        FOREIGN KEY (userid)
        REFERENCES userbase(userid)
);
INSERT INTO SECURITYQUESTION VALUES
(1, 101, 'What is the name of your first pet?', 'Buddy');

INSERT INTO SECURITYQUESTION VALUES
(2, 101, 'What city were you born in?', 'Dallas');

INSERT INTO SECURITYQUESTION VALUES
(3, 102, 'What is your favorite video game?', 'Skyrim');

INSERT INTO SECURITYQUESTION VALUES
(4, 102, 'What was the name of your elementary school?', 'Lincoln');

INSERT INTO SECURITYQUESTION VALUES
(5, 103, 'What is your mother’s maiden name?', 'Smith');

INSERT INTO SECURITYQUESTION VALUES
(6, 103, 'What was your first car?', 'Civic');

INSERT INTO SECURITYQUESTION VALUES
(7, 104, 'What is your favorite movie?', 'Inception');

INSERT INTO SECURITYQUESTION VALUES
(8, 104, 'What was the name of your childhood best friend?', 'Alex');

INSERT INTO SECURITYQUESTION VALUES
(9, 105, 'What is your favorite food?', 'Pizza');

INSERT INTO SECURITYQUESTION VALUES
(10, 105, 'What was the name of your first teacher?', 'Mrs. Brown');

INSERT INTO SECURITYQUESTION VALUES
(11, 106, 'What city did you meet your best friend in?', 'Austin');

INSERT INTO SECURITYQUESTION VALUES
(12, 107, 'What is your favorite console?', 'PlayStation');


-- task 7
CREATE TABLE communityrules (
    rulenum       NUMBER(3),
    title         VARCHAR2(250),
    description   VARCHAR2(250),
    severitypoint NUMBER(4),
 
    CONSTRAINT communityrules_pk
        PRIMARY KEY (rulenum)
);
INSERT INTO communityrules VALUES (1,'No Harassment','Harassment or bullying of any kind is prohibited.',100);
INSERT INTO communityrules VALUES (2,'No Hate Speech','Hate speech will not be tolerated.',150);
INSERT INTO communityrules VALUES (3,'No Cheating','Using exploits or cheats is forbidden.',120);
INSERT INTO communityrules VALUES (4,'Respect Others','Treat all players with respect.',50);
INSERT INTO communityrules VALUES (5,'No Spamming','Spamming chat or messages is not allowed.',40);
INSERT INTO communityrules VALUES (6,'No Impersonation','Do not impersonate staff or players.',80);
INSERT INTO communityrules VALUES (7,'Appropriate Language','Keep language appropriate.',30);
INSERT INTO communityrules VALUES (8,'No Scamming','Scamming other users is prohibited.',130);
INSERT INTO communityrules VALUES (9,'No Threats','Threats of violence are not allowed.',200);
INSERT INTO communityrules VALUES (10,'No Advertising','Unapproved advertising is prohibited.',60);
INSERT INTO communityrules VALUES (11,'No Account Sharing','Sharing accounts is not allowed.',70);
INSERT INTO communityrules VALUES (12,'Follow Game Rules','Always follow in-game rules.',20);

-- task 8
CREATE TABLE INFRACTIONS (
    INFRACTIONID NUMBER,
    USERID       NUMBER(3),
    RULENUM      NUMBER(3),
    DATEASSIGNED DATE,
    PENALTY      VARCHAR2(250),

    CONSTRAINT PK_INFRACTIONS PRIMARY KEY (INFRACTIONID),
    CONSTRAINT FK_INFRACTIONS_USER FOREIGN KEY (USERID)
        REFERENCES USERBASE (USERID),
    CONSTRAINT FK_INFRACTIONS_RULE FOREIGN KEY (RULENUM)
        REFERENCES COMMUNITYRULES (RULENUM)
);
INSERT INTO INFRACTIONS VALUES
(1, 101, 1, DATE '2025-01-05', 'Warning issued');

INSERT INTO INFRACTIONS VALUES
(2, 102, 3, DATE '2025-01-06', '24-hour chat mute');

INSERT INTO INFRACTIONS VALUES
(3, 103, 5, DATE '2025-01-07', 'Temporary suspension');

INSERT INTO INFRACTIONS VALUES
(4, 104, 2, DATE '2025-01-08', 'Content removed');

INSERT INTO INFRACTIONS VALUES
(5, 105, 4, DATE '2025-01-09', 'Warning issued');

INSERT INTO INFRACTIONS VALUES
(6, 106, 6, DATE '2025-01-10', '3-day account suspension');

INSERT INTO INFRACTIONS VALUES
(7, 107, 7, DATE '2025-01-11', 'Permanent ban');

INSERT INTO INFRACTIONS VALUES
(8, 108, 1, DATE '2025-01-12', 'Warning issued');

INSERT INTO INFRACTIONS VALUES
(9, 109, 8, DATE '2025-01-13', 'Loss of posting privileges');

INSERT INTO INFRACTIONS VALUES
(10, 110, 9, DATE '2025-01-14', 'Account flagged for review');

INSERT INTO INFRACTIONS VALUES
(11, 101, 10, DATE '2025-01-15', '7-day suspension');

INSERT INTO INFRACTIONS VALUES
(12, 102, 2, DATE '2025-01-16', 'Post deletion and warning');

-- task 9
CREATE TABLE USERSUPPORT (
    TICKETID      NUMBER,
    EMAIL         VARCHAR2(250),
    ISSUE         VARCHAR2(250),
    DATESUBMITTED DATE,
    DATEUPDATED   DATE,
    STATUS        VARCHAR2(250),

    CONSTRAINT PK_USERSUPPORT PRIMARY KEY (TICKETID)
);
INSERT INTO USERSUPPORT VALUES
(1, 'user101@email.com', 'Cannot log into my account', DATE '2025-01-05', DATE '2025-01-05', 'NEW');

INSERT INTO USERSUPPORT VALUES
(2, 'user102@email.com', 'Game download stuck at 99%', DATE '2025-01-06', DATE '2025-01-07', 'IN PROGRESS');

INSERT INTO USERSUPPORT VALUES
(3, 'user103@email.com', 'Incorrect charge on my account', DATE '2025-01-07', DATE '2025-01-08', 'CLOSED');

INSERT INTO USERSUPPORT VALUES
(4, 'user104@email.com', 'Unable to reset password', DATE '2025-01-08', DATE '2025-01-08', 'NEW');

INSERT INTO USERSUPPORT VALUES
(5, 'user105@email.com', 'Game crashes on startup', DATE '2025-01-09', DATE '2025-01-10', 'IN PROGRESS');

INSERT INTO USERSUPPORT VALUES
(6, 'user106@email.com', 'Account suspended by mistake', DATE '2025-01-10', DATE '2025-01-12', 'CLOSED');

INSERT INTO USERSUPPORT VALUES
(7, 'user107@email.com', 'Unable to add friend', DATE '2025-01-11', DATE '2025-01-11', 'NEW');

INSERT INTO USERSUPPORT VALUES
(8, 'user108@email.com', 'Wishlist items disappeared', DATE '2025-01-12', DATE '2025-01-13', 'IN PROGRESS');

INSERT INTO USERSUPPORT VALUES
(9, 'user109@email.com', 'Chat messages not sending', DATE '2025-01-13', DATE '2025-01-14', 'CLOSED');

INSERT INTO USERSUPPORT VALUES
(10, 'user110@email.com', 'Refund request for recent purchase', DATE '2025-01-14', DATE '2025-01-15', 'IN PROGRESS');

INSERT INTO USERSUPPORT VALUES
(11, 'guest@email.com', 'General question about platform', DATE '2025-01-15', DATE '2025-01-15', 'NEW');

INSERT INTO USERSUPPORT VALUES
(12, 'helpme@email.com', 'Email verification not received', DATE '2025-01-16', DATE '2025-01-17', 'CLOSED');

-- task 10
CREATE VIEW VW_UNIQUE_SECURITY_QUESTIONS AS
SELECT DISTINCT QUESTION
FROM SECURITYQUESTION;

CREATE VIEW VW_ACTIVE_SUPPORT_TICKETS AS
SELECT
    TICKETID,
    EMAIL,
    ISSUE,
    DATEUPDATED
FROM USERSUPPORT
WHERE STATUS IN ('NEW', 'IN PROGRESS')
ORDER BY DATEUPDATED ASC;

SELECT * FROM VW_UNIQUE_SECURITY_QUESTIONS;
SELECT * FROM VW_ACTIVE_SUPPORT_TICKETS;