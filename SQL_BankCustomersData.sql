# Pre-Requsites
# Assuming Candidates are familiar with “Group by” and “Grouping functions” because these are used along with JOINS in the questionnaire. 



#Table Definitions:

--  1. BANK_CUSTOMER - Details of Customers of the Bank
-- 2. BANK_CUSTOMER_EXPORT - Details of Customers of the Bank - to be used only when explicitly asked.
-- 3. Bank_Account_Details - Account Details of the customers along with ADD on cards. One customer can have multiple details for Savings deposits, Recurring deposits, Credit Cards and Add on credit cards.
-- 4. Bank_Account_Relationship_Details - Details of secondary accounts linked to primary accounts.
-- 5. BANK_ACCOUNT_TRANSACTION - Details of the transactions.
-- 6. BANK_CUSTOMER_MESSAGES - Details of Messages sent to customers after a transaction takes place.
-- 7. BANK_INTEREST_RATE - Current interest rates for savings, RD and other accounts.
-- 8. Bank_Holidays - Details of Bank Holidays.   
-- = to get this CTRL + /

CREATE DATABASE sql3bank;

# Create below DB objects 
use sql3bank;
CREATE TABLE BANK_CUSTOMER 
( customer_id INT PRIMARY KEY,
customer_name VARCHAR(20),
Address 	VARCHAR(20),
state_code  VARCHAR(3) ,    	 
Telephone   VARCHAR(10)	);
				
INSERT INTO BANK_CUSTOMER VALUES (123001,"Oliver", "225-5, Emeryville", "CA" , "1897614500");
INSERT INTO BANK_CUSTOMER VALUES (123002,"George", "194-6,New brighton","MN" , "1897617000");
INSERT INTO BANK_CUSTOMER VALUES (123003,"Harry", "2909-5,walnut creek","CA" , "1897617866");
INSERT INTO BANK_CUSTOMER VALUES (123004,"Jack", "229-5, Concord",  	"CA" , "1897627999");
INSERT INTO BANK_CUSTOMER VALUES (123005,"Jacob", "325-7, Mission Dist","SFO", "1897637000");
INSERT INTO BANK_CUSTOMER VALUES (123006,"Noah", "275-9, saint-paul" ,  "MN" , "1897613200");
INSERT INTO BANK_CUSTOMER VALUES (123007,"Charlie","125-1,Richfield",   "MN" , "1897617666");
INSERT INTO BANK_CUSTOMER VALUES (123008,"Robin","3005-1,Heathrow", 	"NY" , "1897614000");

select COUNT(*) from BANK_CUSTOMER;


CREATE TABLE BANK_CUSTOMER_EXPORT 
( 
customer_id CHAR(10)PRIMARY KEY,
customer_name CHAR(20),
Address CHAR(20),
state_code  CHAR(3) ,    	 
Telephone  CHAR(10));
    
INSERT INTO BANK_CUSTOMER_EXPORT VALUES ("123001 ","Oliver", "225-5, Emeryville", "CA" , "1897614500") ;
INSERT INTO BANK_CUSTOMER_EXPORT VALUES ("123002 ","George", "194-6,New brighton","MN" , "189761700");


#Bank_Account_details table

CREATE TABLE Bank_Account_Details
(Customer_id INT,
Account_Number VARCHAR(19) PRIMARY KEY,
Account_type VARCHAR(25) ,
Balance_amount INT,
Account_status VARCHAR(10),             	 
Relationship_type varchar(1)) ;

ALTER TABLE Bank_Account_Details ADD FOREIGN KEY (Customer_id) REFERENCES bank_customer(Customer_id);

