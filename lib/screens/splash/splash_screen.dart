import 'package:flutter/material.dart';
import 'package:me_fit/screens/splash/functions/gotoscreen.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        goToScreen(context);
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: sizeConfig.screenHeight,
            width: sizeConfig.screenWidth,
            child: Image.asset(
              'assets/images/splash_screen_bck.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: sizeConfig.screenHeight,
            child: Column(
              children: [
                SizedBox(height: sizeConfig.blockSizeVertical * 15),
                Text(
                  'Me FIT',
                  style: kbigText,
                ),
                SizedBox(height: sizeConfig.blockSizeVertical * 8),

                Text(
                  'FIND OUT EXACTLY WHAT DIET & TRAINING WILL WORK SPECIFICALLY FOR YOU',
                  style: kDmSansFont.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: sizeConfig.blockSizeVertical * 30),
                const Spacer(),
                SizedBox(
                  height: 400,
                  child: Image.asset(
                    'assets/images/athletic_girl_png.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
