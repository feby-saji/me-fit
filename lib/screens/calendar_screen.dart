import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter/material.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/widgets/workout_record_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

DateTime selectedDate = DateTime.now();

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);
    HiveDb db = HiveDb();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: sizeConfig.screenHeight,
            width: sizeConfig.screenWidth,
            child: Image.asset(
              'assets/images/Calendar.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 15, right: 0),
                  child: SizedBox(
                      height: 400,
                      child: CalendarCarousel(
                        onDayPressed: (date, events) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        selectedDateTime: selectedDate,
                        weekendTextStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Workouts',
                                style: kMedText.copyWith(
                                    color: Colors.black, fontSize: 21),
                              ),
                              Text(
                                'see all',
                                style: kMedText.copyWith(
                                    color: Colors.black, fontSize: 21),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        FutureBuilder(
                            future: db.getAllWorkOutRecords(),
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<List<WorkOutRecordModel>> snapshot,
                            ) {
                              if (snapshot.hasData) {
                                List<WorkOutRecordModel> records =
                                    snapshot.data!;

                                if (records.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'no records found',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                } else {
                                  return Expanded(
                                    child: ListView.separated(
                                      itemCount: records.length,
                                      separatorBuilder: (context, ind) =>
                                          const SizedBox(height: 10),
                                      itemBuilder: (context, ind) {
                                        WorkOutRecordModel record =
                                            records[ind];

                                        return DateUtils.isSameDay(
                                          selectedDate,
                                          record.dateTime,
                                        )
                                            ? WorkoutRecordWidget(
                                                iconPath: record.iconPath,
                                                workOutName: record.workoutName,
                                                set: record.setCount,
                                                caloriesBurned:
                                                    record.caloriesBurned,
                                              )
                                            : const SizedBox();
                                      },
                                    ),
                                  );
                                }
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              }

                              return const Center(
                                child: Text(
                                  'no records found',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
