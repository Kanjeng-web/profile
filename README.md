# Art Memory 2.0 — Roblox Profile Studio

Upgrade ini mengubah website menjadi **one-page Roblox profile + gallery** dengan fokus pada pengalaman pengunjung dan admin.

## Yang berubah

- Image Roblox, Art Roblox, dan SS Roblox sekarang berada dalam **satu halaman profil**.
- Tombol Image / Art / SS tetap ada; tombol melakukan **smooth scroll** ke section terkait.
- Fav Friend lama tetap dipertahankan sebagai section agar data versi sebelumnya tidak hilang.
- Request HD / Edit berada **paling bawah**.
- Like online dengan database Supabase dan update realtime.
- Like dibatasi satu kali per visitor/browser untuk satu karya.
- View dihitung maksimal sekali per visitor per hari untuk satu karya.
- Download counter juga tersimpan di Supabase dan dibatasi sekali per visitor per hari.
- Modal gambar memiliki **zoom 50%–300%**, tombol +/−, reset, dan zoom dengan scroll mouse.
- Animasi reveal saat section masuk viewport, hover gallery, glow, micro-interaction, dan background motion.
- Admin Studio baru dengan dashboard statistik.
- Theme Studio: preset Aurora, Ocean, Sunset, Emerald, Violet, Mono + warna custom.
- Admin bisa mengatur radius kartu dan melihat live preview sebelum menyimpan.
- Admin bisa mengatur posisi avatar kiri/kanan/atas/bawah dan zoom avatar.
- Request HD/Edit masuk ke inbox admin secara realtime.
- RLS Supabase memisahkan hak akses pengunjung dan admin.
- Storage gallery/avatar memakai policy admin.
- Fallback localStorage tetap tersedia untuk testing lokal tanpa Supabase.

## Supabase — urutan setup

1. Buat project Supabase.
2. Buka **SQL Editor**.
3. Jalankan **seluruh** `supabase-schema.sql` dari awal sampai akhir.
4. Buka **Authentication → Users → Add user** dan buat email + password admin.
5. Copy UUID user tersebut.
6. Jalankan SQL berikut, ganti UUID dan username:

```sql
insert into public.admin_users(user_id, username)
values ('UUID_DARI_AUTH_USERS', 'KanjengCicak')
on conflict (user_id) do update set username=excluded.username;
```

7. Isi `assets/supabase-config.js` dengan **Project URL** dan **anon/public key**.
8. Jangan pernah memasukkan `service_role` key ke file website.
9. Login melalui `login.html` memakai email + password Supabase Auth.

### Tentang password

Password admin **tidak disimpan di tabel aplikasi**. Password dikelola oleh Supabase Auth. Ini lebih aman daripada menaruh password plaintext atau password hard-coded di JavaScript.

## Realtime

SQL sudah menambahkan `photos`, `profile`, dan `contact_messages` ke publication `supabase_realtime` jika publication tersebut tersedia. Frontend juga otomatis subscribe untuk update statistik/gallery/request.

## Storage

SQL membuat/menyiapkan bucket:

- `gallery`
- `avatars`

Bucket bersifat public untuk membaca gambar, sedangkan upload/update/delete dibatasi ke akun admin.

## Jalankan lokal

### Windows

Double-click `run.bat`, atau jalankan:

```powershell
powershell -ExecutionPolicy Bypass -File .\run.ps1
```

Lalu buka alamat localhost yang diberikan server.

### VS Code

Bisa memakai Live Server atau server HTTP lokal lain.

## Catatan upload

Admin menerima gambar hingga 15 MB per file. Untuk website produksi, ukuran gambar sebaiknya tetap dikompres agar loading pengunjung cepat.

## Struktur utama

- `index.html` — halaman profil + seluruh gallery + request
- `admin.html` — Admin Studio
- `login.html` — login Supabase Auth
- `supabase-schema.sql` — database, RLS, RPC, storage, realtime, index
- `assets/app.js` — profil/gallery/like/view/zoom/realtime
- `assets/admin.js` — admin/profile/theme/gallery/request/realtime
- `assets/style.css` — tema, responsive layout, animasi
- `art.html`, `screenshots.html`, `image.html`, `fav-friend.html` — redirect kompatibilitas ke section one-page
