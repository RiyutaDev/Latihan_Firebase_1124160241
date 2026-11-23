# STUDENT ID – Aplikasi Profil Mahasiswa

Aplikasi profil mahasiswa berbasis Flutter yang mengintegrasikan Firebase Authentication untuk proses registrasi, login, dan logout pengguna. Aplikasi ini merupakan pengembangan dari proyek Profil Mahasiswa sebelumnya dengan penambahan Firebase, Splash Screen, serta penyempurnaan tampilan Login dan Register.

## 1. Informasi Proyek

| Keterangan | Detail |
|---|---|
| Nama Aplikasi | STUDENT ID |
| Platform | Android |
| Framework | Flutter |
| Bahasa Pemrograman | Dart |
| Backend Authentication | Firebase Authentication |
| Metode Login | Email dan Password |
| Repository | https://github.com/RiyutaDev/Latihan_Firebase_1124160241 |
| Pengembang | Rizki Riana Putra |
| NIM | 1124160241 |
| Program Studi | Teknik Informatika Software Engineering |
| Kelas | TI24SESHIFT |

## 2. Teknologi yang Digunakan

- Flutter sebagai framework pengembangan aplikasi.
- Dart sebagai bahasa pemrograman.
- Firebase Core untuk inisialisasi Firebase.
- Firebase Authentication untuk autentikasi pengguna.
- FlutterFire CLI untuk menghubungkan aplikasi Flutter dengan Firebase.
- Git dan GitHub untuk pengelolaan repository proyek.

## 3. Fitur Aplikasi

1. **Splash Screen**  
   Menampilkan identitas aplikasi dan memeriksa status autentikasi pengguna sebelum masuk ke halaman berikutnya.

2. **Login**  
   Memungkinkan pengguna masuk menggunakan email dan password melalui Firebase Authentication.

3. **Register**  
   Memungkinkan pengguna membuat akun menggunakan email dan password.

4. **Profil Mahasiswa**  
   Menampilkan informasi profil mahasiswa seperti nama, NIM, program studi, kelas, email, dan informasi lainnya.

5. **Edit Profil**  
   Memungkinkan pengguna mengubah informasi profil yang ditampilkan pada aplikasi.

6. **Logout**  
   Mengakhiri sesi autentikasi pengguna melalui Firebase Authentication.

7. **Dark Mode dan Light Mode**  
   Menyediakan pilihan tampilan terang dan gelap.

## 4. Langkah Integrasi Firebase

Berikut ringkasan tahapan integrasi Firebase ke dalam proyek Flutter.

### 4.1 Membuat Project Firebase

1. Membuka [Firebase Console](https://console.firebase.google.com/).
2. Membuat project Firebase baru.
3. Menambahkan aplikasi Android menggunakan package name proyek.
4. Mengunduh file konfigurasi `google-services.json`.
5. Menempatkan file tersebut pada folder `android/app/`.

### 4.2 Mengaktifkan Firebase Authentication

1. Membuka menu Authentication pada Firebase Console.
2. Memilih Sign-in method.
3. Mengaktifkan provider Email/Password.

### 4.3 Menghubungkan Flutter dengan Firebase

Login terlebih dahulu melalui Firebase CLI:

```bash
firebase login
firebase projects:list
```

Mengaktifkan FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

Menghubungkan proyek Flutter dengan project Firebase:

```bash
flutterfire configure --project=latihan-firebase-31b50
```

Memilih platform Android dan Web sesuai konfigurasi proyek.

Proses tersebut menghasilkan file `firebase_options.dart` pada folder `lib/`.

### 4.4 Menginisialisasi Firebase

Firebase diinisialisasi sebelum aplikasi dijalankan melalui fungsi `main()`.

```dart
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### 4.5 Mengimplementasikan Firebase Authentication

Proses autentikasi dikelola melalui `AuthService` dengan beberapa fungsi utama:

- Register menggunakan `createUserWithEmailAndPassword()`.
- Login menggunakan `signInWithEmailAndPassword()`.
- Logout menggunakan `signOut()`.
- Memeriksa status autentikasi menggunakan `authStateChanges()`.

### 4.6 Mengintegrasikan Splash Screen dan Login

Splash Screen diintegrasikan dengan status autentikasi Firebase.

- Jika pengguna sudah login, aplikasi diarahkan ke halaman Profil Mahasiswa.
- Jika pengguna belum login, aplikasi diarahkan ke halaman Login.

Halaman Login dan Register juga dilengkapi validasi input, indikator loading, serta penanganan pesan kesalahan autentikasi.

## 5. Pengujian Aplikasi

Pengujian dilakukan untuk memastikan fitur utama aplikasi berjalan sesuai fungsinya.

| No. | Fitur | Hasil Pengujian |
|---|---|---|
| 1 | Splash Screen | Berjalan |
| 2 | Registrasi akun | Berjalan |
| 3 | Login menggunakan Firebase | Berjalan |
| 4 | Navigasi ke halaman profil | Berjalan |
| 5 | Edit profil | Berjalan |
| 6 | Logout | Berjalan |
| 7 | Dark Mode dan Light Mode | Berjalan |

## 6. Akun Login untuk Pengujian

Gunakan akun berikut untuk mencoba fitur Login:

| Keterangan | Akun |
|---|---|
| Email | [Email akun pengujian] |
| Password | [Password akun pengujian] |

**Catatan:** Akun ini disediakan khusus untuk keperluan demonstrasi dan pengujian aplikasi.

## 7. Repository GitHub

Source code proyek dapat diakses melalui repository berikut:

https://github.com/RiyutaDev/Latihan_Firebase_1124160241

Repository digunakan untuk menyimpan source code, mencatat perubahan melalui Git, dan mengelola versi pengerjaan proyek.

Perintah dasar untuk menjalankan proyek:

```bash
git clone https://github.com/RiyutaDev/Latihan_Firebase_1124160241.git

cd Latihan_Firebase_1124160241

flutter pub get

flutter run
```

**Catatan:** Pastikan konfigurasi Firebase untuk project yang digunakan tersedia sebelum menjalankan aplikasi. Jangan memasukkan kredensial pribadi seperti service account key ke repository.

## 8. Daftar Tugas Pengerjaan Individu

Proyek ini dikerjakan secara individu oleh Rizki Riana Putra.

| No. | Daftar Tugas |
|---|---|
| 1 | Menyiapkan project Flutter dan konfigurasi Firebase. |
| 2 | Menghubungkan aplikasi Flutter dengan Firebase menggunakan FlutterFire CLI. |
| 3 | Mengimplementasikan Firebase Core. |
| 4 | Membuat AuthService untuk mengelola autentikasi pengguna. |
| 5 | Mengintegrasikan Firebase Authentication pada halaman Login. |
| 6 | Membuat halaman Register dengan autentikasi Firebase. |
| 7 | Mengintegrasikan Splash Screen dengan status login pengguna. |
| 8 | Menyempurnakan UI Login, Register, dan Splash Screen dengan branding STUDENT ID. |
| 9 | Mengintegrasikan fitur profil mahasiswa, edit profil, dan logout. |
| 10 | Melakukan pengujian aplikasi serta mengelola repository GitHub. |
| 11 | Menyusun dokumentasi proyek melalui README.md. |

## 9. Pengembang

**Rizki Riana Putra**

NIM: 1124160241  
Program Studi: Teknik Informatika Software Engineering  
Kelas: TI24SESHIFT

---
**STUDENT ID – Aplikasi Profil Mahasiswa**  
Dikembangkan menggunakan Flutter dan Firebase Authentication.
