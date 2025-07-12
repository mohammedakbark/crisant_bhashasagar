// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_created_at.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UiLangCreatedAtAdapter extends TypeAdapter<UiLangCreatedAt> {
  @override
  final int typeId = 1;

  @override
  UiLangCreatedAt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UiLangCreatedAt(
      date: fields[0] as String,
      timezoneType: fields[1] as int,
      timezone: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UiLangCreatedAt obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.timezoneType)
      ..writeByte(2)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiLangCreatedAtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
