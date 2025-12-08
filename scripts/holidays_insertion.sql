-- Create sequence for holiday_id if not exists
CREATE SEQUENCE holiday_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Insert Rwanda National Public Holidays for 2024
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-01-01', 'New Year''s Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-02-01', 'National Heroes'' Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-04-07', 'Genocide against the Tutsi Memorial Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-05-01', 'Labour Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-07-01', 'Independence Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-07-04', 'Liberation Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-08-15', 'Assumption Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-12-25', 'Christmas Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-12-26', 'Boxing Day', 'RWANDA', 'Y', SYSDATE);

-- Insert Rwanda Public Holidays for 2025 (for future planning)
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-01-01', 'New Year''s Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-02-01', 'National Heroes'' Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-04-07', 'Genocide against the Tutsi Memorial Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-05-01', 'Labour Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-07-01', 'Independence Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-07-04', 'Liberation Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-08-15', 'Assumption Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-12-25', 'Christmas Day', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2025-12-26', 'Boxing Day', 'RWANDA', 'Y', SYSDATE);

-- Insert variable date holidays (non-recurring fixed dates)
-- Note: These are based on typical dates, actual dates might vary
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-03-29', 'Good Friday', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-04-01', 'Easter Monday', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-04-10', 'Eid al-Fitr (End of Ramadan)', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-06-16', 'Eid al-Adha (Feast of the Sacrifice)', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-09-16', 'Rwanda Patriotic Front (RPF) Anniversary', 'RWANDA', 'Y', SYSDATE);

-- Insert historical holidays for reference
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2023-10-26', 'Accession Day (Kwibohora 29)', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2023-12-08', 'Umuganura Day (National Harvest Day)', 'RWANDA', 'N', SYSDATE);

-- Insert some international observances that might affect pharmacy operations
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-02-04', 'World Cancer Day (Observance)', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-04-25', 'World Malaria Day (Observance)', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-12-01', 'World AIDS Day (Observance)', 'RWANDA', 'Y', SYSDATE);

-- Insert bank holidays (weekends that are extended)
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-05-03', 'Bank Holiday (Day after Labour Day)', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-12-27', 'Bank Holiday (Day after Boxing Day)', 'RWANDA', 'N', SYSDATE);

-- Insert regional/local holidays (example for Kigali)
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-03-01', 'Kigali City Day', 'RWANDA', 'Y', SYSDATE);

-- Insert for testing purposes (past holidays)
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2023-07-04', 'Liberation Day 2023', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2023-12-25', 'Christmas Day 2023', 'RWANDA', 'N', SYSDATE);

-- Insert holiday periods (extended holidays)
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-12-24', 'Christmas Eve', 'RWANDA', 'Y', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2024-12-31', 'New Year''s Eve', 'RWANDA', 'Y', SYSDATE);

-- Insert for 2026 (long-term planning)
INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2026-01-01', 'New Year''s Day 2026', 'RWANDA', 'N', SYSDATE);

INSERT INTO holidays (holiday_id, holiday_date, holiday_name, country, is_recurring, created_date) 
VALUES (holiday_seq.NEXTVAL, DATE '2026-07-01', 'Independence Day 2026', 'RWANDA', 'N', SYSDATE);

-- Verify the inserts
COMMIT;

-- Display inserted holidays
SELECT holiday_id, holiday_date, holiday_name, country, is_recurring, created_date
FROM holidays
ORDER BY holiday_date;

-- Count holidays by year
SELECT EXTRACT(YEAR FROM holiday_date) as holiday_year, COUNT(*) as holiday_count
FROM holidays
GROUP BY EXTRACT(YEAR FROM holiday_date)
ORDER BY holiday_year;

-- Count recurring vs non-recurring holidays
SELECT is_recurring, COUNT(*) as count
FROM holidays
GROUP BY is_recurring;