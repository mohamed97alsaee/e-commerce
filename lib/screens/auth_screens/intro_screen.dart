import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../../helpers/consts.dart';
import '../../../providers/dark_theme_provider.dart';

import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import '../../widgets/static_widgets/single_intro_screen.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  static String id = 'intro_screen';
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      SingleIntroScreen(
        image: 'assets/intro1.png',
        title: AppLocalizations.of(context)!.intro1title,
        description: AppLocalizations.of(context)!.intro1,
      ),
      SingleIntroScreen(
        image: 'assets/intro2.png',
        title: AppLocalizations.of(context)!.intro2title,
        description: AppLocalizations.of(context)!.intro2,
      ),
      SingleIntroScreen(
        image: 'assets/intro3.png',
        title: AppLocalizations.of(context)!.intro3title,
        description: AppLocalizations.of(context)!.intro3,
      ),
    ];
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("$currentIndex/3"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClickableText(
                  text: AppLocalizations.of(context)!.skip,
                  color: darkGreyColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
            ),
          )
        ],
      ),
      body: IntroductionScreen(
        showSkipButton: false,
        showBackButton: false,
        showDoneButton: false,
        showNextButton: false,
        dotsDecorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          activeColor: themeListener.isDark ? lightWihteColor : mainColor,
          color: themeListener.isDark
              ? lightWihteColor.withOpacity(0.5)
              : mainColor.withOpacity(0.5),
        ),
        globalBackgroundColor:
            themeListener.isDark ? darkGreyColor : lightWihteColor,
        rawPages: pages,
        onChange: (index) {
          setState(() {
            currentIndex = index + 1;
          });
        },
        curve: Curves.easeIn,
      ),
      bottomNavigationBar: SizedBox(
        height: size.height * 0.20,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(
                // btnColor: currentIndex != 3 ? Colors.transparent : mainColor,
                // txtColor:
                //     currentIndex != 3 ? Colors.transparent : darkGreyColor,
                radius: 30,
                text: currentIndex == 3
                    ? AppLocalizations.of(context)!.signin
                    : AppLocalizations.of(context)!.scrolltonext,
                widthFromScreen: 0.5,
                onPressed: () {
                  if (currentIndex == 3) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const LoginScreen()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
