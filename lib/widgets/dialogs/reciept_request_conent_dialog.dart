import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';

import '../../screens/handling_screens/otp_screen.dart';
import '../../screens/main_screens/tabs_screen.dart';
import '../clickable_widgets/main_button_widget.dart';
import 'custom_flushbar_widget.dart';

class RecieptRequestDialogContent extends StatefulWidget {
  const RecieptRequestDialogContent(
      {super.key,
      required this.success,
      required this.title,
      required this.subTitle,
      required this.buttonText,
      required this.onPressed});
  final bool success;
  final String title;
  final String subTitle;
  final String buttonText;
  final Function onPressed;
  @override
  State<RecieptRequestDialogContent> createState() =>
      _RecieptRequestDialogContentState();
}

class _RecieptRequestDialogContentState
    extends State<RecieptRequestDialogContent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: size.height * 0.4,
            color: Colors.transparent,
            child: Stack(children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: size.height * 0.3,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: themeListener.isDark
                            ? darkGreyColor
                            : lightWihteColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                                color: themeListener.isDark
                                    ? lightWihteColor
                                    : darkGreyColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "The Account Holder has requested a reciept for this transaction for 120 LYD to pay about iphone case.",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MainButton(
                                  horizontalPadding: 0,
                                  widthFromScreen: 0.3,
                                  btnColor:
                                      widget.success ? mainColor : warningColor,
                                  txtColor: widget.success
                                      ? darkGreyColor
                                      : lightWihteColor,
                                  radius: 40,
                                  text: AppLocalizations.of(context)!.accept,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => OtpScreen(
                                                  phoneNumber: '926175513',
                                                  onNext: () {
                                                    showCustomFlushbar(
                                                            "Accepted Reciept Request ",
                                                            successColor,
                                                            Icons.check,
                                                            context)
                                                        .then((value) {
                                                      Timer(
                                                          const Duration(
                                                              seconds: 3), () {
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const TabsScreen()),
                                                            (route) => false);
                                                      });
                                                    });
                                                  },
                                                  nextBtnText: 'Continue',
                                                )));
                                  }),
                              MainButton(
                                  horizontalPadding: 0,
                                  widthFromScreen: 0.3,
                                  btnColor:
                                      widget.success ? mainColor : warningColor,
                                  txtColor: widget.success
                                      ? darkGreyColor
                                      : lightWihteColor,
                                  radius: 40,
                                  text: AppLocalizations.of(context)!.decline,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Positioned(
                top: size.height * 0.05,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(200)),
                        child: Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.white,
                          size: size.width * 0.15,
                        )),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
