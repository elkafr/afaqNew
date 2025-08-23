import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/locale/localization.dart';

class LogoutDialog extends StatelessWidget {
  final String? alertMessage;

  const LogoutDialog({Key? key, this.alertMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              alertMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                fontFamily: 'segoeui',
              ),
            ),
            SizedBox(height: 10),
            Divider(height: 2, color: Color(0xff707070)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'segoeui',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(width: 1, height: 30, color: Colors.black),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    SharedPreferencesHelper.remove("user");
                    appState.setCurrentUser(null);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login_screen',
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.ok,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'segoeui',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
