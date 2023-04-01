import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/consts.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {Key? key, this.width, this.height, this.child, this.radius = 6})
      : super(key: key);
  final double? width;
  final double? height;
  final Widget? child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: middleGreyColor,
        highlightColor: Colors.white.withOpacity(0.5),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5),
              color: Colors.white10,
              borderRadius: BorderRadius.circular(radius)),
          width: width,
          height: height,
          child: child,
        ));
  }
}
