import 'package:flutter/material.dart';
import 'package:me_fit/styles/styles.dart';


class WorkoutDetailTile extends StatelessWidget {
  final String title;
  final String text;
  const WorkoutDetailTile({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: kSmalText.copyWith(color: Colors.black),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: kSmalText.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
