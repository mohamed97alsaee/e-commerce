import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../helpers/consts.dart';
import '../../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import '../../widgets/dialogs/custom_flushbar_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    required this.phoneNumber,
    required this.onNext,
    required this.nextBtnText,
  }) : super(key: key);
  final String phoneNumber;
  final String nextBtnText;

  final Function onNext;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String? verificationId;
  final GlobalKey<FormState> otpForm = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool enableNextButton = false;
  bool buttonBusy = false;
  bool showSendNewCode = false;

  verify() async {
    Timer(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          showSendNewCode = true;
        });
      }
    });
    if (kDebugMode) {
      print("PHONE IS from verifyPhoneNumber : +218${widget.phoneNumber} ");
    }
    await auth.verifyPhoneNumber(
      phoneNumber: '+218${widget.phoneNumber}',
      verificationCompleted: (phoneAuthCredential) async {
        if (mounted) setState(() {});
      },
      verificationFailed: (verificationFailed) async {
        showCustomFlushbar(verificationFailed.message.toString(), warningColor,
            FontAwesomeIcons.info, context);
        if (kDebugMode) {
          print('ERRO HERE :${verificationFailed.message}');
        }
      },
      codeSent: (verificationId, resendingToken) async {
        if (mounted) {
          setState(() {
            this.verificationId = verificationId;
          });
        }
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        if (mounted) {
          setState(() {
            this.verificationId = verificationId;
          });
        }
        showCustomFlushbar(
            "Expired Code", warningColor, FontAwesomeIcons.info, context);
      },
      timeout: const Duration(seconds: 30),
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    auth.currentUser!.reload();
    try {
      auth.currentUser!.reload();

      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user!.uid.toString() != 'null') {
        if (mounted) {
          setState(() {
            enableNextButton = true;
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      showCustomFlushbar(
          e.message.toString(), warningColor, FontAwesomeIcons.info, context);
    }
  }

  @override
  void initState() {
    !showSendNewCode ? showSendNewCode = false : showSendNewCode = true;

    verify();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SafeArea(
          child: Form(
              key: otpForm,
              onChanged: () {
                if (mounted) setState(() {});
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
                        AppLocalizations.of(context)!.entercode,
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
                        "${AppLocalizations.of(context)!.entervefrificationcodesenttp} 0${widget.phoneNumber}",
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.95,
                        height: size.height * 0.2,
                        child: Center(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              enablePinAutofill: true,
                              cursorColor: themeListener.isDark
                                  ? lightWihteColor
                                  : darkGreyColor,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              length: 6,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.scale,
                              pinTheme: PinTheme(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13)),
                                  disabledColor: lightWihteColor,
                                  inactiveColor: lightWihteColor,
                                  borderWidth: 0.8,
                                  inactiveFillColor: themeListener.isDark
                                      ? Colors.white12.withOpacity(0.06)
                                      : Colors.black12.withOpacity(0.06),
                                  errorBorderColor: warningColor,
                                  selectedColor: themeListener.isDark
                                      ? lightWihteColor
                                      : mainColor,
                                  selectedFillColor: themeListener.isDark
                                      ? Colors.white12.withOpacity(0.06)
                                      : Colors.black12.withOpacity(0.06),
                                  activeColor: Colors.transparent,
                                  shape: PinCodeFieldShape.box,
                                  fieldHeight: size.width / 6,
                                  fieldWidth: size.width / 8,
                                  activeFillColor: themeListener.isDark
                                      ? Colors.white12.withOpacity(0.06)
                                      : Colors.black12.withOpacity(0.06)),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              controller: otpController,
                              hintCharacter: 'X',
                              textStyle: TextStyle(
                                  color: themeListener.isDark
                                      ? lightWihteColor
                                      : darkGreyColor,
                                  fontSize: 20),
                              hintStyle: TextStyle(
                                  fontSize: 24,
                                  color: themeListener.isDark
                                      ? lightWihteColor
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold),
                              onCompleted: (v) async {
                                if (kDebugMode) {
                                  print("ON COMPLETE MTF");
                                }

                                if (kDebugMode) {
                                  print("ON COMPLETE MTF not reseved bfore");
                                }
                                PhoneAuthCredential phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId!,
                                        smsCode: otpController.text);

                                signInWithPhoneAuthCredential(
                                    phoneAuthCredential);

                                try {
                                  final authCredential =
                                      await auth.signInWithCredential(
                                          phoneAuthCredential);

                                  if (authCredential.user!.uid.toString() !=
                                      'null') {
                                    if (mounted) {
                                      setState(() {
                                        enableNextButton = true;
                                      });
                                    }
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (kDebugMode) {
                                    print(e.message);
                                  }
                                  if (mounted) setState(() {});
                                }
                              },
                              onChanged: (value) {
                                if (kDebugMode) {
                                  print(value);
                                }
                                if (mounted) setState(() {});
                              },
                              appContext: context,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    MainButton(
                      text: widget.nextBtnText,
                      onPressed: () async {
                        buttonBusy = true;
                        await widget.onNext();
                      },
                      isActive: enableNextButton,
                      inProgress: buttonBusy,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.didntreceivecode,
                              style: const TextStyle(
                                color: middleGreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          ClickableText(
                              fontSize: 14,
                              enabled: showSendNewCode,
                              text: AppLocalizations.of(context)!.resend,
                              onPressed: () async {
                                if (kDebugMode) {
                                  print("SENDED NEW CODE TO PHONE NUMBER");
                                }
                                if (mounted) {
                                  setState(() {
                                    showSendNewCode = false;
                                    enableNextButton = false;
                                    otpController.clear();
                                  });
                                }
                                await verify();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
