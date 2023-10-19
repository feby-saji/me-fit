import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
part 'user_details.g.dart';

@HiveType(typeId: 2)
class UserBodyDetails {
  @HiveField(1)
  int height;
  @HiveField(2)
  int weight;
  @HiveField(3)
  int totalCaloriesBurned;
  @HiveField(4)
  int caloriesBurnedToday;
  @HiveField(5)
  int dailySteps;
  @HiveField(6)
  int totalSteps;
  @HiveField(7)
  int dailyStepsGoal;
  @HiveField(8)
  int lastSteps;
  @HiveField(9)
  int distanceToday;
  @HiveField(10)
  int distanceTotal;
  @HiveField(11)
  int userBmi;
  @HiveField(12)
  DateTime lastStepTakenDate;
  @HiveField(13)
  DateTime dateIsToday;
  @HiveField(14)
  WorkOutRecordModel? lastWorkOutRecord;

  UserBodyDetails({
    required this.height,
    required this.weight,
    required this.caloriesBurnedToday,
    required this.dailySteps,
    required this.dailyStepsGoal,
    required this.totalSteps,
    required this.totalCaloriesBurned,
    required this.distanceToday,
    required this.distanceTotal,
    required this.userBmi,
    required this.lastSteps,
    required this.lastStepTakenDate,
    required this.dateIsToday,
    this.lastWorkOutRecord,
  });
}
