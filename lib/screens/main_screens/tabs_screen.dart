import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/main_screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/consts.dart';
import '../../models/product_model.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/cart_button.dart';
import '../../widgets/static_widgets/custom_drawer_widget.dart';
import '../sub_screens/notifications_screen.dart';
import './products_screen.dart';
import './profile_screen.dart';
import 'history_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        // key: _scaffoldKey,
        // floatingActionButton: const DebuggingButtons(),
        //
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     FirebaseFirestore firestore = FirebaseFirestore.instance;
        //     firestore
        //         .collection('products')
        //         .add(ProductModel(
        //                 categoryUid: 'sOk0HL3usOwj6xC8svo7',
        //                 imageUrl:
        //                     'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MPLT3ref_VW_34FR+watch-45-alum-midnight-cell-8s_VW_34FR_WF_CO?wid=1400&hei=1400&trim=1%2C0&fmt=p-jpg&qlt=95&.v=1660778409162%2C1661968677801',
        //                 nameAr: "ساعة أبل",
        //                 nameEn: 'Apple Watch',
        //                 price: '1950')
        //             .toJson())
        //         .then((value) {
        //       if (kDebugMode) {
        //         print(value.id);
        //       }
        //     });
        //   },
        //   child: const Icon(Icons.add),
        // ),
        //
        appBar: AppBar(
          // leading: IconButton(
          //     icon: FaIcon(
          //         size: 25,
          //         FontAwesomeIcons.barsStaggered,
          //         color:
          //             themeListener.isDark ? lightWihteColor : darkGreyColor),
          //     onPressed: () {
          //       _scaffoldKey.currentState!.openDrawer();
          //     }),
          actions: [
            const CartButton(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const NotificationsScreen()));
                },
                icon: Image.asset('assets/icons/notificationIcon.png',
                    width: 25,
                    height: 25,
                    color: themeListener.isDark
                        ? lightWihteColor
                        : darkGreyColor)),
          ],
        ),
        drawer: const DrawerWidget(),
        body: RefreshIndicator(
          onRefresh: () {
            if (kDebugMode) {
              print("REFRESH INDICATOR");
            }
            return Future.delayed(const Duration(seconds: 1));
          },
          child: AnimatedSwitcher(
              duration: animationDuration,
              child: currentIndex == 0
                  ? const ProductsScreen()
                  : currentIndex == 1
                      ? const WalletScreen()
                      : currentIndex == 2
                          ? const HistoryScreen()
                          : currentIndex == 3
                              ? const ProfileScreen()
                              : Container()),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                backgroundColor:
                    themeListener.isDark ? darkGreyColor : lightWihteColor,
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset('assets/icons/homeIcon.png',
                      color: currentIndex == 0
                          ? mainColor
                          : themeListener.isDark
                              ? lightWihteColor
                              : Colors.grey,
                      width: 25,
                      height: 25),
                ),
                label: AppLocalizations.of(context)!.home),
            BottomNavigationBarItem(
                backgroundColor:
                    themeListener.isDark ? darkGreyColor : lightWihteColor,
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset('assets/icons/walletIcon.png',
                      color: currentIndex == 1
                          ? mainColor
                          : themeListener.isDark
                              ? lightWihteColor
                              : Colors.grey,
                      width: 25,
                      height: 25),
                ),
                label: AppLocalizations.of(context)!.wallet),
            BottomNavigationBarItem(
                backgroundColor:
                    themeListener.isDark ? darkGreyColor : lightWihteColor,
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset('assets/icons/historyIcon.png',
                      color: currentIndex == 2
                          ? mainColor
                          : themeListener.isDark
                              ? lightWihteColor
                              : Colors.grey,
                      width: 25,
                      height: 25),
                ),
                label: AppLocalizations.of(context)!.history),
            BottomNavigationBarItem(
                backgroundColor:
                    themeListener.isDark ? darkGreyColor : lightWihteColor,
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset('assets/icons/userIcon.png',
                      color: currentIndex == 3
                          ? mainColor
                          : themeListener.isDark
                              ? lightWihteColor
                              : Colors.grey,
                      width: 25,
                      height: 25),
                ),
                label: AppLocalizations.of(context)!.account),
          ],
        ));
  }
}
