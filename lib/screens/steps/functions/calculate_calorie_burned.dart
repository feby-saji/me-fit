import 'package:hive/hive.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home/home_screen.dart';

calculateCalorieBurned() async {
  Box<UserBodyDetails> box = await Hive.openBox('userBodyDetailsBox');
  UserBodyDetails? user = box.get('userbodydetails');

  num heightInM = user!.height / 100;
  num weight = user.weight;
  int totalSteps = user.totalSteps;

  // Calculate stride length and distance
  num stride = heightInM * 0.414;
  num distance = stride * totalSteps;

  // Calculate time and calories burned
  num time = distance / 3;
  double MET = 3.5;

  caloriesBurnedTotal.value = (time * MET * 3.5 * weight / (200 * 60)).round();
  caloriesBurnedTotal.notifyListeners();
}
