// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Expanses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpansesAdapter extends TypeAdapter<Expanses> {
  @override
  final int typeId = 0;

  @override
  Expanses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expanses(
      title: fields[0] as String,
      amount: fields[1] as int,
      category: fields[2] as Category?,
    );
  }

  @override
  void write(BinaryWriter writer, Expanses obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpansesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
