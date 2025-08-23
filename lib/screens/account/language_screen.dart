import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/Locale_helper.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/utils/app_colors.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  double _height = 0, _width = 0;
  AppState? _appState;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(height: 70),
        GestureDetector(
          onTap: () {
            SharedPreferencesHelper.setUserLang('ar');
            helper.onLocaleChanged!(new Locale('ar'));
            _appState!.setCurrentLanguage('ar');
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: Image.asset('assets/images/arabic.png'),
              ),
              Text(
                AppLocalizations.of(context)!.arabic,
                style: TextStyle(color: cBlack, fontSize: 15),
              ),
            ],
          ),
        ),
        Divider(height: 30),
        GestureDetector(
          onTap: () {
            SharedPreferencesHelper.setUserLang('en');
            helper.onLocaleChanged!(new Locale('en'));
            _appState!.setCurrentLanguage('en');
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: Image.asset('assets/images/english.png'),
              ),
              Text(
                AppLocalizations.of(context)!.english,
                style: TextStyle(color: cBlack, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _appState = Provider.of<AppState>(context);
    return PageContainer(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildBodyItem(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GradientAppBar(
                appBarTitle: AppLocalizations.of(context)!.language,
                leading: _appState!.currentLang == 'ar'
                    ? IconButton(
                        icon: Image.asset('assets/images/back.png'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
                trailing: _appState!.currentLang == 'en'
                    ? IconButton(
                        icon: Image.asset('assets/images/back.png'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
