import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';

class HorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.035,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
      ),
      height: 1,
      color: cDarkGrey.withOpacity(0.10),
    );
  }
}