INSERT INTO Bank_Account_Details  VALUES (123001, "4000-1956-3456",  "SAVINGS" , 200000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123001, "5000-1700-3456", "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO Bank_Account_Details  VALUES (123002, "4000-1956-2001",  "SAVINGS", 400000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S");
INSERT INTO Bank_Account_Details  VALUES (123003, "4000-1956-2900",  "SAVINGS" ,750000,"INACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123004, "5000-1700-6091", "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S");
INSERT INTO Bank_Account_Details  VALUES (123004, "4000-1956-3401",  "SAVINGS" , 655000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123005, "4000-1956-5102",  "SAVINGS" , 300000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123006, "4000-1956-5698",  "SAVINGS" , 455000 ,"ACTIVE" ,"P");
INSERT INTO Bank_Account_Details  VALUES (123007, "5000-1700-9800",  "SAVINGS" , 355000 ,"ACTIVE" ,"P");
INSERT INTO Bank_Account_Details  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S");
INSERT INTO Bank_Account_Details  VALUES (123007, "9000-1700-7777-4321",  "Credit Card"	,0  ,"INACTIVE", "P");
INSERT INTO Bank_Account_Details  VALUES (123007, '5900-1900-9877-5543', "Add-on Credit Card" ,   0   ,"ACTIVE", "S");
INSERT INTO Bank_Account_Details  VALUES (123008, "5000-1700-7755",  "SAVINGS"   	,0   	,"INACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123006, '5800-1700-9800-7755', "Credit Card"   ,0   	,"ACTIVE", "P");
INSERT INTO Bank_Account_Details  VALUES (123006, '5890-1970-7706-8912', "Add-on Credit Card"   ,0   	,"ACTIVE", "S");


# CREATE TABLE Bank_Account_Relationship_Details

CREATE TABLE Bank_Account_Relationship_Details
( Customer_id INT ,
Account_Number VARCHAR(19) PRIMARY KEY ,
Account_type VARCHAR(25),
Linking_Account_Number VARCHAR(19) 
);

ALTER TABLE Bank_Account_Relationship_Details ADD FOREIGN KEY (Customer_id) REFERENCES bank_customer(Customer_id);
ALTER TABLE Bank_Account_Relationship_Details ADD FOREIGN KEY (Linking_Account_Number) REFERENCES bank_account_details(Account_Number);

								
INSERT INTO Bank_Account_Relationship_Details  VALUES (123001, "4000-1956-3456",  "SAVINGS" , NULL);
INSERT INTO Bank_Account_Relationship_Details  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" , "4000-1956-3456");  
INSERT INTO Bank_Account_Relationship_Details  VALUES (123002, "4000-1956-2001",  "SAVINGS" , NULL );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" , "4000-1956-2001" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123003, "4000-1956-2900",  "SAVINGS" , NULL );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" , "4000-1956-2900" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123004, "5000-1700-7791",  "RECURRING DEPOSITS" , "4000-1956-2900" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123007, "5000-1700-9800",  "SAVINGS" , NULL);
INSERT INTO Bank_Account_Relationship_Details  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , "5000-1700-9800" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, "9000-1700-7777-4321",  "Credit Card" , "5000-1700-9800" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5900-1900-9877-5543', 'Add-on Credit Card', '9000-1700-7777-4321' );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5800-1700-9800-7755', 'Credit Card', '4000-1956-5698' );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5890-1970-7706-8912', 'Add-on Credit Card', '5800-1700-9800-7755' );


# CREATE TABLE BANK_ACCOUNT_TRANSACTION

CREATE TABLE BANK_ACCOUNT_TRANSACTION 
(  
Account_Number VARCHAR(19),
Transaction_amount Decimal(18,2) , 
Transcation_channel VARCHAR(18) ,
Province varchar(3) , 
Transaction_Date Date
) ;

ALTER TABLE Bank_Account_Transaction ADD FOREIGN KEY (Account_number) REFERENCES Bank_Account_Details(Account_Number);

INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-3456",  -2000, "ATM withdrawl" , "CA", "2020-01-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -4000, "POS-Walmart"   , "MN", "2020-02-14");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -1600, "UPI transfer"  , "MN", "2020-01-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -6000, "Bankers cheque", "CA", "2020-03-23");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -3000, "Net banking"   , "CA", "2020-04-24");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  23000, "cheque deposit", "MN", "2020-03-15");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5000-1700-6091",  40000, "ECS transfer"  , "NY", "2020-02-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5000-1700-7791",  40000, "ECS transfer"  , "NY", "2020-02-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-3401",   8000, "Cash Deposit"  , "NY", "2020-01-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-5102",  -6500, "ATM withdrawal" , "NY", "2020-03-14");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-5698",  -9000, "Cash Deposit"  , "NY", "2020-03-27");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-9977",  50000, "ECS transfer"  , "NY", "2020-01-16");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -5000, "POS-Walmart", "NY", "2020-02-17");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -8000, "Shopping Cart", "MN", "2020-03-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -2500, "Shopping Cart", "MN", "2020-04-21");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5800-1700-9800-7755", -9000, "POS-Walmart","MN", "2020-04-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( '5890-1970-7706-8912', -11000, "Shopping Cart" , "NY" , "2020-03-12") ;



# CREATE TABLE BANK_CUSTOMER_MESSAGES

CREATE TABLE BANK_CUSTOMER_MESSAGES 
(  
Event VARCHAR(24),
Customer_message VARCHAR(75),
Notice_delivery_mode VARCHAR(15)) ;


INSERT INTO BANK_CUSTOMER_MESSAGES VALUES ( "Adhoc", "All Banks are closed due to announcement of National strike", "mobile" ) ;
INSERT INTO BANK_CUSTOMER_MESSAGES VALUES ( "Transaction Limit", "Only limited withdrawals per card are allowed from ATM machines", "mobile" );


INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    10000.00     ,'ECS transfer',     'MN' ,    '2020-02-16' ) ;

-- inserted for queries after 17th  
INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    40000.00     ,'ECS transfer',     'MN' ,    '2020-03-18' ) ;

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    60000.00     ,'ECS transfer',     'MN' ,    '2020-04-18' ) ;

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    20000.00     ,'ECS transfer',     'MN' ,    '2020-03-20' ) ;

-- inserted for queries after 24th 

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    49000.00     ,'ECS transfer',     'MN' ,    '2020-06-18' ) ;




# CREATE TABLE BANK_INTEREST_RATE

CREATE TABLE BANK_INTEREST_RATE(  
account_type varchar(24)PRIMARY KEY,
interest_rate decimal(4,2),
month varchar(2),
year  varchar(4)
)	;

INSERT  INTO BANK_INTEREST_RATE VALUES ( "SAVINGS" , 0.04 , '02' , '2020' );
INSERT  INTO BANK_INTEREST_RATE VALUES ( "RECURRING DEPOSITS" , 0.07, '02' , '2020' );
INSERT  INTO BANK_INTEREST_RATE VALUES   ( "PRIVILEGED_INTEREST_RATE" , 0.08 , '02' , '2020' );

# Bank_holidays:

Create table Bank_Holidays (
Holiday  date PRIMARY KEY,
Start_time datetime ,
End_time timestamp);

Insert into bank_holidays values ( '2020-05-20','2020-05-20','2020-05-20' ) ;

Insert into bank_holidays values( '2020-03-13' ,'2020-03-13' ,'2020-03-13' ) ;




############################################ Questions ############################################

use sql3bank; 

# Question 1:
# 1) Print customer Id, customer name and average account_balance maintained by each customer for all 
# of his/her accounts in the bank.

SELECT 
    a.customer_id,
    b.customer_name,
    AVG(a.balance_amount) AS 'Average_balance_amount'
FROM
    bank_account_details AS a
        INNER JOIN
    bank_customer AS b USING (customer_id)
GROUP BY a.customer_id , b.customer_name;

# Question 2:
# 2) Print customer_id , account_number and balance_amount for all the accounts.
# for account_type = "Credit Card" apply the condition that if balance_amount is nil then assign transaction_amount 

SELECT DISTINCT
    a.customer_id,
    a.account_number,
    a.account_type,
    CASE
        WHEN ((a.account_type LIKE '%CREDIT CARD%') AND COALESCE(a.Balance_amount, 0) = 0) THEN b.transaction_amount
        ELSE balance_amount END AS 'Balance Amount'
