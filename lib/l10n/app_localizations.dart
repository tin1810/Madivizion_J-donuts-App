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

  /// Short name of the phone step
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneTitle;

  /// Phone step headline
  ///
  /// In en, this message translates to:
  /// **'Enter your phone\nnumber'**
  String get phoneHeadline;

  /// Shown after the phone field is left incomplete or invalid
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Myanmar mobile number.'**
  String get phoneInvalid;

  /// Sign-in message before the register link
  ///
  /// In en, this message translates to:
  /// **'This number is not registered. '**
  String get phoneUnknown;

  /// Link from an unknown number to registration
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get phoneRegisterLink;

  /// Registration message before the log in link
  ///
  /// In en, this message translates to:
  /// **'This number is already registered. '**
  String get phoneAlready;

  /// Link from an existing number to sign in
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get phoneLogInLink;

  /// Shown when the local account store fails
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get phoneUnavailable;

  /// Submits the current registration step
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueAction;

  /// OTP step headline
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get otpHeadline;

  /// Tells the user which number received the fake code
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent 6 digit OTP to {phone}'**
  String otpSent(String phone);

  /// Shown when the OTP is not 123456
  ///
  /// In en, this message translates to:
  /// **'That code is incorrect.'**
  String get otpIncorrect;

  /// Shown after three wrong OTP codes
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Resend the code to try again.'**
  String get otpLocked;

  /// First line under the OTP boxes
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get otpResendPrompt;

  /// Words before the resend countdown
  ///
  /// In en, this message translates to:
  /// **'resend in'**
  String get otpResendIn;

  /// Word after the resend countdown
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get otpResendMin;

  /// Resend countdown while the action is still locked
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? resend in {time} min'**
  String otpResendWaiting(String time);

  /// Text before the resend action once the timer ends
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get otpResendReady;

  /// Restarts the OTP timer and clears the lock
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get otpResendAction;

  /// Name step headline
  ///
  /// In en, this message translates to:
  /// **'What\'s your\nname?'**
  String get nameHeadline;

  /// Hint for the required first name
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get nameFirstHint;

  /// Hint for the optional last name
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get nameLastHint;

  /// Shown when the first name is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your first name.'**
  String get nameRequired;

  /// Shown when a name is longer than 50 characters
  ///
  /// In en, this message translates to:
  /// **'Use 50 characters or fewer.'**
  String get nameTooLong;

  /// Shown when a name contains digits or symbols
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only.'**
  String get nameInvalid;

  /// Date of birth step headline
  ///
  /// In en, this message translates to:
  /// **'What\'s your\ndate of birth?'**
  String get birthHeadline;

  /// Hint for the birth month
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get birthMonthHint;

  /// No description provided for @monthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get monthJanuary;

  /// No description provided for @monthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get monthFebruary;

  /// No description provided for @monthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get monthMarch;

  /// No description provided for @monthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get monthApril;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get monthJune;

  /// No description provided for @monthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get monthJuly;

  /// No description provided for @monthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get monthAugust;

  /// No description provided for @monthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get monthSeptember;

  /// No description provided for @monthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get monthOctober;

  /// No description provided for @monthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get monthNovember;

  /// No description provided for @monthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get monthDecember;

  /// Hint for the birth day
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get birthDayHint;

  /// Hint for the birth year
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get birthYearHint;

  /// Shown when month, day, or year is missing
  ///
  /// In en, this message translates to:
  /// **'Enter a complete date of birth.'**
  String get birthIncomplete;

  /// Shown for dates such as 31 April
  ///
  /// In en, this message translates to:
  /// **'Enter a real calendar date.'**
  String get birthImpossible;

  /// Shown when the date is after today
  ///
  /// In en, this message translates to:
  /// **'Date of birth cannot be in the future.'**
  String get birthFuture;

  /// Shown when the person is younger than the minimum age
  ///
  /// In en, this message translates to:
  /// **'You must be at least 13.'**
  String get birthTooYoung;

  /// Short name of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeTitle;

  /// Headline under the welcome donut tiles
  ///
  /// In en, this message translates to:
  /// **'Welcome to the\nworld of J\'donuts'**
  String get welcomeHeadline;

  /// Opens Home from the welcome screen
  ///
  /// In en, this message translates to:
  /// **'LET\'S EXPLORE'**
  String get welcomeExplore;

  /// Small banner shown while the network cannot be reached
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get offlineBanner;

  /// Spoken label when a catalog image cannot be shown
  ///
  /// In en, this message translates to:
  /// **'Image unavailable'**
  String get imageUnavailable;

  /// Short name of the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Home row of seasonal products
  ///
  /// In en, this message translates to:
  /// **'Seasonal specials💕'**
  String get homeSeasonal;

  /// Home row of popular products
  ///
  /// In en, this message translates to:
  /// **'Popular 🔥'**
  String get homePopular;

  /// Home row of products the member can order again
  ///
  /// In en, this message translates to:
  /// **'Order again'**
  String get homeOrderAgain;

  /// Tier chip beside the member name on Home
  ///
  /// In en, this message translates to:
  /// **'{tier} member'**
  String homeTierMember(String tier);

  /// Points remaining before the next tier
  ///
  /// In en, this message translates to:
  /// **'{points} points left to become {tier}'**
  String homePointsLeft(int points, String tier);

  /// Shop strip heading, using the number of shops in the database
  ///
  /// In en, this message translates to:
  /// **'There are {count} J\'Donut shops'**
  String homeShops(int count);

  /// Heading above the nearby shop cards
  ///
  /// In en, this message translates to:
  /// **'near you. 🤤'**
  String get homeNearYou;

  /// Small pill on the lead Home banner
  ///
  /// In en, this message translates to:
  /// **'Now Open'**
  String get homeNowOpen;

  /// Display-only shop action
  ///
  /// In en, this message translates to:
  /// **'EXPLORE NOW'**
  String get homeExploreNow;

  /// Display-only shop action
  ///
  /// In en, this message translates to:
  /// **'Order Online'**
  String get homeOrderOnline;

  /// Shown when a Home section has no rows
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get homeSectionEmpty;

  /// Shown when a Home section fails to read
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this section'**
  String get homeSectionError;

  /// Shown when the shared member row cannot be read
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your profile'**
  String get homeMemberError;

  /// Orange badge on a discounted product
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String homeDiscount(int percent);

  /// Reloads Home after a failed read
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeTryAgain;

  /// Bottom navigation label for Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom navigation label for Reward
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get navReward;

  /// Placeholder title for the nearby tab
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get navNearby;

  /// Placeholder title for the wallet tab
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get navWallet;

  /// Title of the Reward tab until the rewards screen is built
  ///
  /// In en, this message translates to:
  /// **'J\' Donuts Rewards'**
  String get rewardsTitle;

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

  /// Badge on a product marked new
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get productNew;

  /// Label beside the product description
  ///
  /// In en, this message translates to:
  /// **'What\'s this?'**
  String get productWhatsThis;

  /// Button that confirms the chosen quantity
  ///
  /// In en, this message translates to:
  /// **'ADD TO CART'**
  String get productAdd;

  /// Confirmation after Add to cart. Nothing is stored.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get productAdded;

  /// Shown when /product/:id is not in Drift
  ///
  /// In en, this message translates to:
  /// **'This product is not available.'**
  String get productMissing;

  /// A price in Myanmar kyat, already grouped
  ///
  /// In en, this message translates to:
  /// **'{amount} MMK'**
  String productPrice(String amount);

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
