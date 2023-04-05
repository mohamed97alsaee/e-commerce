import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../helpers/consts.dart';
import '../../../main.dart';
import '../../../providers/dark_theme_provider.dart';
import '../../helpers/functions_helper.dart';
import '../../screens/auth_screens/login_screen.dart';
import '../clickable_widgets/drawer_tile.dart';

class DrawerWidget extends StatefulWidget {
  // final UserModel userModel;

  const DrawerWidget({
    Key? key,
    // required this.userModel,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: false);
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: themeListener.isDark ? darkGreyColor : lightWihteColor,
      child: SafeArea(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: themeListener.isDark ? darkGreyColor : lightWihteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // authProvider.status == Status.authenticated

                  auth.currentUser != null
                      ? Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8, vertical: 20),
                            //   child: Column(children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     CircleAvatar(
                            //       radius: size.width / 10,
                            //       backgroundColor: mainColor
                            //           .withOpacity(0.5)
                            //           .withOpacity(0.2),
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(50),
                            //         child: Image.network(
                            //             // widget.userModel.user.profilePhoto.toString(),
                            //             'https://thispersondoesnotexist.com/image',
                            //             fit: BoxFit.cover,
                            //             scale: 0.5,
                            //             loadingBuilder:
                            //                 (BuildContext context,
                            //                     Widget child,
                            //                     ImageChunkEvent?
                            //                         loadingProgress) {
                            //               if (loadingProgress == null) {
                            //                 return SizedBox(
                            //                     width:
                            //                         (size.width / 10) * 2,
                            //                     height:
                            //                         (size.width / 10) * 2,
                            //                     child: child);
                            //               }
                            //               return Center(
                            //                 child:
                            //                     CircularProgressIndicator(
                            //                   color: themeListener.isDark
                            //                       ? lightWihteColor
                            //                       : mainColor,
                            //                   value: loadingProgress
                            //                               .expectedTotalBytes !=
                            //                           null
                            //                       ? loadingProgress
                            //                               .cumulativeBytesLoaded /
                            //                           loadingProgress
                            //                               .expectedTotalBytes!
                            //                       : null,
                            //                 ),
                            //               );
                            //             },
                            //             errorBuilder:
                            //                 (context, url, error) => Text(
                            //                     getInitials(
                            //                       string: ' BABAK USER',
                            //                     ).toUpperCase(),
                            //                     style: TextStyle(
                            //                       fontSize: 20,
                            //                       color:
                            //                           themeListener.isDark
                            //                               ? lightWihteColor
                            //                               : darkGreyColor,
                            //                     )),
                            //             width: size.width / 5),
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 15,
                            //     ),
                            //     Column(
                            //       crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           // widget.userModel.user.name
                            //           'BABAK USER'.substring(
                            //             0,
                            //             // widget.userModel.user.name
                            //             'BABAK USER'.indexOf(" "),
                            //           ),
                            //           style: TextStyle(
                            //               color: themeListener.isDark
                            //                   ? lightWihteColor
                            //                   : darkGreyColor,
                            //               fontSize: 14,
                            //               overflow: TextOverflow.ellipsis,
                            //               fontWeight: FontWeight.w600),
                            //         ),
                            //         const SizedBox(
                            //           height: 7.5,
                            //         ),
                            //         Text(
                            //           // widget.userModel.user.code
                            //           '82798473473'.toString(),
                            //           style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w500,
                            //             color: themeListener.isDark
                            //                 ? mainColor.withOpacity(0.5)
                            //                 : mainColor,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // )
                            //   ]),
                            // ),
                            Column(
                              children: [
                                // DrawerTile(
                                //   icon: FontAwesomeIcons.userPen,
                                //   title:
                                //       AppLocalizations.of(context)!.userprofile,
                                //   onPressed: () {
                                //     Navigator.push(
                                //       context,
                                //       CupertinoPageRoute(
                                //           builder: ((context) =>
                                //               const UpdateProfileScreen())),
                                //     ).then((value) {
                                //       Navigator.pop(context);
                                //     });
                                //   },
                                // ),
                                // DrawerTile(
                                //   icon: FontAwesomeIcons.clock,
                                //   title: AppLocalizations.of(context)!
                                //       .transactionhistory,
                                //   onPressed: () {
                                //     Navigator.push(
                                //       context,
                                //       CupertinoPageRoute(
                                //           builder: ((context) =>
                                //               const TransactionsHistoryScreen())),
                                //     );
                                //   },
                                // ),
                                // DrawerTile(
                                //     title: AppLocalizations.of(context)!
                                //         .changepassword,
                                //     icon: FontAwesomeIcons.key,
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         CupertinoPageRoute(
                                //             builder: ((context) =>
                                //                 const ResetPasswordScreen())),
                                //       );
                                //     }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mohamed Alfaitory",
                                            style: TextStyle(
                                                color: themeListener.isDark
                                                    ? lightWihteColor
                                                    : darkGreyColor,
                                                fontSize: 20,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            'Level 1',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.6,
                                            child: LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor:
                                                  mainColor.withOpacity(0.2),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    thickness: 0.2,
                                    color: themeListener.isDark
                                        ? lightWihteColor.withOpacity(0.5)
                                        : darkGreyColor.withOpacity(0.5),
                                  ),
                                ),
                                ExpansionTile(
                                  collapsedBackgroundColor: Colors.transparent,
                                  leading: FaIcon(
                                    FontAwesomeIcons.language,
                                    color: themeListener.isDark
                                        ? lightWihteColor
                                        : darkGreyColor,
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .changelanguage,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: themeListener.isDark
                                            ? lightWihteColor
                                            : darkGreyColor),
                                  ),
                                  textColor: themeListener.isDark
                                      ? lightWihteColor
                                      : mainColor,
                                  iconColor: themeListener.isDark
                                      ? lightWihteColor
                                      : mainColor,
                                  collapsedIconColor: themeListener.isDark
                                      ? lightWihteColor.withOpacity(0.5)
                                      : mainColor.withOpacity(0.5),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Divider(
                                        thickness: 0.2,
                                        color: themeListener.isDark
                                            ? lightWihteColor.withOpacity(0.5)
                                            : darkGreyColor.withOpacity(0.5),
                                      ),
                                    ),
                                    DrawerTile(
                                        title: AppLocalizations.of(context)!
                                            .arabic,
                                        icon: Icons.language_rounded,
                                        onPressed: () {
                                          MyApp.setLocale(
                                              context, const Locale('ar'));
                                          setLang('ar');
                                        }),
                                    DrawerTile(
                                      title:
                                          AppLocalizations.of(context)!.english,
                                      icon: Icons.language_rounded,
                                      onPressed: () {
                                        MyApp.setLocale(
                                            context, const Locale('en'));
                                        setLang('en');
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    thickness: 0.2,
                                    color: themeListener.isDark
                                        ? lightWihteColor.withOpacity(0.5)
                                        : darkGreyColor.withOpacity(0.5),
                                  ),
                                ),
                                // DrawerTile(
                                //     title: AppLocalizations.of(context)!
                                //         .banktransfer,
                                //     icon: FontAwesomeIcons.buildingColumns,
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         CupertinoPageRoute(
                                //             builder: ((context) =>
                                //                 const RefundScreen())),
                                //       );
                                //     }),

                                DrawerTile(
                                    title:
                                        AppLocalizations.of(context)!.contactus,
                                    icon: FontAwesomeIcons.phone,
                                    onPressed: () {}),
                                DrawerTile(
                                    title:
                                        AppLocalizations.of(context)!.support,
                                    icon: FontAwesomeIcons.headphones,
                                    onPressed: () {}),
                                DrawerTile(
                                    title: AppLocalizations.of(context)!
                                        .privacypolicy,
                                    icon: FontAwesomeIcons.fileShield,
                                    onPressed: () {}),
                                // ExpansionTile(
                                //   collapsedBackgroundColor: Colors.transparent,
                                //   leading: FaIcon(
                                //     Icons.support_agent,
                                //     color: themeListener.isDark
                                //         ? lightWihteColor
                                //         : darkGreyColor,
                                //   ),
                                //   title: Text(
                                //     AppLocalizations.of(context)!.contactus,
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w600,
                                //         fontSize: 14,
                                //         color: themeListener.isDark
                                //             ? lightWihteColor
                                //             : darkGreyColor),
                                //   ),
                                //   textColor: themeListener.isDark
                                //       ? lightWihteColor
                                //       : mainColor,
                                //   iconColor: themeListener.isDark
                                //       ? lightWihteColor
                                //       : mainColor,
                                //   collapsedIconColor: themeListener.isDark
                                //       ? lightWihteColor.withOpacity(0.5)
                                //       : mainColor.withOpacity(0.5),
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 10),
                                //       child: Divider(
                                //         thickness: 0.2,
                                //         color: themeListener.isDark
                                //             ? lightWihteColor.withOpacity(0.5)
                                //             : darkGreyColor.withOpacity(0.5),
                                //       ),
                                //     ),
                                //     DrawerTile(
                                //         title: AppLocalizations.of(context)!
                                //             .viaphone,
                                //         icon: Icons.phone,
                                //         onPressed: () {
                                //           FlutterPhoneDirectCaller.callNumber(
                                //               '0612236644');
                                //         }),
                                //   ],
                                // ),
                                DrawerTile(
                                    title: themeListener.isDark
                                        ? AppLocalizations.of(context)!
                                            .lightmode
                                        : AppLocalizations.of(context)!
                                            .darkmode,
                                    icon: themeListener.isDark
                                        ? Icons.light_mode
                                        : Icons.dark_mode,
                                    onPressed: () {
                                      themeFunctions.switchMode();
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     CupertinoPageRoute(
                                      //         builder: (context) =>
                                      //             const ScreenRouter()),
                                      //     (route) => false);
                                    }),
                              ],
                            ),
                          ],
                        )

