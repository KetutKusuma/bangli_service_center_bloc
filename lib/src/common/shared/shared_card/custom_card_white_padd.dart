import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomCardWhitePadd extends StatelessWidget {
  const CustomCardWhitePadd({
    super.key,
    required this.child,
    this.horizontal = 15,
    this.vertical = 20,
    this.paddingTop = 15,
    this.paddingBottom = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.boxShadow,
  });

  final Widget child;
  final double horizontal, vertical;
  final double paddingTop, paddingBottom, paddingLeft, paddingRight;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: Container(
        width: deviceWidth(context),
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
