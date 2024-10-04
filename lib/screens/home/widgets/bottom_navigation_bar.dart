import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:me_fit/screens/home/home_screen.dart';

import '../../workout/workout_screen.dart';

class BottomNavigatioinBar extends StatefulWidget {
  const BottomNavigatioinBar({super.key});

  @override
  State<BottomNavigatioinBar> createState() => _BottomNavigatioinBarState();
}

class _BottomNavigatioinBarState extends State<BottomNavigatioinBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (ind) {
          if (ind == 1) {
            Get.to(() => const WorkOutScreen());
          }
        },
        currentIndex: currentInd,
        items: const [
          BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.dumbbell), label: 'workout')
        ]);
  }
}
