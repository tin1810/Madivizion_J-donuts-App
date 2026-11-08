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
  String get phoneHeadline => 'Enter your phone\nnumber';

  @override
  String get phoneInvalid => 'Enter a valid Myanmar mobile number.';

  @override
  String get phoneUnknown => 'This number is not registered. ';

  @override
  String get phoneRegisterLink => 'Register';

  @override
  String get phoneAlready => 'This number is already registered. ';

  @override
  String get phoneLogInLink => 'Log in';

  @override
  String get phoneUnavailable => 'Something went wrong. Try again.';

  @override
  String get continueAction => 'CONTINUE';

  @override
  String get otpHeadline => 'Verify your number';

  @override
  String otpSent(String phone) {
    return 'We\'ve sent 6 digit OTP to $phone';
  }

  @override
  String get otpIncorrect => 'That code is incorrect.';

  @override
  String get otpLocked => 'Too many attempts. Resend the code to try again.';

  @override
  String otpResendWaiting(String time) {
    return 'Didn\'t receive the code? resend in $time min';
  }

  @override
  String get otpResendReady => 'Didn\'t receive the code? ';

  @override
  String get otpResendAction => 'Resend';

  @override
  String get nameHeadline => 'What\'s your\nname?';

  @override
  String get nameFirstHint => 'First Name';

  @override
  String get nameLastHint => 'Last Name';

  @override
  String get nameRequired => 'Enter your first name.';

  @override
  String get nameTooLong => 'Use 50 characters or fewer.';

  @override
  String get nameInvalid => 'Use letters and spaces only.';

  @override
  String get birthHeadline => 'What\'s your\ndate of birth?';

  @override
  String get birthMonthHint => 'Month';

  @override
  String get birthDayHint => 'Day';

  @override
  String get birthYearHint => 'Year';

  @override
  String get birthIncomplete => 'Enter a complete date of birth.';

  @override
  String get birthImpossible => 'Enter a real calendar date.';

  @override
  String get birthFuture => 'Date of birth cannot be in the future.';

  @override
  String get birthTooYoung => 'You must be at least 13.';

  @override
  String get welcomeTitle => 'Welcome';

  @override
  String get welcomeHeadline => 'Welcome to the\nworld of J\'donuts';

  @override
  String get welcomeExplore => 'LET\'S EXPLORE';

  @override
  String get offlineBanner => 'You\'re offline';

  @override
  String get imageUnavailable => 'Image unavailable';

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
