import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_fit/screens/register_login/functions/email_validation.dart';

class EmailFormFiledWidget extends StatelessWidget {
  const EmailFormFiledWidget({
    super.key,
    required this.ctrlEmail,
    // required this.stateFocus,
  });

  final TextEditingController ctrlEmail;
  // final FocusNode stateFocus

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: ctrlEmail,
        maxLength: 40,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@_.]")),
        ],
        // focusNode: stateFocus,
        validator: (value) {
          int res = validateEmail(value as String);
          if (res == 1) {
            return "cannot be empty";
          } else if (res == 2) {
            return "invalid email";
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
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
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
