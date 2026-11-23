
import '../models/profile.dart';

Profile createStudentProfile(String email) {
  return Profile(
    nama: 'Rizki Riana Putra',
    nim: '1124160241',
    prodi: 'Teknik Informatika Software Engineering',
    kelas: 'TI24SESHIFT',
    email: email,
    noHp: '081283561060',
    github: 'RiyutaDev',
    bio:
        'Mahasiswa yang tertarik pada teknologi dan pengembangan aplikasi berbasis web.',
  );
}
