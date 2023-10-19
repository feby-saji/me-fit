import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/goals_page.dart';
import 'package:me_fit/screens/set_weight_height_screen.dart';
import 'package:me_fit/screens/steps_page.dart';
import 'package:me_fit/screens/workout_screen.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/widgets/profile_home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

ValueNotifier<int> stepsGoal = ValueNotifier(0);
ValueNotifier<double> stepsGoalCompletePer = ValueNotifier(0);
ValueNotifier<int> caloriesBurnedTotal = ValueNotifier(0);
ValueNotifier<int> caloriesBurnedToday = ValueNotifier(0);
ValueNotifier<String> lastWorkOutName = ValueNotifier('');

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
  Widget build(BuildContext context) {
    sizeConfig.initSizeConfig(context);
    Future.delayed(const Duration(seconds: 3), () {
      updateGoalCompletePerc();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/rectangle.png',
                          height: 350,
                          fit: BoxFit.contain,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/mask_grp.png',
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                            top: 100,
                            left: 10,
                            child: ValueListenableBuilder(
                              valueListenable: caloriesBurnedToday,
                              builder: (context, value, child) {
                                return Text(
                                  '${value.toString()} Kcal',
                                  style: kbigText.copyWith(
                                      fontWeight: FontWeight.w400),
                                );
                              },
                            )),
                        Positioned(
                            top: 160,
                            left: 15,
                            child: Text(
                              dateParse(DateTime.now()),
                              style: kDmSansFont.copyWith(fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: sizeConfig.blockSizeHorizontal * 20),
                      Column(
                        children: [
                          Text(
                            widget.stepsToday.toString(),
                            style: kMedText.copyWith(color: Colors.black),
                          ),
                          Text(
                            'steps',
                            style: kDmSansFont.copyWith(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 30),
                          stepsGoal.value == 0
                              ? ElevatedButton(
                                  onPressed: () =>
                                      Get.to(() => DailyStepsInputPage(
                                            goToHome: true,
                                          )),
                                  child: const Text('set daily goal'))
                              : stepsGoal.value != 0
                                  ? ValueListenableBuilder(
                                      valueListenable: stepsGoal,
                                      builder: (context, value, child) {
                                        return Text(
                                          value.toString(),
                                          style: kMedText.copyWith(
                                              color: Colors.black),
                                        );
                                      },
                                    )
                                  : Text(
                                      '0',
                                      style: kMedText.copyWith(
                                          color: Colors.black),
                                    ),
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
                      ValueListenableBuilder(
                          valueListenable: stepsGoalCompletePer,
                          builder: (context, value, child) {
                            print('printing the goal notifier value $value');
                            return SizedBox(
                              width: 35,
                              height: 150,
                              child: FAProgressBar(
                                animatedDuration: const Duration(seconds: 1),
                                // changeColorValue: value.round(),
                                backgroundColor:
                                    const Color.fromARGB(255, 224, 220, 220),
                                maxValue: 100,
                                currentValue: value,
                                displayText: '%',
                                direction: Axis.vertical,
                                verticalDirection: VerticalDirection.up,
                              ),
                            );
                          })
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => Get.to(() => const WorkOutScreen()),
                      child: Container(
                          height: 140,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 254, 219, 231),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 50),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.pink,
                                  ),
                                  child: Image.asset(
                                    'assets/images/bolt_FILL0_wght400_GRAD0_opsz24.png',
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                ValueListenableBuilder(
                                  valueListenable: lastWorkOutName,
                                  builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        Text(
                                          value,
                                          style: kDmSansFont.copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                sizeConfig.blockSizeHorizontal *
                                                    5,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          value.isEmpty
                                              ? 'start your first work out'
                                              : 'Continue',
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                          )),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 130, left: 30),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  const Text('Calories'),
                                  const Spacer(),
                                  Image.asset(
                                    'assets/images/local_fire_department_FILL0_wght400_GRAD0_opsz24.png',
                                    color: Colors.pink,
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 15),
                              ValueListenableBuilder(
                                valueListenable: caloriesBurnedTotal,
                                builder: (context, value, child) {
                                  return Text(
                                    value.toString(),
                                    style: kMedText.copyWith(
                                        color: Colors.black, fontSize: 20),
                                  );
                                },
                              ),
                              const SizedBox(height: 1),
                              const Text('Kcal'),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(height: 30),

// steps

                  Padding(
                    padding: const EdgeInsets.only(right: 130, left: 30),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  const Text('steps'),
                                  const Spacer(),
                                  Image.asset(
                                    'assets/images/steps.png',
                                    color: Colors.pink,
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                widget.totalSteps.toString(),
                                style: kMedText.copyWith(
                                    color: Colors.black, fontSize: 20),
                              ),
                              const SizedBox(height: 1),
                              const Text('steps'),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                ]),
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (ind) async {
            if (ind == 1) {
              bool activityRecognitionGranded =
                  await Permission.activityRecognition.request().isGranted;
              Box<UserBodyDetails> box =
                  await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
              UserBodyDetails? user = box.get('userbodydetails');

              bool hasWeightandHeight = user!.height != 0 && user.weight != 0;
              if (activityRecognitionGranded) {
                if (hasWeightandHeight) {
                  num heightInM = user.height / 100;
                  Get.to(() => StepsTrackerScreen(
                        userWeight: user.weight,
                        userHeightInMeters: heightInM,
                      ));
                } else {
                  if (!mounted) return;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              const Text('add weight and height to continue'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Get.to(() => const HeightAndWeightInput());
                              },
                              child: const Text('add'),
                            ),
                          ],
                        );
                      });
                }
              } else {
                Permission.activityRecognition.request();
                Get.snackbar('permission needed',
                    'allow activity recognition permission in app settings');
              }
            }
            if (ind == 2) {
              Get.to(() => const WorkOutScreen());
            }
          },
          currentIndex: currentInd,
          items: const [
            BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.shoePrints,
                ),
                label: 'steps'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.dumbbell,
                ),
                label: 'workout'),
          ]),
    );
  }

  String dateParse(date) {
    return DateFormat.MMMMd().format(date);
  }

  String dateParse2(date) {
    return DateFormat.yMMMM().format(date);
  }

  updateGoalCompletePerc() async {
    Box<UserBodyDetails> box =
        await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
    UserBodyDetails? user = box.get('userbodydetails');
    if (user?.dailySteps != null && stepsGoal.value != 0) {
      double? normalizedValue = ((user!.dailySteps / stepsGoal.value) * 100);

      stepsGoalCompletePer.value = normalizedValue;
      stepsGoalCompletePer.notifyListeners();
      // print('printing normalizedValue $normalizedValue');
    }
  }
}
