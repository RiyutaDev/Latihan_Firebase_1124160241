# Dokumentasi Pengujian Firebase Cloud Messaging (FCM)

## 1. Informasi Pengujian

Dokumentasi ini berisi hasil pengujian fitur **Firebase Cloud Messaging
(FCM)** pada aplikasi Flutter **Profil Mahasiswa**. Pengujian dilakukan
menggunakan Postman dengan Firebase Cloud Messaging HTTP v1 API dan
perangkat Android.

Tujuan pengujian adalah memastikan aplikasi dapat menerima notifikasi
pada tiga kondisi, yaitu **foreground**, **background**, dan
**terminated**, serta membuka halaman **Detail Notifikasi** ketika
notifikasi dipilih.

## 2. Konfigurasi Pengujian

  Komponen                       Keterangan
  ------------------------------ ----------------------------------
  Platform aplikasi              Flutter pada Android
  Layanan notifikasi             Firebase Cloud Messaging (FCM)
  Metode pengiriman              Postman -- FCM HTTP v1 API
  Target pengiriman              FCM Registration Token perangkat
  Android notification channel   `high_importance_channel`
  Halaman tujuan                 Detail Notifikasi

> Catatan keamanan: FCM Registration Token dan OAuth Access Token tidak
> dicantumkan dalam dokumentasi ini karena merupakan nilai yang tidak
> perlu dipublikasikan.

## 3. Skenario A --- Foreground (Aplikasi Sedang Dibuka)

**Tujuan:** Memastikan notifikasi diterima dan ditampilkan sebagai
pop-up ketika aplikasi sedang aktif di layar.

**Langkah pengujian:** 1. Aplikasi Profil Mahasiswa dibuka dan berada di
halaman Profil. 2. Request pengiriman notifikasi dijalankan melalui
Postman. 3. Notifikasi diterima ketika aplikasi masih berada di
foreground. 4. Notifikasi pop-up tampil di atas halaman aplikasi. 5.
Notifikasi dipilih untuk membuka halaman Detail Notifikasi.

**Hasil yang diamati:** - Judul notifikasi: `Halo Rizki Riana Putra`. -
Isi notifikasi: `Ini notifikasi pertama dari Postman` (pada pengujian
foreground juga digunakan pesan
`Ini notifikasi saat aplikasi di buka`). - Debug Console menampilkan
log:

``` text
[FCM] Pesan FOREGROUND: Halo Rizki Riana Putra
```

**Bukti hasil pengujian:**

### Gambar A.1 --- Pop-up notifikasi pada kondisi foreground

![Pop-up notifikasi
foreground](screenshots/skenario-a-notifikasi-foreground.png)

Keterangan: Notifikasi tampil sebagai pop-up ketika aplikasi Profil
Mahasiswa masih terbuka. Hal ini menunjukkan pesan diterima melalui
listener foreground `FirebaseMessaging.onMessage`.

### Gambar A.2 --- Halaman Detail Notifikasi pada kondisi foreground

![Detail notifikasi
foreground](screenshots/skenario-a-detail-foreground.png)

Keterangan: Setelah notifikasi dipilih, aplikasi menampilkan halaman
Detail Notifikasi. Informasi judul, isi pesan, dan data tambahan
(`id_pesan`, `kategori`, serta `isi_lengkap`) ditampilkan pada halaman
tersebut.

**Kesimpulan Skenario A:** Berhasil. Notifikasi diterima ketika aplikasi
aktif dan alur menuju halaman Detail Notifikasi dapat dijalankan.

## 4. Skenario B --- Background (Aplikasi di-Minimize)

**Tujuan:** Memastikan notifikasi tetap diterima ketika aplikasi berada
di background atau pengguna sedang berada di Home.

**Langkah pengujian:** 1. Aplikasi Profil Mahasiswa dibuka. 2. Tombol
Home ditekan sehingga aplikasi berada di background, bukan ditutup. 3.
Request notifikasi dikirim kembali melalui Postman. 4. Notifikasi muncul
pada layar/status bar Android. 5. Notifikasi dipilih untuk membuka
kembali aplikasi dan menampilkan Detail Notifikasi.

**Hasil yang diamati:** - Judul notifikasi: `Halo Rizki Riana Putra`. -
Isi notifikasi: `Ini notifikasi dari Background`. - Debug Console
menampilkan log penerimaan pesan background dan data payload, kemudian
ketika notifikasi dipilih menampilkan:

``` text
[FCM] Dibuka dari BACKGROUND
```

Data payload yang ditampilkan pada halaman Detail Notifikasi: -
`id_pesan`: `001` - `kategori`: `pengumuman` - `isi_lengkap`:
`Kuliah besok dimulai jam 19.00 di Lab 3`

**Bukti hasil pengujian:**

### Gambar B.1 --- Notifikasi diterima saat aplikasi berada di background

![Notifikasi
background](screenshots/skenario-b-notifikasi-background.png)

Keterangan: Notifikasi tampil pada layar Android ketika aplikasi tidak
sedang berada di depan dan pengguna berada di Home. Notifikasi sistem
ditampilkan oleh Android.

