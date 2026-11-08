/// Shared limits for first and last name.
abstract final class NameRules {
  static const int minLength = 1;
  static const int maxLength = 50;
}

/// A name field that can be submitted.
sealed class NameCheck {
  const NameCheck();
}

/// [value] is the trimmed name. An optional last name may be empty.
final class ValidName extends NameCheck {
  const ValidName(this.value);

  final String value;

  @override
  bool operator ==(Object other) {
    return other is ValidName && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// Why a name cannot be submitted.
enum NameRejection { required, tooLong, invalidCharacters }

/// The field does not match [NameRules].
final class InvalidName extends NameCheck {
  const InvalidName(this.reason);

  final NameRejection reason;

  @override
  bool operator ==(Object other) {
    return other is InvalidName && other.reason == reason;
  }

  @override
  int get hashCode => reason.hashCode;
}

final RegExp _lettersAndSpaces = RegExp(
  r'^[\p{L}\p{M} ]+$',
  unicode: true,
);
final RegExp _hasLetter = RegExp(r'\p{L}', unicode: true);

/// First name is required. Letters and spaces only, Myanmar script included.
NameCheck validateFirstName(String raw) {
  return _validateName(raw, requiredField: true);
}

/// Last name is optional and uses the same character rules.
NameCheck validateLastName(String raw) {
  return _validateName(raw, requiredField: false);
}

NameCheck _validateName(String raw, {required bool requiredField}) {
  final value = raw.trim();
  if (value.isEmpty) {
    return requiredField
        ? const InvalidName(NameRejection.required)
        : const ValidName('');
  }
  if (value.length > NameRules.maxLength) {
    return const InvalidName(NameRejection.tooLong);
  }
  final hasOnlyLettersAndSpaces = _lettersAndSpaces.hasMatch(value);
  final hasLetter = _hasLetter.hasMatch(value);
  if (!hasOnlyLettersAndSpaces || !hasLetter) {
    return const InvalidName(NameRejection.invalidCharacters);
  }
  return ValidName(value);
}
