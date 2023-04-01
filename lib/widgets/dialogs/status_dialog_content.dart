import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';

import '../clickable_widgets/main_button_widget.dart';

class StatusDialogContent extends StatefulWidget {
  const StatusDialogContent(
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
  State<StatusDialogContent> createState() => _StatusDialogContentState();
}

class _StatusDialogContentState extends State<StatusDialogContent> {
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
                            "datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MainButton(
                              btnColor:
                                  widget.success ? mainColor : warningColor,
                              txtColor: widget.success
                                  ? darkGreyColor
                                  : lightWihteColor,
                              radius: 40,
                              text: widget.buttonText,
                              onPressed: () {
                                widget.onPressed();
                              })
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
                            color: widget.success ? mainColor : warningColor,
                            borderRadius: BorderRadius.circular(200)),
                        child: Icon(
                          widget.success ? Icons.check : Icons.close_rounded,
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