FROM
    bank_account_details a
        INNER JOIN
    bank_account_transaction b USING (account_number);   
    

# Question 3:
# 3) Print account_number and balance_amount , transaction_amount,Transaction_Date from Bank_Account_Details and 
# bank_account_transaction for all the transactions occurred during march,2020 and april, 2020


SELECT 
    a.account_number,
    a.balance_amount,
    b.account_number,
    b.transaction_amount,
    b.transaction_date
FROM
    bank_account_details a
        JOIN
    bank_account_transaction b USING (account_number)
WHERE
    transaction_date BETWEEN '2020-03-01' AND '2020-04-30'; 


# Question 4:
# 4) Print all the customer ids, account number,  balance_amount, transaction_amount , Transaction_Date 
# from bank_customer, Bank_Account_Details and bank_account_transaction tables where excluding 
# all of their transactions in march, 2020  month

SELECT 
    a.customer_id,
    a.account_number,
    a.balance_amount,
    b.transaction_amount,
    b.transaction_date
FROM
    bank_account_details a
        JOIN
    bank_account_transaction b ON a.account_number = b.account_number
WHERE
    transaction_date NOT BETWEEN '2020-03-01' AND '2020-03-31';


# Question 5:
# 5) Print the customer ids, account_number, balance_amount,transaction_amount ,transaction_date who did transactions 
# during the first quarter. Do not display the accounts if they have not done any transactions in the first quarter.

SELECT 
    a.customer_id,
    a.account_number,
    a.balance_amount,
    b.transaction_amount,
    b.transaction_date
FROM
    bank_account_details a
        JOIN
    bank_account_transaction b USING (account_number)
WHERE
    transaction_date BETWEEN '2020-01-01' AND '2020-03-31';

# Question 6:
# 6) Print account_number, Event and Customer_message from BANK_CUSTOMER_MESSAGES and Bank_Account_Details to 
# display an “Adhoc" Event for all customers who have  “SAVINGS" account_type account.

SELECT 
    a.account_number, b.event, b.customer_message
FROM
    bank_account_details a
        CROSS JOIN
    bank_customer_messages b
WHERE
    b.event = 'Adhoc'
        AND account_type = 'SAVINGS'; 


# Question 7: EDIT     
# 7) Print all the Customer_ids, Account_Number, Account_type, and display deducted balance_amount by  
# subtracting only negative transaction_amounts for Relationship_type =
#  "P" ( P - means  Primary , S - means Secondary ) .


SELECT 
    a.customer_id,
    a.account_number,
    a.account_type,
    a.balance_amount - b.transaction_amount AS deducted_balance_amount
FROM
    bank_account_details a
        INNER JOIN
    bank_account_transaction b USING (account_number)
WHERE
    b.transaction_amount LIKE '-%'
        AND a.Relationship_type IN ('P'); 



# Question 8:
# a) Display records of All Accounts , their Account_types, the balance amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 

SELECT 
    a.Account_Number AS 'Primary_account_no',
    a.Account_type AS 'Primary_account_type',
    a.balance_amount,
    b.Account_Number AS 'Secondary_account_no',
    b.Account_type AS 'secondary_account_type'
FROM
    bank_account_details a
        INNER JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number; 


# Question 9:
# a) Display records of All Accounts , their Account_types, the balance amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 
# c) After retrieving all records of accounts and their linked accounts, display the  
# transaction amount of accounts appeared  in another column.

SELECT 
    a.Account_Number AS primary_account_number,
    a.Account_type AS primary_account_type,
    b.Account_Number AS secondary_account_number,
    b.Account_type AS secondary_account_type,
    c.Transaction_amount AS primary_acct_tran_amount
FROM
    bank_Account_Details a
        LEFT JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        LEFT JOIN
    bank_account_transaction c ON a.Account_Number = c.Account_Number;


# Question 10:
# 10) Display all account holders from Bank_Accounts_Details table who have “Add-on Credit Cards" and “Credit cards" 

