// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'စတင်ခြင်း';

  @override
  String get onboardingHeadline => 'ခံစားချက်တိုင်းအတွက်\nအဝိုင်းအစားအစာ';

  @override
  String get onboardingGetStarted => 'စတင်လိုက်ကြရအောင်';

  @override
  String get onboardingAccountPrompt => 'အကောင့်ရှိပြီးသားလား။ ';

  @override
  String get onboardingLogIn => 'ဝင်မယ်';

  @override
  String get onboardingLegalLead => 'ဆက်လုပ်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ ';

  @override
  String get onboardingTerms => 'အသုံးပြုမှုစည်းမျဉ်းများ';

  @override
  String get onboardingLegalJoin => ' နှင့် ';

  @override
  String get onboardingPrivacy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get onboardingLegalEnd => ' ကို ဖတ်ရှုပြီး သဘောတူပါသည်။';

  @override
  String get onboardingGoogle => 'Google';

  @override
  String get onboardingApple => 'Apple';

  @override
  String get onboardingFacebook => 'Facebook';

  @override
  String onboardingSocialUnavailable(String provider) {
    return '$provider ဖြင့် ဝင်ရောက်ခြင်းကို ဤစမ်းသပ်မှုတွင် မချိတ်ဆက်ရသေးပါ။';
  }

  @override
  String get onboardingDocumentUnavailable =>
      'ဤစာရွက်စာတမ်းကို ဤစမ်းသပ်ဗားရှင်းတွင် မထည့်သွင်းရသေးပါ။';

  @override
  String get phoneTitle => 'ဖုန်းနံပါတ်';

  @override
  String get phoneHeadline => 'ဖုန်းနံပါတ်\nထည့်ပါ';

  @override
  String get phoneInvalid => 'မှန်ကန်သော မြန်မာဖုန်းနံပါတ် ထည့်ပါ။';

  @override
  String get phoneUnknown => 'ဤနံပါတ်ကို မှတ်ပုံတင်မထားပါ။ ';

  @override
  String get phoneRegisterLink => 'မှတ်ပုံတင်မယ်';

  @override
  String get phoneAlready => 'ဤနံပါတ်ကို မှတ်ပုံတင်ပြီးသားဖြစ်သည်။ ';

  @override
  String get phoneLogInLink => 'ဝင်မယ်';

  @override
  String get phoneUnavailable => 'တစ်ခုခု မှားယွင်းနေသည်။ ထပ်ကြိုးစားပါ။';

  @override
  String get continueAction => 'ဆက်လုပ်မယ်';

  @override
  String get otpHeadline => 'နံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSent(String phone) {
    return '$phone သို့ ဂဏန်း ၆ လုံး OTP ပို့ပြီးပါပြီ';
  }

  @override
  String get otpIncorrect => 'ကုဒ် မမှန်ပါ။';

  @override
  String get otpLocked =>
      'အကြိမ်များစွာ မှားယွင်းခဲ့သည်။ ထပ်ကြိုးစားရန် ကုဒ်ကို ပြန်ပို့ပါ။';

  @override
  String get otpResendPrompt => 'ကုဒ် မရောက်ဘူးလား။';

  @override
  String get otpResendIn => 'ပြန်ပို့ရန်';

  @override
  String get otpResendMin => 'မိနစ်';

  @override
  String otpResendWaiting(String time) {
    return 'ကုဒ် မရောက်ဘူးလား။ $time မိနစ်အတွင်း ပြန်ပို့ပါ';
  }

  @override
  String get otpResendReady => 'ကုဒ် မရောက်ဘူးလား။ ';

  @override
  String get otpResendAction => 'ပြန်ပို့မယ်';

  @override
  String get nameHeadline => 'သင့်နာမည်\nဘယ်လိုခေါ်လဲ။';

  @override
  String get nameFirstHint => 'နာမည်';

  @override
  String get nameLastHint => 'မျိုးရိုးအမည်';

  @override
  String get nameRequired => 'နာမည် ထည့်ပါ။';

  @override
  String get nameTooLong => 'စာလုံး ၅၀ သို့မဟုတ် ယင်းထက်နည်းအောင် သုံးပါ။';

  @override
  String get nameInvalid => 'စာလုံးနှင့် နေရာလွတ်သာ သုံးပါ။';

  @override
  String get birthHeadline => 'မွေးနေ့\nဘယ်နေ့လဲ။';

  @override
  String get birthMonthHint => 'လ';

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
  String get birthDayHint => 'နေ့';

  @override
  String get birthYearHint => 'ခုနှစ်';

  @override
  String get birthIncomplete => 'မွေးနေ့ကို ပြည့်စုံအောင် ထည့်ပါ။';

  @override
  String get birthImpossible => 'ပြက္ခဒိန်တွင် ရှိသော ရက်စွဲ ထည့်ပါ။';

  @override
  String get birthFuture => 'မွေးနေ့သည် အနာဂတ်ရက် မဖြစ်ရပါ။';

  @override
  String get birthTooYoung => 'အနည်းဆုံး အသက် ၁၃ နှစ် ရှိရပါမည်။';

  @override
  String get welcomeTitle => 'ကြိုဆိုပါသည်';

  @override
  String get welcomeHeadline => 'J\'donuts ကမ္ဘာသို့\nကြိုဆိုပါသည်';

  @override
  String get welcomeExplore => 'စူးစမ်းကြည့်မယ်';

  @override
  String get offlineBanner => 'အင်တာနက် မရှိပါ';

  @override
  String get imageUnavailable => 'ပုံ မရနိုင်ပါ';

  @override
  String get homeTitle => 'ပင်မ';

  @override
  String get homeSeasonal => 'ရာသီအလိုက် အထူး';

  @override
  String get homePopular => 'လူကြိုက်များ 🔥';

  @override
  String get homeOrderAgain => 'ထပ်မှာမယ်';

  @override
  String homeTierMember(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String homePointsLeft(int points, String tier) {
    return '$tier ဖြစ်ဖို့ နောက်ထပ် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String homeShops(int count) {
    return 'အနီးအနားတွင် J\'Donut ဆိုင် $count ဆိုင် ရှိသည် ';
  }

  @override
  String get homeNearYou => 'အနီးမှာ။ 🤤';

  @override
  String get homeNowOpen => 'ဖွင့်ထားသည်';

  @override
  String get homeExploreNow => 'ယခု ကြည့်မယ်';

  @override
  String get homeOrderOnline => 'အွန်လိုင်း မှာမယ်';

  @override
  String get homeSectionEmpty => 'ဘာမှ မရှိသေးပါ';

  @override
  String get homeSectionError => 'ဤအပိုင်းကို ဖွင့်၍ မရပါ';

  @override
  String get homeMemberError => 'ပရိုဖိုင်ကို ဖွင့်၍ မရပါ';

  @override
  String homeDiscount(int percent) {
    return '$percent% လျှော့ဈေး';
  }

  @override
  String get homeTryAgain => 'ထပ်ကြိုးစားမယ်';

  @override
  String get navHome => 'ပင်မ';

  @override
  String get navReward => 'ဆုလာဘ်';

  @override
  String get navNearby => 'အနီးအနား';

  @override
  String get navWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get comingSoon => 'မကြာမီ ရောက်မည်';

  @override
  String get rewardsTitle => 'J\' Donuts ဆုလာဘ်';

  @override
  String get rewardsBadge => 'ဆုလာဘ်';

  @override
  String get rewardsTotalPoints => 'စုစုပေါင်း မှတ်';

  @override
  String get rewardsEarnTab => 'ပိုစား ပိုရ';

  @override
  String get rewardsGiftTab => 'လက်ဆောင်';

  @override
  String get rewardsEarn => 'ရယူမယ်';

  @override
  String get rewardsCongratulations => 'ဂုဏ်ယူပါတယ်!';

  @override
  String rewardsPoints(int points) {
    return '$points မှတ်';
  }

  @override
  String get rewardsGiftEmpty => 'ဘာမှ မရှိသေးပါ';

  @override
  String get settingsTitle => 'ဆက်တင်';

  @override
  String get logOut => 'ထွက်မယ်';

  @override
  String get settingsLanguage => 'ဘာသာစကား';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageMyanmar => 'Myanmar';

  @override
  String get settingsLanguageEnglishValue => 'ENGLISH';

  @override
  String get settingsLanguageMyanmarValue => 'MYANMAR';

  @override
  String get productNew => 'အသစ်';

  @override
  String get productWhatsThis => 'ဒါ ဘာလဲ။';

  @override
  String get productAdd => 'ခြင်းတောင်းထဲ ထည့်မယ်';

  @override
  String get productAdded => 'ခြင်းတောင်းထဲ ထည့်ပြီးပါပြီ';

  @override
  String get productMissing => 'ဤပစ္စည်း မရနိုင်ပါ။';

  @override
  String productPrice(String amount) {
    return '$amount MMK';
  }

  @override
  String productTitle(String id) {
    return 'ပစ္စည်း $id';
  }
}
