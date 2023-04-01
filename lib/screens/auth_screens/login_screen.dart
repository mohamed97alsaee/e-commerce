import 'package:e_commerce/screens/auth_screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/consts.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import '../../widgets/input_widgets/text_field_widget.dart';
import '../handling_screens/otp_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  bool buttonEnabled = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
            key: loginForm,
            onChanged: () {
              setState(() {
                buttonEnabled = loginForm.currentState!.validate();
              });
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/logo.png',
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Text(
                      AppLocalizations.of(context)!.signin,
                      style: TextStyle(
                        color: themeListener.isDark
                            ? lightWihteColor
                            : darkGreyColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Text(
                      AppLocalizations.of(context)!.ltutaf,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFieldWidget(
                      suffix: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Container(
                              width: 1,
                              height: size.height * 0.025,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "+218",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      keyboard: TextInputType.phone,
                      controller: phoneController,
                      hintText: "92XXXXXXX",
                      isPhone: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.please +
                              AppLocalizations.of(context)!.eypn;
                        }
                        if (value.length != 9) {
                          return AppLocalizations.of(context)!.pnmb9d;
                        }
                        return null;
                      },
                      onchanged: () {}),
                  TextFieldWidget(
                      obscureText: showPassword,
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      controller: passwordController,
                      hintText: AppLocalizations.of(context)!.password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.eypc}";
                        }
                        if (value.length < 8) {
                          return AppLocalizations.of(context)!.pmb8c;
                        }
                        return null;
                      },
                      onchanged: () {}),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClickableText(
                          text: AppLocalizations.of(context)!.forgotpassword,
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return MainButton(
                        isActive: buttonEnabled,
                        inProgress: authProvider.isLoading,
                        text: AppLocalizations.of(context)!.signin,
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => OtpScreen(
                                        nextBtnText:
                                            AppLocalizations.of(context)!
                                                .signin,
                                        onNext: () {
                                          authProvider.login({
                                            "phone": phoneController.text,
                                            "password": passwordController.text,
                                            "firebase_uid": FirebaseAuth
                                                .instance.currentUser!.uid,
                                          }, context).then((logedIn) {
                                            if (logedIn) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          const ScreenRouter()),
                                                  (route) => false);
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                        phoneNumber: phoneController.text,
                                      )));
                        });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.donthaveaccount,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ClickableText(
                          text: AppLocalizations.of(context)!.signup,
                          color: mainColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
