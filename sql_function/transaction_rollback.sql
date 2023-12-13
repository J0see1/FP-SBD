START TRANSACTION;

SELECT tenaga_medis.nama_tenaga_medis, spesialisasi_tenaga_medis.jenis_pekerjaan, kontak_dan_gaji.kontak_tenaga_medis
FROM tenaga_medis
INNER JOIN spesialisasi_tenaga_medis ON tenaga_medis.id_tenaga_medis = spesialisasi_tenaga_medis.id_tenaga_medis
INNER JOIN kontak_dan_gaji ON tenaga_medis.id_tenaga_medis = kontak_dan_gaji.id_tenaga_medis
GROUP BY tenaga_medis.nama_tenaga_medis, spesialisasi_tenaga_medis.jenis_pekerjaan;

DELETE FROM spesialisasi_tenaga_medis WHERE jenis_pekerjaan="Doctor";

SELECT 
    subquery.nama_tenaga_medis,
    subquery.jenis_pekerjaan,
    subquery.total_gaji
FROM (
    SELECT 
        tenaga_medis.nama_tenaga_medis,
        spesialisasi_tenaga_medis.jenis_pekerjaan,
        SUM(kontak_dan_gaji.gaji_pokok + kontak_dan_gaji.gaji_bonus) AS total_gaji
    FROM 
        tenaga_medis
    INNER JOIN 
        spesialisasi_tenaga_medis ON tenaga_medis.id_tenaga_medis = spesialisasi_tenaga_medis.id_tenaga_medis
    INNER JOIN 
        kontak_dan_gaji ON tenaga_medis.id_tenaga_medis = kontak_dan_gaji.id_tenaga_medis
    GROUP BY 
        tenaga_medis.nama_tenaga_medis, spesialisasi_tenaga_medis.jenis_pekerjaan
    HAVING
    total_gaji < 5000
    ORDER BY total_gaji ASC
) AS subquery;

ROLLBACK;

    SELECT 
        tenaga_medis.nama_tenaga_medis,
        spesialisasi_tenaga_medis.jenis_pekerjaan,
        spesialisasi_tenaga_medis.spesialisasi_tenaga_medis
    FROM 
        tenaga_medis
    INNER JOIN 
        spesialisasi_tenaga_medis ON tenaga_medis.id_tenaga_medis = spesialisasi_tenaga_medis.id_tenaga_medis
    INNER JOIN 
        kontak_dan_gaji ON tenaga_medis.id_tenaga_medis = kontak_dan_gaji.id_tenaga_medis
     WHERE spesialisasi_tenaga_medis.jenis_pekerjaan = 'Doctor' AND spesialisasi_tenaga_medis.spesialisasi_tenaga_medis = 'Orthopedics'
    GROUP BY 
        tenaga_medis.nama_tenaga_medis