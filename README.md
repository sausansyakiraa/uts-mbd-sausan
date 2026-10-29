# UTS Manajemen Basis Data - PostgreSQL & pgAdmin (Docker)

Nama : Sausan Syakira R D
NIM : 1247050055
Dosen : Wildan Budiawan Z, S.T., M.Kom

## Isi repo

- `docker-compose.yml` : service PostgreSQL dan pgAdmin4
- `.env.example` : contoh isi `.env` (salin menjadi `.env`)
- `sql/01_schema_table.sql` : skema `salam` dan tabel `mahasiswas`
- `sql/02_test_constraint.sql` : uji constraint (dokumentasi, jalankan satu per satu)
- `sql/03_users_roles.sql` : user dan hak akses (jalankan sekali)
- `sql/04_test_roles.sql` : uji hak akses (jalankan per koneksi user)

## Port

| Service    | Kontainer       | Port eksternal |
| ---------- | --------------- | -------------- |
| PostgreSQL | postgres_Sausan | 22055          |
| pgAdmin4   | pgadmin_Sausan  | 44055          |

## Cara menjalankan

1. `cp .env.example .env` (Windows: `copy .env.example .env`), lalu isi nilainya
   (`POSTGRES_USER=postgres`, `POSTGRES_PASSWORD=ifunggul`, dst.)
2. `docker compose up -d`
3. pgAdmin: http://localhost:44055 (host server `postgres`, port `5432`)
4. DBeaver: host `localhost`, port `22055`
5. Jalankan file SQL sesuai urutan nomor.

Catatan: password user pada `03_users_roles.sql` khusus untuk tugas ini.
