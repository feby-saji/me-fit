import 'package:flutter/material.dart';
import 'package:me_fit/styles/size_config.dart';

class WorkoutRecordWidget extends StatelessWidget {
  final String iconPath;
  final String workOutName;
  final int caloriesBurned;
  final int set;

  const WorkoutRecordWidget({
    super.key,
    required this.iconPath,
    required this.workOutName,
    required this.set,
    required this.caloriesBurned,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  iconPath,
                  width: sizeConfig.blockSizeHorizontal * 15,
                  height: sizeConfig.blockSizeVertical * 7,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        workOutName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${set.toString()} set',
                        ),
                        Text('${caloriesBurned.round().toString()} kcal'),
                      ],
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
