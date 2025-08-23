import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/utils/app_colors.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  double _height = 0;
  double _width = 0;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(height: _height * 0.25),
        Container(
          margin: EdgeInsets.only(bottom: _height * 0.05),
          child: Icon(
            FontAwesomeIcons.key,
            size: _height * 0.12,
            color: cPrimaryColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: _height * 0.005),
          child: CustomTextFormField(
            iconIsImage: true,

            isPassword: true,
            imagePath: 'assets/images/key.png',
            hintTxt: 'كلمة المرور',
            inputData: TextInputType.text,
            onChangedFunc: (String text) {
              // _userPassword = text.toString();
            },
            validationFunc: (value) {
              return null;

              // if (value.trim().length < 8) {
              //   return 'من فضلك أدخل كلمة المرور أكبر من  8';
              // }
              // return null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: _height * 0.005),
          child: CustomTextFormField(
            iconIsImage: true,

            isPassword: true,
            imagePath: 'assets/images/key.png',
            hintTxt: 'تأكيد كلمة المرور الجديدة',
            inputData: TextInputType.text,
            onChangedFunc: (String text) {
              // _userPassword = text.toString();
            },
            validationFunc: (value) {
              return null;

              // if (value.trim().length < 8) {
              //   return 'من فضلك أدخل كلمة المرور أكبر من  8';
              // }
              // return null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: _height * 0.01),
          height: 60,
          child: CustomButton(btnLbl: 'حفظ', onPressedFunction: () {}),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
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
                appBarTitle: 'استرجاع كلمة المرور',

                trailing: IconButton(
                  icon: Image.asset('assets/images/cancel.png', color: cWhite),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Center(child: ProgressIndicatorComponent()),
          ],
        ),
      ),
    );
  }
}
