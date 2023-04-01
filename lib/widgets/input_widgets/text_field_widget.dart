import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/dark_theme_provider.dart';
import '../../helpers/consts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboard = TextInputType.name,
    this.suffix,
    this.obscureText = false,
    required this.validator,
    this.textAlign = TextAlign.center,
    this.isEnabled = true,
    this.isPhone = false,
    this.numbersOnly = false,
    this.doubleOnly = false,
    this.label,
    this.perfix,
    required this.onchanged,
    this.horizontalPadding = 25,
  }) : super(key: key);
  final String? label;

  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboard;
  final Widget? suffix;
  final Widget? perfix;
  final bool obscureText;
  final FormFieldValidator<String?> validator;
  final TextAlign textAlign;
  final bool isEnabled;
  final bool isPhone;
  final bool numbersOnly;
  final bool doubleOnly;
  final Function onchanged;
  final double horizontalPadding;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding, vertical: 4),
      child: Center(
        child: Column(
          children: [
            widget.label == null
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.label!,
                          style: TextStyle(
                              color: themeListener.isDark
                                  ? lightWihteColor.withOpacity(0.5)
                                  : darkGreyColor.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextFormField(
                      textDirection: widget.isPhone ? TextDirection.ltr : null,
                      onChanged: (value) {
                        widget.onchanged();
                      },
                      inputFormatters: [
                        widget.numbersOnly || widget.isPhone
                            ? FilteringTextInputFormatter.digitsOnly
                            : widget.doubleOnly
                                ? FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,2}'))
                                : FilteringTextInputFormatter.deny(
                                    RegExp(r'-')),
                      ],
                      enabled: widget.isEnabled,
                      obscureText: widget.obscureText,
                      textAlign:
                          widget.isPhone ? TextAlign.center : TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      controller: widget.controller,
                      cursorColor: themeListener.isDark
                          ? lightWihteColor
                          : darkGreyColor,
                      cursorWidth: 2,
                      style: TextStyle(
                          fontSize: 14,
                          color: themeListener.isDark
                              ? lightWihteColor
                              : darkGreyColor),
                      keyboardType: widget.keyboard,
                      autofocus: false,
                      decoration: InputDecoration(
                        fillColor: themeListener.isDark
                            ? lightWihteColor.withOpacity(0.2)
                            : Colors.black12.withOpacity(0.05),
                        hintTextDirection:
                            widget.isPhone ? TextDirection.ltr : null,
                        suffix: widget.isPhone && widget.suffix != null
                            ? null
                            : widget.suffix,
                        prefix: widget.perfix,
                        hintText: widget.hintText,
                      ),
                      validator: widget.validator,
                    ),
                  ),
                ),
                widget.isPhone && widget.suffix != null
                    ? Positioned(
                        left: 20,
                        top: 16,
                        child: Center(
                          child: widget.suffix,
                        ))
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
