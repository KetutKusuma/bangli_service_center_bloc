import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FilledCustomButton extends StatelessWidget {
  const FilledCustomButton({
    required this.label,
    required this.color,
    required this.onTap,
    required this.elevation,
    Key? key,
    this.fontSize,
  }) : super(key: key);

  final String? label;
  final void Function()? onTap;
  final Color? color;
  final double elevation;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: color,
        // elevation: 10,
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Center(
              child: Text(
                label!,
                style: GoogleFonts.poppins(
                  fontSize: fontSize ?? 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilledWithIconCustomButton extends StatelessWidget {
  const FilledWithIconCustomButton({
    required this.label,
    required this.color,
    required this.onTap,
    required this.elevation,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String? label;
  final void Function()? onTap;
  final Color? color;
  final double elevation;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: color,
        // elevation: 10,
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FaIcon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
