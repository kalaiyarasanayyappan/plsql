--1.*Write a query which will display the customer id, account type they hold, their account number and bank name.

SELECT AI.CUSTOMER_ID, AI.ACCOUNT_TYPE, AI.ACCOUNT_NO, BI.BANK_NAME
FROM BANK_INFO BI
INNER JOIN ACCOUNT_INFO AI
ON BI.IFSC_CODE=AI.IFSC_CODE;

----2.*Write a query which will display the customer id, account type and the account number of HDFC customers
--who registered after 12-JAN-2012 and before 04-APR-2012.

SELECT AI.CUSTOMER_ID, AI.ACCOUNT_TYPE, AI.ACCOUNT_NO
FROM ACCOUNT_INFO AI
INNER JOIN BANK_INFO BI
ON AI.IFSC_CODE=BI.IFSC_CODE
WHERE AI.REGISTRATION_DATE BETWEEN to_date('2012-01-13','yyyy-mm-dd') AND to_date('2012-04-03','yyyy-mm-dd') AND BI.BANK_NAME='HDFC';

-------3.*Write a query which will display the customer id, customer name, account no,
--account type and bank name where the customers hold the account.



SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, AI.ACCOUNT_TYPE, BI.BANK_NAME
FROM BANK_INFO BI
INNER JOIN ACCOUNT_INFO AI
ON BI.IFSC_CODE=AI.IFSC_CODE
INNER JOIN CUSTOMER_PERSONAL_INFO CPI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID
WHERE AI.ACCOUNT_NO IS NOT NULL;

-------4.*Write a query which will display the customer id, customer name, gender, marital status along with the unique reference string and
-- sort the records based on customer id in descending order. <br/>
--<br/><b>Hint:  </b>Generate unique reference string as mentioned below
--:
--<br/> CustomerName_Gender_MaritalStatus
--<br/><b> Example, </b>
--<br/> C-005           KUMAR              M                 SINGLE            KUMAR_M_SINGLE
--<BR/> 
--Use ""UNIQUE_REF_STRING"" as alias name for displaying the unique reference string."


SELECT CUSTOMER_ID, CUSTOMER_NAME, GENDER, MARITAL_STATUS, CONCAT(CUSTOMER_NAME,CONCAT('_',CONCAT(GENDER,CONCAT('_',MARITAL_STATUS)))) AS UNIQUE_REF_STRING
FROM CUSTOMER_PERSONAL_INFO;

------5.*Write a query which will display the account number, customer id, registration date, initial deposit amount of the customer
-- whose initial deposit amount is within the range of Rs.15000 to Rs.25000.


SELECT ACCOUNT_NO, CUSTOMER_ID, REGISTRATION_DATE, INITIAL_DEPOSIT
FROM ACCOUNT_INFO
WHERE INITIAL_DEPOSIT BETWEEN 15000 AND 25000;

------6.*Write a query which will display customer id, customer name, date of birth,
--guardian name of the customers whose name starts with 'J'.

SELECT CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, GUARDIAN_NAME
FROM CUSTOMER_PERSONAL_INFO
WHERE CUSTOMER_NAME LIKE 'J%';

-----7.*Write a query which will display customer id, account number and passcode. 
--<br/>
--Hint:  To generate passcode, join the last three digits of customer id and last four digit of account number.
 
--<br/>Example
--<br/>C-001                   1234567898765432                0015432
--<br/>Use ""PASSCODE"" as alias name for displaying the passcode."


SELECT CUSTOMER_ID, ACCOUNT_NO, CONCAT(SUBSTR(CUSTOMER_ID,-3),SUBSTR(ACCOUNT_NO,-4))AS PASSCODE
FROM ACCOUNT_INFO;

-----8.*Write a query which will display the customer id, customer name, date of birth, Marital Status, Gender, Guardian name, 
--contact no and email id of the customers whose gender is male 'M' and marital status is MARRIED.


SELECT CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, MARITAL_STATUS, GENDER, GUARDIAN_NAME, CONTACT_NO, MAIL_ID
FROM CUSTOMER_PERSONAL_INFO
WHERE GENDER='M' AND MARITAL_STATUS='MARRIED';

------9.*Write a query which will display the customer id, customer name, guardian name, reference account holders name of the customers 
--who are referenced / referred by their 'FRIEND'.



SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, CPI.GUARDIAN_NAME, CRI.REFERENCE_ACC_NAME AS FRIEND
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN CUSTOMER_REFERENCE_INFO CRI
ON CPI.CUSTOMER_ID=CRI.CUSTOMER_ID;

-------10.*Write a query to display the customer id, account number and interest amount in the below format with INTEREST_AMT as alias name
-- Sort the result based on the INTEREST_AMT in ascending order.  <BR/>Example: 
--$5<BR/>Hint: Need to prefix $ to interest amount and round the result without decimals.



