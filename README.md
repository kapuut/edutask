
# EduTrack 

## Ringkasan
EduTrack adalah aplikasi admin sederhana berbasis Laravel untuk:
- CRUD mahasiswa dan kursus
- Assign kursus ke mahasiswa (many-to-many)
- Input nilai ujian dengan format array dan tuple komentar
- Login admin + proteksi route dashboard
- Upload file tugas mahasiswa
- Laporan performa per mahasiswa
- Unit & feature testing
- Tool build TypeScript untuk simulasi data (opsional enhancement)

## Setup Laravel
1. Pastikan project ini berada di dalam struktur Laravel lengkap.
2. Atur koneksi database pada file `.env`.
3. Jalankan migration:
```bash
php artisan migrate
```
4. Seed admin default:
```bash
php artisan db:seed --class=AdminSeeder
```
5. Jalankan server:
```bash
php artisan serve
```

## Akun Admin Default
- Username: `admin`
- Password: `admin123`

## Endpoint Utama
- `POST /login`
- `POST /logout`
- `GET /dashboard`
- `GET|POST|PUT|DELETE /students`
- `POST /students/{student}/assign-course`
- `GET|POST|PUT|DELETE /courses`
- `GET|POST|PUT /grades`
- `POST /submissions`
- `GET /submissions/student/{student}`
- `GET /reports/students/{student}`

Semua endpoint selain login menggunakan middleware admin session.

## Menjalankan Test
```bash
php artisan test
```

## TypeScript Simulation (Opsional)
1. Install dependency:
```bash
npm install
```
2. Build + jalankan simulasi:
```bash
npm run simulate
```
