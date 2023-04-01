import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/consts.dart';
import '../../widgets/clickable_widgets/notifications_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notifications),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount:
                    // cartConsumer.isLoading?
                    4, // : cartConsumer.cartItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return const AnimatedSwitcher(
                      duration: animationDuration,
                      child:
                          // cartConsumer.isLoading
                          //     ? Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: ShimmerWidget(
                          //           height: size.height * 0.12,
                          //         ),
                          //       )
                          //     :
                          NotificationCard());
                }),
          ],
        ),
      ),
    );
  }
}
