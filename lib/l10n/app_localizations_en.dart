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
  String get otpResendPrompt => 'Didn\'t receive the code?';

  @override
  String get otpResendIn => 'resend in';

  @override
  String get otpResendMin => 'min';

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
  String get monthJanuary => 'January';

  @override
  String get monthFebruary => 'February';

  @override
  String get monthMarch => 'March';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'May';

  @override
  String get monthJune => 'June';

  @override
  String get monthJuly => 'July';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'October';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'December';

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
  String get homeSeasonal => 'Seasonal specials💕';

  @override
  String get homePopular => 'Popular 🔥';

  @override
  String get homeOrderAgain => 'Order again';

  @override
  String homeTierMember(String tier) {
    return '$tier member';
  }

  @override
  String homePointsLeft(int points, String tier) {
    return '$points points left to become $tier';
  }

  @override
  String homeShops(int count) {
    return 'There are $count J\'Donut shops';
  }

  @override
  String get homeNearYou => 'near you. 🤤';

  @override
  String get homeNowOpen => 'Now Open';

  @override
  String get homeExploreNow => 'EXPLORE NOW';

  @override
  String get homeOrderOnline => 'Order Online';

  @override
  String get homeSectionEmpty => 'Nothing here yet';

  @override
  String get homeSectionError => 'Couldn\'t load this section';

  @override
  String get homeMemberError => 'Couldn\'t load your profile';

  @override
  String homeDiscount(int percent) {
    return '$percent% off';
  }

  @override
  String get homeTryAgain => 'Try again';

  @override
  String get navHome => 'Home';

  @override
  String get navReward => 'Reward';

  @override
  String get navNearby => 'Nearby';

  @override
  String get navWallet => 'Wallet';

  @override
  String get rewardsTitle => 'J\' Donuts Rewards';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get logOut => 'Log out';

  @override
  String get productNew => 'New';

  @override
  String get productWhatsThis => 'What\'s this?';

  @override
  String get productAdd => 'ADD TO CART';

  @override
  String get productAdded => 'Added to cart';

  @override
  String get productMissing => 'This product is not available.';

  @override
  String productPrice(String amount) {
    return '$amount MMK';
  }

  @override
  String productTitle(String id) {
    return 'Product $id';
  }
}