                      // just change to push after reset git.
                      : Column(
                          children: [
                            DrawerTile(
                                title: AppLocalizations.of(context)!.signin,
                                icon: FontAwesomeIcons.rightToBracket,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: ((context) =>
                                            const LoginScreen())),
                                  );
                                }),
                          ],
                        ),
                  Column(
                    children: [
                      auth.currentUser != null
                          ? DrawerTile(
                              title: AppLocalizations.of(context)!.logout,
                              icon: FontAwesomeIcons.rightFromBracket,
                              onPressed: () async {
                                auth.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: ((context) => const MyApp())),
                                    (route) => false);
                                // authProvider.logOut().then((value) {
                                //   value ?

                                //       : Navigator.pop(context);
                                // });
                              },
                              withDivider: false,
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: FaIcon(
                                FontAwesomeIcons.copyright,
                                color: themeListener.isDark
                                    ? lightWihteColor.withOpacity(0.5)
                                    : darkGreyColor.withOpacity(0.5),
                                size: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                canLaunchUrl(Uri.parse('https://vue.ly/'))
                                    .then((canBelaunched) {
                                  if (canBelaunched) {
                                    launchUrl(Uri.parse('https://vue.ly/'));
                                  } else {
                                    if (kDebugMode) {
                                      print("can't launch url");
                                    }
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(AppLocalizations.of(context)!.dbv,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: themeListener.isDark
                                            ? lightWihteColor.withOpacity(0.5)
                                            : darkGreyColor.withOpacity(0.5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
