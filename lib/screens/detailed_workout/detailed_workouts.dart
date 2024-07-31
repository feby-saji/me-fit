// ignore_for_file: must_be_immutable
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:me_fit/Models/workout_model.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/detailed_workout/widgets/detailedWorkOut.dart';


ValueNotifier<String> status = ValueNotifier('REST');
  final CountDownController timerController = CountDownController();
bool isPlaying = true;
late int modelID;
int workOutSet = 1;
int caloriesBurned = 4;

late PageController pageController;
int pageInd = 0;

// Page view
class DetailedWorkoutScreenStatePageView extends StatefulWidget {
  int initialPage = 0;
  DetailedWorkoutScreenStatePageView({super.key, required this.initialPage});

  @override
  State<DetailedWorkoutScreenStatePageView> createState() =>
      _DetailedWorkoutScreenStatePageViewState();
}

class _DetailedWorkoutScreenStatePageViewState
    extends State<DetailedWorkoutScreenStatePageView> {
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: pageController,
      onPageChanged: (ind) {
        if (mounted) {
          setState(() {
            pageInd = ind;
          });
        }
      },
      itemCount: allBodyPartWorkouts.length,
      itemBuilder: (context, ind) {
        WorkoutModel data = allBodyPartWorkouts[ind];
        return DetailedWorkoutScreenWidget(
          name: data.name,
          bodyPart: data.bodyPart,
          gifUrl: data.gifUrl,
          target: data.target,
          instructions: data.instructions,
        );
      },
    ));
  }
}
