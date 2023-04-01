import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../helpers/consts.dart';

Future showCustomFlushbar(
    String message, Color color, IconData icon, BuildContext context) async {
  Flushbar(
    message: message,
    icon: Icon(
      icon,
      size: 28.0,
      color: lightGreyColor,
    ),
    margin: const EdgeInsets.all(6.0),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(12),
    duration: const Duration(seconds: 2),
    leftBarIndicatorColor: color,
  ).show(context);
}
