import 'dart:developer';

import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_custom_alert/custom_alert.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_custom_progress/custom_progress.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  late PageController pageController;
  int? pageIndex;
  SimpleFontelicoProgressDialog? pd;

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
    pd = SimpleFontelicoProgressDialog(
      context: context,
      barrierDimisable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {},
      child: DoubleTapToExit(
        snackBar: SnackBar(
          content: Text(
            'Tekan lagi untuk keluar',
            style: tsW600.copyWith(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ),
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: lightGrey,
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          // ),
          body: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            children: [
              // BerandaNewView(
              //   pageController: pageController,
              // ),
              // ProfileView(),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: primaryColor,
              onPressed: () async {
                Alert(
                  context: context,
                  style: alertStyleWithButton,
                  type: AlertType.warning,
                  title: "Peringatan",
                  // desc: "Apakah Anda ingin mengadukan pada PSC BANGLI ?",
                  desc:
                      'Apakah Anda memiliki keadaan darurat dan ingin mengadukan pada PSC BANGLI ?',
                  buttons: [
                    DialogButton(
                      color: Colors.white,
                      radius: BorderRadius.circular(10),
                      border: Border.all(
                        color: primaryColor,
                        width: 2.5,
                      ),
                      child: const Text(
                        "Ya",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        progressCustom(
                          pd: pd!,
                        );
                        if (await checkConnectionReuseable() == false) {
                          pd!.hide();
                          if (mounted) {
                            alertError(
                              isDismiss: true,
                              context: context,
                              desc:
                                  'Internetmu mungkin tidak stabil, coba lagi',
                            );
                          }
                        } else {
                          log('id psc : ${idPSC.value}');
                          if (idPSC.value == '') {
                            if (mounted) {
                              alertError(
                                context: context,
                                isDismiss: true,
                                desc:
                                    'Maaf sekarang tidak bisa melaporkan coba sekali lagi',
                              );
                            }
                          }
                          // Map<String, dynamic> result =
                          //     await berandaController!.createPengaduan(
                          //   idVendor: idPSC.value,
                          // );
                          // if (mounted) {
                          //   if (result['status']) {
                          //     pd!.hide();
                          //     Alert(
                          //       context: context,
                          //       type: AlertType.success,
                          //       style: alertStyleWithoutButton,
                          //       title: "Sukses",
                          //       desc: result['message'],
                          //     ).show().then((value) {
                          //       Navigator.pop(context);
                          //       setState(() {});
                          //     });
                          //   } else {
                          //     pd!.hide();
                          //     Alert(
                          //       context: context,
                          //       type: AlertType.error,
                          //       style: alertStyleWithoutButton,
                          //       title: "Yahhh",
                          //       desc: result['message'],
                          //     ).show().then((value) {
                          //       Navigator.pop(context);
                          //     });
                          //   }
                          // }
                        }
                      },
                    ),
                    DialogButton(
                      color: primaryColor,
                      radius: BorderRadius.circular(10),
                      child: const Text(
                        "Tidak",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();
              },
              child: const Icon(
                CupertinoIcons.exclamationmark_circle,
                size: 55,
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: SizedBox(
              height: 60,
              // color: Colors.transparent,
              child: Row(
                //children inside bottom appbar
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: deviceWidth(context) * 0.1),
                    child: Material(
                      color: Colors.transparent,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              pageIndex = 0;
                              pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                size: 28,
                                color: pageIndex == 0
                                    ? primaryColor
                                    : primaryColorWithOpacity,
                              ),
                              Text(
                                "Beranda",
                                style: TextStyle(
                                    color: pageIndex == 0
                                        ? primaryColor
                                        : primaryColorWithOpacity
                                    // fontWeight: FontWeight.w600,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                            pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 28,
                              color: pageIndex == 1
                                  ? primaryColor
                                  : primaryColorWithOpacity,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: pageIndex == 1
                                    ? primaryColor
                                    : primaryColorWithOpacity,
                                // fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
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
