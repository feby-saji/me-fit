import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home_screen.dart';
import 'package:me_fit/styles/styles.dart';

class DailyStepsInputPage extends StatefulWidget {
  bool goToHome;
  DailyStepsInputPage({super.key, required this.goToHome});

  @override
  _DailyStepsInputPageState createState() => _DailyStepsInputPageState();
}

class _DailyStepsInputPageState extends State<DailyStepsInputPage> {
  final TextEditingController _stepsController = TextEditingController();
  double _dailyDistance = 0;
  int steptoAddToCtrl = 0;

  double stepsToKm(int steps) {
    const double averageStrideLength = 0.762; // meters

    double distanceInMeters = steps * averageStrideLength;
    double distanceInKm = distanceInMeters / 1000;

    return distanceInKm;
  }

  void calcDailySteps() async {
    int dailySteps = int.parse(_stepsController.text.trim());
    setState(() {
      _dailyDistance = stepsToKm(int.parse(_stepsController.text.trim()));
    });
  }

  setDailySteps() async {
    int dailySteps = int.parse(_stepsController.text.trim());
    await HiveDb().setDailyStepsGoalDb(dailySteps);
  }

  @override
  void initState() {
    super.initState();
    _stepsController.text = 0.toString();
  }

  @override
  Widget build(BuildContext context) {
    _stepsController.addListener(() async {
      steptoAddToCtrl = int.parse(_stepsController.text);
      calcDailySteps();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Steps '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your daily steps goal:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _stepsController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
//choice chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      steptoAddToCtrl = int.parse(_stepsController.text);
                      steptoAddToCtrl += 1000;
                      _stepsController.text = steptoAddToCtrl.toString();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text('+ 1,000'),
                      ),
                    ),
                  ),
// 2

                  GestureDetector(
                    onTap: () {
                      steptoAddToCtrl = int.parse(_stepsController.text);
                      steptoAddToCtrl += 5000;
                      _stepsController.text = steptoAddToCtrl.toString();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text('+ 5,000'),
                      ),
                    ),
                  ),
// 3
                  GestureDetector(
                    onTap: () {
                      steptoAddToCtrl = int.parse(_stepsController.text);
                      steptoAddToCtrl += 10000;
                      _stepsController.text = steptoAddToCtrl.toString();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text('+ 10,000'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
//button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await setDailySteps();
                    Box<UserBodyDetails> box =
                        await Hive.openBox<UserBodyDetails>(
                            'userBodyDetailsBox');
                    UserBodyDetails? user = box.get('userbodydetails');
// notify listeners

                    caloriesBurnedTotal.value = user!.totalCaloriesBurned;
                    caloriesBurnedTotal.notifyListeners();
                    caloriesBurnedToday.value = user.caloriesBurnedToday;
                    caloriesBurnedTotal.notifyListeners();
                   

                    print('printing stepsGoal.value ${stepsGoal.value}');
                    await HomeScreenState().updateGoalCompletePerc();

                    if (widget.goToHome) {
                      Get.offAll(HomeScreen(
                        stepsToday: user.dailySteps,
                        totalSteps: user.totalSteps,
                        distanceToday: user.distanceToday,
                      ));
                    } else {
                      Get.back();
                    }
                  },
                  child: const Text('Set Daily Steps'),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Daily distance is ${_dailyDistance.toString()} km',
                style: kMedText.copyWith(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
