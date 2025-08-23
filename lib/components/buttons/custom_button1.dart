import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';

class CustomButton1 extends StatelessWidget {
  final double? height;
  final Color? btnColor;
  final String? btnLbl;
  final Function? onPressedFunction;
  final TextStyle? btnStyle;
  final Color? borderColor;
  final bool? defaultMargin;

  const CustomButton1({
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
      height: height == null ? 50 : height,
      width: MediaQuery.of(context).size.width * .5,
      margin: EdgeInsets.symmetric(
        horizontal: defaultMargin!
            ? MediaQuery.of(context).size.width * 0.07
            : 0.0,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
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
                  style: TextStyle(color: cWhite, fontSize: 15),
                ),
              ),

              Positioned(
                left: 2,
                top: 12,
                child: Icon(Icons.shopping_cart_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
