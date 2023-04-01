import 'package:flutter/material.dart';

import '../../helpers/consts.dart';
import '../../widgets/clickable_widgets/previous_order_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          PreviousOrderCard());
                }),
          ],
        ),
      ),
    );
  }
}
