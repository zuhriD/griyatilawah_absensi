class Jadwal {
  int id;
  int imamId;
  String namaImam;
  String namaMasjid;
  String latitudeMasjid;
  String longitudeMasjid;
  String namaAktivitas;
  String date;
  String keterangan;
  String bukti;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Jadwal({
    required this.id,
    required this.imamId,
    required this.namaImam,
    required this.namaMasjid,
    required this.latitudeMasjid,
    required this.longitudeMasjid,
    required this.namaAktivitas,
    required this.date,
    required this.keterangan,
    required this.bukti,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      imamId: json['imam_id'],
      namaImam: json['nama_imam'],
      namaMasjid: json['nama_masjid'],
      latitudeMasjid: json['latitude_masjid'],
      longitudeMasjid: json['longitude_masjid'],
      namaAktivitas: json['nama_aktivitas'],
      date: json['date'],
      keterangan: json['keterangan'],
      bukti: json['bukti'],
      status: json['status'],
      createdAt: DateTime.parse(json['timestamps']['created_at']),
      updatedAt: DateTime.parse(json['timestamps']['updated_at']),
    );
  }
}
