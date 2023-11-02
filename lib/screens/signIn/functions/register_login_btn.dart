import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/screens/register_login/register_or_login_screen.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

class RegisterLoginBtnWidget extends StatelessWidget {
  const RegisterLoginBtnWidget({
    super.key,
    required this.sizeConfig,
  });

  final SizeConfig sizeConfig;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
        onTap: () =>
            Get.to(() => const RegisterOrLoginScreen(isRegister: true)),
        child: Container(
          width: sizeConfig.blockSizeHorizontal * 40,
          height: sizeConfig.blockSizeHorizontal * 10,
          decoration: BoxDecoration(
            color: kprimaryClr,
            // border: Border.all(width: 1, color: kBorderClr),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Register',
              style: kDmSansFont.copyWith(
                  fontSize: sizeConfig.blockSizeHorizontal * 4),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () =>
            Get.to(() => const RegisterOrLoginScreen(isRegister: false)),
        child: Container(
          width: sizeConfig.blockSizeHorizontal * 40,
          height: sizeConfig.blockSizeHorizontal * 10,
          decoration: BoxDecoration(
            color: kprimaryClr,
            // border: Border.all(width: 1, color: kBorderClr),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Login',
              style: kDmSansFont.copyWith(
                  fontSize: sizeConfig.blockSizeHorizontal * 4),
            ),
          ),
        ),
      ),
    ]);
  }
}
