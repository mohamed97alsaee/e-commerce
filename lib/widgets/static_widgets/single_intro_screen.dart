import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/consts.dart';
import '../../../../providers/dark_theme_provider.dart';

class SingleIntroScreen extends StatelessWidget {
  const SingleIntroScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);
  final String title;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Container(
      color: themeListener.isDark ? darkGreyColor : lightWihteColor,
      // color: Colors.blue.withOpacity(0.2),
      // height: size.height * 0.62,
      child: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.66,
                ),
                child: Center(
                  child: Image.asset(
                    image,
                    width: size.width * 0.66,
                    height: size.width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.05,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 61),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: themeListener.isDark
                          ? lightGreyColor.withOpacity(0.7)
                          : darkGreyColor.withOpacity(0.7)),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
