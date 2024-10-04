import 'dart:async';

import 'package:me_fit/DB/hive_function.dart';

import '../home_screen.dart';

void onStepCountDebouncer(int steps) {
  Timer? debouncer;
  // If a previous timer is active, cancel it
  if (debouncer?.isActive ?? false) debouncer!.cancel();

  // Set a debouncer delay (e.g., 1 second)
  debouncer = Timer(Duration(seconds: 1), () {
    // Call the function to calculate calories and update Hive
    onStepCount(steps);
  });
}

int _totalSteps = 0;
num gUserHeightInMeters = 0;
num gUserWeight = 0;

void onStepCount(int listenerStep) async {
  HiveDb db = HiveDb();
  // Update the database with the new step count
  await db.setLastStep(listenerStep);
  await db.setTotalSteps(listenerStep);

  // Retrieve the last step count from the database
  int lastStep = await db.getLastStep();

  if (_totalSteps == 0) {
    await db.setLastStep(listenerStep);
  }

  // Fix: Ensure step count is positive
  _totalSteps = listenerStep;
  stepTodayTaken.value = (_totalSteps - lastStep).abs();
  stepTodayTaken.notifyListeners();

  // Debug print for step count
  print('stepTodayTaken: $_totalSteps - $lastStep = ${stepTodayTaken.value}');

  if (gUserHeightInMeters == 0) {
    int height = await HiveDb().getUserHeight();
    gUserHeightInMeters = cmToMeter(height);
  }

  if (gUserWeight == 0) {
    gUserWeight = await HiveDb().getUserWeight();
  }

  // Calculate stride length and distance
  num stride = gUserHeightInMeters * 0.414;
  num distance = stride * stepTodayTaken.value;

  // Debug print for distance
  print('Stride: $stride, Distance: $distance');

  // Calculate time and calories burned
  num time = distance / 3; // Assuming average walking speed (3 m/s)
  double MET = 3.5;

  // Debug print for time and user weight
  print('Time: $time, User weight: $gUserWeight');
  print('gUserHeightInMeters value is : $gUserHeightInMeters');

  caloriesBurnedToday.value =
      (time * MET * 3.5 * gUserWeight / (200 * 60)).round();
  caloriesBurnedToday.notifyListeners();

  await db.setCaloriesBurnedToday(caloriesBurnedToday.value);
  print('caloriesBurnedToday = ${caloriesBurnedToday.value}');
}

double cmToMeter(int cm) {
  return cm / 100;
}
