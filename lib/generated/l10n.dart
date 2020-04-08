// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get appName {
    return Intl.message(
      'BlendTV',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  String get orLoginWith {
    return Intl.message(
      'Or log in with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  String get loginContent1 {
    return Intl.message(
      'Do not have an account? So let\'s ',
      name: 'loginContent1',
      desc: '',
      args: [],
    );
  }

  String get loginContent2 {
    return Intl.message(
      ' right away',
      name: 'loginContent2',
      desc: '',
      args: [],
    );
  }

  String get loginTitle {
    return Intl.message(
      'Username',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  String get loginUsername {
    return Intl.message(
      'Username',
      name: 'loginUsername',
      desc: '',
      args: [],
    );
  }

  String get loginPassword {
    return Intl.message(
      'Password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  String get loginConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'loginConfirmPassword',
      desc: '',
      args: [],
    );
  }

  String get registerContent1 {
    return Intl.message(
      'Do you already have an account? So please ',
      name: 'registerContent1',
      desc: '',
      args: [],
    );
  }

  String get registerContent2 {
    return Intl.message(
      ' okay',
      name: 'registerContent2',
      desc: '',
      args: [],
    );
  }

  String get registerComplete {
    return Intl.message(
      'Registration successful',
      name: 'registerComplete',
      desc: '',
      args: [],
    );
  }

  String get registerContent {
    return Intl.message(
      'Thank you for taking the time to register for an account with Werry. Now start the experience!',
      name: 'registerContent',
      desc: '',
      args: [],
    );
  }

  String get fontAvenirNext {
    return Intl.message(
      'AvenirNext',
      name: 'fontAvenirNext',
      desc: '',
      args: [],
    );
  }

  String get actionConfirm {
    return Intl.message(
      'Confirm',
      name: 'actionConfirm',
      desc: '',
      args: [],
    );
  }

  String get actionCancel {
    return Intl.message(
      'Cancel',
      name: 'actionCancel',
      desc: '',
      args: [],
    );
  }

  String get viewStateMessageError {
    return Intl.message(
      'Load Failed',
      name: 'viewStateMessageError',
      desc: '',
      args: [],
    );
  }

  String get viewStateMessageNetworkError {
    return Intl.message(
      'Load Failed,Check network ',
      name: 'viewStateMessageNetworkError',
      desc: '',
      args: [],
    );
  }

  String get viewStateMessageEmpty {
    return Intl.message(
      'Nothing Found',
      name: 'viewStateMessageEmpty',
      desc: '',
      args: [],
    );
  }

  String get viewStateMessageUnAuth {
    return Intl.message(
      'Not sign in yet',
      name: 'viewStateMessageUnAuth',
      desc: '',
      args: [],
    );
  }

  String get viewStateButtonRefresh {
    return Intl.message(
      'Refresh',
      name: 'viewStateButtonRefresh',
      desc: '',
      args: [],
    );
  }

  String get viewStateButtonRetry {
    return Intl.message(
      'Retry',
      name: 'viewStateButtonRetry',
      desc: '',
      args: [],
    );
  }

  String get viewStateButtonLogin {
    return Intl.message(
      'Sign In',
      name: 'viewStateButtonLogin',
      desc: '',
      args: [],
    );
  }

  String get refreshTwoLevel {
    return Intl.message(
      'release to enter second floor',
      name: 'refreshTwoLevel',
      desc: '',
      args: [],
    );
  }

  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  String get splashSkip {
    return Intl.message(
      'Skip',
      name: 'splashSkip',
      desc: '',
      args: [],
    );
  }

  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  String get settingLanguage {
    return Intl.message(
      'Language',
      name: 'settingLanguage',
      desc: '',
      args: [],
    );
  }

  String get settingFont {
    return Intl.message(
      'System Font',
      name: 'settingFont',
      desc: '',
      args: [],
    );
  }

  String get logout {
    return Intl.message(
      'Sign Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  String get needLogin {
    return Intl.message(
      'NeedLogin',
      name: 'needLogin',
      desc: '',
      args: [],
    );
  }

  String get feedback {
    return Intl.message(
      'FeedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  String get autoBySystem {
    return Intl.message(
      'Auto',
      name: 'autoBySystem',
      desc: '',
      args: [],
    );
  }

  String get fieldNotNull {
    return Intl.message(
      'not empty',
      name: 'fieldNotNull',
      desc: '',
      args: [],
    );
  }

  String get noAccount {
    return Intl.message(
      'No Account ? ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  String get homeShows {
    return Intl.message(
      'Shows',
      name: 'homeShows',
      desc: '',
      args: [],
    );
  }

  String get homeMovies {
    return Intl.message(
      'Movies',
      name: 'homeMovies',
      desc: '',
      args: [],
    );
  }

  String get homeTVGuide {
    return Intl.message(
      'TV Guide',
      name: 'homeTVGuide',
      desc: '',
      args: [],
    );
  }

  String get homeRecordings {
    return Intl.message(
      'Recordings',
      name: 'homeRecordings',
      desc: '',
      args: [],
    );
  }

  String get homeParental {
    return Intl.message(
      'Parental Control',
      name: 'homeParental',
      desc: '',
      args: [],
    );
  }

  String get homeWatchlist {
    return Intl.message(
      'Your Watchlist',
      name: 'homeWatchlist',
      desc: '',
      args: [],
    );
  }

  String get homePackages {
    return Intl.message(
      'Packages',
      name: 'homePackages',
      desc: '',
      args: [],
    );
  }

  String get homeChannel {
    return Intl.message(
      'Channel List',
      name: 'homeChannel',
      desc: '',
      args: [],
    );
  }

  String get homeLogin {
    return Intl.message(
      'Login',
      name: 'homeLogin',
      desc: '',
      args: [],
    );
  }

  String get homeMenuProfile {
    return Intl.message(
      'My Account',
      name: 'homeMenuProfile',
      desc: '',
      args: [],
    );
  }

  String get homeMenuLogin {
    return Intl.message(
      'Login',
      name: 'homeMenuLogin',
      desc: '',
      args: [],
    );
  }

  String get homeMenuHome {
    return Intl.message(
      'Home',
      name: 'homeMenuHome',
      desc: '',
      args: [],
    );
  }

  String get homeMenuLiveTv {
    return Intl.message(
      'TV Guide',
      name: 'homeMenuLiveTv',
      desc: '',
      args: [],
    );
  }

  String get homeMenuMovies {
    return Intl.message(
      'Movies',
      name: 'homeMenuMovies',
      desc: '',
      args: [],
    );
  }

  String get homeMenuTvShow {
    return Intl.message(
      'Shows',
      name: 'homeMenuTvShow',
      desc: '',
      args: [],
    );
  }

  String get homeMenuRecord {
    return Intl.message(
      'Recordings',
      name: 'homeMenuRecord',
      desc: '',
      args: [],
    );
  }

  String get homeMenuParentControl {
    return Intl.message(
      'Parental Control',
      name: 'homeMenuParentControl',
      desc: '',
      args: [],
    );
  }

  String get homeMenuFavorite {
    return Intl.message(
      'Your Watchlist',
      name: 'homeMenuFavorite',
      desc: '',
      args: [],
    );
  }

  String get homeMenuPackage {
    return Intl.message(
      'Packages',
      name: 'homeMenuPackage',
      desc: '',
      args: [],
    );
  }

  String get homeMenuChannelList {
    return Intl.message(
      'Channel List',
      name: 'homeMenuChannelList',
      desc: '',
      args: [],
    );
  }

  String get homeMenuSpeedTest {
    return Intl.message(
      'Speed Test',
      name: 'homeMenuSpeedTest',
      desc: '',
      args: [],
    );
  }

  String get parentalControlTitle {
    return Intl.message(
      'PIN PROTECT ACCESS TO ANY OF THE FOLLOWING:',
      name: 'parentalControlTitle',
      desc: '',
      args: [],
    );
  }

  String get parentalControlEnable {
    return Intl.message(
      'Enable\nAll',
      name: 'parentalControlEnable',
      desc: '',
      args: [],
    );
  }

  String get parentalControlDone {
    return Intl.message(
      'Done',
      name: 'parentalControlDone',
      desc: '',
      args: [],
    );
  }

  String get parentalControlConfirm {
    return Intl.message(
      'Confirm',
      name: 'parentalControlConfirm',
      desc: '',
      args: [],
    );
  }

  String get parentalControlSetPin {
    return Intl.message(
      'Set PIN',
      name: 'parentalControlSetPin',
      desc: '',
      args: [],
    );
  }

  String get parentalControlChangePin {
    return Intl.message(
      'Change PIN',
      name: 'parentalControlChangePin',
      desc: '',
      args: [],
    );
  }

  String get parentalControlResetPin {
    return Intl.message(
      'Reset PIN',
      name: 'parentalControlResetPin',
      desc: '',
      args: [],
    );
  }

  String get parentalControlDefaultPinIs1234 {
    return Intl.message(
      'Please Change Default PIN 0–0-0-0, then Press Save',
      name: 'parentalControlDefaultPinIs1234',
      desc: '',
      args: [],
    );
  }

  String get parentalChangePinOk {
    return Intl.message(
      'Change PIN Confirmed!',
      name: 'parentalChangePinOk',
      desc: '',
      args: [],
    );
  }

  String get parentalChangePinError {
    return Intl.message(
      'Change PIN Failed!',
      name: 'parentalChangePinError',
      desc: '',
      args: [],
    );
  }

  String get parentalUpdateSettingOk {
    return Intl.message(
      'Update Setting Confirmed!',
      name: 'parentalUpdateSettingOk',
      desc: '',
      args: [],
    );
  }

  String get parentalUpdateSettingError {
    return Intl.message(
      'Update Failed!',
      name: 'parentalUpdateSettingError',
      desc: '',
      args: [],
    );
  }

  String get parentalResetSettingOk {
    return Intl.message(
      'Reset Setting Confirmed',
      name: 'parentalResetSettingOk',
      desc: '',
      args: [],
    );
  }

  String get parentalResetSettingError {
    return Intl.message(
      'Reset Failed',
      name: 'parentalResetSettingError',
      desc: '',
      args: [],
    );
  }

  String get verifyLockOk {
    return Intl.message(
      'PIN Code Verify Confirmed!',
      name: 'verifyLockOk',
      desc: '',
      args: [],
    );
  }

  String get verifyLockError {
    return Intl.message(
      'PIN Code Verify Failed!',
      name: 'verifyLockError',
      desc: '',
      args: [],
    );
  }

  String get parentalPc {
    return Intl.message(
      'Enable Parental Control',
      name: 'parentalPc',
      desc: '',
      args: [],
    );
  }

  String get parentalAdult {
    return Intl.message(
      'Hide Adult Content',
      name: 'parentalAdult',
      desc: '',
      args: [],
    );
  }

  String get parentalAge {
    return Intl.message(
      'Change Age Rating',
      name: 'parentalAge',
      desc: '',
      args: [],
    );
  }

  String get resetPin {
    return Intl.message(
      'Reset PIN Setting? ',
      name: 'resetPin',
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
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}