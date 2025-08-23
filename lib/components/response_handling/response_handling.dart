import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:toast/toast.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/dialogs/response_alert_dialog.dart';
import 'package:afaq/locale/localization.dart';

handleUnauthenticated(BuildContext context) {
  showDialog(
    barrierDismissible: false, // user must tap button!
    context: context,
    builder: (_) {
      return ResponseAlertDialog(
        alertTitle: 'عفواً',
        alertMessage: 'يرجي تسجيل الدخول مجدداً',
        alertBtn: 'موافق',
        onPressedAlertBtn: () {
          Navigator.pop(context);
          SharedPreferencesHelper.remove("user");
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login_screen',
            (Route<dynamic> route) => false,
          );
        },
      );
    },
  );
}

showErrorDialog(var message, BuildContext context) {
  showDialog(
    barrierDismissible: false, // user must tap button!
    context: context,
    builder: (_) {
      return ResponseAlertDialog(
        alertTitle: 'عفواً',
        alertMessage: message,
        alertBtn: AppLocalizations.of(context)!.ok,
        onPressedAlertBtn: () {},
      );
    },
  );
}

void showToast(BuildContext? context, {required String message, Color? color}) {
  ToastContext().init(context!);
  return Toast.show(
    message,
    backgroundColor: color == null ? cPrimaryColor : color,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
  );
}
