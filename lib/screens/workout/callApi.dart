import 'dart:convert';
import 'package:me_fit/Models/workout_model.dart';
import 'package:me_fit/main.dart';
import 'package:http/http.dart' as http;
import 'package:me_fit/screens/workout/workout_screen.dart';

Future<List> workoutDataFromApi() async {
  hasloaded.value = false;
  hasloaded.notifyListeners();

  if (allBodyPartWorkouts.isEmpty) {
    try {
      print('requesting for workout details///////////////');
      Uri uri = Uri.parse(
        'https://exercisedb.p.rapidapi.com/exercises/equipment/body%20weight',
      );

      final response = await http.get(uri, headers: {
        'X-RapidAPI-Key': '4ad43c1bbcmsh25d4f4dc9cbd45ap17c1d8jsn88f98f05157f',
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
      hasloaded.value = true;
      hasloaded.notifyListeners();

      return allBodyPartWorkouts;
    } catch (e) {
      print('failed to fetch datas $e');
    }
  }
  hasloaded.value = true;
  hasloaded.notifyListeners();

  return allBodyPartWorkouts;
}
