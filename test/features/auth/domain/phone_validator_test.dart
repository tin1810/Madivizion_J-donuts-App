import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/phone_validator.dart';

void main() {
  const normalized = ValidPhone('+959254135592');

  test('a local number with one leading zero normalizes to +95', () {
    expect(validatePhone('09254135592'), normalized);
  });

  test('spaces and dashes are removed before the check', () {
    expect(validatePhone('09 254-135-592'), normalized);
  });

  test('a +95 number with a leading zero normalizes', () {
    expect(validatePhone('+95 09254135592'), normalized);
  });

  test('a +95 number without a leading zero normalizes', () {
    expect(validatePhone('+959254135592'), normalized);
  });

  test('a +95 number with dashes normalizes', () {
    expect(validatePhone('+95-925-413-5592'), normalized);
  });

  test('nine plus seven digits is accepted', () {
    expect(validatePhone('92541355'), const ValidPhone('+9592541355'));
  });

  test('fewer than seven digits after 9 is rejected', () {
    expect(validatePhone('9254135'), const InvalidPhone());
  });

  test('more than nine digits after 9 is rejected', () {
    expect(validatePhone('92541355921'), const InvalidPhone());
  });

  test('a number that does not start with 9 is rejected', () {
    expect(validatePhone('8254135592'), const InvalidPhone());
  });

  test('only one leading zero is removed', () {
    expect(validatePhone('009254135592'), const InvalidPhone());
  });

  test('letters are rejected', () {
    expect(validatePhone('09abc4135592'), const InvalidPhone());
  });

  test('an empty value is rejected', () {
    expect(validatePhone('   '), const InvalidPhone());
  });
}
