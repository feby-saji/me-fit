import 'package:hive_flutter/hive_flutter.dart';
part 'workout_record.g.dart';

@HiveType(typeId: 3)
class WorkOutRecordModel {
  @HiveField(7)
  int id;
  @HiveField(1)
  String iconPath;
  @HiveField(2)
  String workoutName;
  @HiveField(3)
  DateTime dateTime;
  @HiveField(5)
  int setCount;
  @HiveField(6)
  int caloriesBurned;

  WorkOutRecordModel({
    required this.id,
    required this.dateTime,
    required this.iconPath,
    required this.workoutName,
    required this.setCount,
    required this.caloriesBurned,
  });
}

