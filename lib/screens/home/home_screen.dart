// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:me_fit/screens/home/functions/date_parse2.dart';
import 'package:me_fit/screens/home/functions/updateGoalCompletePerc.dart';
import 'package:me_fit/screens/home/widgets/bottom_navigation_bar.dart';
import 'package:me_fit/screens/home/widgets/calorie_info.dart';
import 'package:me_fit/screens/home/widgets/lastWorkout.dart';
import 'package:me_fit/screens/home/widgets/main_container.dart';
import 'package:me_fit/screens/home/widgets/overall_info.dart';
import 'package:me_fit/screens/home/widgets/steps_goal.dart';
import 'package:me_fit/screens/home/widgets/vertical_bar.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/widgets/profile_home_screen.dart';

import '../splash/functions/gotoscreen.dart';

ValueNotifier<int> stepsGoal = ValueNotifier(0);
ValueNotifier<double> stepsGoalCompletePer = ValueNotifier(0);
ValueNotifier<int> caloriesBurnedTotal = ValueNotifier(0);
ValueNotifier<String> lastWorkOutName = ValueNotifier('');
ValueNotifier<int> caloriesBurnedToday = ValueNotifier(0);
ValueNotifier<int> stepTodayTaken = ValueNotifier(0);

class HomeScreen extends StatefulWidget {
  int? stepsToday = 0;
  int? totalSteps = 0;
  int? distanceToday = 0;

  HomeScreen({
    super.key,
    required this.stepsToday,
    required this.totalSteps,
    required this.distanceToday,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

int currentInd = 0;
SizeConfig sizeConfig = SizeConfig();

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // start step count listener
    getPermissionActivityRecognition(context);
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.initSizeConfig(context);

    Future.delayed(const Duration(seconds: 3), () {
      updateGoalCompletePercentage();
    });
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: sizeConfig.blockSizeVertical * 5,
            left: 10,
          ),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Profile1Widget(),
              SizedBox(
                height: sizeConfig.blockSizeVertical * 77,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView(children: [
                    const MainContainerWidget(),

                    Row(
                      children: [
                        SizedBox(width: sizeConfig.blockSizeHorizontal * 20),
                        Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: stepTodayTaken,
                              builder: (context, value, child) {
                                return Text(
                                  value.abs().toString(),
                                  style: kMedText.copyWith(color: Colors.black),
                                );
                              },
                            ),
                            Text(
                              'steps',
                              style: kDmSansFont.copyWith(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const StepsGoalWidget(),
                            Text(
                              'Goal',
                              style: kDmSansFont.copyWith(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 60),
// VerticalBarIndicator
                        const VerticalProgressbar()
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'last workout',
                      style: kSmalText.copyWith(color: Colors.black),
                    ),
                    Text(
                      dateParse2(DateTime.now()),
                      style: kDmSansFont.copyWith(
                        color: Colors.grey,
                        fontSize: sizeConfig.blockSizeHorizontal * 4,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const LastWorkoutWidget(),
                    const SizedBox(height: 50),
                    const Text('overall Information'),
                    Text(
                      dateParse2(DateTime.now()),
                      style: kDmSansFont.copyWith(
                        color: Colors.grey,
                        fontSize: sizeConfig.blockSizeHorizontal * 4,
                      ),
                    ),
                    const SizedBox(height: 50),
//calories
                    const CaloriesinfoWidget(),
                    const SizedBox(height: 30),
// steps
                    StepsInfoWidget(value: widget.totalSteps.toString()),
                    const SizedBox(height: 10),
                  ]),
                ),
              ),
            ],
          )),
        ),
        bottomNavigationBar: const BottomNavigatioinBar());
  }
}
