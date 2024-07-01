import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ShowAlertOrProgress {
  static progressCustom({
    required SimpleFontelicoProgressDialog pd,
  }) async {
    pd.show(
      width: deviceWidth(pd.context),
      type: SimpleFontelicoProgressDialogType.custom,
      backgroundColor: Colors.transparent,
      loadingIndicator: Column(
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
      message: '',
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }

  static alertFiturInProgress({
    required BuildContext context,
  }) async {
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
