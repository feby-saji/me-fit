import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/goals/choice_chip.dart';
import 'package:me_fit/screens/home/functions/updateGoalCompletePerc.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/styles/styles.dart';

class DailyStepsInputPage extends StatefulWidget {
  final bool goToHome;

  DailyStepsInputPage({super.key, required this.goToHome});

  @override
  DailyStepsInputPageState createState() => DailyStepsInputPageState();
}

class DailyStepsInputPageState extends State<DailyStepsInputPage> {
  final TextEditingController _stepsController = TextEditingController();
  double _dailyDistance = 0;
  int steptoAddToCtrl = 0;

  @override
  void initState() {
    super.initState();
    _stepsController.text = '0';
    _stepsController.addListener(_updateDailyDistance);
  }

  @override
  void dispose() {
    _stepsController.removeListener(_updateDailyDistance);
    _stepsController.dispose();
    super.dispose();
  }

  void _updateDailyDistance() {
    final stepsText = _stepsController.text.trim();
    if (stepsText.isNotEmpty) {
      steptoAddToCtrl = int.tryParse(stepsText) ?? 0;
      setState(() {
        _dailyDistance = stepsToKm(steptoAddToCtrl);
      });
    }
  }

  double stepsToKm(int steps) {
    const double averageStrideLength = 0.762; // meters
    double distanceInMeters = steps * averageStrideLength;
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }

  Future<void> setDailySteps() async {
    int dailySteps = int.parse(_stepsController.text.trim());
    await HiveDb().setDailyStepsGoalDb(dailySteps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Steps'),
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
              // Choice chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChipWidget(
                    function: () {
                      int currentSteps =
                          int.tryParse(_stepsController.text) ?? 0;
                      _stepsController.text = (currentSteps + 1000).toString();
                    },
                    value: '1000',
                  ),
                  ChoiceChipWidget(
                    function: () {
                      int currentSteps =
                          int.tryParse(_stepsController.text) ?? 0;
                      _stepsController.text = (currentSteps + 5000).toString();
                    },
                    value: '5,000',
                  ),
                  ChoiceChipWidget(
                    function: () {
                      int currentSteps =
                          int.tryParse(_stepsController.text) ?? 0;
                      _stepsController.text = (currentSteps + 10000).toString();
                    },
                    value: '10,000',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (steptoAddToCtrl > 0) {
                      await setDailySteps();
                      Box<UserBodyDetails> box =
                          await Hive.openBox<UserBodyDetails>(
                              'userBodyDetailsBox');
                      UserBodyDetails? user = box.get('userbodydetails');

                      // Notify listeners
                      caloriesBurnedTotal.value = user!.totalCaloriesBurned;
                      caloriesBurnedTotal.notifyListeners();
                      caloriesBurnedToday.value = user.caloriesBurnedToday;
                      caloriesBurnedToday.notifyListeners();

                      await updateGoalCompletePercentage();

                      if (widget.goToHome) {
                        Get.offAll(HomeScreen(
                          stepsToday: user?.dailySteps ?? 0,
                          distanceToday: user?.distanceToday ?? 0,
                          totalSteps: user?.totalSteps ?? 0,
                        ));
                      } else {
                        Get.back();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid goal'),
                        ),
                      );
                    }
                  },
                  child: const Text('Set Daily Steps'),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Daily distance is ${_dailyDistance.toStringAsFixed(2)} km',
                style: kMedText.copyWith(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
