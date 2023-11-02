import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

class BMICalculationScreen extends StatefulWidget {
  const BMICalculationScreen({super.key});

  @override
  BMICalculationScreenState createState() => BMICalculationScreenState();
}

class BMICalculationScreenState extends State<BMICalculationScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double _bmi = 0.0;
  String _bmiText = '';

  void calculateBMI() async {
    if (_weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty) {
      double height = double.parse(_heightController.text.trim());
      double weight = double.parse(_weightController.text.trim());

      setState(() {
        _bmi = weight / (height * height / 10000);
      });

      setState(() {
        switch (_bmi.round()) {
          case < 18:
            _bmiText = 'underweight';
            break;
          case < 25:
            _bmiText = 'healthy';
            break;
          case < 35:
            _bmiText = 'overweight';
            break;
          default:
            _bmiText = 'obese';
        }
      });

      await HiveDb().setUserBmiDb(_bmi.round());
      _heightController.clear();
      _weightController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('fields cannot be empty'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              SizedBox(
                height: sizeConfig.screenHeight,
                width: sizeConfig.screenWidth,
                child: Image.asset(
                  'assets/images/splash_screen_bck.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'BMI Calculator',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 30),
//
                    Text(
                      'Enter your height in cm:',
                      style: kSmalText,
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                      ),
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Enter your weight in kg:',
                      style: kSmalText,
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: calculateBMI,
                      child: const Text('Calculate BMI'),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(
                        _bmi == 0 ? '' : 'Your BMI is: ${_bmi.round()}',
                        style: kSmalText,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(
                        _bmiText.isEmpty ? '' : 'You are $_bmiText',
                        style: kMedText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
