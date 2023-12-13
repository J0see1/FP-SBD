DELIMITER //

CREATE PROCEDURE GetPatients(
    IN diagnosis_name VARCHAR(80),
    IN lab_result VARCHAR(80),
    IN min_lab_count INT
)
BEGIN
    SELECT 
        p.id_pasien,
        p.nama_pasien,
        COUNT(tl.id_tes_lab) AS total_lab_count
    FROM pasien p
    JOIN catatan_pasien cp ON p.id_pasien = cp.id_pasien
    JOIN tes_lab tl ON cp.id_rekam_medis = tl.id_pasien
    JOIN diagnosa d ON cp.id_rekam_medis = d.id_rekam_medis
    WHERE d.diagnosa = diagnosis_name AND tl.hasil_tes_lab = lab_result
    GROUP BY p.id_pasien, p.nama_pasien
    HAVING total_lab_count >= min_lab_count
    ORDER BY total_lab_count DESC;
END //

DELIMITER ;

-- CALL GetPatients('gastritis', 'positive', 1);