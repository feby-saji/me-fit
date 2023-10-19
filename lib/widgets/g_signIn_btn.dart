import 'package:flutter/material.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

class GoogleSignInBtn extends StatelessWidget {
  const GoogleSignInBtn({
    super.key,
    required this.sizeConfig,
  });

  final SizeConfig sizeConfig;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: Container(
        width: sizeConfig.blockSizeHorizontal * 2,
        decoration: BoxDecoration(
          // color: kprimaryClr,
          border: Border.all(width: 0.8, color: kBorderClr),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icons/google.png',
              fit: BoxFit.cover,
              width: sizeConfig.blockSizeHorizontal * 12,
            ),
            // SizedBox(width: sizeConfig.blockSizeHorizontal * 15),
            Text(
              'Sign-in with Google',
              style: kDmSansFont.copyWith(
                  fontSize: sizeConfig.blockSizeHorizontal * 4),
            )
          ],
        ),
      ),
    );
  }
}
