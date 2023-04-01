import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/dark_theme_provider.dart';

class DebuggingButtons extends StatefulWidget {
  const DebuggingButtons({super.key});

  @override
  State<DebuggingButtons> createState() => _DebuggingButtonsState();
}

class _DebuggingButtonsState extends State<DebuggingButtons> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      child: Column(
        children: [
          FloatingActionButton(onPressed: () {
            Provider.of<DarkThemeProvider>(context, listen: false).switchMode();
          }),
          const SizedBox(height: 10),
          FloatingActionButton(onPressed: () {
            MyApp.setLocale(
                context,
                AppLocalizations.of(context)!.localeName == 'en'
                    ? const Locale('ar')
                    : const Locale('en'));
          }),
        ],
      ),
    );
  }
}
