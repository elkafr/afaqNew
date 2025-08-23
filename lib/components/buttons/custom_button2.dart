import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';

class CustomButton2 extends StatelessWidget {
  final double? height;
  final Color? btnColor;
  final String? btnLbl;
  final Function? onPressedFunction;
  final TextStyle? btnStyle;
  final Color? borderColor;
  final bool? defaultMargin;

  const CustomButton2({
    Key? key,
    this.btnLbl,
    this.height,
    this.borderColor,
    this.onPressedFunction,
    this.btnColor,
    this.btnStyle,
    this.defaultMargin = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,

      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff44A73A), Color(0xffFF8D12)],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
              blurRadius: 5,
            ), //blur radius of shadow
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            onPressedFunction!();
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            //make color or elevated button transparent
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: new Text(
                  '$btnLbl',
                  style: TextStyle(color: cWhite, fontSize: 13),
                ),
              ),

              Positioned(
                left: 2,
                top: 9,
                child: Image.asset('assets/images/back1.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
