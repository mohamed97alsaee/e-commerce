import 'package:e_commerce/providers/dark_theme_provider.dart';
import 'package:e_commerce/screens/auth_screens/intro_screen.dart';
import 'package:e_commerce/screens/main_screens/tabs_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/handling_screens/loading_screen.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'helpers/consts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getLocalLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localCode = prefs.getString('langCode');
    if (localCode == 'en') {
      setState(() {
        _locale = const Locale('en');
        setLocale(const Locale('en'));
      });
    } else {
      setState(() {
        _locale = const Locale('ar');
        setLocale(const Locale('ar'));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocalLang();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (BuildContext context) => AuthProvider()),
        ChangeNotifierProvider<DarkThemeProvider>(
          create: (_) {
            return DarkThemeProvider();
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeListener, _) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor:
              themeListener.isDark ? darkGreyColor : lightWihteColor,
        ));
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              'en',
            ),
            Locale(
              'ar',
            ),
          ],
          locale: _locale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: themeListener.isDark ? darkGreyColor : lightWihteColor,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.tajawal(
                  color: themeListener.isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              backgroundColor:
                  themeListener.isDark ? darkGreyColor : lightWihteColor,
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(
                  color: themeListener.isDark ? Colors.white : Colors.black),
            ),
            primaryColor: mainColor,
            scaffoldBackgroundColor:
                themeListener.isDark ? darkGreyColor : lightWihteColor,
            textTheme:
                GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
            scrollbarTheme: ScrollbarThemeData(
              thickness: MaterialStateProperty.all<double>(10),
              trackVisibility: MaterialStateProperty.all<bool>(true),
            ).copyWith(
              thumbColor: MaterialStateProperty.all(lightWihteColor),
              trackColor:
                  MaterialStateProperty.all(lightGreyColor.withOpacity(0.2)),
            ),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: mainColor,
            ),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: themeListener.isDark
                  ? darkGreyColor
                  : lightWihteColor.withOpacity(0.1),
              filled: true,
              isDense: false,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor.withOpacity(0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor.withOpacity(0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: middleGreyColor,
              ),
              errorStyle: const TextStyle(
                fontSize: 9,
                color: Colors.red,
              ),
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(mainColor),
              checkColor: MaterialStateProperty.all(
                  themeListener.isDark ? darkGreyColor : lightWihteColor),
              overlayColor: MaterialStateProperty.all(mainColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: themeListener.isDark ? darkGreyColor : lightWihteColor,
                  width: 1,
                ),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: mainColor,
              unselectedItemColor:
                  themeListener.isDark ? lightWihteColor : middleGreyColor,
              backgroundColor:
                  themeListener.isDark ? darkGreyColor : lightGreyColor,
              selectedLabelStyle: const TextStyle(
                  color: mainColor, fontSize: 10, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
              showUnselectedLabels: true,
              elevation: 0,
            ),
          ),
          home: const ScreenRouter(),
        );
      }),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({Key? key, this.fromRegister = false}) : super(key: key);
  final bool fromRegister;

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    // onMessageListen(context);
    // Remove when make noification list request
    // onMessageOpenedApp(context);
    Provider.of<DarkThemeProvider>(context, listen: false).setMode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    authProvider.initAuthProvider();

    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (
          context,
          authProvider,
          child,
        ) {
          switch (authProvider.status) {
            case Status.authenticating:
              return const LoadingScreen();
            case Status.uninitialized:
              return const LoadingScreen();
            case Status.authenticated:
              return const TabsScreen();
            case Status.unauthenticated:
              return const IntroScreen();

            default:
              return const IntroScreen();
          }
        },
      ),
    );
  }
}
