import 'package:flutter/material.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

class OptionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;
  const OptionsWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              SizedBox(width: sizeConfig.blockSizeHorizontal * 4),
              Container(
                  decoration: BoxDecoration(
                      color: kpinkLightClr,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(icon),
                  )),
              const SizedBox(width: 10),
              SizedBox(
                width: sizeConfig.blockSizeHorizontal * 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: kSmalText.copyWith(color: Colors.black),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
