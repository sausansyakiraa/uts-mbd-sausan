-- =====================================================
-- Soal 3: Skema SALAM dan tabel mahasiswas
-- Koneksi: db_uts_sausan (localhost:22055), user postgres
-- Catatan: PostgreSQL menyimpan nama tanpa tanda kutip dalam huruf kecil,
-- jadi skema SALAM tersimpan sebagai "salam".
-- =====================================================

-- Skema (namespace) untuk mengelompokkan objek
CREATE SCHEMA IF NOT EXISTS salam;

-- Tabel mahasiswas
CREATE TABLE salam.mahasiswas (
    -- Kolom identity: id dibuat otomatis oleh PostgreSQL, tidak boleh diisi manual
    id            BIGINT GENERATED ALWAYS AS IDENTITY,

    -- NOT NULL: wajib diisi
    nim           VARCHAR(15)  NOT NULL,
    nama          VARCHAR(100) NOT NULL,

    -- Boleh kosong, tetapi jika diisi harus unik (uq_mahasiswas_email)
    email         VARCHAR(100),

    -- Hanya boleh 'L' atau 'P' (ck_mahasiswas_gender)
    jenis_kelamin CHAR(1),

    -- Wajib diisi, rentang 1 sampai 14 (ck_mahasiswas_semester)
    semester      SMALLINT     NOT NULL,

    -- Rentang 0 sampai 4 (ck_mahasiswas_ipk)
    ipk           NUMERIC(3,2),

    -- Waktu data dibuat, terisi otomatis
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),

    -- PRIMARY KEY: identitas unik tiap baris
    CONSTRAINT pk_mahasiswas PRIMARY KEY (id),

    -- UNIQUE: nim dan email tidak boleh sama antar baris
    CONSTRAINT uq_mahasiswas_nim   UNIQUE (nim),
    CONSTRAINT uq_mahasiswas_email UNIQUE (email),

    -- CHECK: membatasi nilai yang valid
    CONSTRAINT ck_mahasiswas_ipk      CHECK (ipk BETWEEN 0 AND 4),
    CONSTRAINT ck_mahasiswas_semester CHECK (semester BETWEEN 1 AND 14),
    CONSTRAINT ck_mahasiswas_gender   CHECK (jenis_kelamin IN ('L','P'))
);