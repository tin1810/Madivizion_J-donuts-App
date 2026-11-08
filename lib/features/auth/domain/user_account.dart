/// A registered J'Donuts customer stored on the device.
class UserAccount {
  const UserAccount({
    required this.phoneE164,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  final String phoneE164;
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  @override
  bool operator ==(Object other) {
    return other is UserAccount &&
        other.phoneE164 == phoneE164 &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode => Object.hash(phoneE164, firstName, lastName, birthDate);
}
