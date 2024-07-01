import 'package:flutter/material.dart';

import '../../constant.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor, width: 3),
          ),
          child: Center(
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineButtonCustomColor extends StatelessWidget {
  const OutlineButtonCustomColor({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor,
    this.colorBackground,
    this.borderColor,
    this.icon,
  });

  final String? title;
  final void Function()? onTap;
  final Color? textColor, colorBackground, borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(5),
          height: 45,
          decoration: BoxDecoration(
            color: colorBackground ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor ?? primaryColor, width: 3),
          ),
          child: Center(
            child: Row(
              children: [
                icon == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Tab(
                          icon: icon,
                        ),
                      ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor ?? primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineButtonSmall extends StatelessWidget {
  const OutlineButtonSmall({
    super.key,
    required this.title,
    required this.onTap,
    this.paddHorizontal,
    this.paddVertical,
    this.fontsize,
  });

  final String? title;
  final void Function()? onTap;
  final double? paddHorizontal, paddVertical, fontsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddHorizontal ?? 0,
            vertical: paddVertical ?? 0,
          ),
          // height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor, width: 3),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: fontsize ?? 15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
