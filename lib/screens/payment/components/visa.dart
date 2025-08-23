import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

class Visa extends StatefulWidget {
  @override
  _VisaState createState() => _VisaState();
}

class _VisaState extends State<Visa> {
  double _height = 0, _width = 0;

  dynamic _pickImageError;

  Services _services = Services();

  bool _initialRun = true;

  final _imagePicker = ImagePicker();
  String _bankName = '', _bankAcount = '', _bankIban = '';

  final _formKey = GlobalKey<FormState>();
  String _accountOwner = '', _accountNo = '', _iban = '', _imgIsDetected = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(100),
        child: Center(
          child: Text(
            "قريبا",
            style: TextStyle(fontSize: 25, color: cPrimaryColor),
          ),
        ),
      ),
    );
  }
}
