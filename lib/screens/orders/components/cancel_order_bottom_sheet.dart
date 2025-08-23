import 'package:afaq/components/buttons/custom_button2.dart';
import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';

class CancelOrderBottomSheet extends StatefulWidget {
  final Function? onPressedConfirmation;

  const CancelOrderBottomSheet({Key? key, this.onPressedConfirmation})
    : super(key: key);
  @override
  _CancelOrderBottomSheetState createState() => _CancelOrderBottomSheetState();
}

class _CancelOrderBottomSheetState extends State<CancelOrderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
              child: Icon(
                Icons.not_interested,
                size: constraints.maxHeight * 0.4,
                color: cLightRed,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * 0.1,
              ),
              child: Text(
                "هل تريد بالفعل الغاء الطلب",
                style: TextStyle(
                  color: cBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 35,
                  child: CustomButton2(
                    btnStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: cWhite,
                    ),

                    btnLbl: "نعم",
                    onPressedFunction: () async {
                      widget.onPressedConfirmation!();
                    },
                  ),
                ),

                Spacer(flex: 1),

                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 35,
                  child: CustomButton2(
                    btnStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: cBlack,
                    ),

                    btnLbl: "الغاء",
                    btnColor: cPrimaryColor,
                    borderColor: cPrimaryColor,
                    onPressedFunction: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ],
        );
      },
    );
  }
}
