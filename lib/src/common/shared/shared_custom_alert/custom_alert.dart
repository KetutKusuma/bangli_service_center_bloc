import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constant.dart';

Future customAlert({
  required BuildContext context,
  required String desc,
  title = 'Hi',
  required AlertStyle alertStyle,
  required AlertType alertType,
  List<DialogButton>? buttons,
  Widget? content,
}) async {
  return Alert(
    context: context,
    style: alertStyle,
    type: alertType,
    title: title,
    desc: desc,
    content: content!,
    buttons: buttons,
  ).show();
}

Future alertError({
  required bool isDismiss,
  required BuildContext context,
  required String desc,
  String title = 'Oops',
}) async {
  return Alert(
    context: context,
    style:
        isDismiss ? alertStyleWithoutButton : alertStyleWithoutButtonNoDismiss,
    type: AlertType.error,
    title: title,
    desc: desc,
  ).show();
}

Future alertSuccess({
  required bool isDismiss,
  required BuildContext context,
  required String desc,
  String title = 'Yeay',
}) async {
  return Alert(
    context: context,
    style:
        isDismiss ? alertStyleWithoutButton : alertStyleWithoutButtonNoDismiss,
    type: AlertType.success,
    title: title,
    desc: desc,
  ).show();
}

Future alertFiturInProgress({
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
