import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:me_fit/Models/workout_model.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/detailed_workout/detailed_workouts.dart';
import 'package:me_fit/screens/workout/callApi.dart';
import 'package:me_fit/styles/size_config.dart';

ValueNotifier<bool> hasloaded = ValueNotifier(false);

class WorkOutScreen extends StatefulWidget {
  const WorkOutScreen({super.key});

  @override
  State<WorkOutScreen> createState() => WorkOutScreenState();
}

class WorkOutScreenState extends State<WorkOutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      workoutDataFromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -20,
            child: SizedBox(
              width: sizeConfig.screenWidth,
              height: sizeConfig.screenHeight,
              child: Image.asset('assets/images/bck_of_some_screens.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.chevron_left)),
                      const Text(
                        'start workout',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: hasloaded,
                      builder: (BuildContext context, bool value, _) {
                        return value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: FutureBuilder(
                                  future: workoutDataFromApi(),
                                  builder: (context, snapshot) {
                                    return ListView.builder(
                                        itemCount: allBodyPartWorkouts.length,
                                        itemBuilder: (context, ind) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.blueAccent,
                                              ),
                                            ));
                                          }
                                          if (snapshot.hasData) {
                                            WorkoutModel data =
                                                snapshot.data![ind];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ListTile(
                                                onTap: () {
                                                  print('printing index $ind');
                                                  Get.to(() =>
                                                      DetailedWorkoutScreenStatePageView(
                                                        initialPage: ind,
                                                      ));
                                                },
                                                leading:
                                                    Image.network(data.gifUrl),
                                                title: Text(data.name),
                                                trailing: const Icon(
                                                    Icons.chevron_right),
                                              ),
                                            );
                                          }
                                          return Container();
                                        });
                                  },
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.pink));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
