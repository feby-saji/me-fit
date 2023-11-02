import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/steps/steps_page.dart';
import 'package:me_fit/screens/weight_height/set_weight_height_screen.dart';
import 'package:me_fit/screens/workout/workout_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomNavigatioinBar extends StatefulWidget {
  const BottomNavigatioinBar({super.key});

  @override
  State<BottomNavigatioinBar> createState() => _BottomNavigatioinBarState();
}

class _BottomNavigatioinBarState extends State<BottomNavigatioinBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
                        title: const Text('add weight and height to continue'),
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
        ]);
  }
}
