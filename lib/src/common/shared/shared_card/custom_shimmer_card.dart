import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
    this.height,
    this.width,
    this.outTop,
    this.outBot,
    this.outLeft,
    this.outRight,
    this.color,
  });

  final double? height, width, outTop, outBot, outLeft, outRight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: outTop ?? 0,
        bottom: outBot ?? 0,
        left: outLeft ?? 0,
        right: outRight ?? 0,
      ),
      child: SkeletonAnimation(
        shimmerColor: Colors.white,
        child: Container(
          height: height ?? 18,
          width: width ?? 120,
          decoration: BoxDecoration(
            color: color ?? Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
