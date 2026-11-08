/// Minimum age required to register.
abstract final class AgeRules {
  static const int minimumAge = 13;
}

/// How many digits the day and year fields must contain.
abstract final class BirthRules {
  static const int dayDigits = 2;
  static const int yearDigits = 4;
  static const int earliestYear = 1900;
}

/// A date of birth that can be submitted.
sealed class BirthDateCheck {
  const BirthDateCheck();
}

/// [date] is a real calendar date, not in the future, and old enough.
final class ValidBirthDate extends BirthDateCheck {
  const ValidBirthDate(this.date);

  final DateTime date;

  @override
  bool operator ==(Object other) {
    return other is ValidBirthDate && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;
}

/// Why a date of birth cannot be submitted.
enum BirthDateRejection { incomplete, impossible, inTheFuture, tooYoung }

/// The field does not match [AgeRules].
final class InvalidBirthDate extends BirthDateCheck {
  const InvalidBirthDate(this.reason);

  final BirthDateRejection reason;

  @override
  bool operator ==(Object other) {
    return other is InvalidBirthDate && other.reason == reason;
  }

  @override
  int get hashCode => reason.hashCode;
}

/// Reads a day only when it is exactly [BirthRules.dayDigits] long.
int? parseBirthDay(String raw) => _parseDigits(raw, BirthRules.dayDigits);

/// Reads a year only when it is exactly [BirthRules.yearDigits] long.
int? parseBirthYear(String raw) => _parseDigits(raw, BirthRules.yearDigits);

/// Years from [currentYear] back to [BirthRules.earliestYear], newest first.
List<int> birthYears(int currentYear) {
  if (currentYear < BirthRules.earliestYear) {
    return const [];
  }
  return [
    for (var year = currentYear; year >= BirthRules.earliestYear; year--) year,
  ];
}

int? _parseDigits(String raw, int length) {
  final text = raw.trim();
  if (text.length != length) {
    return null;
  }
  return int.tryParse(text);
}

/// Checks a real calendar date, then future dates, then [AgeRules.minimumAge].
BirthDateCheck validateBirthDate({
  required int? month,
  required int? day,
  required int? year,
  required DateTime today,
}) {
  if (month == null || day == null || year == null) {
    return const InvalidBirthDate(BirthDateRejection.incomplete);
  }
  if (!_isRealDate(year: year, month: month, day: day)) {
    return const InvalidBirthDate(BirthDateRejection.impossible);
  }
  final birth = DateTime(year, month, day);
  final current = DateTime(today.year, today.month, today.day);
  if (birth.isAfter(current)) {
    return const InvalidBirthDate(BirthDateRejection.inTheFuture);
  }
  if (_ageInYears(birth, current) < AgeRules.minimumAge) {
    return const InvalidBirthDate(BirthDateRejection.tooYoung);
  }
  return ValidBirthDate(birth);
}

bool _isRealDate({required int year, required int month, required int day}) {
  if (year < 1 || month < 1 || day < 1) {
    return false;
  }
  final date = DateTime(year, month, day);
  return date.year == year && date.month == month && date.day == day;
}

int _ageInYears(DateTime birth, DateTime today) {
  var age = today.year - birth.year;
  final birthdayThisYear = DateTime(today.year, birth.month, birth.day);
  if (today.isBefore(birthdayThisYear)) {
    age -= 1;
  }
  return age;
}
