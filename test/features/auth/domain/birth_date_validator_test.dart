import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';

void main() {
  final today = DateTime(2026, 11, 8);

  BirthDateCheck check({int? month, int? day, int? year}) {
    return validateBirthDate(month: month, day: day, year: year, today: today);
  }

  test('1 May 1980 is a valid birth date', () {
    expect(
      check(month: 5, day: 1, year: 1980),
      ValidBirthDate(DateTime(1980, 5, 1)),
    );
  });

  test('31 April is not a real date', () {
    expect(
      check(month: 4, day: 31, year: 1980),
      const InvalidBirthDate(BirthDateRejection.impossible),
    );
  });

  test('29 February is accepted in a leap year', () {
    expect(
      check(month: 2, day: 29, year: 2000),
      ValidBirthDate(DateTime(2000, 2, 29)),
    );
  });

  test('29 February is rejected in a common year', () {
    expect(
      check(month: 2, day: 29, year: 2011),
      const InvalidBirthDate(BirthDateRejection.impossible),
    );
  });

  test('29 February 1900 is rejected because it is not a leap year', () {
    expect(
      check(month: 2, day: 29, year: 1900),
      const InvalidBirthDate(BirthDateRejection.impossible),
    );
  });

  test('a date after today is in the future', () {
    expect(
      check(month: 11, day: 9, year: 2026),
      const InvalidBirthDate(BirthDateRejection.inTheFuture),
    );
  });

  test('a person who turns 13 today is old enough', () {
    expect(
      check(month: 11, day: 8, year: 2013),
      ValidBirthDate(DateTime(2013, 11, 8)),
    );
  });

  test('a person younger than 13 is rejected', () {
    expect(
      check(month: 11, day: 9, year: 2013),
      const InvalidBirthDate(BirthDateRejection.tooYoung),
    );
  });

  test('a birth date of today is too young', () {
    expect(
      check(month: 11, day: 8, year: 2026),
      const InvalidBirthDate(BirthDateRejection.tooYoung),
    );
  });

  test('a day needs exactly two digits', () {
    expect(parseBirthDay('1'), isNull);
    expect(parseBirthDay('01'), 1);
    expect(parseBirthDay('15'), 15);
    expect(parseBirthDay('123'), isNull);
  });

  test('calendar years run from this year back to 1900', () {
    final years = birthYears(2026);
    expect(years.first, 2026);
    expect(years.last, BirthRules.earliestYear);
    expect(years, isNot(contains(2027)));
    expect(birthYears(1899), isEmpty);
  });

  test('a year needs exactly four digits', () {
    expect(parseBirthYear('980'), isNull);
    expect(parseBirthYear('1980'), 1980);
    expect(parseBirthYear('19801'), isNull);
  });

  test('a missing day is incomplete', () {
    expect(
      check(month: 5, year: 1980),
      const InvalidBirthDate(BirthDateRejection.incomplete),
    );
  });

  test('month 13 is not a real date', () {
    expect(
      check(month: 13, day: 1, year: 1980),
      const InvalidBirthDate(BirthDateRejection.impossible),
    );
  });
}
