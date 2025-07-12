// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_instruction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UiInstructionModelAdapter extends TypeAdapter<UiInstructionModel> {
  @override
  final int typeId = 0;

  @override
  UiInstructionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UiInstructionModel(
      instructionId: fields[0] as String,
      uiLanguageId: fields[1] as String,
      page: fields[2] as String,
      placeholderId: fields[3] as String,
      uiText: fields[4] as String,
      createdBy: fields[5] as String,
      createdAt: fields[6] as UiLangCreatedAt,
      modifiedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UiInstructionModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.instructionId)
      ..writeByte(1)
      ..write(obj.uiLanguageId)
      ..writeByte(2)
      ..write(obj.page)
      ..writeByte(3)
      ..write(obj.placeholderId)
      ..writeByte(4)
      ..write(obj.uiText)
      ..writeByte(5)
      ..write(obj.createdBy)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.modifiedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiInstructionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