SELECT 
    a.customer_id, b.customer_name, a.account_type
FROM
    bank_account_details a
        INNER JOIN
    bank_customer b USING (customer_id)
WHERE
    account_type LIKE 'Credit card'
    OR account_type LIKE 'Add-on credit card';
        
# Question 11: 
# 11)  Display  records of “SAVINGS” accounts linked with “Credit card" account_type and its credit
# aggregate sum of transaction amount.

SELECT 
    a.account_type,
    b.account_number,
    b.linking_account_number,
    b.account_type,
    SUM(c.transaction_amount) AS Sum_transaction_amount
FROM
    bank_Account_Details a
        JOIN
    bank_account_relationship_details b ON b.linking_account_number = a.account_number
        JOIN
    bank_account_transaction c ON b.account_number = c.account_number
WHERE
    a.account_type = 'SAVINGS'
        AND b.account_type = 'Credit card' 
GROUP BY b.Linking_account_number; 


# Ref: Use bank_Account_Details for Credit card types
		#Check linking relationship in bank_transaction_relationship_details.
        # Check transaction_amount in bank_account_transaction. 


# Question 12:
# 12) Display all type of “Credit cards”  accounts including linked “Add-on Credit Cards"  # type accounts with their respective aggregate sum of transaction amount

SELECT 
    a.Account_Number AS account_number,
    SUM(b.Transaction_amount)
FROM
    bank_account_details a
        INNER JOIN
    bank_account_transaction b ON a.Account_Number = b.Account_Number
WHERE
    a.Account_type LIKE '%Credit%'
GROUP BY account_number; 



# Ref: Check Bank_Account_Details_table for all types of credit card.
        # Check transaction_amount in bank_account_transaction. 
		
# Question 13:
# 13) Display “SAVINGS” accounts and their corresponding aggregate sum of transaction amount 
# of all recurring deposits


SELECT 
    a.Account_Number AS Primary_account_number,
    a.Account_type AS Primary_account_type,
    a.Balance_amount,
    b.Account_Number AS 'Secondary acc no',
    b.Account_type AS 'Secondary acc type',
    SUM(c.Transaction_amount) AS RD_transaction_Amt
FROM
    bank_Account_Details a
        INNER JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        INNER JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
WHERE
    b.Account_type LIKE 'RECURRING DEPOSITS'
GROUP BY a.Account_Number , a.Account_type , a.Balance_amount , b.Account_Number;


# Question 14: 
# 14) Display recurring deposits and their transaction amounts in  Feb 2020  along with 
# associated SAVINGS account_number , balance. 

SELECT 
    a.Account_Number AS savings_account_number,
    a.Account_type AS savings_account_type,
    a.balance_amount,
    b.Account_Number AS recurring_deposit_account_number,
    b.Account_type AS recurring_deposit_account_type,
    SUM(c.transaction_amount) AS transaction_amt
FROM
    bank_Account_Details a
        JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
WHERE
    b.Account_type = 'RECURRING DEPOSITS'
        AND MONTH(c.transaction_date) = 2
        AND YEAR(c.transaction_date) = 2020
GROUP BY a.Account_Number; 
        

# Question 15:
# 15) Display every account's total no of transactions for every year and each month.

SELECT 
    account_Number,
    YEAR(transaction_date),
    MONTH(transaction_date),
    COUNT(*) AS total_no_of_transactions
FROM
    bank_account_transaction
GROUP BY account_Number , YEAR(transaction_date) , MONTH(transaction_date);


# Question 16:
# 16) Compare the aggregate sum transaction amount of Feb2020 month versus Jan2020 Month for each account number.
-- Display account_number, transaction_amount , 
-- sum of feb month transaction amount ,
-- sum of Jan month transaction amount , 

# date format = (2020-09-27, %Y-%m) = 2020-02 -- to fetch year,month or day from the particular date given 
-- remember that in data format Y of year is always capital, rest is in small letter 


