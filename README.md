# PRAKTIKUM MOBILE PROGRAMMING
# Geolokasi, Peta Digital, dan Geocoding

NAMA  : MOCH FIRMAN TRISWANDA
NIM   : 362458302013
KELAS : 2B TRPL

## LANGKAH KERJA
**Langkah 1**: Pembuatan Proyek dan Konfigurasi
Buat proyek baru dan tambahkan dependensi yang diperlukan pada file pubspec.yaml. Jangan lupa jalankan perintah flutter pub get di terminal.
<u>DOKUMENTASI:</u>
<img width="1430" height="930" alt="image" src="https://github.com/user-attachments/assets/ecaeaac7-472e-4c55-b1dc-8c9d8d637111" />
<img width="995" height="799" alt="image" src="https://github.com/user-attachments/assets/d3da604a-5fd3-4c0b-8d01-7e5a93cd4299" />

**Langkah 2**: Pengaturan Izin (Permissions)
Agar aplikasi dapat mengakses GPS, tambahkan izin pada android/app/src/main/AndroidManifesttepat di atas tag <application>:
<u>DOKUMENTASI:</u>
<img width="1430" height="820" alt="image" src="https://github.com/user-attachments/assets/4188189d-debd-42b8-a4ac-38d75036ac54" />

**Langkah 3**: Membuat Model Data
Buat file baru lib/catatan_model.dart untuk menyimpan struktur data.
<u>DOKUMENTASI:</u>
<img width="928" height="966" alt="image" src="https://github.com/user-attachments/assets/73f678b0-2efd-4bc8-92d2-cc36acc1b4b0" />

**Langkah 4**: Implementasi Logika Utama
Buka file lib/main.dart. Kita akan mengimplementasikan peta dengan fitur Long
Press untuk menambah data.
<u>DOKUMENTASI:</u>
<img width="1430" height="3846" alt="image" src="https://github.com/user-attachments/assets/d81a36fe-b5a9-455c-b776-a993c5893ae7" />


## TUGAS MANDIRI
**No 1**: Kustomisasi Marker
Ubah ikon marker agar berbeda-beda tergantung jenis catatan (misal: Toko, Rumah, Kantor).
<u>DOKUMENTASI:</u>
<img width="1380" height="1788" alt="image" src="https://github.com/user-attachments/assets/4afb1935-666a-45da-9885-959a8a16184f" />

<u>PENJELASAN:</u>
Pada saat pengguna melakukan long-press pada peta, maka secara otomatis akan memilih kategori seperti Icon Rumah, Toko, Penginapan, dan lain-lainnya. CatatanModel(category: ...), ini fungsinya kategori menyimpan dimodel ini. Lalu, ketika menampilkan marker pada peta, aplikasi memerikasa kategori dan menampilkan ikon rumah bewarna biru jika kategori rumah, menampilkan ikon toko bewarna hijau jika kategori toko, menampilkan gedung bewaena ungu jika kategori kantor.

**No 2**: Menghapus Data
Tambahkan fitur untuk menghapus marker yang sudah dibuat.
<u>DOKUMENTASI:</u>
<img width="874" height="782" alt="image" src="https://github.com/user-attachments/assets/f2dcbe5f-30dc-46b3-b146-39583d77a520" />

<u>PENJELASAN:</u>
Ketika pengguna mengklik marker, secara otomatis aplikasi membuka BottomSheet berisi detail catatan. Didalam sheet tersebut ada tombol Hapus Marker juga. Lalu jika marker dihapus itu dari list _saveNotes, tampilan peta diperbarui di (setState), data diperbarui supaya tetap sama dengan enyimpanan. Ketika mengklik Hapus Marker, secara otomatis catatan yang di tambahkan barusan akan otomatis terhapus atau menghilang.

**No 3**: Simpan Data
(Opsional) Gunakan SharedPreferences atau Hive agar data tidak hilang saat aplikasi ditutup.
<u>DOKUMENTASI:</u>
<img width="1430" height="1564" alt="image" src="https://github.com/user-attachments/assets/9c3cfcfc-5fd1-4d50-abdf-b203cac93778" />

<u>PENJELASAN:</u>
Fungsi ini berguna untuk jika pengguna telah menambahkan catatan ikon atau menghapus pada marker, semua data tersebut di simpan di SharePreferences dalam bentuk JSON. Lalu ketika pengguna membuka kembali aplikasi tersebut secara otomatis data sebelumnya masih terseimpan, dan menampilkan sesuai akhir pengguna mengubahnya.

## TAMPILAN APLIKASI:
**- Tampilan peta**
![WhatsApp Image 2025-11-21 at 21 33 04](https://github.com/user-attachments/assets/4562258e-8c82-485e-b929-be23164d8585)

**- Menambahkan Catatan Tempat/Lokasi**
<img width="576" height="1280" alt="image" src="https://github.com/user-attachments/assets/7d7a17cf-6d7e-4404-9993-e04295071af7" />

**- Pengisian Catatan**
<img width="576" height="1280" alt="image" src="https://github.com/user-attachments/assets/15f2e365-e045-4959-a934-baf48097b808" />

**- Tampilan Catatan Yang Sudah Dibuat**
<img width="576" height="1280" alt="image" src="https://github.com/user-attachments/assets/48cc4a33-26cd-425c-b154-9fb19729a36b" />

**- Tampilan Hapus Catatan**
<img width="576" height="1280" alt="image" src="https://github.com/user-attachments/assets/1eabc09d-e25e-4115-a4dc-55972882e689" />

**- Sesudah Menghapus Catatan Bagian Ikon Kantor Spareoart**
<img width="576" height="1280" alt="image" src="https://github.com/user-attachments/assets/fcfccc7b-30cc-49ea-b416-b85b4127a13d" />

