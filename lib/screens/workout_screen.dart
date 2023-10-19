import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:me_fit/Models/workout_model.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/detailed_workouts.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:http/http.dart' as http;

bool hasloaded = false;

class WorkOutScreen extends StatefulWidget {
  const WorkOutScreen({super.key});

  @override
  State<WorkOutScreen> createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen> {
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
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.close)),
                    const Text('start workout'),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(height: 60),
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
                    child: hasloaded
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
                                        WorkoutModel data = snapshot.data![ind];

                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ListTile(
                                            onTap: () {
                                              print('printing index $ind');
                                              Get.to(() =>
                                                  DetailedWorkoutScreenStatePageView(
                                                    initialPage: ind,
                                                  ));
                                            },
                                            leading: Image.network(data.gifUrl),
                                            title: Text(data.name),
                                            trailing:
                                                const Icon(Icons.chevron_right),
                                          ),
                                        );
                                      }
                                      return Container();
                                    });
                              },
                            ),
                          )
                        : SizedBox(
                            width: 80,
                            height: 80,
                            child: Lottie.asset(
                              'assets/lottie/rat_run.json',
                              width: 10,
                              height: 10,
                            ),
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

  Widget selectTimer() {
    Duration duration = const Duration(minutes: 1);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: DurationPicker(
        duration: duration,
        onChange: (val) {
          // setState(() => duration = val);
        },
        snapToMins: 5.0,
      ),
    );
  }

  Future<List> workoutDataFromApi() async {
    setState(() {
      hasloaded = false;
    });

    if (allBodyPartWorkouts.isEmpty) {
      try {
        print('requesting for workout details///////////////');
        Uri uri = Uri.parse(
          'https://exercisedb.p.rapidapi.com/exercises/equipment/body%20weight',
        );

        final response = await http.get(uri, headers: {
          'X-RapidAPI-Key':
              '4ad43c1bbcmsh25d4f4dc9cbd45ap17c1d8jsn88f98f05157f',
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
        });

        allBodyPartWorkouts.clear();
        final jsonBody = jsonDecode(response.body);

        if (jsonBody is List) {
          for (var element in jsonBody) {
            // print(element);
            WorkoutModel model = WorkoutModel(
              name: element['name'],
              bodyPart: element['bodyPart'],
              gifUrl: element['gifUrl'],
              target: element['target'],
              instructions: element['instructions'].join(),
            );
            allBodyPartWorkouts.add(model);
          }
        } else {
          print("Unexpected JSON format: $jsonBody");
        }
        setState(() {
          hasloaded = true;
        });

        return allBodyPartWorkouts;
      } catch (e) {
        print('failed to fetch datas $e');
      }
    }
    setState(() {
      hasloaded = true;
    });
    return allBodyPartWorkouts;
  }
}
