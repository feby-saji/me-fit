import 'package:flutter/material.dart';
import 'package:me_fit/screens/register_login/widgets/email_field_widget.dart';
import 'package:me_fit/screens/register_login/widgets/password_field_widget.dart';
import 'package:me_fit/screens/register_login/widgets/reg_login_btn.dart';
import 'package:me_fit/screens/register_login/widgets/show_name_if_register.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

final validationKey = GlobalKey<FormState>();

class RegisterOrLoginScreen extends StatefulWidget {
  final bool isRegister;
  const RegisterOrLoginScreen({super.key, required this.isRegister});

  @override
  State<RegisterOrLoginScreen> createState() => RegisterOrLoginScreenState();
}

class RegisterOrLoginScreenState extends State<RegisterOrLoginScreen> {
  TextEditingController ctrlUserName = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  SizeConfig sizeConfig = SizeConfig();
  final FocusNode stateFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    ctrlEmail.clear();
    ctrlPassword.clear();
    ctrlUserName.clear();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.initSizeConfig(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pinkAccent,
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            height: sizeConfig.screenHeight,
            width: sizeConfig.screenWidth,
            child: Image.asset(
              'assets/images/splash_screen_bck.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: sizeConfig.blockSizeHorizontal * 9,
              right: sizeConfig.blockSizeHorizontal * 20,
              top: sizeConfig.blockSizeVertical * 5,
            ),
            child: Form(
              key: validationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Me FIT',
                    style: kbigText,
                  ),
                  SizedBox(
                      height: widget.isRegister
                          ? sizeConfig.blockSizeVertical * 8
                          : sizeConfig.blockSizeVertical * 22),
                  Visibility(
                    visible: widget.isRegister,
                    child: Text(
                      'user name',
                      style: kDmSansFont,
                    ),
                  ),
//
                  ShowNameIfRegistering(
                      isRegister: widget.isRegister,
                      ctrlUserName: ctrlUserName),
                  SizedBox(height: sizeConfig.blockSizeVertical * 5),
//
                  Text(
                    'email',
                    style: kDmSansFont,
                  ),
                  EmailFormFiledWidget(
                    ctrlEmail: ctrlEmail,
                  ),
                  SizedBox(height: sizeConfig.blockSizeVertical * 5),
//
                  Text(
                    'password',
                    style: kDmSansFont,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child:
                          PasswordFormFiledWidget(ctrlPassword: ctrlPassword)),

                  // btn
                  SizedBox(height: sizeConfig.blockSizeVertical * 20),
                  RegisterLoginBtnWidget(
                      isRegister: widget.isRegister,
                      ctrlUserName: ctrlUserName,
                      ctrlEmail: ctrlEmail,
                      ctrlPassword: ctrlPassword),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
