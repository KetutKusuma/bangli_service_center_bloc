import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_button/filled_custom_button.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_card/custom_card_white_padd.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_custom_alert/custom_alert.dart';
import 'package:bangli_service_center_bloc/src/common/shared/shared_form/custom_form_field.dart';
import 'package:bangli_service_center_bloc/src/common/show_alert_or_progress.dart';
import 'package:bangli_service_center_bloc/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? isObsecurePass;
  TextEditingController? phoneController, passwordController;
  SimpleFontelicoProgressDialog? pd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObsecurePass = true;
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    pd = SimpleFontelicoProgressDialog(
      context: context,
      barrierDimisable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog pd = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          ShowAlertOrProgress.progressCustom(pd: pd);
        } else if (state is AuthSuccess) {
          pd.hide();
          if (mounted) {
            alertSuccess(
              isDismiss: true,
              context: context,
              desc: state.returnResponseModel.message,
            );
          }
        } else if (state is AuthFailure) {
          pd.hide();
          if (mounted) {
            alertError(
              isDismiss: true,
              context: context,
              desc: state.returnResponseModel.message,
            );
          }
        }
      },
      builder: (context, state) {
        return DoubleTapToExit(
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
                        onTap: () async {
                          context.read<AuthBloc>().add(
                                LoginEvent(
                                  phone: phoneController!.text,
                                  password: passwordController!.text,
                                ),
                              );
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
        );
      },
    );
  }
}
