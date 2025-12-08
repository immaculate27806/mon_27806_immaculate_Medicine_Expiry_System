-- First, let's insert some alerts based on different scenarios
-- WARNING: Only do this in a test/dev environment, not production!
ALTER TABLE alerts DISABLE CONSTRAINT FK_ALERT_BATCH;

-- Now insert your alerts
-- (Use all the original INSERT statements from your script)


-- 1. Expired medicines (already past expiry date)
INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (1, 1001, 'EXPIRED', DATE '2024-01-15', 'ACTIVE', 'HIGH', 
        'Batch of Amoxicillin 500mg expired on 2024-01-10. Please remove from shelves immediately.', 
        -5);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (2, 1005, 'EXPIRED', DATE '2024-01-20', 'RESOLVED', 'HIGH', 
        'Batch of Ibuprofen 400mg expired on 2024-01-18. Disposed as per protocol.', 
        -2);

-- 2. Expiry warnings (medicines expiring soon)
INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (3, 1010, 'EXPIRY_WARNING', SYSDATE - 5, 'ACTIVE', 'HIGH', 
        'Batch of Insulin Vials expiring in 7 days. Consider moving to front for priority sale.', 
        7);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (4, 1012, 'EXPIRY_WARNING', SYSDATE - 2, 'ACTIVE', 'MEDIUM', 
        'Batch of Paracetamol 500mg tablets expiring in 30 days.', 
        30);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (5, 1015, 'EXPIRY_WARNING', SYSDATE - 1, 'ACKNOWLEDGED', 'LOW', 
        'Batch of Vitamin C supplements expiring in 60 days. Inventory manager notified.', 
        60);

-- 3. Recall alerts (medicine recalls)
INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (6, 1008, 'RECALL', DATE '2024-02-01', 'ACTIVE', 'HIGH', 
        'URGENT: Manufacturer recall due to packaging contamination. Batch LOT#RX2345.', 
        NULL);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining, resolved_by, resolved_date) 
VALUES (7, 1003, 'RECALL', DATE '2023-12-15', 'RESOLVED', 'HIGH', 
        'FDA recall - Mislabeled dosage instructions. All units returned to supplier.', 
        NULL, 101, DATE '2023-12-20');

-- More varied alerts
INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (8, 1020, 'EXPIRY_WARNING', SYSDATE - 7, 'ACTIVE', 'HIGH', 
        'CRITICAL: Emergency stock of Epinephrine auto-injectors expiring in 3 days!', 
        3);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining, resolved_by, resolved_date) 
VALUES (9, 1018, 'EXPIRED', DATE '2023-11-30', 'RESOLVED', 'HIGH', 
        'Cold chain breach detected. Batch of vaccines disposed following protocol.', 
        -45, 105, DATE '2023-12-05');

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (10, 1025, 'RECALL', SYSDATE - 3, 'ACTIVE', 'MEDIUM', 
        'Voluntary recall - Incorrect leaflet insert. Contact patients if dispensed in last 30 days.', 
        NULL);

-- Mixed status alerts for reporting
INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (11, 1030, 'EXPIRY_WARNING', SYSDATE - 10, 'ACKNOWLEDGED', 'MEDIUM', 
        'Antibiotic batch expiring in 15 days. Sales team prioritizing this batch.', 
        15);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining, resolved_by, resolved_date) 
VALUES (12, 1032, 'EXPIRED', DATE '2024-01-25', 'RESOLVED', 'HIGH', 
        'Controlled substance expired. Destroyed with two witnesses as per DEA guidelines.', 
        -10, 108, DATE '2024-01-26');

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (13, 1035, 'EXPIRY_WARNING', SYSDATE, 'ACTIVE', 'LOW', 
        'OTC medications expiring in 90 days. Regular monitoring required.', 
        90);

-- Alert chain showing escalation
INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (14, 1040, 'EXPIRY_WARNING', DATE '2024-01-01', 'RESOLVED', 'MEDIUM', 
        'Initial warning: Batch expiring in 45 days.', 
        45);

INSERT INTO alerts (alert_id, batch_id, alert_type, alert_date, status, priority, message, days_remaining) 
VALUES (15, 1040, 'EXPIRY_WARNING', SYSDATE - 15, 'ACKNOWLEDGED', 'HIGH', 
        'ESCALATION: Same batch now expiring in 10 days. Urgent action needed.', 
        10);
        
-- After inserting, re-enable the constraint
ALTER TABLE alerts ENABLE CONSTRAINT FK_ALERT_BATCH;
-- Create a sequence for future alert inserts (if not already created)
CREATE SEQUENCE alert_id_seq
    START WITH 100
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
select COUNT(*) from alerts;