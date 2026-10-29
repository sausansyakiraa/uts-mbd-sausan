-- =====================================================
-- Soal 4: Pengujian hak akses
-- Jalankan di koneksi masing-masing user (localhost:22055)
-- =====================================================

-- ============ backend_dev ============
SELECT current_user;
SELECT * FROM salam.mahasiswas;                                    -- BERHASIL

INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050200', 'Tes Backend', 'be@mail.com', 'L', 3, 3.10); -- BERHASIL

UPDATE salam.mahasiswas SET ipk = 3.20 WHERE nim = '1247050200';   -- BERHASIL
DELETE FROM salam.mahasiswas WHERE nim = '1247050200';             -- BERHASIL

CREATE TABLE salam.tes_backend (id INT);                           -- GAGAL: permission denied for schema
DROP TABLE salam.mahasiswas;                                       -- GAGAL: must be owner

-- ============ bi_dev ============
SELECT current_user;
SELECT * FROM salam.mahasiswas;                                    -- BERHASIL

INSERT INTO salam.mahasiswas (nim, nama, semester)
VALUES ('1247050201', 'X', 1);                                     -- GAGAL: permission denied
UPDATE salam.mahasiswas SET ipk = 1;                               -- GAGAL: permission denied
DELETE FROM salam.mahasiswas;                                      -- GAGAL: permission denied
CREATE TABLE salam.tes_bi (id INT);                                -- GAGAL: permission denied for schema

-- ============ data_engineer ============
SELECT current_user;

CREATE TABLE salam.mata_kuliahs (
    kode VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100)
);                                                                 -- BERHASIL
ALTER TABLE salam.mata_kuliahs ADD COLUMN sks SMALLINT;            -- BERHASIL
INSERT INTO salam.mata_kuliahs VALUES ('MBD', 'Manajemen Basis Data', 3);
SELECT * FROM salam.mata_kuliahs;                                  -- sks = 3
UPDATE salam.mata_kuliahs SET sks = 4 WHERE kode = 'MBD';
SELECT * FROM salam.mata_kuliahs;                                  -- sks = 4
DELETE FROM salam.mata_kuliahs WHERE kode = 'MBD';

-- ============ Bukti default privileges ============
-- bi_dev:
SELECT * FROM salam.mata_kuliahs;                                  -- BERHASIL (SELECT otomatis)
-- backend_dev:
INSERT INTO salam.mata_kuliahs VALUES ('BD2', 'Basis Data Lanjut', 3);  -- BERHASIL
DELETE FROM salam.mata_kuliahs WHERE kode = 'BD2';                      -- BERHASIL
-- bi_dev:
INSERT INTO salam.mata_kuliahs VALUES ('X', 'X', 1);               -- GAGAL: permission denied

-- ============ data_engineer: DROP ============
DROP TABLE salam.mata_kuliahs;                                     -- BERHASIL