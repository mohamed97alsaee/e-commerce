import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../../providers/dark_theme_provider.dart';
import '../../helpers/consts.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    Key? key,
    required this.text,
    this.isActive = true,
    required this.onPressed,
    this.widthFromScreen = 0.9,
    this.inProgress = false,
    this.withBorder = false,
    this.btnColor = mainColor,
    this.txtColor = darkGreyColor,
    this.radius = 10,
    this.heightFromScreen = 0.06,
    this.horizontalPadding = 25,
  }) : super(key: key);

  final String text;
  final bool isActive;
  final double widthFromScreen;
  final bool inProgress;
  final bool withBorder;
  final Color btnColor;
  final Color txtColor;
  final Function onPressed;
  final double radius;

  final double heightFromScreen;
  final double horizontalPadding;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: TapDebouncer(
          cooldown: const Duration(milliseconds: 1000),
          onTap: () async {
            if (widget.isActive && !widget.inProgress) await widget.onPressed();
          },
          builder: (BuildContext context, TapDebouncerFunc? onTap) {
            return GestureDetector(
              onTap: () {
                if (widget.isActive || !widget.inProgress) onTap!();
              },
              child: Container(
                width: size.width * widget.widthFromScreen,
                height: size.height * widget.heightFromScreen,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? widget.btnColor
                      : widget.btnColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(widget.radius),
                  border: widget.withBorder
                      ? Border.all(
                          color: themeListener.isDark
                              ? lightWihteColor
                              : mainColor,
                          width: 2)
                      : null,
                ),
                child: Center(
                  child: widget.inProgress
                      ? const CircularProgressIndicator(
                          color: Colors.white60,
                          backgroundColor: mainColor,
                        )
                      : Text(
                          widget.text,
                          style: TextStyle(
                              color: widget.txtColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            );
          }),
    );
  }
}
