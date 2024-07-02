import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_button/filled_custom_button.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_card/custom_card_white_padd.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_custom_alert/custom_alert.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_form/custom_form_field.dart';
import 'package:bangli_service_center_bloc/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:bangli_service_center_bloc/src/presentation/screens/main_page_view/main_page_view.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? isObsecurePass;
  TextEditingController? phoneController, passwordController;
  late ProgressDialog pd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pd = ProgressDialog(context);
    pd.style(
      message: 'Loading...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
        fontWeight: FontWeight.w600,
      ),
    );
    isObsecurePass = true;
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log("stete : ${state is AuthFailure}");
        if (state is AuthSuccess) {
          pd.hide();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPageView(),
            ),
            (context) => false,
          );
        } else if (state is AuthFailure) {
          log("MASOKK GA SI");
          pd.hide();
          Navigator.pop(context);
          alertError(
            isDismiss: true,
            context: context,
            desc: state.returnResponse.message,
          );
        } else if (state is AuthLoading) {}
      },
      child: DoubleTapToExit(
        snackBar: SnackBar(
          content: Text(
            'Tekan lagi untuk keluar',
            style: tsW600.copyWith(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 80),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Selamat Datang,\nBangli Emergency Center",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 15),
                    child: Image.asset(
                      logo,
                      fit: BoxFit.scaleDown,
                      width: 220,
                    ),
                  ),
                  CustomCardWhitePadd(
                    vertical: 25,
                    horizontal: 20,
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: phoneController,
                          labelText: "Nomor Handphone",
                          hintText: "Masukan nomor handphone",
                          isObscure: false,
                          keyboardType: TextInputType.phone,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: CustomFormField(
                            controller: passwordController,
                            labelText: "Password",
                            hintText: "Masukan password",
                            isObscure: isObsecurePass!,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObsecurePass = !isObsecurePass!;
                                });
                              },
                              child: Icon(
                                !isObsecurePass!
                                    ? CupertinoIcons.eye_solid
                                    : CupertinoIcons.eye_slash_fill,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FilledCustomButton(
                      label: "Masuk",
                      color: primaryColor,
                      onTap: () {
                        if (passwordController!.text.isEmpty ||
                            passwordController!.text.length < 8) {
                          alertError(
                              isDismiss: true,
                              context: context,
                              desc: passwordController!.text.isEmpty
                                  ? "Password masih kosong"
                                  : passwordController!.text.length < 8
                                      ? "Password masih kurang dari 8 karakter"
                                      : "Password masih salah");
                        } else if (phoneController!.text.isEmpty) {
                          alertError(
                              isDismiss: true,
                              context: context,
                              desc: "Nomor handphone masih kosong");
                        } else {
                          pd.show().onError((lala, e) {
                            log(
                              "lala : $lala and $e",
                            );
                            return true;
                          });
                          context.read<AuthBloc>().add(
                                LoginEvent(
                                  phone: phoneController!.text,
                                  password: passwordController!.text,
                                ),
                              );
                        }
                      },
                      elevation: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SizedBox(),
                          ),
                        );
                      },
                      child: Text(
                        "Lupa Password?",
                        style: tsW600.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun?",
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SizedBox(),
                            ),
                          );
                        },
                        child: const Text(
                          "Daftar baru yuk!",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
