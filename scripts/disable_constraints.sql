-- Disable foreign key constraints for data loading
ALTER TABLE medicines DISABLE CONSTRAINT fk_med_manufacturer;
ALTER TABLE batches DISABLE CONSTRAINT fk_batch_medicine;
ALTER TABLE recalls DISABLE CONSTRAINT fk_recall_manufacturer;
ALTER TABLE alerts DISABLE CONSTRAINT fk_alert_batch;
ALTER TABLE alerts DISABLE CONSTRAINT fk_alert_resolved_by;

-- Verify constraints are disabled
SELECT constraint_name, status FROM user_constraints 
WHERE table_name IN ('MEDICINES', 'BATCHES', 'RECALLS', 'ALERTS');