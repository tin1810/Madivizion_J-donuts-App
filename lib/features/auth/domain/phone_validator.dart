/// Myanmar mobile numbers accepted after the +95 prefix.
abstract final class PhoneRules {
  static const String countryCode = '+95';
  static const String leadingZero = '0';
  static const int minSubscriberDigits = 7;
  static const int maxSubscriberDigits = 10;

  /// Digits the person can type, not counting +95. Fewer still match.
  static const int maxDigits = 11;
}

/// A phone field that can be submitted.
sealed class PhoneCheck {
  const PhoneCheck();
}

/// [e164] is the normalized number, such as +959254135592.
final class ValidPhone extends PhoneCheck {
  const ValidPhone(this.e164);

  final String e164;

  @override
  bool operator ==(Object other) {
    return other is ValidPhone && other.e164 == e164;
  }

  @override
  int get hashCode => e164.hashCode;
}

/// The field does not match [PhoneRules].
final class InvalidPhone extends PhoneCheck {
  const InvalidPhone();
}

final RegExp _nationalNumber = RegExp(
  '^9\\d{${PhoneRules.minSubscriberDigits},${PhoneRules.maxSubscriberDigits}}\$',
);

/// Strips +95, spaces, dashes, and one leading 0, then checks the pattern.
PhoneCheck validatePhone(String raw) {
  var national = raw.trim();
  if (national.startsWith(PhoneRules.countryCode)) {
    national = national.substring(PhoneRules.countryCode.length);
  }
  national = national.replaceAll(RegExp(r'[\s-]'), '');
  if (national.length > PhoneRules.maxDigits) {
    return const InvalidPhone();
  }
  if (national.startsWith(PhoneRules.leadingZero)) {
    national = national.substring(PhoneRules.leadingZero.length);
  }
  if (!_nationalNumber.hasMatch(national)) {
    return const InvalidPhone();
  }
  return ValidPhone('${PhoneRules.countryCode}$national');
}

/// Drops digits past [PhoneRules.maxDigits]. Spaces and dashes stay.
String limitPhoneDigits(String raw) {
  final hasCountry = raw.startsWith(PhoneRules.countryCode);
  final body = hasCountry ? raw.substring(PhoneRules.countryCode.length) : raw;
  return '${hasCountry ? PhoneRules.countryCode : ''}${_keepDigits(body)}';
}

String _keepDigits(String body) {
  final kept = StringBuffer();
  var digits = 0;
  for (final rune in body.runes) {
    final isDigit = rune >= 0x30 && rune <= 0x39;
    if (isDigit && digits == PhoneRules.maxDigits) {
      continue;
    }
    if (isDigit) {
      digits++;
    }
    kept.writeCharCode(rune);
  }
  return kept.toString();
}
