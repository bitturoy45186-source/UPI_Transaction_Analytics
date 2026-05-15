use upi_project;
# Row Counts across table
SELECT COUNT(*) FROM customer_master;
SELECT COUNT(*) FROM device_info;
SELECT COUNT(*) FROM upi_account_details;
SELECT COUNT(*) FROM merchant_info;
SELECT COUNT(*) FROM upi_transaction_history;
SELECT COUNT(*) FROM fraud_alert_history;
SELECT COUNT(*) FROM customer_feedback_surveys;

# Random spot checks for field mapping
# Look at 5 random customers
SELECT * FROM customer_master ORDER BY RAND() LIMIT 5;
SELECT * FROM device_info ORDER BY RAND() LIMIT 5;
SELECT * FROM fraud_alert_history ORDER BY RAND() LIMIT 5;
SELECT * FROM merchant_info ORDER BY RAND() LIMIT 5;
SELECT * FROM upi_account_details ORDER BY RAND() LIMIT 5;
SELECT * FROM upi_transaction_history ORDER BY RAND() LIMIT 5;
SELECT * FROM customer_feedback_surveys ORDER BY RAND() LIMIT 5;

# Foreign Key Consistency

# customer to device
SELECT d.device_id
FROM device_info d
LEFT JOIN customer_master c ON d.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

# upi_transaction_history to merchant_info
SELECT t.transaction_id
FROM upi_transaction_history t
LEFT JOIN merchant_info m ON t.merchant_id = m.merchant_id
WHERE t.merchant_id IS NOT NULL AND m.merchant_id IS NULL;

# upi_transaction_history to upi_account_details
SELECT t.transaction_id
FROM upi_transaction_history t
LEFT JOIN upi_account_details u ON t.upi_id = u.upi_id
WHERE u.upi_id IS NULL;

# fraud_alert_history to upi_transaction_history
SELECT f.alert_id
FROM fraud_alert_history f
LEFT JOIN upi_transaction_history t ON f.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;