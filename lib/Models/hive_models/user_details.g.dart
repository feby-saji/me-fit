// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBodyDetailsAdapter extends TypeAdapter<UserBodyDetails> {
  @override
  final int typeId = 2;

  @override
  UserBodyDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBodyDetails(
      height: fields[1] as int,
      weight: fields[2] as int,
      caloriesBurnedToday: fields[4] as int,
      dailySteps: fields[5] as int,
      dailyStepsGoal: fields[7] as int,
      totalSteps: fields[6] as int,
      totalCaloriesBurned: fields[3] as int,
      distanceToday: fields[9] as int,
      distanceTotal: fields[10] as int,
      userBmi: fields[11] as int,
      lastSteps: fields[8] as int,
      lastStepTakenDate: fields[12] as DateTime,
      dateIsToday: fields[13] as DateTime,
      lastWorkOutRecord: fields[14] as WorkOutRecordModel?,
    );
  }

  @override
  void write(BinaryWriter writer, UserBodyDetails obj) {
    writer
      ..writeByte(14)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.totalCaloriesBurned)
      ..writeByte(4)
      ..write(obj.caloriesBurnedToday)
      ..writeByte(5)
      ..write(obj.dailySteps)
      ..writeByte(6)
      ..write(obj.totalSteps)
      ..writeByte(7)
      ..write(obj.dailyStepsGoal)
      ..writeByte(8)
      ..write(obj.lastSteps)
      ..writeByte(9)
      ..write(obj.distanceToday)
      ..writeByte(10)
      ..write(obj.distanceTotal)
      ..writeByte(11)
      ..write(obj.userBmi)
      ..writeByte(12)
      ..write(obj.lastStepTakenDate)
      ..writeByte(13)
      ..write(obj.dateIsToday)
      ..writeByte(14)
      ..write(obj.lastWorkOutRecord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBodyDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
