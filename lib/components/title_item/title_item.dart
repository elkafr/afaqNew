import 'package:flutter/material.dart';

import 'package:afaq/utils/app_colors.dart';

// حدد العنوان ، أدخل رقم التواصل
class TitleItem extends StatelessWidget {
  final String? title;

  const TitleItem({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: width * 0.04, left: width * 0.04),
              child: Divider(color: Colors.grey[400], height: 2, thickness: 1),
            ),
          ),
          Center(
            child: Text(
              title!,
              style: TextStyle(
                color: cPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
              child: Divider(color: Colors.grey[400], height: 2, thickness: 1),
            ),
          ),
        ],
      ),
    );
  }
}
