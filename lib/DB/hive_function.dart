import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
import 'package:me_fit/screens/home/home_screen.dart';

class HiveDb {
  //boxes
  String userBox = 'userBox';
  String userBodyDetailsBoxKey = 'userBodyDetailsBox';
  String usertRecordsKey = 'userWorkOutRecords';
  String userProfileDetailsKey = 'userProfileDetails';
  late Box<UserBodyDetails> userBodyDetailsBox;
  late Box<WorkOutRecordModel> userWorkOutRecords;

// STEPS
  setDailyStepsDb(dailySteps) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.dailySteps = dailySteps;
    await userBodyDetailsBox.put('userbodydetails', user);
  }

  setDailyStepsGoalDb(dailyStepsGoal) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.dailyStepsGoal = dailyStepsGoal;
    await userBodyDetailsBox.put('userbodydetails', user);

    stepsGoal.value = user.dailyStepsGoal;
    stepsGoal.notifyListeners();
  }

  Future<int> getDailyStepsGoalDb() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    return user!.dailyStepsGoal;
  }

  Future<int> getDailyStepsDb() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    return user!.dailySteps;
  }

// BMI
  setUserBmiDb(bmi) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.userBmi = bmi;
    await userBodyDetailsBox.put('userbodydetails', user);
  }

  Future<int> getUserBmiDb() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    return user!.userBmi;
  }

//CALORIES
  setCaloriesBurnedToday(int calorieBurnedToday) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    DateTime today = DateTime.now();

    if (DateUtils.isSameDay(user!.dateIsToday, today)) {
      user.caloriesBurnedToday =
          user.caloriesBurnedToday + calorieBurnedToday.abs();
      await userBodyDetailsBox.put('userbodydetails', user);
    } else {
      user.dateIsToday = today;
      user.caloriesBurnedToday = calorieBurnedToday.abs();
      await userBodyDetailsBox.put('userbodydetails', user);
    }

    caloriesBurnedToday.value = user.caloriesBurnedToday;
    caloriesBurnedToday.notifyListeners();
    print(
        'printng calories burned today notifier ${caloriesBurnedToday.value}');
  }

  setCaloriesBurnedTotal(int calBurnedToday) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.totalCaloriesBurned = user.totalCaloriesBurned + calBurnedToday.abs();
    await userBodyDetailsBox.put('userbodydetails', user);

    caloriesBurnedTotal.value = user.totalCaloriesBurned;
    caloriesBurnedTotal.notifyListeners();
    print('printng user.totalCaloriesBurned  ${user.totalCaloriesBurned}');
  }

  getCaloriesBurnedTotal() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    caloriesBurnedTotal.value = user!.totalCaloriesBurned;
    caloriesBurnedTotal.notifyListeners();
    print(
        'printng calories burned total notifier ${caloriesBurnedTotal.value}');
  }

  getCaloriesBurnedToday() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    caloriesBurnedToday.value = user!.caloriesBurnedToday;
    caloriesBurnedToday.notifyListeners();
  }

  getDailyStepsGoal() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    stepsGoal.value = user!.dailyStepsGoal;
    stepsGoal.notifyListeners();
  }

// step tracking
  setTodaySteps(lastStep) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.dailySteps = lastStep;
    await userBodyDetailsBox.put('userbodydetails', user);
  }

  Future<void> setLastStep(int lastStep) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    if (user == null) {
      print('No user data found in the box.');
      return;
    }
    // Get the last step date and current date
    DateTime lastDate = user.lastStepTakenDate;
    DateTime todayDate = DateTime.now();

    if (DateUtils.isSameDay(lastDate, todayDate)) {
      // Dates are the same; no update needed
      print('//setLastStep: Dates are the same. No update needed.');
      print('Last step date: $lastDate');
      print('Today\'s date: $todayDate');
    } else {
      // Dates are different; update required
      print('//setLastStep: Dates are different. Updating the date.');
      print('Last step date: $lastDate');
      print('Today\'s date: $todayDate');

      // Update user details
      user.lastSteps = lastStep;
      user.lastStepTakenDate = DateTime.now();

      // Save updated user data
      await userBodyDetailsBox.put('userbodydetails', user);
    }
    // Log the last step parameter and the updated last step
    print('setLastStep function: Last step parameter passed: $lastStep');
    print('setLastStep function: User\'s last step is: ${user.lastSteps}');
  }

  setTotalSteps(totalSteps) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.totalSteps = totalSteps;
    // print('setTotalSteps func in db  ${user.totalSteps}');
    // print('setTotalSteps func in totalSteps  $totalSteps');

    await userBodyDetailsBox.put('userbodydetails', user);
  }

  setHeightAndWeight(int height, int weight) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.height = height;
    user.weight = weight;
    await userBodyDetailsBox.put('userbodydetails', user);
  }

  getTodaySteps(lastStep) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    return user!.dailySteps;
  }

  Future<int> getLastStep() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    // print('printing from getLastStep ${user!.lastSteps}');
    return user!.lastSteps;
  }

  Future<int> getTotalStep() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    // print('printing from getLastStep ${user!.lastSteps}');
    return user!.totalSteps;
  }

  // distance
  setTodayDistance(lastStep) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.distanceToday = lastStep;
    await userBodyDetailsBox.put('userbodydetails', user);
  }

  getTodayDistance(lastStep) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');
    return user!.distanceToday;
  }

// reset daily values functions
// these function gets called on splash screen if authenticated
  resetDailySteps() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    DateTime lastDate = user!.lastStepTakenDate;
    DateTime todayDate = DateTime.now();

    if (!DateUtils.isSameDay(lastDate, todayDate)) {
      user.dailySteps = 0;
      user.dateIsToday = DateTime.now();
      await userBodyDetailsBox.put('userbodydetails', user);
    }
  }

// workout records
  setLastWorkout(WorkOutRecordModel model) async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    user!.lastWorkOutRecord = model;
    print('seeting lasr workout ${user.lastWorkOutRecord!.workoutName}');
  }

  setWorkoutRecord(WorkOutRecordModel model) async {
    print('setWorkoutRecord model id is ${model.id}');
    userWorkOutRecords = await Hive.openBox('userWorkOutRecords');
    WorkOutRecordModel? workOutModel = userWorkOutRecords.get(model.id);

    if (workOutModel != null) {
      print('setWorkoutRecord updating the record');
      workOutModel.caloriesBurned = workOutModel.caloriesBurned + 4;
      workOutModel.dateTime = model.dateTime;
      workOutModel.iconPath = model.iconPath;
      workOutModel.setCount = workOutModel.setCount + 1;
      workOutModel.workoutName = model.workoutName;

      await userWorkOutRecords.put(
        model.id,
        workOutModel,
      );
    } else if (workOutModel == null) {
      print('setWorkoutRecord creating new record');
      await userWorkOutRecords.put(model.id, model);
    }
    await setCaloriesBurnedToday(4);
    await setCaloriesBurnedTotal(4);
  }

  Future<List<WorkOutRecordModel>> getAllWorkOutRecords() async {
    userWorkOutRecords =
        await Hive.openBox<WorkOutRecordModel>('userWorkOutRecords');
    return userWorkOutRecords.values.toList();
  }

  void getLastWorkout() async {
    userBodyDetailsBox = await Hive.openBox('userBodyDetailsBox');
    UserBodyDetails? user = userBodyDetailsBox.get('userbodydetails');

    lastWorkOutName.value = user!.lastWorkOutRecord?.workoutName ?? '';
    // return user.lastWorkOutRecord?.workoutName;
  }
}
