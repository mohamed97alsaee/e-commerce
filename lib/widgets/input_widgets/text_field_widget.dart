import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/consts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      this.label,
      required this.validator,
      required this.hintText,
      this.obSecureText = false,
      this.perfix,
      this.digitsOnly = false});
  final TextEditingController controller;
  final String? label;
  final String hintText;
  final FormFieldValidator<String?> validator;
  final bool digitsOnly;
  final bool obSecureText;
  final Widget? perfix;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget.label != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.label ?? "",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
              controller: widget.controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              obscureText: widget.obSecureText,
              inputFormatters: [
                if (widget.digitsOnly) FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
                suffixIcon: widget.perfix,
                fillColor: mainColor.withOpacity(0.2),
                filled: true,
                hintText: widget.hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: mainColor.withOpacity(0.2))),
                focusColor: mainColor.withOpacity(0.2),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: mainColor.withOpacity(0.4))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: mainColor.withOpacity(0.2))),
              ))
        ],
      ),
    );
  }
}
