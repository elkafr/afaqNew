import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final Color btnColor;
  final String btnLbl;
  final VoidCallback onPressedFunction;
  final TextStyle btnStyle;
  final Color borderColor;
  final bool defaultMargin;
  final List<Color> gradientColors;
  final String? imagePath;

  const CustomButton({
    Key? key,
    required this.btnLbl,
    required this.onPressedFunction,
    this.height = 50.0,
    this.borderColor = Colors.transparent,
    this.btnColor = Colors.blue,
    this.btnStyle = const TextStyle(color: Colors.white, fontSize: 15),
    this.defaultMargin = true,
    this.gradientColors = const [Color(0xff44A73A), Color(0xffFF8D12)],
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: defaultMargin
            ? MediaQuery.of(context).size.width * 0.04
            : 0.0,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.57), // shadow for button
              blurRadius: 5, // blur radius of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressedFunction,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: borderColor),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  btnLbl,
                  style: btnStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              if (imagePath != null)
                Positioned(left: 8, top: 16, child: Image.asset(imagePath!)),
            ],
          ),
        ),
      ),
    );
  }
}
