import 'package:flutter/material.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/utils/app_colors.dart';

import 'package:provider/provider.dart';

import '../../components/app_repo/app_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _height = 0, _width = 0;

  AppState? _appState;

  Widget _buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(title, style: TextStyle(color: cBlack, fontSize: 16)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(value, style: TextStyle(color: cBlack, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Container(
        height: _height,
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            _buildRow(
              '${AppLocalizations.of(context)?.name}     :',
              _appState!.currentUser!.userName ?? "",
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 30),
            ),
            _buildRow(
              '${AppLocalizations.of(context)?.phoneNo}          :',
              _appState?.currentUser?.userPhone ?? "",
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 30),
            ),
            _buildRow(
              '${AppLocalizations.of(context)?.email}   :',
              _appState?.currentUser?.userEmail ?? "",
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 30),
            ),

            _buildRow(
              'المدينة              :      ',
              _appState?.currentUser?.userCity ?? '',
            ),

            Spacer(),

            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: _width * 0.45,
                    height: 50,
                    child: CustomButton(
                      // buttonOnDialog: true,
                      btnStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: cWhite,
                      ),
                      btnLbl: "تعديل المعلومات الشخصية",
                      onPressedFunction: () {
                        Navigator.pushNamed(
                          context,
                          '/modify_personal_info_screen',
                        );
                      },
                    ),
                  ),
                  Container(
                    width: _width * 0.45,
                    height: 50,
                    child: CustomButton(
                      // buttonOnDialog: true,
                      //    btnStyle: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w700,
                      //       color: cAccentColor),
                      btnLbl: AppLocalizations.of(context)!.editPassword,
                      btnColor: cWhite,
                      borderColor: cLightRed,
                      onPressedFunction: () {
                        Navigator.pushNamed(context, '/modify_password_screen');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context)!.personalInfo,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: GestureDetector(
        child: Consumer<AppState>(
          builder: (context, appState, child) {
            return appState.currentLang == 'ar'
                ? Image.asset('assets/images/back.png')
                : Image.asset('assets/images/back.png');
          },
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );

    _height =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(appBar: appBar, body: _buildBodyItem()),
      ),
    );
  }
}
