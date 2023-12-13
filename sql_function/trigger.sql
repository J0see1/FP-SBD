-- Membuat trigger setelah pembaruan pada detail_appointment
DELIMITER //
CREATE TRIGGER after_update_detail_appointment
AFTER UPDATE ON detail_appointment
FOR EACH ROW
BEGIN
    -- Variabel untuk menyimpan total jumlah appointment untuk pasien tertentu
    DECLARE total_appointments INT;

    -- Menggunakan subquery untuk mendapatkan total jumlah appointment untuk pasien yang sama
    SELECT COUNT(*) INTO total_appointments
    FROM appointment a
    JOIN detail_appointment da ON a.id_appointment = da.id_appointment
    WHERE a.id_pasien = (SELECT id_pasien FROM appointment WHERE id_appointment = NEW.id_appointment);

    -- Menambahkan log ke dalam tabel audit_log berdasarkan kondisi
    IF NEW.id_tenaga_medis IS NOT NULL AND total_appointments > 1 THEN
        INSERT INTO audit_log (log_message, total_appointments) 
        VALUES ('Detail appointment diperbarui dengan tenaga medis dan pasien yang sama memiliki lebih dari 1 appointment', total_appointments);
    END IF;
END;
//
DELIMITER ;


-- cara jalaninnya:

-- -- Contoh pernyataan pembaruan untuk menjalankan trigger
-- UPDATE detail_appointment SET id_tenaga_medis = 123 WHERE id_detail_appointment = 1;

-- -- Pernyataan SELECT untuk melihat log di tabel audit_log
-- SELECT * FROM audit_log;
