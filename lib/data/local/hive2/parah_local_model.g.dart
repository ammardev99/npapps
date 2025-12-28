// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parah_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParahLocalModelAdapter extends TypeAdapter<ParahLocalModel> {
  @override
  final int typeId = 1;

  @override
  ParahLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParahLocalModel(
      id: fields[0] as String,
      title: fields[1] as String,
      arabicName: fields[2] as String,
      typeArea: fields[3] as String,
      parahNo: fields[4] as int,
      pageCount: fields[5] as int,
      ayatCount: fields[6] as int,
      filePath: fields[7] as String,
      downloadDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ParahLocalModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.arabicName)
      ..writeByte(3)
      ..write(obj.typeArea)
      ..writeByte(4)
      ..write(obj.parahNo)
      ..writeByte(5)
      ..write(obj.pageCount)
      ..writeByte(6)
      ..write(obj.ayatCount)
      ..writeByte(7)
      ..write(obj.filePath)
      ..writeByte(8)
      ..write(obj.downloadDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParahLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
