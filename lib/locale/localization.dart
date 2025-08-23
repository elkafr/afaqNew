import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:afaq/l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  String get languageSymbol {
    return Intl.message('Language Symbol');
  }

  String get ourVision {
    return Intl.message('Our Vision');
  }

  String get next {
    return Intl.message('Next');
  }

  String get previous {
    return Intl.message('Previous');
  }

  String get finish {
    return Intl.message('Finish');
  }

  String get login {
    return Intl.message('Login');
  }

  String get email {
    return Intl.message('Email');
  }

  String get password {
    return Intl.message('Password');
  }

  String get forgetPassword {
    return Intl.message('Forget Password');
  }

  String get clickHere {
    return Intl.message('Click Here');
  }

  String get hasAccount {
    return Intl.message('Has Account');
  }

  String get register {
    return Intl.message('Register');
  }

  String get skip {
    return Intl.message('Skip');
  }

  String get phonoNoValidation {
    return Intl.message('Phone No Validation');
  }

  String get emailValidation {
    return Intl.message('Email Validation');
  }

  String get passwordValidation {
    return Intl.message('Password Validation');
  }

  String get name {
    return Intl.message('Name');
  }

  String get nameValidation {
    return Intl.message('Name Validation');
  }

  String get passwordVerify {
    return Intl.message('Password Verify');
  }

  String get passwordVerifyValidation {
    return Intl.message('Password Verify Validation');
  }

  String get passwordNotIdentical {
    return Intl.message('Password Not Identical');
  }

  String get phoneNo {
    return Intl.message('Phone No');
  }

  String get iAccept {
    return Intl.message('I Accept');
  }

  String get terms {
    return Intl.message('Terms');
  }

  String get sendMessageToMobile {
    return Intl.message('Send Message To Mobile');
  }

  String get save {
    return Intl.message('Save');
  }

  String get send {
    return Intl.message('Send');
  }

  String get acceptTerms {
    return Intl.message('Accept Terms');
  }

  String get codeToRestorePassword {
    return Intl.message('Code To Restore Password');
  }

  String get enterCodeToRestorePassword {
    return Intl.message('Enter Code To Restore Password');
  }

  String get restorePassword {
    return Intl.message('Restore Password');
  }

  String get confirmNewPassword {
    return Intl.message('Confirm New Password');
  }

  String get accountActivationCode {
    return Intl.message('Account Activation Code');
  }

  String get enterCodeToActivateAccount {
    return Intl.message('Enter Code To Activate Account');
  }

  String get confirmationOfActivation {
    return Intl.message('Confirmation Of Activation');
  }

  String get home {
    return Intl.message('Home');
  }

  String get orders {
    return Intl.message('Odrers');
  }

  String get favourite {
    return Intl.message('Favourite');
  }

  String get cart {
    return Intl.message('Cart');
  }

  String get account {
    return Intl.message('Account');
  }

  String get personalInfo {
    return Intl.message('Personal Info');
  }

  String get about {
    return Intl.message('About');
  }

  String get contactUs {
    return Intl.message('Contact Us');
  }

  String get language {
    return Intl.message('Language');
  }

  String get logOut {
    return Intl.message('Log out');
  }

  String get enter {
    return Intl.message('Enter');
  }

  String get editInfo {
    return Intl.message('Edit Info');
  }

  String get editPassword {
    return Intl.message('Edit Password');
  }

  String get oldPassword {
    return Intl.message('Old Password');
  }

  String get newPassword {
    return Intl.message('New  Password');
  }

  String get messageTitle {
    return Intl.message('Message Title');
  }

  String get messageDescription {
    return Intl.message('Message Description');
  }

  String get textValidation {
    return Intl.message('Text Validation');
  }

  String get or {
    return Intl.message('Or');
  }

  String get arabic {
    return Intl.message('Arabic');
  }

  String get english {
    return Intl.message('English');
  }

  String get wantToLogout {
    return Intl.message('Want to logout ?');
  }

  String get ok {
    return Intl.message('Ok');
  }

  String get cancel {
    return Intl.message('Cancel');
  }

  String get baladiaTuraif {
    return Intl.message('Baladia Turaif');
  }

  String get aouonTuraif {
    return Intl.message('Aouon Turaif');
  }

  String get search {
    return Intl.message('Search');
  }

  String get noResults {
    return Intl.message('No Results');
  }

  String get noDepartments {
    return Intl.message('No Departments');
  }

  String get sr {
    return Intl.message('SR');
  }

  String get addToCart {
    return Intl.message('Add To Cart');
  }

  String get productDetails {
    return Intl.message('Product Details');
  }

  String get allProductDetails {
    return Intl.message('All Product Details');
  }

  String get firstLogin {
    return Intl.message('First Login');
  }

  String get productsNo {
    return Intl.message('Products No');
  }

  String get totalPrice {
    return Intl.message('Total Price');
  }

  String get applicationValue {
    return Intl.message('Application Value');
  }

  String get completePurchase {
    return Intl.message('Complete Purchase');
  }

  String get amount {
    return Intl.message('Amount');
  }

  String get purchaseRequestHasSentSuccessfully {
    return Intl.message('Purchase Request Has sent Successfully');
  }

  String get waiting {
    return Intl.message('Waiting');
  }

  String get processing {
    return Intl.message('Processing');
  }

  String get done {
    return Intl.message('Done');
  }

  String get canceled {
    return Intl.message('Canceled');
  }

  String get orderDetails {
    return Intl.message('Order Details');
  }

  String get cancelOrder {
    return Intl.message('Cancel Order');
  }

  String get wantToCancelOrder {
    return Intl.message('Want To Cancel Order?');
  }

  String get orderNo {
    return Intl.message('Order No');
  }

  String get store {
    return Intl.message('Store');
  }

  String get orderPrice {
    return Intl.message('Order Price');
  }

  String get orderDate {
    return Intl.message('Order Date');
  }

  String get orderReceiptTime {
    return Intl.message('Order Receipt Time');
  }

  String get orderStatus {
    return Intl.message('Order Status');
  }

  String get editOrder {
    return Intl.message('Edit Order');
  }

  String get saveChanges {
    return Intl.message('Save Changes');
  }

  String get addNewProduct {
    return Intl.message('Add New Product');
  }

  String get addToOrder {
    return Intl.message('AddToOrder');
  }

  String get noResultIntoCart {
    return Intl.message('No Result Into Cart');
  }

  String get sorry {
    return Intl.message('Sorry');
  }

  String get updateScreen {
    return Intl.message('update screen');
  }

  String get reconnectInternet {
    return Intl.message('reconnect Internet');
  }

  String get scanRouter {
    return Intl.message('scan Router');
  }

  String get sorryNoInternet {
    return Intl.message('sorryNoInternet');
  }

  String get notifications {
    return Intl.message('Notifications');
  }

  String get activateCode {
    return Intl.message('activate Code');
  }

  String get activation {
    return Intl.message('Activation');
  }

  String get fromStore {
    return Intl.message('From Store');
  }

  String get noNotifications {
    return Intl.message('No Notifications');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
