DROP DATABASE IF EXISTS medcare;
CREATE DATABASE medcare;
USE medcare;

DROP TABLE IF EXISTS pasien;
CREATE TABLE pasien(
    id_pasien INT PRIMARY KEY,
    nama_pasien VARCHAR(80),
    tanggal_lahir TIMESTAMP,
    jenis_kelamin VARCHAR(80)
);

DROP TABLE IF EXISTS asuransi;
CREATE TABLE asuransi(
    nomor_asuransi VARCHAR(80) PRIMARY KEY,
    nama_perusahaan_asuransi VARCHAR(80),
    id_pasien INT,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien)
);

DROP TABLE IF EXISTS asuransi_pasien;
CREATE TABLE asuransi_pasien(
    id_pasien INT,
    nomor_asuransi VARCHAR(80),
    FOREIGN KEY (nomor_asuransi) REFERENCES asuransi(nomor_asuransi)
);

DROP TABLE IF EXISTS tenaga_medis;
CREATE TABLE tenaga_medis(
    id_tenaga_medis INT PRIMARY KEY,
    nama_tenaga_medis VARCHAR(80)
);

DROP TABLE IF EXISTS spesialisasi_tenaga_medis;
CREATE TABLE spesialisasi_tenaga_medis(   
    id_spesialisasi INT PRIMARY KEY,
    id_tenaga_medis INT,
    jenis_pekerjaan VARCHAR(80),
    spesialisasi_tenaga_medis VARCHAR(80),
    FOREIGN KEY (id_tenaga_medis) REFERENCES tenaga_medis(id_tenaga_medis)
);

DROP TABLE IF EXISTS kontak_dan_gaji;
CREATE TABLE kontak_dan_gaji(
    kontak_tenaga_medis VARCHAR(80) PRIMARY KEY,
    id_tenaga_medis INT,
    gaji_pokok DECIMAL(10,2),
    gaji_bonus DECIMAL(10,2),
    FOREIGN KEY (id_tenaga_medis) REFERENCES tenaga_medis(id_tenaga_medis)
);

DROP TABLE IF EXISTS catatan_pasien;
CREATE TABLE catatan_pasien(
    id_rekam_medis INT PRIMARY KEY,
    id_pasien INT,
    id_tenaga_medis INT,
    tanggal_catatan_medis TIMESTAMP,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_tenaga_medis) REFERENCES tenaga_medis(id_tenaga_medis)
);

DROP TABLE IF EXISTS diagnosa;
CREATE TABLE diagnosa(
    id_diagnosa INT PRIMARY KEY,
    id_rekam_medis INT,
    diagnosa VARCHAR(80),
    deskripsi_diagnosa TEXT,
    metode_pengobatan VARCHAR(80),
    FOREIGN KEY (id_rekam_medis) REFERENCES catatan_pasien(id_rekam_medis)
);

DROP TABLE IF EXISTS inventaris;
CREATE TABLE inventaris(
    id_inventaris INT PRIMARY KEY,
    nama_barang VARCHAR(80),
    jumlah_stok_barang DECIMAL(10,8),
    lokasi_penyimpanan_barang VARCHAR(80)
);

DROP TABLE IF EXISTS detail_barang;
CREATE TABLE detail_barang(
    nomor_seri_barang VARCHAR(80) PRIMARY KEY,
    tanggal_kadaluwarsa DATETIME,
    id_inventaris INT,
    FOREIGN KEY (id_inventaris) REFERENCES inventaris(id_inventaris)
);

DROP TABLE IF EXISTS jenis_barang;
CREATE TABLE jenis_barang(
    id_jenis_barang INT PRIMARY KEY,
    nomor_seri_barang VARCHAR(80),
    jenis_barang VARCHAR(80),
    keterangan_jenis_barang TEXT,
    FOREIGN KEY (nomor_seri_barang) REFERENCES detail_barang(nomor_seri_barang)
);

DROP TABLE IF EXISTS administrasi_dan_pembayaran;
CREATE TABLE administrasi_dan_pembayaran(
    id_administrasi INT PRIMARY KEY,
    id_inventaris INT,
    id_pasien INT,
    tanggal_pembayaran TIMESTAMP,
    total_pembayaran DECIMAL(10,2),
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_inventaris) REFERENCES inventaris(id_inventaris)
);

DROP TABLE IF EXISTS detail_pembayaran;
CREATE TABLE detail_pembayaran(
    nomor_referensi_pembayaran VARCHAR(80) PRIMARY KEY,
    metode_pembayaran VARCHAR(80),
    status_pembayaran VARCHAR(80),
    id_administrasi INT,
    FOREIGN KEY (id_administrasi) REFERENCES administrasi_dan_pembayaran(id_administrasi)
);

DROP TABLE IF EXISTS tes_lab;
CREATE TABLE tes_lab(
    id_tes_lab INT PRIMARY KEY,
    id_pasien INT,
    id_tenaga_medis INT,
    tanggal_tes_lab DATETIME,
    hasil_tes_lab VARCHAR(80),
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_tenaga_medis) REFERENCES tenaga_medis(id_tenaga_medis)
);

DROP TABLE IF EXISTS metode_tes_lab;
CREATE TABLE metode_tes_lab(
    id_metode_tes_lab INT PRIMARY KEY,
    id_tes_lab INT,
    jenis_tes_lab VARCHAR(80),
    metode_tes_lab VARCHAR(80),
    FOREIGN KEY (id_tes_lab) REFERENCES tes_lab(id_tes_lab)
);

DROP TABLE IF EXISTS appointment;
CREATE TABLE appointment(
    id_appointment INT PRIMARY KEY,
    id_pasien INT,
    jenis_appointment VARCHAR(80),
    tanggal_mulai_appointment DATETIME,
    tanggal_selesai_appointment DATETIME,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien)
);

DROP TABLE IF EXISTS detail_appointment;
CREATE TABLE detail_appointment(
    id_detail_appointment INT PRIMARY KEY,
    id_appointment INT,
    id_tenaga_medis INT,
    FOREIGN KEY (id_appointment)REFERENCES appointment(id_appointment),
    FOREIGN KEY (id_tenaga_medis)REFERENCES tenaga_medis(id_tenaga_medis)
);

DROP TABLE IF EXISTS lokasi_appointment;
CREATE TABLE lokasi_appointment(
    nomor_ruangan INT PRIMARY KEY,
    id_detail_appointment INT,
    jam_appointment TIMESTAMP,
    FOREIGN KEY (id_detail_appointment) REFERENCES detail_appointment(id_detail_appointment)
);