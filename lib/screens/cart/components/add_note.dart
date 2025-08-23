import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/models/location.dart';
import 'package:afaq/utils/app_colors.dart';

import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/services/access_api.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Services _services = Services();
  Future<List<Location>>? _locationList;
  AppState? _appState;
  bool _initialRun = true;
  String? _note;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Image.asset('assets/images/bottomTop.png'),
              ),

              Container(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ملاحظة جديدة",
                      style: TextStyle(
                        color: cText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      "اضف ملاحظاتك على الطلب",
                      style: TextStyle(color: cHintColor, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: CustomTextFormField(
                  maxLines: 20,

                  hintTxt: " ... اكتب ملاحظتك",

                  inputData: TextInputType.text,
                  onChangedFunc: (String text) {
                    _note = text.toString();
                  },
                ),
              ),

              Container(
                height: 50,
                child: CustomButton(
                  btnLbl: "إضافة ",
                  onPressedFunction: () {
                    _appState!.setCurrentNote(_note!);
                    Navigator.pop(context);
                    print(_appState!.note);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
