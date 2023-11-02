import 'package:flutter/material.dart';
import 'package:me_fit/screens/register_login/functions/password_validate.dart';

class PasswordFormFiledWidget extends StatelessWidget {
  const PasswordFormFiledWidget({
    super.key,
    required this.ctrlPassword,
    // required this.stateFocus,
  });

  final TextEditingController ctrlPassword;
  // final FocusNode stateFocus

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: ctrlPassword,
        maxLength: 40,
        inputFormatters: const [
          // FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@_.]")),
        ],
        // focusNode: stateFocus,
        validator: (value) {
          int res = validatePassword(value as String);
          if (res == 1) {
            return "cannot be empty";
          } else if (res == 2) {
            return "min 8 character";
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          errorMaxLines: 1,
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 0,
              color: Color(0xffE5E5E5),
            ),
          ),
        
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xffE5E5E5),
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 3,
                color: Colors.purpleAccent,
              )),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
                color: Colors.purpleAccent,
            ),
          ),
        ),
      ),
    );
  }
}
