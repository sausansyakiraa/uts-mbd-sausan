-- =====================================================
-- Soal 3: Pengujian constraint tabel salam.mahasiswas
-- Koneksi: db_uts_sausan (localhost:22055)
-- Catatan: file ini dokumentasi urutan uji. Jalankan SATU PER SATU
-- (blok perintah lalu Ctrl+Enter). Uji 2 sampai 8 memang HARUS GAGAL.
-- =====================================================

-- 1. Data valid (BERHASIL, Updated Rows = 1)
INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050055', 'Sausan Syakira R D', 'sausan@mail.com', 'P', 5, 3.80);

-- 2. UNIQUE nim (GAGAL: uq_mahasiswas_nim)
INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050055', 'Orang Lain', 'lain@mail.com', 'L', 5, 3.00);

-- 3. UNIQUE email (GAGAL: uq_mahasiswas_email)
INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050099', 'Budi', 'sausan@mail.com', 'L', 5, 3.00);

-- 4. CHECK ipk, nilai 4.50 di luar rentang 0-4 (GAGAL: ck_mahasiswas_ipk)
INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050100', 'Ani', 'ani@mail.com', 'P', 5, 4.50);

-- 5. CHECK semester, nilai 20 di luar rentang 1-14 (GAGAL: ck_mahasiswas_semester)
INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050101', 'Citra', 'citra@mail.com', 'P', 20, 3.00);

-- 6. CHECK jenis_kelamin, nilai 'X' bukan 'L' atau 'P' (GAGAL: ck_mahasiswas_gender)
INSERT INTO salam.mahasiswas (nim, nama, email, jenis_kelamin, semester, ipk)
VALUES ('1247050102', 'Dedi', 'dedi@mail.com', 'X', 5, 3.00);

-- 7. Kolom identity GENERATED ALWAYS, id tidak boleh diisi manual
--    (GAGAL: cannot insert a non-DEFAULT value into column "id")
INSERT INTO salam.mahasiswas (id, nim, nama, semester)
VALUES (1, '1247050103', 'Eka', 3);

-- 7b. PRIMARY KEY duplikat dengan OVERRIDING SYSTEM VALUE (GAGAL: pk_mahasiswas)
INSERT INTO salam.mahasiswas (id, nim, nama, semester)
OVERRIDING SYSTEM VALUE
VALUES (1, '1247050103', 'Eka', 3);

-- 8. NOT NULL pada kolom nama (GAGAL: null value violates not-null constraint)
INSERT INTO salam.mahasiswas (nim, nama, semester)
VALUES ('1247050104', NULL, 3);

-- =====================================================
-- Hasil akhir
-- =====================================================

-- Hanya 1 baris valid yang tersimpan
SELECT * FROM salam.mahasiswas;

-- Daftar constraint: p = primary key, u = unique, c = check
SELECT conname, contype FROM pg_constraint
WHERE conrelid = 'salam.mahasiswas'::regclass;