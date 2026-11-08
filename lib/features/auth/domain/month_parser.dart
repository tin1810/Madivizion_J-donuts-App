const List<String> _monthNames = <String>[
  'january',
  'february',
  'march',
  'april',
  'may',
  'june',
  'july',
  'august',
  'september',
  'october',
  'november',
  'december',
];

/// Reads a month number or an English month name. Empty input stays null.
int? parseMonth(String raw) {
  final text = raw.trim().toLowerCase();
  if (text.isEmpty) {
    return null;
  }
  final numeric = int.tryParse(text);
  if (numeric != null) {
    return numeric;
  }
  for (var index = 0; index < _monthNames.length; index++) {
    final name = _monthNames[index];
    if (text.length >= 3 && name.startsWith(text)) {
      return index + 1;
    }
  }
  return null;
}
