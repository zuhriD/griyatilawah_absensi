// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Absensi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbsensiAdapter extends TypeAdapter<Absensi> {
  @override
  final int typeId = 0;

  @override
  Absensi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Absensi(
      nama: fields[0] as String,
      masjid: fields[1] as String,
      date: fields[2] as DateTime,
      sholat: fields[3] as String,
      keterangan: fields[4] as String,
      lokasi: fields[5] as String,
      status: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Absensi obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nama)
      ..writeByte(1)
      ..write(obj.masjid)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.sholat)
      ..writeByte(4)
      ..write(obj.keterangan)
      ..writeByte(5)
      ..write(obj.lokasi)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbsensiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
