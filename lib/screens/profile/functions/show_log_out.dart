import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:me_fit/screens/profile/functions/log_out.dart';

showLogOut(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('log out ?'),
          actions: [
            IconButton(
                onPressed: () async => await logOutFunc(context),
                icon: const Icon(FluentIcons.sign_out_20_regular)),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close))
          ],
        );
      });
}
