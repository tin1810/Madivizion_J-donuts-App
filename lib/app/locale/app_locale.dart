import 'package:flutter/widgets.dart';

/// The language chosen in Settings. English is the starting language.
class AppLocale extends ChangeNotifier {
  AppLocale({this.onSave, Locale initial = const Locale('en')})
    : _locale = known(initial);

  final Future<void> Function(String code)? onSave;
  Locale _locale;

  Locale get locale => _locale;

  static const Locale english = Locale('en');
  static const Locale myanmar = Locale('my');

  static Locale known(Locale locale) {
    return locale.languageCode == myanmar.languageCode ? myanmar : english;
  }

  bool get isMyanmar => _locale.languageCode == myanmar.languageCode;

  Future<void> use(Locale locale) async {
    final next = known(locale);
    if (next == _locale) {
      return;
    }
    _locale = next;
    notifyListeners();
    await onSave?.call(next.languageCode);
  }
}
