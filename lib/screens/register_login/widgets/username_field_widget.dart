import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_fit/screens/register_login/functions/name_validation.dart';

class NameFormFiledWidget extends StatelessWidget {
  const NameFormFiledWidget({
    super.key,
    required this.ctrlName,
    // required this.stateFocus,
  });

  final TextEditingController ctrlName;
  // final FocusNode stateFocus

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: ctrlName,
        maxLength: 20,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp("[0-9@_.]")),
        ],
        // focusNode: stateFocus,
        validator: (value) {
          int res = validateName(value as String);
          if (res == 1) {
            return "cannot be empty";
          } else if (res == 2) {
            return "max 20 characters";
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
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          //   borderSide: BorderSide(
          //     width: 0,
          //     color: Color(0xffE5E5E5),
          //   ),
          // ),
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
