// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOutRecordModelAdapter extends TypeAdapter<WorkOutRecordModel> {
  @override
  final int typeId = 3;

  @override
  WorkOutRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOutRecordModel(
      id: fields[7] as int,
      dateTime: fields[3] as DateTime,
      iconPath: fields[1] as String,
      workoutName: fields[2] as String,
      setCount: fields[5] as int,
      caloriesBurned: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOutRecordModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.iconPath)
      ..writeByte(2)
      ..write(obj.workoutName)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.setCount)
      ..writeByte(6)
      ..write(obj.caloriesBurned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOutRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
