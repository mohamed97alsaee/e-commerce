import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';

import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import '../../widgets/input_widgets/text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../handling_screens/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> registerForm = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  bool showPassword = true;
  bool buttonEnabled = false;
  bool agreed = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
            key: registerForm,
            onChanged: () {
              setState(() {
                buttonEnabled = registerForm.currentState!.validate();
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
                      AppLocalizations.of(context)!.signup,
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
                      AppLocalizations.of(context)!.stutaf,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFieldWidget(
                      controller: firstNameController,
                      hintText: AppLocalizations.of(context)!.firstname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enter} ${AppLocalizations.of(context)!.firstname}";
                        }
                        if (value.length < 2) {
                          return AppLocalizations.of(context)!.nmb2cal;
                        }
                        return null;
                      },
                      onchanged: () {}),
                  TextFieldWidget(
                      controller: lastNameController,
                      hintText: AppLocalizations.of(context)!.lastname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enter} ${AppLocalizations.of(context)!.lastname}";
                        }
                        if (value.length < 2) {
                          return AppLocalizations.of(context)!.nmb2cal;
                        }
                        return null;
                      },
                      onchanged: () {}),
                  TextFieldWidget(
                      controller: emailController,
                      hintText: AppLocalizations.of(context)!.emailaddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enter} ${AppLocalizations.of(context)!.emailaddress}";
                        }
                        if (!value.contains("@") || !value.contains(".com")) {
                          return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enter} ${AppLocalizations.of(context)!.validemailaddress}";
                        }
                        return null;
                      },
                      onchanged: () {}),
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
                      controller: passwordConfirmationController,
                      hintText: AppLocalizations.of(context)!.password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.eypc}";
                        }
                        if (value.length < 8) {
                          return AppLocalizations.of(context)!.pmb8c;
                        }
                        if (value != passwordController.text) {
                          return AppLocalizations.of(context)!
                              .passwordsnotmatch;
                        }
                        return null;
                      },
                      onchanged: () {}),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: agreed,
                            onChanged: (agreementValue) {
                              setState(() {
                                agreed = agreementValue!;
                              });
                            }),
                        Expanded(
                          child: RichText(
                            maxLines: 2,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.iato} ",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.termsandconditions} ",
                                  style: const TextStyle(
                                      color: mainColor, fontSize: 15)),
                              TextSpan(
                                  text: "${AppLocalizations.of(context)!.and} ",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                              TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.privacypolicy} ",
                                  style: const TextStyle(
                                      color: mainColor, fontSize: 15)),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return MainButton(
                        isActive: buttonEnabled && agreed,
                        inProgress: authProvider.isLoading,
                        text: AppLocalizations.of(context)!.createaccount,
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => OtpScreen(
                                      phoneNumber: phoneController.text,
                                      onNext: () {
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .register({
                                          "phone": phoneController.text,
                                          "password": passwordController.text,
                                          "password_confirmation":
                                              passwordConfirmationController
                                                  .text,
                                          "first_name":
                                              firstNameController.text,
                                          "last_name": lastNameController.text,
                                          "email": emailController.text,
                                          "fcm_token": FirebaseMessaging
                                              .instance
                                              .getToken()
                                              .toString(),
                                          "firebase_uid": FirebaseAuth
                                              .instance.currentUser!.uid,
                                        }, context).then((registered) {
                                          if (registered) {
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
                                      nextBtnText: AppLocalizations.of(context)!
                                          .createaccount)));
                        });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.doyouhaveanaccount,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ClickableText(
                          text: AppLocalizations.of(context)!.signin,
                          color: mainColor,
                          onPressed: () {
                            Navigator.pop(context);
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
