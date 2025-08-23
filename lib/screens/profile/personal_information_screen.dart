import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/screens/profile/modify_password_screen.dart';
import 'package:afaq/screens/profile/modify_personal_info_screen.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  double _height = 0, _width = 0;
  AppState? _appState;

  Widget _buildRow(String title, String? value, Widget icon) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
          child: icon,
        ),
        Text(
          title,
          style: TextStyle(
            color: cBlack,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        Text(
          value!,
          style: TextStyle(
            color: cBlack,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: _width * 0.03),
      ],
    );
  }

  Widget _buildBodyItem() {
    return Consumer<AppState>(
      builder: (buildContext, appState, child) {
        return Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              height: _height * 0.1,
              child: _buildRow(
                AppLocalizations.of(context)!.name,
                appState.currentUser!.userName != null
                    ? appState.currentUser!.userName
                    : "",
                Icon(Icons.person, color: cLightLemon),
              ),
            ),
            Container(
              height: _height * 0.1,
              color: Color(0xffFBF6F6),
              child: _buildRow(
                AppLocalizations.of(context)!.email,
                appState.currentUser!.userEmail != null
                    ? appState.currentUser!.userEmail
                    : appState.currentUser!.userEmail,
                Icon(Icons.email, color: cLightLemon),
              ),
            ),
            Container(
              height: _height * 0.1,
              child: _buildRow(
                AppLocalizations.of(context)!.phoneNo,
                appState.currentUser!.userPhone,
                Icon(Icons.phone, color: cLightLemon),
              ),
            ),
            Container(
              height: _height * 0.1,
              color: Color(0xffFBF6F6),
              child: _buildRow(
                "المدينة",
                appState.currentUser!.userCityName,
                Icon(Icons.location_city, color: cLightLemon),
              ),
            ),
            Spacer(),
            Divider(),
            Container(
              margin: EdgeInsets.only(
                right: _width * 0.02,
                left: _width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: _height * 0.01),
                    height: 60,
                    width: _width * 0.46,
                    child: CustomButton(
                      btnLbl: AppLocalizations.of(context)!.editInfo,
                      btnStyle: TextStyle(color: cWhite, fontSize: 12.0),
                      defaultMargin: false,
                      onPressedFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ModifyPersonalInformationScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: _height * 0.01),
                    height: 60,
                    width: _width * 0.46,
                    child: CustomButton(
                      defaultMargin: false,
                      btnStyle: TextStyle(color: cLightLemon, fontSize: 12.0),

                      btnLbl: AppLocalizations.of(context)!.editPassword,
                      btnColor: cWhite,
                      onPressedFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModifyPasswordScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _appState = Provider.of<AppState>(context);

    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context)!.personalInfo,
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
      ),
    );
  }
}
