USE upi_project;
# Enable local infile
SET GLOBAL local_infile = 1;

# Load customer_master
LOAD DATA LOCAL INFILE "D:/New folder/customer_master.csv"
INTO TABLE customer_master
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;

# Load device_info
LOAD DATA LOCAL INFILE "D:/New folder/device_info.csv"
INTO TABLE device_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;

# fraud_alert_history
TRUNCATE TABLE fraud_alert_history;
LOAD DATA LOCAL INFILE "D:/New folder/fraud_alert_history.csv"
INTO TABLE fraud_alert_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;

# merchant_info
LOAD DATA LOCAL INFILE "D:/New folder/merchant_info.csv"
INTO TABLE merchant_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;

# upi_account_details
LOAD DATA LOCAL INFILE "D:/New folder/upi_account_details.csv"
INTO TABLE upi_account_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;

# upi_transaction_history
LOAD DATA LOCAL INFILE "D:/New folder/upi_transaction_history.csv"
INTO TABLE upi_transaction_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;


# customer_feedback_surveys
LOAD DATA LOCAL INFILE "D:/New folder/customer_feedback_surveys.csv"
INTO TABLE customer_feedback_surveys
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY'\n'
IGNORE 1 ROWS;


select * from customer_master;
select * from device_info;
select * from fraud_alert_history;
select	* from merchant_info;
select * from upi_account_details;
select * from upi_transaction_history;
select * from customer_feedback_surveys;

DELETE FROM upi_transaction_history 
WHERE transaction_id IS NULL;

DELETE FROM customer_master 
WHERE customer_id IS NULL;

DELETE FROM device_info 
WHERE device_id IS NULL;

DELETE FROM fraud_alert_history 
WHERE alert_id IS NULL;

DELETE FROM merchant_info 
WHERE merchant_id IS NULL;

DELETE FROM upi_account_details 
WHERE upi_id IS NULL;
describe fraud_alert_history;

# Update alert_date
UPDATE fraud_alert_history 
SET alert_date = STR_TO_DATE(alert_date, '%m/%d/%Y %H:%i');

#Update resolution_date (handling potential empty values)
UPDATE fraud_alert_history 
SET resolution_date = STR_TO_DATE(resolution_date, '%m/%d/%Y %H:%i')
WHERE resolution_date IS NOT NULL AND resolution_date != '';

# Update timestamp in upi_transaction_hsitory
UPDATE upi_transaction_history
Set timestamp = str_to_date(timestamp,'%m/%d/%Y %H:%i');