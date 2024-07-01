import 'dart:io';
import 'package:bangli_service_center_bloc/src/common/shared/rotate_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const String logo = "assets/logo/logo_bsc_warna.png";
const String logoWhite = "assets/logo/logo_bsc_white.png";

///----COLOR----
const Color backgroundColor = Color(0xFFFAFAFA);
const Color primaryColor = Color(0xFFB73E3E);
Color primaryColorWithOpacity = primaryColor.withOpacity(0.7);
const Color greyTextColor = Color.fromARGB(255, 145, 144, 144);
const Color greenColor = Color(0xFF37B34A);
const Color grey = Color(0xFFD9D9D9);
const Color lightGrey = Color(0xFFF5F5F5);
const Color greenIconColor = Color(0xFF4BAD50);
const Color avatarBgColor = Color(0xFFEEFAFA);
const Color redColor = Color(0xFFB33737);
const Color yellowColor = Color(0xFFF4B44B);
const Color greenWAColor = Color(0xFF128C7E);
const Color billingColor = Color(0xFFCAE2F0);
const Color PDAMColor = Color(0xFFF2D9CDB);
const Color DLHColor = Color(0xFF27AE60);
const Color PLNColor = Color(0xFFF2994A);
const Color rumahSakitColor = Color(0xFFDD5353);
const Color logoColor = Color(0xFF113B86);

//---DEVICE CUSTOM SIZE VARIABLE--
double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

///---ALERT CUSTOM-----

final AlertStyle alertStyleWithButton = AlertStyle(
  animationType: AnimationType.grow,
  animationDuration: const Duration(milliseconds: 400),
  isButtonVisible: true,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  titleStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  descStyle: const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  ),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
final AlertStyle alertStyleWithoutButton = AlertStyle(
  animationType: AnimationType.grow,
  animationDuration: const Duration(milliseconds: 400),
  isButtonVisible: false,
  isCloseButton: false,
  titleStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
  descStyle: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  ),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

final AlertStyle alertStyleWithoutButtonNoDismiss = AlertStyle(
  alertPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
  animationType: AnimationType.grow,
  animationDuration: const Duration(milliseconds: 400),
  isButtonVisible: false,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  titleStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
  descStyle: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  ),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

const AlertStyle alertStyleImageWithCloseButton = AlertStyle(
  animationType: AnimationType.grow,
  animationDuration: Duration(milliseconds: 400),
  isCloseButton: true,
  isButtonVisible: false,
);

///------ TEXT STYLE CUSTOM------

const TextStyle tsTitle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

const TextStyle tsW600 = TextStyle(
  fontWeight: FontWeight.w600,
);

///----------- CHECK CONNECTION REUSEABLE -------////
Future<bool> checkConnectionReuseable() async {
  try {
    var checkConnection = await InternetAddress.lookup('google.com');
    if (checkConnection.isNotEmpty) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

///---------- CAROUSELSLIDER -----------

CarouselOptions carouselOptions = CarouselOptions(
  aspectRatio: 3.1,
  viewportFraction: 0.85,
  initialPage: 0,
  enableInfiniteScroll: true,
  reverse: false,
  autoPlay: true,
  autoPlayInterval: const Duration(seconds: 3),
  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
  autoPlayCurve: Curves.fastOutSlowIn,
  enlargeCenterPage: true,
  enlargeFactor: 0.22,
  // onPageChanged: callbackFunction,
  scrollDirection: Axis.horizontal,
);

ValueNotifier idPSC = ValueNotifier('');

RotateTut rotationFlowerAnimation = RotateTut(
  repeat: true,
  rotationsPerMinute: 80,
  child: Image.asset(
    "assets/icon/flower-white.png",
    width: 35,
  ),
);
