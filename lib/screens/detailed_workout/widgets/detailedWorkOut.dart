import 'package:flutter/material.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
import 'package:me_fit/screens/detailed_workout/detailed_workouts.dart';
import 'package:me_fit/screens/detailed_workout/widgets/WorkoutGif.dart';
import 'package:me_fit/screens/detailed_workout/widgets/circular_timer.dart';
import 'package:me_fit/screens/detailed_workout/widgets/instructions_container.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/widgets/workout_detail_tile.dart';

class DetailedWorkoutScreenWidget extends StatefulWidget {
  final String name;
  final String bodyPart;
  final String gifUrl;
  final String target;
  final String instructions;
  const DetailedWorkoutScreenWidget({
    super.key,
    required this.name,
    required this.bodyPart,
    required this.gifUrl,
    required this.target,
    required this.instructions,
  });

  @override
  State<DetailedWorkoutScreenWidget> createState() =>
      DetailedWorkoutScreenState();
}

int splitIntInHalfDigits(int intToSplit) {
  String intAsString = intToSplit.toString();
  int splitInt = int.parse(intAsString.substring(intAsString.length ~/ 2));
  return splitInt;
}

class DetailedWorkoutScreenState extends State<DetailedWorkoutScreenWidget> {
  @override
  void initState() {
    super.initState();
    modelID = splitIntInHalfDigits(DateTime.now().millisecondsSinceEpoch);
  }

  @override
  void dispose() {
    super.dispose();
    workOutSet = 1;
  }

  @override
  Widget build(BuildContext context) {
    WorkOutRecordModel model = WorkOutRecordModel(
        id: modelID,
        dateTime: DateTime.now(),
        iconPath: 'assets/images/dumbbell.jpg',
        workoutName: widget.name,
        setCount: workOutSet,
        caloriesBurned: caloriesBurned);
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          WorkoutGif(url: widget.gifUrl),
          WorkoutDetailTile(text: widget.name, title: 'workout :'),
          WorkoutDetailTile(text: widget.bodyPart, title: 'Body part :'),
          WorkoutDetailTile(text: widget.target, title: 'Target :'),
          Text(
            'Instructions : ',
            style: kSmalText.copyWith(color: Colors.black),
          ),
          InstructionsContainer(instructions: widget.instructions),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (isPlaying == true) {
                            timerController.pause();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            timerController.resume();
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        },
                        icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow)),
                    CircularCountDownTimerWidget(model: model),
                    ValueListenableBuilder(
                        valueListenable: status,
                        builder: (BuildContext context, String value, _) {
                          return Text(value);
                        }),
                  ]))
        ]));
  }
}
