import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton(
      {super.key,
      required this.image,
      required this.onTap,
      required this.isSelected});
  final String image;
  final Function onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener =
        Provider.of<DarkThemeProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? themeListener.isDark
                        ? lightWihteColor
                        : middleGreyColor
                    : Colors.transparent,
                width: 0.5),
            borderRadius: BorderRadius.circular(20)),
        child: GestureDetector(
            onTap: onTap as void Function()?,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                image,
                width: size.width / 7,
                height: size.width / 7,
                fit: BoxFit.contain,
              ),
            )),
      ),
    );
  }
}
