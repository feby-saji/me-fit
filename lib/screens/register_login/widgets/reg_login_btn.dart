import 'package:flutter/material.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/screens/register_login/functions/login_user.dart';
import 'package:me_fit/screens/register_login/functions/register.dart';
import 'package:me_fit/screens/register_login/register_or_login_screen.dart';

class RegisterLoginBtnWidget extends StatelessWidget {
  const RegisterLoginBtnWidget({
    super.key,
    required this.isRegister,
    required this.ctrlUserName,
    required this.ctrlEmail,
    required this.ctrlPassword,
  });

  final bool isRegister;
  final TextEditingController ctrlUserName;
  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (validationKey.currentState!.validate()) {
// register
            if (isRegister) {
              ModelOfUserProfileDetails user = ModelOfUserProfileDetails(
                userName: ctrlUserName.text,
                email: ctrlEmail.text,
                password: ctrlPassword.text,
              );
              await registerUser(user, context);
            }
// login
            else {
              await loginUser(ctrlEmail.text, ctrlPassword.text, context);
            }
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(isRegister ? 'Register' : 'Login')));
  }
}
