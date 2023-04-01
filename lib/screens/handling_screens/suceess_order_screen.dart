import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../main.dart';
import '../../providers/dark_theme_provider.dart';

class SuccessOrderScreen extends StatefulWidget {
  const SuccessOrderScreen({super.key});

  @override
  State<SuccessOrderScreen> createState() => _SuccessOrderScreenState();
}

class _SuccessOrderScreenState extends State<SuccessOrderScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const ScreenRouter()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                height: size.height * 0.1,
                width: size.height * 0.1,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(200)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: size.width * 0.15,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.yoic,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: themListener.isDark ? lightWihteColor : darkGreyColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.yowbdycttdsios,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themListener.isDark ? lightWihteColor : darkGreyColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