SELECT 
    bt1.account_number AS Account_number,
    SUM(bt1.transaction_amount) AS Feb_amount,
    SUM(bt2.transaction_amount) AS Jan_amount
FROM
    bank_account_transaction bt1
        JOIN
    bank_account_transaction bt2 ON bt1.Account_Number = bt2.Account_Number
WHERE
    DATE_FORMAT(bt1.transaction_date, '%Y-%m') = '2020-02'
        AND DATE_FORMAT(bt2.transaction_date, '%Y-%m') = '2020-01'
GROUP BY bt1.account_number;


# Question 17: EDIT
# 17) Display the customer names who have all three account types - 
# savings, recurring and credit card account holders.

SELECT 
    a.customer_name
FROM
    bank_customer a
        INNER JOIN
    bank_account_details b USING (customer_id)
WHERE
    b.Account_type IN ('savings' , 'recurring deposits', 'credit card')
GROUP BY customer_name
HAVING COUNT(customer_name) >= 3; 

SELECT 
    customer_name,
    ba.Account_Number AS savings_account_number,
    ba.Account_type AS savings_account_type,
    br1.Account_Number AS Recurring_deposit_account_number,
    br1.Account_type AS Recurring_deposit_account_type,
    br2.Account_Number AS credit_card_account_Number,
    br2.Account_type AS credit_card_account_type
FROM
    bank_Account_Details ba
        JOIN
    bank_customer bc ON ba.customer_id = bc.customer_id
        JOIN
    bank_account_relationship_details br1 ON ba.Account_Number = br1.Linking_Account_Number
        JOIN
    bank_account_relationship_details br2 ON ba.account_number = br2.Linking_account_number
WHERE
    br1.account_type IN ('RECURRING DEPOSITS')
        AND br2.account_type LIKE '%Credit%';
        


# Question 18:
# 18) Display savings accounts and its corresponding Recurring deposits transactions that are occuring more than 4 times.

SELECT 
    a.Account_Number AS savings_account_number,
    a.Account_type AS savings_account_type,
    b.Account_Number AS recurring_deposit_account_number,
    b.Account_type AS recurring_deposit_account_type,
    COUNT(c.transaction_date) AS count_transaction_date
FROM
    bank_Account_Details a
        JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
WHERE
    b.Account_type = 'RECURRING DEPOSITS'
GROUP BY a.Account_Number , a.Account_type , b.Account_Number , b.Account_type
HAVING COUNT(c.transaction_date) > 4;


# Question 19: 
# 19) Display savings accounts and its recurring deposits account with their aggregate 
# transactions per month occurs in 3 different months.

SELECT 
    ba.Account_Number AS savings_account_number,
    ba.Account_type AS savings_account_type,
    br.Account_Number AS recurring_deposit_account_number,
    br.Account_type AS recurring_deposit_account_type,
    SUM(bat.transaction_amount) AS Transaction_amount,
    COUNT(DISTINCT DATE_FORMAT(bat.Transaction_Date, '%Y-%m')) AS different_transaction_months
FROM
    bank_Account_Details ba
        JOIN
    bank_account_relationship_details br ON ba.Account_Number = br.Linking_Account_Number
        JOIN
    bank_account_transaction bat ON br.Account_Number = bat.Account_Number
WHERE
    br.Account_type = 'RECURRING DEPOSITS'
GROUP BY ba.Account_Number , ba.Account_type , br.Account_Number , br.Account_type
HAVING COUNT(DISTINCT DATE_FORMAT(bat.Transaction_Date, '%Y-%m')) >= 3;

# Question 20:
# 20) Find the no. of transactions of credit cards including add-on Credit Cards

SELECT 
    a.Account_Number AS credit_card_account_number,
    a.Account_type AS credit_card_account_type,
    COUNT(b.transaction_amount) AS count_of_Transaction_amount
FROM
    bank_account_details a
        JOIN
    bank_account_transaction b ON a.Account_Number = b.Account_Number
WHERE
    a.Account_type LIKE '%Credit%'
GROUP BY a.Account_Number , a.Account_type; 
