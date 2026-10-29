-- =====================================================
-- Soal 4: Pembuatan user dan hak akses
-- Koneksi: db_uts_sausan (localhost:22055), user postgres
-- Catatan: jalankan SEKALI saja (Alt+X). Kalau diulang, CREATE ROLE
-- akan error karena role sudah ada.
-- =====================================================

-- 1. Buat tiga user (role dengan hak LOGIN)
CREATE ROLE backend_dev   LOGIN PASSWORD 'Backend#055';
CREATE ROLE bi_dev        LOGIN PASSWORD 'Bi#055';
CREATE ROLE data_engineer LOGIN PASSWORD 'DataEng#055';

-- 2. Izin untuk terhubung ke database
GRANT CONNECT ON DATABASE db_uts_sausan TO backend_dev, bi_dev, data_engineer;

-- 3. data_engineer: dijadikan pemilik skema dan tabel.
--    Di PostgreSQL, CREATE, ALTER, dan DROP hanya bisa dilakukan oleh pemilik
--    objek, sehingga data_engineer bisa CREATE, MODIFY, DROP + CRUD.
ALTER SCHEMA salam OWNER TO data_engineer;
ALTER TABLE  salam.mahasiswas OWNER TO data_engineer;

-- 4. backend_dev: CRUD semua tabel (tanpa hak DDL)
GRANT USAGE ON SCHEMA salam TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA salam TO backend_dev;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA salam TO backend_dev;

-- 5. bi_dev: hanya baca (SELECT)
GRANT USAGE ON SCHEMA salam TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA salam TO bi_dev;

-- 6. Default privileges: tabel/sequence BARU yang dibuat data_engineer
--    otomatis memberi hak yang sama kepada backend_dev dan bi_dev
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA salam
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA salam
    GRANT SELECT ON TABLES TO bi_dev;
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA salam
    GRANT USAGE, SELECT ON SEQUENCES TO backend_dev;