### Gambar B.2 --- Detail Notifikasi setelah notifikasi background dipilih

![Detail notifikasi
background](screenshots/skenario-b-detail-background.png)

Keterangan: Setelah notifikasi dipilih, aplikasi kembali terbuka dan
menampilkan halaman Detail Notifikasi. Data tambahan dari payload
berhasil ditampilkan sesuai nilai yang dikirim melalui Postman.

**Kesimpulan Skenario B:** Berhasil. Aplikasi menerima notifikasi saat
berada di background dan dapat membuka Detail Notifikasi ketika
notifikasi dipilih.

## 5. Skenario C --- Terminated (Aplikasi Ditutup dari Recent Apps)

**Tujuan:** Memastikan notifikasi tetap diterima setelah aplikasi
ditutup melalui Recent Apps, kemudian aplikasi dapat dijalankan kembali
melalui notifikasi dan menampilkan Detail Notifikasi.

**Langkah pengujian:** 1. Aplikasi dibuka secara manual dari ikon
perangkat untuk memastikan aplikasi pernah dijalankan. 2. Menu Recent
Apps dibuka. 3. Aplikasi Profil Mahasiswa di-swipe/geser hingga tertutup
dari daftar Recent Apps. 4. Notifikasi dikirim melalui Postman
menggunakan FCM Registration Token perangkat. 5. Notifikasi muncul pada
layar perangkat meskipun aplikasi sudah ditutup. 6. Notifikasi dipilih
sehingga aplikasi dijalankan kembali dan membuka halaman Detail
Notifikasi.

**Hasil yang diamati:** - Judul notifikasi: `Halo Rizki Riana Putra`. -
Isi notifikasi: `Ini notifikasi saat aplikasi di Tutup`. - Halaman
Detail Notifikasi menampilkan: - `id_pesan`: `003` - `kategori`:
`pengujian` - `isi_lengkap`:
`Pengujian FCM kondisi terminated berhasil.`

**Bukti hasil pengujian:**

### Gambar C.1 --- Notifikasi diterima saat aplikasi terminated

![Notifikasi
terminated](screenshots/skenario-c-notifikasi-terminated.png)

Keterangan: Notifikasi tetap muncul pada perangkat setelah aplikasi
ditutup melalui Recent Apps. Pengujian ini tidak menggunakan Force Stop
dari pengaturan Android.

### Gambar C.2 --- Detail Notifikasi setelah aplikasi dijalankan dari notifikasi

![Detail notifikasi
terminated](screenshots/skenario-c-detail-terminated.png)

Keterangan: Setelah notifikasi dipilih, aplikasi dijalankan kembali dan
menampilkan halaman Detail Notifikasi. Data payload dengan ID pesan
`003` dan kategori `pengujian` berhasil ditampilkan.

**Kesimpulan Skenario C:** Berhasil. Notifikasi diterima pada kondisi
aplikasi terminated (ditutup melalui Recent Apps), dan pemilihan
notifikasi membuka aplikasi menuju Detail Notifikasi.

> **Catatan penting:** Kondisi terminated pada pengujian ini berarti
> aplikasi ditutup dengan swipe dari Recent Apps. Jangan menggunakan
> Force Stop pada pengaturan Android atau tombol Stop di IDE, karena
> aplikasi yang di-force-stop dapat berhenti menerima pengiriman FCM
> sampai dibuka kembali secara manual.

## 6. Rekapitulasi Hasil Pengujian

  -------------------------------------------------------------------------------
             No. Skenario     Kondisi       Notifikasi   Detail       Hasil
                              aplikasi      diterima     terbuka saat 
                                                         notifikasi   
                                                         dipilih      
  -------------- ------------ ------------- ------------ ------------ -----------
               1 A ---        Aplikasi      Ya           Ya           Berhasil
                 Foreground   sedang dibuka                           

               2 B ---        Aplikasi      Ya           Ya           Berhasil
                 Background   di-minimize /                           
                              Home                                    

               3 C ---        Aplikasi      Ya           Ya           Berhasil
                 Terminated   di-swipe dari                           
                              Recent Apps                             
  -------------------------------------------------------------------------------

## 7. Kesimpulan

Berdasarkan hasil pengujian pada perangkat Android, fitur Firebase Cloud
Messaging pada aplikasi Profil Mahasiswa berhasil diuji dalam tiga
kondisi aplikasi, yaitu foreground, background, dan terminated.
Notifikasi yang dikirim melalui Postman berhasil diterima. Ketika
notifikasi dipilih, aplikasi menampilkan halaman Detail Notifikasi
beserta data tambahan yang dikirim melalui payload.

Dengan demikian, ketiga skenario pengujian FCM yang dilakukan dinyatakan
**berhasil**.

## 8. Struktur File Bukti Screenshot

Seluruh gambar bukti disimpan pada folder `screenshots` dengan susunan
berikut:

``` text
README.md
screenshots/
├── skenario-a-notifikasi-foreground.png
├── skenario-a-detail-foreground.png
├── skenario-b-notifikasi-background.png
├── skenario-b-detail-background.png
├── skenario-c-notifikasi-terminated.png
└── skenario-c-detail-terminated.png
```
