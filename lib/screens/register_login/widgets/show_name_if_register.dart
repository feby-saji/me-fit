import 'package:flutter/material.dart';
import 'package:me_fit/screens/register_login/widgets/username_field_widget.dart';

class ShowNameIfRegistering extends StatelessWidget {
  const ShowNameIfRegistering({
    super.key,
    required this.isRegister,
    required this.ctrlUserName,
  });

  final bool isRegister;
  final TextEditingController ctrlUserName;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isRegister,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: NameFormFiledWidget(ctrlName: ctrlUserName),
      ),
    );
  }
}
