import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/workout/workout_screen.dart';
import 'package:me_fit/styles/styles.dart';

class LastWorkoutWidget extends StatelessWidget {
  const LastWorkoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          SizedBox(
                            width: 150,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              style: kDmSansFont.copyWith(
                                color: Colors.black,
                                fontSize: sizeConfig.blockSizeHorizontal * 5,
                              ),
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
    );
  }
}
