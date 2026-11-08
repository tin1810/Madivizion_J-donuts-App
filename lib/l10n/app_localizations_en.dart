// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'Onboarding';

  @override
  String get onboardingHeadline => 'Round food for\nevery mood';

  @override
  String get onboardingGetStarted => 'LET\'S GET STARTED';

  @override
  String get onboardingAccountPrompt => 'Already have an account? ';

  @override
  String get onboardingLogIn => 'Log in';

  @override
  String get onboardingLegalLead =>
      'By continuing, you acknowledge that you have read and agree to our ';

  @override
  String get onboardingTerms => 'Terms of Use';

  @override
  String get onboardingLegalJoin => ' and ';

  @override
  String get onboardingPrivacy => 'Privacy Policy';

  @override
  String get onboardingLegalEnd => '.';

  @override
  String get onboardingGoogle => 'Google';

  @override
  String get onboardingApple => 'Apple';

  @override
  String get onboardingFacebook => 'Facebook';

  @override
  String onboardingSocialUnavailable(String provider) {
    return '$provider sign-in is not connected in this test.';
  }

  @override
  String get onboardingDocumentUnavailable =>
      'This document is not included in the test build.';

  @override
  String get phoneTitle => 'Phone number';

  @override
  String get homeTitle => 'Home';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get logOut => 'Log out';

  @override
  String productTitle(String id) {
    return 'Product $id';
  }
}