SELECT CUSTOMER_ID, ACCOUNT_NO, CONCAT('$',ROUND(INTEREST,0)) AS INTEREST_AMT
FROM ACCOUNT_INFO;

---11.*Write a query which will display the customer id, customer name, account no, account type, activation date,
-- bank name whose account will be activated on '10-APR-2012'


SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, AI.ACCOUNT_TYPE, AI.ACTIVATION_DATE, BI.BANK_NAME
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID
INNER JOIN BANK_INFO BI
ON BI.IFSC_CODE=AI.IFSC_CODE
WHERE AI.ACTIVATION_DATE='10-APR-2012';

-----12.*Write a query which will display account number, customer id, customer name, bank name, branch name, ifsc code
--, citizenship, interest and initial deposit amount of all the customers.


SELECT AI.ACCOUNT_NO, CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, BI.BANK_NAME, BI.BRANCH_NAME, BI.IFSC_CODE, CPI.CITIZENSHIP, AI.INTEREST, AI.INITIAL_DEPOSIT
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID
INNER JOIN BANK_INFO BI
ON BI.IFSC_CODE=AI.IFSC_CODE;

-----------13.*Write a query which will display customer id, customer name, date of birth, guardian name, contact number,
 --mail id and reference account holder's name of the customers who has submitted the passport as an identification document.



SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, CPI.DATE_OF_BIRTH, CPI.GUARDIAN_NAME, CPI.MAIL_ID, CRI.REFERENCE_ACC_NAME
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN CUSTOMER_REFERENCE_INFO CRI
ON CPI.CUSTOMER_ID=CRI.CUSTOMER_ID
WHERE CPI.IDENTIFICATION_DOC_TYPE='PASSPORT';

-----------14.*Write a query to display the customer id, customer name, account number, account type, initial deposit, 
--interest who have deposited maximum amount in the bank.


SELECT * FROM (SELECT CUSTOMER_PERSONAL_INFO.CUSTOMER_ID, CUSTOMER_PERSONAL_INFO.CUSTOMER_NAME,
ACCOUNT_INFO.ACCOUNT_NO, ACCOUNT_INFO.ACCOUNT_TYPE, ACCOUNT_INFO.INITIAL_DEPOSIT,
ACCOUNT_INFO.INTEREST FROM CUSTOMER_PERSONAL_INFO INNER JOIN ACCOUNT_INFO ON CUSTOMER_PERSONAL_INFO.CUSTOMER_ID = 
ACCOUNT_INFO.CUSTOMER_ID GROUP BY CUSTOMER_PERSONAL_INFO.CUSTOMER_ID, CUSTOMER_PERSONAL_INFO.CUSTOMER_NAME,
ACCOUNT_INFO.ACCOUNT_NO, ACCOUNT_INFO.ACCOUNT_TYPE, ACCOUNT_INFO.INTEREST, 
ACCOUNT_INFO.INITIAL_DEPOSIT ORDER BY ACCOUNT_INFO.INITIAL_DEPOSIT DESC) WHERE ROWNUM=1

-------------15.*Write a query to display the customer id, customer name, account number, account type, interest, bank name 
--and initial deposit amount of the customers who are getting maximum interest rate.


SELECT * FROM (SELECT CUSTOMER_PERSONAL_INFO.CUSTOMER_ID,
CUSTOMER_PERSONAL_INFO.CUSTOMER_NAME, ACCOUNT_INFO.ACCOUNT_NO,
ACCOUNT_INFO.ACCOUNT_TYPE, ACCOUNT_INFO.INTEREST, BANK_INFO.BANK_NAME,
ACCOUNT_INFO.INITIAL_DEPOSIT FROM CUSTOMER_PERSONAL_INFO INNER JOIN ACCOUNT_INFO ON CUSTOMER_PERSONAL_INFO.CUSTOMER_ID =
ACCOUNT_INFO.CUSTOMER_ID INNER JOIN BANK_INFO ON ACCOUNT_INFO.IFSC_CODE =
BANK_INFO.IFSC_CODE GROUP BY CUSTOMER_PERSONAL_INFO.CUSTOMER_ID,
CUSTOMER_PERSONAL_INFO.CUSTOMER_NAME, ACCOUNT_INFO.ACCOUNT_NO, 
ACCOUNT_INFO.ACCOUNT_TYPE, ACCOUNT_INFO.INTEREST,BANK_INFO.BANK_NAME, 
ACCOUNT_INFO.INITIAL_DEPOSIT ORDER BY ACCOUNT_INFO.INTEREST DESC) WHERE ROWNUM=1


------------------16.Write a query to display the customer id, customer name, account no, bank name, contact no 
--and mail id of the customers who are from BANGALORE.


SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, BI.BANK_NAME, BI.BRANCH_NAME, CPI.CONTACT_NO, CPI.MAIL_ID
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID
INNER JOIN BANK_INFO BI
ON BI.IFSC_CODE=AI.IFSC_CODE
WHERE CPI.ADDRESS LIKE '%BANGALORE';

----------17.Write a query which will display customer id, bank name, branch name, ifsc code, registration date, 
--activation date of the customers whose activation date is in the month of march (March 1'st to March 31'st).


SELECT CPI.CUSTOMER_ID, BI.BANK_NAME, BI.BRANCH_NAME,
BI.IFSC_CODE, AI.REGISTRATION_DATE, AI.ACTIVATION_DATE FROM 
CUSTOMER_PERSONAL_INFO CPI INNER JOIN ACCOUNT_INFO AI ON 
CPI.CUSTOMER_ID=AI.CUSTOMER_ID INNER JOIN BANK_INFO BI ON BI.IFSC_CODE=
AI.IFSC_CODE WHERE to_char(ACTIVATION_DATE,'MM')=03;

------18.Write a query which will calculate the interest amount and display it along with customer id, customer name, 
--account number, account type, interest, and initial deposit amount.<BR>Hint :Formula for interest amount, 
--calculate: ((interest/100) * initial deposit amt) with column name 'interest_amt' (alias)



SELECT ((INTEREST/100)*INITIAL_DEPOSIT) AS INTEREST_AMT, CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, AI.ACCOUNT_TYPE, AI.INTEREST, AI.INITIAL_DEPOSIT
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID;

------19.Write a query to display the customer id, customer name, date of birth, guardian name, contact number, 
--mail id, reference name who has been referenced by 'RAGHUL'.


SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, CPI.DATE_OF_BIRTH, CPI.GUARDIAN_NAME, CPI.CONTACT_NO, CPI.MAIL_ID, CRI.REFERENCE_ACC_NAME
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN CUSTOMER_REFERENCE_INFO CRI
ON CPI.CUSTOMER_ID=CRI.CUSTOMER_ID
WHERE CRI.REFERENCE_ACC_NAME='RAGHUL';

-------20."Write a query which will display the customer id, customer name and contact number with ISD code of 
--all customers in below mentioned format.  Sort the result based on the customer id in descending order. 
--<BR>Format for contact number is :  
--<br/> ""+91-3digits-3digits-4digits""
--<br/> Example: +91-924-234-2312
--<br/> Use ""CONTACT_ISD"" as alias name."


SELECT CUSTOMER_ID, CUSTOMER_NAME, CONCAT('+91-',CONCAT(SUBSTR(CONTACT_NO,1,3),CONCAT('-',CONCAT(SUBSTR(CONTACT_NO,4,3),CONCAT('-',SUBSTR(CONTACT_NO,-4)))))) AS CONTACT_ISD
FROM CUSTOMER_PERSONAL_INFO
ORDER BY CUSTOMER_ID DESC;

----------21.Write a query which will display account number, account type, customer id, customer name, date of birth, guardian name, 
--contact no, mail id , gender, reference account holders name, reference account holders account number, registration date, 
--activation date, number of days between the registration date and activation date with alias name "NoofdaysforActivation", 
--bank name, branch name and initial deposit for all the customers.


SELECT AI.ACCOUNT_NO, AI.ACCOUNT_TYPE, CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, 
CPI.DATE_OF_BIRTH, CPI.GUARDIAN_NAME, CPI.CONTACT_NO, CPI.MAIL_ID, CPI.GENDER,
CRI.REFERENCE_ACC_NAME, CRI.REFERENCE_ACC_NO, AI.REGISTRATION_DATE, AI.ACTIVATION_DATE, 
(ACTIVATION_DATE - REGISTRATION_DATE) AS NoofdaysforActivation, BI.BANK_NAME, BI.BRANCH_NAME,
AI.INITIAL_DEPOSIT FROM CUSTOMER_PERSONAL_INFO CPI INNER JOIN ACCOUNT_INFO AI ON 
CPI.CUSTOMER_ID=AI.CUSTOMER_ID INNER JOIN BANK_INFO BI ON BI.IFSC_CODE=AI.IFSC_CODE 
INNER JOIN CUSTOMER_REFERENCE_INFO CRI ON CRI.CUSTOMER_ID=CPI.CUSTOMER_ID;

----------22."Write a query which will display customer id, customer name,  guardian name, identification doc type,
 --reference account holders name, account type, ifsc code, bank name and current balance for the customers 
--who has only the savings account. 
--<br/>Hint:  Formula for calculating current balance is add the intital deposit amount and interest
 --and display without any decimals. Use ""CURRENT_BALANCE"" as alias name."


SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, CPI.GUARDIAN_NAME,
CPI.IDENTIFICATION_DOC_TYPE, CRI.REFERENCE_ACC_NAME, AI.ACCOUNT_TYPE, 
BI.IFSC_CODE, BI.BANK_NAME, (INITIAL_DEPOSIT + ((INTEREST*INITIAL_DEPOSIT)/100)) AS 
CURRENT_BALANCE FROM CUSTOMER_PERSONAL_INFO CPI INNER JOIN ACCOUNT_INFO AI ON 
CPI.CUSTOMER_ID=AI.CUSTOMER_ID INNER JOIN BANK_INFO BI ON BI.IFSC_CODE=AI.IFSC_CODE 
INNER JOIN CUSTOMER_REFERENCE_INFO CRI ON CRI.CUSTOMER_ID=CPI.CUSTOMER_ID WHERE ACCOUNT_TYPE='SAVINGS';

---------23."Write a query which will display the customer id, customer name, account number, account type, interest, initial deposit;
 --<br/>check the initial deposit,<br/> if initial deposit is 20000 then display ""high"",<br/> if initial deposit is 16000 display 'moderate'
--,<br/> if initial deposit is 10000 display 'average', <br/>if initial deposit is 5000 display 'low', <br/>if initial deposit is 0 display
-- 'very low' otherwise display 'invalid' and sort by interest in descending order.<br/>
--Hint: Name the column as ""Deposit_Status"" (alias). 
--<br/>Strictly follow the lower case for strings in this query."


SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, AI.ACCOUNT_TYPE, AI.INTEREST, AI.INITIAL_DEPOSIT,
CASE
WHEN INITIAL_DEPOSIT=20000 THEN 'high'
WHEN INITIAL_DEPOSIT=16000 THEN 'moderate'
WHEN INITIAL_DEPOSIT=10000 THEN 'average'
WHEN INITIAL_DEPOSIT=5000 THEN 'low'
WHEN INITIAL_DEPOSIT=0 THEN 'very low'
ELSE 'invalid' END DEPOSIT_STATUS
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID order by interest desc;


-----24."Write a query which will display customer id, customer name,  account number, account type, bank name, ifsc code, initial deposit amount
-- and new interest amount for the customers whose name starts with ""J"". 
--<br/> Hint:  Formula for calculating ""new interest amount"" is 
--if customers account type is savings then add 10 % on current interest amount to interest amount else display the current interest amount.
 --Round the new interest amount to 2 decimals.<br/> Use ""NEW_INTEREST"" as alias name for displaying the new interest amount.

--<br/>Example, Assume Jack has savings account and his current interest amount is 10.00, then the new interest amount is 11.00 i.e (10 + (10 * 10/100)). 
--"


SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, AI.ACCOUNT_TYPE, BI.BANK_NAME, BI.IFSC_CODE, AI.INITIAL_DEPOSIT,
CASE
WHEN ACCOUNT_TYPE='SAVINGS' THEN ROUND((INTEREST+(INTEREST*10/100)),2)
ELSE INTEREST END NEW_INTEREST_AMOUNT
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID
INNER JOIN BANK_INFO BI
ON BI.IFSC_CODE=AI.IFSC_CODE
WHERE CPI.CUSTOMER_NAME LIKE 'J%';

-----------25.Write query to display the customer id, customer name, account no, initial deposit, tax percentage as calculated below.
--<BR>Hint: <BR>If initial deposit = 0 then tax is '0%'<BR>If initial deposit &lt;= 10000 then tax is '3%' 
--<BR>If initial deposit &gt; 10000 and initial deposit &lt; 20000 then tax is '5%' <BR>If initial deposit &gt;= 20000 and
-- initial deposit&lt;=30000 then tax is '7%' <BR>If initial deposit &gt; 30000 then tax is '10%' <BR>Use the alias name 'taxPercentage'



SELECT CPI.CUSTOMER_ID, CPI.CUSTOMER_NAME, AI.ACCOUNT_NO, AI.INITIAL_DEPOSIT,
CASE
WHEN INITIAL_DEPOSIT=0 THEN '0%'
WHEN INITIAL_DEPOSIT<=10000 THEN '3%'
WHEN INITIAL_DEPOSIT>10000 AND INITIAL_DEPOSIT<20000 THEN '5%'
WHEN INITIAL_DEPOSIT>=20000 AND INITIAL_DEPOSIT<=30000 THEN '7%'
WHEN INITIAL_DEPOSIT>30000 THEN '10%' ELSE 'invalid' END TAX_PERCENTAGE
FROM CUSTOMER_PERSONAL_INFO CPI
INNER JOIN ACCOUNT_INFO AI
ON CPI.CUSTOMER_ID=AI.CUSTOMER_ID;


----------


























