import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/name_validator.dart';

void main() {
  test('first name keeps letters and spaces after trimming', () {
    expect(validateFirstName('  Ye Min  '), const ValidName('Ye Min'));
  });

  test('first name accepts Myanmar script', () {
    expect(validateFirstName('အောင်မင်း'), const ValidName('အောင်မင်း'));
  });

  test('a single letter is a valid first name', () {
    expect(validateFirstName('A'), const ValidName('A'));
  });

  test('an empty first name is required', () {
    expect(
      validateFirstName('   '),
      const InvalidName(NameRejection.required),
    );
  });

  test('a first name longer than 50 characters is rejected', () {
    expect(
      validateFirstName('A' * (NameRules.maxLength + 1)),
      const InvalidName(NameRejection.tooLong),
    );
  });

  test('a first name of 50 letters is accepted', () {
    final value = 'A' * NameRules.maxLength;

    expect(validateFirstName(value), ValidName(value));
  });

  test('digits in a first name are rejected', () {
    expect(
      validateFirstName('Ye1'),
      const InvalidName(NameRejection.invalidCharacters),
    );
  });

  test('punctuation in a first name is rejected', () {
    expect(
      validateFirstName('Ye-Min'),
      const InvalidName(NameRejection.invalidCharacters),
    );
  });

  test('an empty last name is allowed', () {
    expect(validateLastName('   '), const ValidName(''));
  });

  test('last name keeps letters and spaces after trimming', () {
    expect(validateLastName('  Phyo Win '), const ValidName('Phyo Win'));
  });

  test('last name accepts Myanmar script', () {
    expect(validateLastName('ခန့်'), const ValidName('ခန့်'));
  });

  test('digits in a last name are rejected', () {
    expect(
      validateLastName('Win2'),
      const InvalidName(NameRejection.invalidCharacters),
    );
  });

  test('a last name longer than 50 characters is rejected', () {
    expect(
      validateLastName('A' * (NameRules.maxLength + 1)),
      const InvalidName(NameRejection.tooLong),
    );
  });
}
