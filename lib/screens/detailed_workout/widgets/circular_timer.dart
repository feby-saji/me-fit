// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
import 'package:me_fit/screens/detailed_workout/detailed_workouts.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

class CircularCountDownTimerWidget extends StatefulWidget {
  WorkOutRecordModel model;

  CircularCountDownTimerWidget({super.key, required this.model});

  @override
  State<CircularCountDownTimerWidget> createState() =>
      _CircularCountDownTimerWidgetState();
}

class _CircularCountDownTimerWidgetState
    extends State<CircularCountDownTimerWidget> {
  List<int> workoutTimeList1 = [3, 10, 5, 10, 5, 10];

  int listInd = 0;
  bool onCompleteCalled = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: NeonCircularTimer(
        width: 200,
        duration: workoutTimeList1[listInd],
        controller: timerController,
        isTimerTextShown: true,
        isReverse: true,
        neumorphicEffect: true,
        innerFillGradient: LinearGradient(
          colors: [Colors.greenAccent.shade200, Colors.blueAccent.shade400],
        ),
        neonGradient: LinearGradient(
          colors: [Colors.greenAccent.shade200, Colors.blueAccent.shade400],
        ),
        onStart: () {
          if (workoutTimeList1[listInd] == 5) {
            status.value = 'REST';
            status.notifyListeners();
          } else if (workoutTimeList1[listInd] == 10) {
            status.value = 'Go';
            status.notifyListeners();
          } else if (workoutTimeList1[listInd] == 3) {
            status.value = 'Ready';
            status.notifyListeners();
          }
        },
        onComplete: () async {
          if (workoutTimeList1[listInd] == 10) {
            lastWorkOutName.value = widget.model.workoutName;
            HiveDb hiveDb = HiveDb();
          
            await hiveDb.setWorkoutRecord(widget.model);
            await hiveDb.setLastWorkout(widget.model);
          }
          if (listInd < workoutTimeList1.length - 1) {
            if (onCompleteCalled == false) {
              await controllerOnComplted();
            }
          } else {
            pageController.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.bounceIn);
          }
        },
      ),
    );
  }

  controllerOnComplted() async {
    onCompleteCalled = true;

    listInd++;
    timerController.restart(duration: workoutTimeList1[listInd]);
    onCompleteCalled = false;
  }
}