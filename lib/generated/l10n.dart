// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get loginTitle {
    return Intl.message('Login', name: 'loginTitle', desc: '', args: []);
  }

  /// `Enter your Login`
  String get loginForm {
    return Intl.message(
      'Enter your Login',
      name: 'loginForm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get passwordForm {
    return Intl.message(
      'Enter your Password',
      name: 'passwordForm',
      desc: '',
      args: [],
    );
  }

  /// `Don't have Account? Tap here to create!`
  String get dontHaveAccButton {
    return Intl.message(
      'Don`t have Account? Tap here to create!',
      name: 'dontHaveAccButton',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get logButton {
    return Intl.message('Login', name: 'logButton', desc: '', args: []);
  }

  /// `Registration`
  String get registrationTitle {
    return Intl.message(
      'Registration',
      name: 'registrationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get clientTab {
    return Intl.message('Client', name: 'clientTab', desc: '', args: []);
  }

  /// `Driver`
  String get driverTab {
    return Intl.message('Driver', name: 'driverTab', desc: '', args: []);
  }

  /// `Enter your Name`
  String get nameForm {
    return Intl.message(
      'Enter your Name',
      name: 'nameForm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Surname`
  String get surnameForm {
    return Intl.message(
      'Enter your Surname',
      name: 'surnameForm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email`
  String get emailForm {
    return Intl.message(
      'Enter your Email',
      name: 'emailForm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Phone`
  String get phoneForm {
    return Intl.message(
      'Enter your Phone',
      name: 'phoneForm',
      desc: '',
      args: [],
    );
  }

  /// `Create a password`
  String get passwordCreateForm {
    return Intl.message(
      'Create a password',
      name: 'passwordCreateForm',
      desc: '',
      args: [],
    );
  }

  /// `Coinfirm your password`
  String get passwordCoinfirmForm {
    return Intl.message(
      'Coinfirm your password',
      name: 'passwordCoinfirmForm',
      desc: '',
      args: [],
    );
  }

  /// `Have account? Tap here to return!`
  String get haveAccTextButton {
    return Intl.message(
      'Have account? Tap here to return!',
      name: 'haveAccTextButton',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  /// `Field can't be empty`
  String get validationFormEmpty {
    return Intl.message(
      'Field can`t be empty',
      name: 'validationFormEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid name`
  String get validationInvalidName {
    return Intl.message(
      'Enter a valid name',
      name: 'validationInvalidName',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid surname`
  String get validarionInvalidSurname {
    return Intl.message(
      'Enter a valid surname',
      name: 'validarionInvalidSurname',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get validationInvalidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'validationInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number`
  String get validationInvalidPhone {
    return Intl.message(
      'Enter a valid phone number',
      name: 'validationInvalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get validationInvalidPasswordLenth {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'validationInvalidPasswordLenth',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get validationInvalidPasswordUppercase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'validationInvalidPasswordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one digit`
  String get validationInvalidPasswordDigit {
    return Intl.message(
      'Password must contain at least one digit',
      name: 'validationInvalidPasswordDigit',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get validationInvalidPasswordSpecChar {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'validationInvalidPasswordSpecChar',
      desc: '',
      args: [],
    );
  }

  /// `Passwords didn't match`
  String get validationInvalidCoinfirmPasswordDidntMatch {
    return Intl.message(
      'Passwords didn`t match',
      name: 'validationInvalidCoinfirmPasswordDidntMatch',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credentials`
  String get firebaseErrorInvalidCredential {
    return Intl.message(
      'Invalid credentials',
      name: 'firebaseErrorInvalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered`
  String get firebaseErrorEmailInUse {
    return Intl.message(
      'This email is already registered',
      name: 'firebaseErrorEmailInUse',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get firebaseErrorInvalidEmail {
    return Intl.message(
      'Invalid email format',
      name: 'firebaseErrorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak`
  String get firebaseErrorWeekPassword {
    return Intl.message(
      'Password is too weak',
      name: 'firebaseErrorWeekPassword',
      desc: '',
      args: [],
    );
  }

  /// `User with this email does not exist`
  String get firebaseErrorUserNotFound {
    return Intl.message(
      'User with this email does not exist',
      name: 'firebaseErrorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get firebaseErrorWrongPassword {
    return Intl.message(
      'Incorrect password',
      name: 'firebaseErrorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again`
  String get firebaseErrorSomethingWrong {
    return Intl.message(
      'Something went wrong. Please try again',
      name: 'firebaseErrorSomethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Access denied. You don't have permission to edit this.`
  String get firebaseErrorPrimissionDenied {
    return Intl.message(
      'Access denied. You don\'t have permission to edit this.',
      name: 'firebaseErrorPrimissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Order not found. It might have been deleted.`
  String get firebaseErrorNotFound {
    return Intl.message(
      'Order not found. It might have been deleted.',
      name: 'firebaseErrorNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Service unavailable. Please check your internet or try later.`
  String get firebaseErrorUnavailable {
    return Intl.message(
      'Service unavailable. Please check your internet or try later.',
      name: 'firebaseErrorUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your internet or try later.`
  String get firebaseErrorNetwork {
    return Intl.message(
      'Network error. Please check your internet or try later.',
      name: 'firebaseErrorNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get bottNavBarSearch {
    return Intl.message('Search', name: 'bottNavBarSearch', desc: '', args: []);
  }

  /// `Create`
  String get bobottNavBarCreate {
    return Intl.message(
      'Create',
      name: 'bobottNavBarCreate',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get bottNavBarOrders {
    return Intl.message('Orders', name: 'bottNavBarOrders', desc: '', args: []);
  }

  /// `Profile`
  String get bottNavBarProfile {
    return Intl.message(
      'Profile',
      name: 'bottNavBarProfile',
      desc: '',
      args: [],
    );
  }

  /// `Search Transport`
  String get searchTitle {
    return Intl.message(
      'Search Transport',
      name: 'searchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Date`
  String get dateLabel {
    return Intl.message('Date', name: 'dateLabel', desc: '', args: []);
  }

  /// `From`
  String get fromFormLable {
    return Intl.message('From', name: 'fromFormLable', desc: '', args: []);
  }

  /// `To`
  String get toFormLable {
    return Intl.message('To', name: 'toFormLable', desc: '', args: []);
  }

  /// `Enter city`
  String get cityFormHint {
    return Intl.message('Enter city', name: 'cityFormHint', desc: '', args: []);
  }

  /// `Create order`
  String get createTitle {
    return Intl.message(
      'Create order',
      name: 'createTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Cargo description`
  String get cargoDescriptionLabel {
    return Intl.message(
      'Cargo description',
      name: 'cargoDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Type, quantity, special requirements`
  String get cargoDescriptionHint {
    return Intl.message(
      'Type, quantity, special requirements',
      name: 'cargoDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Cargo weight`
  String get cargoWeightLabel {
    return Intl.message(
      'Cargo weight',
      name: 'cargoWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Up to 500 kg`
  String get upTo500kg {
    return Intl.message('Up to 500 kg', name: 'upTo500kg', desc: '', args: []);
  }

  /// `500 - 1000 kg`
  String get from500To1000 {
    return Intl.message(
      '500 - 1000 kg',
      name: 'from500To1000',
      desc: '',
      args: [],
    );
  }

  /// `1000 - 1500 kg`
  String get from1000To1500 {
    return Intl.message(
      '1000 - 1500 kg',
      name: 'from1000To1500',
      desc: '',
      args: [],
    );
  }

  /// `1500 - 2000 kg`
  String get from1500to2000 {
    return Intl.message(
      '1500 - 2000 kg',
      name: 'from1500to2000',
      desc: '',
      args: [],
    );
  }

  /// `Over 2000 kg`
  String get above2000 {
    return Intl.message('Over 2000 kg', name: 'above2000', desc: '', args: []);
  }

  /// `Price`
  String get priceFormLable {
    return Intl.message('Price', name: 'priceFormLable', desc: '', args: []);
  }

  /// `Enter price`
  String get priceFormHint {
    return Intl.message(
      'Enter price',
      name: 'priceFormHint',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get ordersTitle {
    return Intl.message('Orders', name: 'ordersTitle', desc: '', args: []);
  }

  /// `Arhive`
  String get archiveTitle {
    return Intl.message('Arhive', name: 'archiveTitle', desc: '', args: []);
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Contacts`
  String get contactCont {
    return Intl.message('Contacts', name: 'contactCont', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Personal info`
  String get personalInfoCont {
    return Intl.message(
      'Personal info',
      name: 'personalInfoCont',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Upload from gallery`
  String get uploadPhotoFromGalery {
    return Intl.message(
      'Upload from gallery',
      name: 'uploadPhotoFromGalery',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo from camera`
  String get takePhotoFromCamera {
    return Intl.message(
      'Take a photo from camera',
      name: 'takePhotoFromCamera',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get avatar {
    return Intl.message('Avatar', name: 'avatar', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Edit profile`
  String get editProfileDropMenu {
    return Intl.message(
      'Edit profile',
      name: 'editProfileDropMenu',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Dark theme:`
  String get darkThemeSwith {
    return Intl.message(
      'Dark theme:',
      name: 'darkThemeSwith',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languageDropMenu {
    return Intl.message(
      'Language',
      name: 'languageDropMenu',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get dropMenuItemEng {
    return Intl.message('English', name: 'dropMenuItemEng', desc: '', args: []);
  }

  /// `Ukrainian`
  String get dropMenuItemUkr {
    return Intl.message(
      'Ukrainian',
      name: 'dropMenuItemUkr',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get dropMenuItemIt {
    return Intl.message('Italian', name: 'dropMenuItemIt', desc: '', args: []);
  }

  /// `About Us`
  String get aboutUsTitle {
    return Intl.message('About Us', name: 'aboutUsTitle', desc: '', args: []);
  }

  /// `TransitTracer`
  String get transitTracerTitle {
    return Intl.message(
      'TransitTracer',
      name: 'transitTracerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cargo transport assistant`
  String get aboutSubtitle {
    return Intl.message(
      'Cargo transport assistant',
      name: 'aboutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutTheAppTitle {
    return Intl.message(
      'About the app',
      name: 'aboutTheAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `TransitTracer helps clients quickly find drivers for cargo transportation while keeping the process simple, safe, and transparent.`
  String get aboutTheAppContent {
    return Intl.message(
      'TransitTracer helps clients quickly find drivers for cargo transportation while keeping the process simple, safe, and transparent.',
      name: 'aboutTheAppContent',
      desc: '',
      args: [],
    );
  }

  /// `Our Mission`
  String get ourMissionTitle {
    return Intl.message(
      'Our Mission',
      name: 'ourMissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Make cargo delivery fast, accessible and trustworthy for everyone.`
  String get ourMissionContent {
    return Intl.message(
      'Make cargo delivery fast, accessible and trustworthy for everyone.',
      name: 'ourMissionContent',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contactsTitle {
    return Intl.message('Contacts', name: 'contactsTitle', desc: '', args: []);
  }

  /// `Version {version}`
  String version(Object version) {
    return Intl.message(
      'Version $version',
      name: 'version',
      desc: '',
      args: [version],
    );
  }

  /// `EU / IT / UA`
  String get contactsRegions {
    return Intl.message(
      'EU / IT / UA',
      name: 'contactsRegions',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
