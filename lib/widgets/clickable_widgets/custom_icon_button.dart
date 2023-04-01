import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.horizantolpadding = 6});

  final IconData icon;
  final Function onPressed;
  final double horizantolpadding;
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizantolpadding),
      child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Container(
            decoration: BoxDecoration(
                color: themeListener.isDark ? Colors.white24 : lightWihteColor,
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                    width: themeListener.isDark ? 0.3 : 1,
                    color: themeListener.isDark
                        ? lightWihteColor
                        : darkGreyColor.withOpacity(0.4))
                // boxShadow: [
                //   if (!themeListener.isDark)
                //     const BoxShadow(
                //       color: Colors.black12,
                //       blurRadius: 5,
                //       spreadRadius: 1,
                //       offset: Offset(0, 1),
                //     ),
                // ]
                ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  icon,
                  color: themeListener.isDark
                      ? lightWihteColor
                      : darkGreyColor.withOpacity(0.4),
                  size: 18,
                ),
              ),
            ),
          )),
    );
  }
}
