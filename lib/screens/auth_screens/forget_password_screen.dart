import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/clickable_widgets/main_button_widget.dart';
import '../../widgets/input_widgets/text_field_widget.dart';
import '../handling_screens/otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> forgetPassPhoneForm = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetNewPassForm = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showPassword = true;
  bool phoneButtonEnabled = false;
  bool newPassButtonEnabled = false;

  int currentStep = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(),
        body: AnimatedSwitcher(
            duration: animationDuration,
            child: currentStep == 1
                ? SingleChildScrollView(
                    child: Form(
                      key: forgetPassPhoneForm,
                      onChanged: () {
                        setState(() {
                          phoneButtonEnabled =
                              forgetPassPhoneForm.currentState!.validate();
                        });
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: creamyColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/messageShape.png',
                                  width: size.width * 0.3,
                                  height: size.width * 0.3,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            child: Text(
                              AppLocalizations.of(context)!.resetpassword,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            child: Text(
                              AppLocalizations.of(context)!.ymhvpnaictrp,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          TextFieldWidget(
                              controller: emailController,
                              hintText: AppLocalizations.of(context)!.email,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enter} ${AppLocalizations.of(context)!.email}";
                                }

                                return null;
                              },
                              onchanged: () {}),
                          const SizedBox(
                            height: 40,
                          ),
                          MainButton(
                              isActive: phoneButtonEnabled,
                              text: AppLocalizations.of(context)!.continuue,
                              onPressed: () {
                                auth
                                    .sendPasswordResetEmail(
                                        email: emailController.text)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              })
                        ],
                      ),
                    ),
                  )
                : currentStep == 2
                    ? OtpScreen(
                        phoneNumber: phoneController.text,
                        onNext: () {
                          setState(() {
                            currentStep++;
                          });
                        },
                        nextBtnText: AppLocalizations.of(context)!.continuue,
                      )
                    : Form(
                        key: forgetNewPassForm,
                        onChanged: () {
                          setState(() {
                            newPassButtonEnabled =
                                forgetNewPassForm.currentState!.validate();
                          });
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: creamyColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/lockShape.png',
                                      width: size.width * 0.3,
                                      height: size.width * 0.3,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                child: Text(
                                  AppLocalizations.of(context)!.resetpassword,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .enterthenewpasswordandbesuretoconfirm,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
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
                                  hintText:
                                      AppLocalizations.of(context)!.password,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.eypc}";
                                    }
                                    if (value.length < 8) {
                                      return AppLocalizations.of(context)!
                                          .pmb8c;
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
                                  controller: confirmPasswordController,
                                  hintText: AppLocalizations.of(context)!
                                      .confirmpassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "${AppLocalizations.of(context)!.please} ${AppLocalizations.of(context)!.enter + AppLocalizations.of(context)!.confirmpassword}";
                                    }
                                    if (value.length < 8) {
                                      return AppLocalizations.of(context)!
                                          .pmb8c;
                                    }
                                    if (value != passwordController.text) {
                                      return AppLocalizations.of(context)!
                                          .passwordnotmatch;
                                    }
                                    return null;
                                  },
                                  onchanged: () {}),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              MainButton(
                                  text: AppLocalizations.of(context)!
                                      .resetpassword,
                                  onPressed: () {
                                    // auth.sendPasswordResetEmail(
                                    //     email: emailController.text);
                                  })
                            ],
                          ),
                        ))));
  }
}
