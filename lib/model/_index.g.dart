// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_index.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultAdapterAdapter extends TypeAdapter<ResultAdapter> {
  @override
  final int typeId = 0;

  @override
  ResultAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultAdapter(
      confidence: fields[0] as double?,
      label: fields[1] as String?,
      date: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultAdapter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.confidence)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
