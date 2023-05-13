import 'package:hive_flutter/hive_flutter.dart';
part 'Absensi.g.dart';

@HiveType(typeId: 0)
class Absensi {
  @HiveField(0)
  String nama;

  @HiveField(1)
  String masjid;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String sholat;

  @HiveField(4)
  String keterangan;

  @HiveField(5)
  String lokasi;

  @HiveField(6)
  String status;

  Absensi(
      {required this.nama,
      required this.masjid,
      required this.date,
      required this.sholat,
      required this.keterangan,
      required this.lokasi,
      required this.status});
}
