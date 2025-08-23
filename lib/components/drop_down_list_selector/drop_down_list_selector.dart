import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';

class DropDownListSelector extends StatefulWidget {
  final List<dynamic>? dropDownList;
  final String? hint;
  final dynamic value;
  final Function? onChangeFunc;
  final bool? elementHasDefaultMargin;
  final Function? validationFunc;
  final bool? availableErrorMsg;

  const DropDownListSelector({
    Key? key,
    this.dropDownList,
    this.hint,
    this.value,
    this.onChangeFunc,
    this.validationFunc,
    this.availableErrorMsg = true,
    this.elementHasDefaultMargin = true,
  }) : super(key: key);
  @override
  _DropDownListSelectorState createState() => _DropDownListSelectorState();
}

class _DropDownListSelectorState extends State<DropDownListSelector> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validationFunc as String Function(dynamic)?,

      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              margin: widget.elementHasDefaultMargin!
                  ? EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                    )
                  : EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xffF9F9F9)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 25.0, // has the effect of softening the shadow
                    spreadRadius: 5.0, // has the effect of extending the shadow
                    offset: Offset(
                      10.0, // horizontal, move right 10
                      10.0, // vertical, move down 10
                    ),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<dynamic>(
                  isExpanded: true,

                  hint: Text(
                    widget.hint!,
                    style: TextStyle(
                      color: cHintColor,
                      fontSize: 14,
                      fontFamily: 'segoeui',
                    ),
                  ),
                  focusColor: cPrimaryColor,
                  icon: Image.asset("assets/images/arrow.png"),
                  style: TextStyle(
                    fontSize: 14,
                    color: cBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'segoeui',
                  ),
                  items:
                      widget.dropDownList as List<DropdownMenuItem<dynamic>>?,
                  onChanged: widget.onChangeFunc as void Function(dynamic)?,
                  value: widget.value,
                ),
              ),
            ),

            widget.availableErrorMsg!
                ? Container(
                    height: 10,
                    margin: widget.elementHasDefaultMargin!
                        ? EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            left: MediaQuery.of(context).size.width * 0.05,
                          )
                        : EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      state.hasError ? state.errorText! : '',
                      style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
