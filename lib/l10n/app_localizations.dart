import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Name of the application
  ///
  /// In en, this message translates to:
  /// **'J\'Donuts'**
  String get appTitle;

  /// Placeholder title for the onboarding route
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get onboardingTitle;

  /// Onboarding headline under the donut circles
  ///
  /// In en, this message translates to:
  /// **'Round food for\nevery mood'**
  String get onboardingHeadline;

  /// Primary action that starts registration
  ///
  /// In en, this message translates to:
  /// **'LET\'S GET STARTED'**
  String get onboardingGetStarted;

  /// Text before the log in action
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get onboardingAccountPrompt;

  /// Action that starts sign in for an existing account
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get onboardingLogIn;

  /// Legal sentence before the terms link
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our '**
  String get onboardingLegalLead;

  /// Link that opens the terms placeholder
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get onboardingTerms;

  /// Word between the terms and privacy links
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get onboardingLegalJoin;

  /// Link that opens the privacy placeholder
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get onboardingPrivacy;

  /// Closing punctuation of the legal sentence
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get onboardingLegalEnd;

  /// Google sign-in action
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get onboardingGoogle;

  /// Apple sign-in action
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get onboardingApple;

  /// Facebook sign-in action
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get onboardingFacebook;

  /// Sheet shown when a social sign-in is tapped
  ///
  /// In en, this message translates to:
  /// **'{provider} sign-in is not connected in this test.'**
  String onboardingSocialUnavailable(String provider);

  /// Sheet shown for Terms of Use and Privacy Policy
  ///
  /// In en, this message translates to:
  /// **'This document is not included in the test build.'**
  String get onboardingDocumentUnavailable;

  /// Title of the phone step until that screen is built
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneTitle;

  /// Placeholder title for the home route
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Placeholder title for the settings route
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Action that clears the saved session
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// Placeholder title for a product route
  ///
  /// In en, this message translates to:
  /// **'Product {id}'**
  String productTitle(String id);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
