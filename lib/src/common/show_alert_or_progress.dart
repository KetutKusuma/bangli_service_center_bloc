import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShowAlertOrProgress {
  static ProgressDialog progressCustom({
    required BuildContext context,
    bool? isDismiss = false,
  }) {
    ProgressDialog pd = ProgressDialog(
      context,
      isDismissible: isDismiss,
      type: ProgressDialogType.normal,
    );
    pd.style(
      backgroundColor: Colors.transparent,
      progressWidget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: rotationFlowerAnimation,
          ),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(
                'Tunggu sebentar ...',
                speed: const Duration(milliseconds: 20),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
      // message: "Tunggu sebentar...",
      // textStyle: const TextStyle(
      //   color: Colors.white,
      //   fontSize: 15,
      // ),
    );
    return pd;
  }

  static alertFiturInProgress({
    required BuildContext context,
  }) {
    Alert(
      context: context,
      style: alertStyleWithoutButton,
      type: AlertType.warning,
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
        child: Image.asset(
          'assets/icon/maintence-gif.gif',
          height: 180,
          // repeat: ImageRepeat.repeat,
        ),
      ),
      title: 'Maintence',
      desc: 'Maaf fitur sedang dikembangkan',
    ).show();
  }
}
