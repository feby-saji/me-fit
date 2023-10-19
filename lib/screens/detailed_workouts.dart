import 'package:flutter/material.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
import 'package:me_fit/Models/workout_model.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/home_screen.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:me_fit/widgets/workout_detail_tile.dart';

ValueNotifier<String> status = ValueNotifier('REST');
final CountDownController _controller = CountDownController();
bool _isPlaying = true;
late int _modelID;
int _workOutSet = 1;
int _caloriesBurned = 4;

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
        return DetailedWorkoutScreen(
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

class DetailedWorkoutScreen extends StatefulWidget {
  final String name;
  final String bodyPart;
  final String gifUrl;
  final String target;
  final String instructions;
  const DetailedWorkoutScreen({
    super.key,
    required this.name,
    required this.bodyPart,
    required this.gifUrl,
    required this.target,
    required this.instructions,
  });

  @override
  State<DetailedWorkoutScreen> createState() => DetailedWorkoutScreenState();
}

int splitIntInHalfDigits(int intToSplit) {
  String intAsString = intToSplit.toString();
  int splitInt = int.parse(intAsString.substring(intAsString.length ~/ 2));
  return splitInt;
}

class DetailedWorkoutScreenState extends State<DetailedWorkoutScreen> {
  @override
  void initState() {
    super.initState();
    _modelID = splitIntInHalfDigits(DateTime.now().millisecondsSinceEpoch);
    print('priting this models id $_modelID');
  }

  @override
  void dispose() {
    super.dispose();
    _workOutSet = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              widget.gifUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
//
          WorkoutDetailTile(
            text: widget.name,
            title: 'workout :',
          ),
//
          WorkoutDetailTile(
            text: widget.bodyPart,
            title: 'Body part :',
          ),
//
          WorkoutDetailTile(
            text: widget.target,
            title: 'Target :',
          ),
//
          Text(
            'Instructions: ',
            style: kSmalText.copyWith(color: Colors.black),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Text(
                widget.instructions,
                style: const TextStyle(color: Colors.white),
              )),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      if (_isPlaying == true) {
                        _controller.pause();
                        setState(() {
                          _isPlaying = false;
                        });
                      } else {
                        _controller.resume();
                        setState(() {
                          _isPlaying = true;
                        });
                      }
                    },
                    icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow)),
                CircularCountDownTimerWidget(name: widget.name),
                ValueListenableBuilder(
                    valueListenable: status,
                    builder: (BuildContext context, String value, _) {
                      return Text(value);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularCountDownTimerWidget extends StatefulWidget {
  String name;
  CircularCountDownTimerWidget({super.key, required this.name});

  @override
  State<CircularCountDownTimerWidget> createState() =>
      _CircularCountDownTimerWidgetState();
}

class _CircularCountDownTimerWidgetState
    extends State<CircularCountDownTimerWidget> {
  List<int> workoutTimeList1 = [3, 10, 5, 10, 5, 10];
  //                            0  1  2   3   4   5

  int listInd = 0;
  bool onCompleteCalled = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: NeonCircularTimer(
        width: 200,
        duration: workoutTimeList1[listInd],
        controller: _controller,
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
            lastWorkOutName.value = widget.name;
            HiveDb hiveDb = HiveDb();
            WorkOutRecordModel model = WorkOutRecordModel(
              id: _modelID,
              dateTime: DateTime.now(),
              iconPath: 'assets/images/dumbbell.jpg',
              workoutName: widget.name,
              setCount: _workOutSet,
              caloriesBurned: _caloriesBurned,
            );
            await hiveDb.setWorkoutRecord(model);
            await hiveDb.setLastWorkout(model);
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
    _controller.restart(duration: workoutTimeList1[listInd]);
    onCompleteCalled = false;
  }
}
