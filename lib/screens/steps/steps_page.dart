import 'package:flutter/material.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/steps/widgets/closeBtn.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:lottie/lottie.dart';

HiveDb db = HiveDb();
late bool activityRecognitionGranded;

int _totalSteps = 0;
int gUserWeight = 0;
num gUserHeightInMeters = 0;

class StepsTrackerScreen extends StatefulWidget {
  final int userWeight;
  final num userHeightInMeters;
  const StepsTrackerScreen(
      {super.key, required this.userWeight, required this.userHeightInMeters});

  @override
  State<StepsTrackerScreen> createState() => StepsTrackerScreenState();
}

class StepsTrackerScreenState extends State<StepsTrackerScreen> {
  @override
  void initState() {
    super.initState();
    gUserHeightInMeters = widget.userHeightInMeters;
    gUserWeight = widget.userWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Steps tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child:
                  Lottie.asset('assets/lottie/Animation - 1695630496886.json'),
            ),
            const SizedBox(height: 50),
            Text(
              'Steps Taken today',
              style: kMedText.copyWith(color: Colors.black),
            ),
            ValueListenableBuilder(
              valueListenable: stepTodayTaken,
              builder: (context, value, child) {
                return Text(
                  stepTodayTaken.value.abs().toString(),
                  style: const TextStyle(fontSize: 30),
                );
              },
            ),
            const Divider(
              height: 10,
              thickness: 0,
              color: Colors.white,
            ),
            ValueListenableBuilder(
              valueListenable: caloriesBurnedToday,
              builder: (context, value, child) {
                return Text(
                    'calories burned : ${caloriesBurnedToday.value.abs().round().toString()}');
              },
            ),
            const Spacer(),
            CloseBtnWidget(db: db),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void onStepCount(int listenerStep) async {
  // Update the database with the new step count
  await db.setLastStep(listenerStep);
  await db.setTotalSteps(listenerStep);

  // Retrieve the last step count from the database
  int lastStep = await db.getLastStep();

  if (_totalSteps == 0) {
    await db.setLastStep(listenerStep);

    // setstate
    stepTodayTaken.value = lastStep - _totalSteps;
    stepTodayTaken.notifyListeners();
  }

  _totalSteps = listenerStep;
  stepTodayTaken.value = lastStep - _totalSteps;
  stepTodayTaken.notifyListeners();

  // Log the step calculations
  print('lastStep - _totalSteps = stepTodayTaken');
  // print('$lastStep - $_totalSteps = ${stepTodayTaken.value}');

  // Calculate stride length and distance
  num stride = gUserHeightInMeters * 0.414;
  num distance = stride * stepTodayTaken.value;

  // Calculate time and calories burned
  num time = distance / 3;
  double MET = 3.5;

  caloriesBurnedToday.value =
      (time * MET * 3.5 * gUserWeight / (200 * 60)).round();
  caloriesBurnedToday.notifyListeners();
  await db.setCaloriesBurnedToday(caloriesBurnedToday.value);
}


