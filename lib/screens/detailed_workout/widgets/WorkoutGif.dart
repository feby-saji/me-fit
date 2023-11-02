import 'package:flutter/material.dart';

class WorkoutGif extends StatelessWidget {
  const WorkoutGif({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.network(
      url,
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    ));
  }
}
