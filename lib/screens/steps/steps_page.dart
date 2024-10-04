// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:me_fit/DB/hive_function.dart';
// import 'package:me_fit/screens/home/home_screen.dart';
// import 'package:me_fit/screens/steps/widgets/closeBtn.dart';
// import 'package:me_fit/styles/styles.dart';
//
// HiveDb db = HiveDb();
// late bool activityRecognitionGranded;
//
//
//
// class StepsTrackerScreen extends StatefulWidget {
//   final int userWeight;
//   final num userHeightInMeters;
//   const StepsTrackerScreen(
//       {super.key, required this.userWeight, required this.userHeightInMeters});
//
//   @override
//   State<StepsTrackerScreen> createState() => StepsTrackerScreenState();
// }
//
// class StepsTrackerScreenState extends State<StepsTrackerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     gUserHeightInMeters = widget.userHeightInMeters;
//     gUserWeight = widget.userWeight;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Steps tracker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               width: 300,
//               height: 300,
//               child:
//                   Lottie.asset('assets/lottie/Animation - 1695630496886.json'),
//             ),
//             const SizedBox(height: 50),
//             Text(
//               'Steps Taken today',
//               style: kMedText.copyWith(color: Colors.black),
//             ),
//             ValueListenableBuilder(
//               valueListenable: stepTodayTaken,
//               builder: (context, value, child) {
//                 return Text(
//                   stepTodayTaken.value.abs().toString(),
//                   style: const TextStyle(fontSize: 30),
//                 );
//               },
//             ),
//             const Divider(
//               height: 10,
//               thickness: 0,
//               color: Colors.white,
//             ),
//             ValueListenableBuilder(
//               valueListenable: caloriesBurnedToday,
//               builder: (context, value, child) {
//                 return Text(
//                     'calories burned : ${caloriesBurnedToday.value.abs().round().toString()}');
//               },
//             ),
//             const Spacer(),
//             CloseBtnWidget(db: db),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
