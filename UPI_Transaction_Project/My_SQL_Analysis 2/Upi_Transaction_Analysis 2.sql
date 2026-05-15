CREATE DATABASE upi_project;
use upi_project;

# Customer Master
CREATE TABLE customer_master (
    customer_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    mobile_number VARCHAR(10) UNIQUE NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR(10),
    region VARCHAR(50),
    date_joined DATE NOT NULL,
    is_business_user VARCHAR(10) NOT NULL,
    risk_score DECIMAL(3,2) CHECK (risk_score BETWEEN 0 AND 1)
);

# Device Info
CREATE TABLE device_info (
    device_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    device_type VARCHAR(20),
    app_version VARCHAR(20),
    is_rooted VARCHAR(10) NOT NULL,
    last_active DATETIME,
    customer_id_check VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

# UPI Account Details
CREATE TABLE upi_account_details (
    upi_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    bank_name VARCHAR(100),
    account_type VARCHAR(30),
    date_added DATE,
    status VARCHAR(20),
    customer_id_check VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);

# Merchant Info
CREATE TABLE merchant_info (
    merchant_id VARCHAR(20) PRIMARY KEY,
    merchant_name VARCHAR(100) NOT NULL,
    merchant_type VARCHAR(50),
    region VARCHAR(50),
    onboard_date DATE,
    risk_score DECIMAL(3,2) CHECK (risk_score BETWEEN 0 AND 1)
);

# UPI Transaction History
CREATE TABLE upi_transaction_history (
    transaction_id VARCHAR(20) PRIMARY KEY,
    upi_id VARCHAR(50) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    timestamp VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    transaction_type VARCHAR(30),
    merchant_id VARCHAR(20),
    counterparty_upi VARCHAR(50),
    status VARCHAR(30),
    device_id VARCHAR(20) NOT NULL,
    device_type VARCHAR(20),
    channel VARCHAR(20),
    fraud_flag VARCHAR(10) NOT NULL,
    reversal_flag VARCHAR(10) NOT NULL,
    failure_reason VARCHAR(100),
    customer_id_check VARCHAR(20),
    merchant_id_check VARCHAR(20),
    validation_status VARCHAR(20),
    upi_id_check VARCHAR(20),
    device_id_check VARCHAR(20),
    FOREIGN KEY (upi_id) REFERENCES upi_account_details(upi_id),
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id),
    FOREIGN KEY (merchant_id) REFERENCES merchant_info(merchant_id),
    FOREIGN KEY (device_id) REFERENCES device_info(device_id)
);

# Fraud Alert History
CREATE TABLE fraud_alert_history (
    alert_id VARCHAR(20) PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL,
    alert_type VARCHAR(50),
    alert_date VARCHAR(100),
    resolved VARCHAR(10) NOT NULL,
    resolution_date VARCHAR(100),
    remarks VARCHAR(255),
    fraud_alert_id_check VARCHAR(20),
    resolution_date_check VARCHAR(20),
    validation_status VARCHAR(20),
    FOREIGN KEY (transaction_id) REFERENCES upi_transaction_history(transaction_id)
);

# Customer Feedback Surveys
CREATE TABLE customer_feedback_surveys (
    feedback_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    date_submitted DATE,
    feedback_text TEXT,
    satisfaction_score INT CHECK (satisfaction_score BETWEEN 1 AND 5),
    issue_type VARCHAR(50),
    resolved VARCHAR(10) NOT NULL,
    customer_id_check VARCHAR(20),
    validation_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id)
);
