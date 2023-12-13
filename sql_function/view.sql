-- Membuat view dengan menggunakan beberapa elemen
CREATE VIEW view_tenaga_medis_summary AS
SELECT
    tm.id_tenaga_medis,
    tm.nama_tenaga_medis,
    COUNT(stm.id_spesialisasi) AS jumlah_spesialisasi,
    SUM(kg.gaji_pokok + kg.gaji_bonus) AS total_gaji
FROM
    tenaga_medis tm
LEFT JOIN spesialisasi_tenaga_medis stm ON tm.id_tenaga_medis = stm.id_tenaga_medis
LEFT JOIN kontak_dan_gaji kg ON tm.id_tenaga_medis = kg.id_tenaga_medis
WHERE
    kg.gaji_pokok IS NOT NULL AND kg.gaji_bonus IS NOT NULL
GROUP BY
    tm.id_tenaga_medis, tm.nama_tenaga_medis
HAVING
    COUNT(stm.id_spesialisasi) > 1
ORDER BY
    total_gaji DESC;


-- cara jalaninnya:

-- SELECT * FROM view_tenaga_medis_summary;


-- SELECT *
-- FROM view_tenaga_medis_summary
-- WHERE jumlah_spesialisasi > 3;

-- SELECT AVG(total_gaji) AS rata_rata_gaji
-- FROM view_tenaga_medis_summary;
