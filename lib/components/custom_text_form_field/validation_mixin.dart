import 'package:flutter/material.dart';

import 'package:afaq/models/category.dart';
import 'package:afaq/models/marka.dart';
import 'package:afaq/models/city.dart';
import 'dart:io';
import 'package:afaq/components/response_handling/response_handling.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String _password = '';

  // String validateKeySearch(String keySearch) {
  //   if (keySearch.trim().length == 0) {
  //     return ' يرجى إدخال كلمة البحث';
  //   }
  //   return null;
  // }

  // String validateAge(String age) {
  //   if (age.trim().length == 0 || !isNumeric(age)) {
  //     return ' يرجى إدخال العمر';
  //   }
  //   return null;
  // }

  bool checkAddProductValidation(
    BuildContext context, {
    File? imgFile,
    Marka? adMainCategory,
  }) {
    if (adMainCategory == null) {
      showToast(context, message: "يجب اختيار الماركة");
      return false;
    }
    return true;
  }

  bool checkEditProductValidation(
    BuildContext context, {
    Category? adMainCategory,
  }) {
    if (adMainCategory == null) {
      showToast(context, message: "يجب اختيار القسم");
      return false;
    }
    return true;
  }

  bool checkAddCatValidation(
    BuildContext context, {
    File? imgFile,
    Category? adMainCategory,
  }) {
    if (imgFile == null) {
      showToast(context, message: "يجب اختيار صورة");
      return false;
    }

    return true;
  }

  bool checkDriverRegisterValidation(
    BuildContext context, {
    File? imgFile,
    File? imgFile1,
    File? imgFile2,
    File? imgFile3,
    File? imgFile4,
    File? imgFile5,
    City? userCity,
  }) {
    if (imgFile == null) {
      showToast(context, message: "يجب اختيار الصورة الشخصية");
      return false;
    }

    if (imgFile1 == null) {
      showToast(context, message: "يجب اختيار صورة السيارة من الامام");
      return false;
    }

    if (imgFile2 == null) {
      showToast(context, message: "يجب اختيار صورة الهوية");
      return false;
    }

    if (imgFile3 == null) {
      showToast(context, message: "يجب اختيار صورة رخصة لقيادة");
      return false;
    }

    if (imgFile4 == null) {
      showToast(context, message: "يجب اختيار صورةاستمارة السيارة");
      return false;
    }

    if (imgFile5 == null) {
      showToast(context, message: "يجب اختيار صورة السيارة من الخلف");
      return false;
    }

    if (userCity == null) {
      showToast(context, message: "يجب اختيار المدينة");
      return false;
    }
    return true;
  }

  bool checkMtgerRegisterValidation(
    BuildContext context, {
    File? imgFile,
    City? userCity,
  }) {
    if (imgFile == null) {
      showToast(context, message: "يجب اختيار صورة من السجل التجاري ");
      return false;
    }

    if (userCity == null) {
      showToast(context, message: "يجب اختيار المدينة");
      return false;
    }

    return true;
  }
}
