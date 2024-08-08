import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/DB/hive_function.dart';

class HeightAndWeightInput extends StatefulWidget {
  const HeightAndWeightInput({super.key});

  @override
  HeightAndWeightInputState createState() => HeightAndWeightInputState();
}

class HeightAndWeightInputState extends State<HeightAndWeightInput> {
  final TextEditingController _heightController =
      TextEditingController(text: '180');
  final TextEditingController _weightController =
      TextEditingController(text: '60');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.height),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.line_weight),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  HiveDb hiveDb = HiveDb();
                  await hiveDb.setHeightAndWeight(
                      int.parse(_heightController.text),
                      int.parse(_weightController.text));
                  Get.back();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
