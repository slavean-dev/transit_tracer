import 'dart:ui';

import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  static const String _fullDateFormat = 'd MMMM y';

  String formatFullDate(Locale locale) {
    return DateFormat(_fullDateFormat, locale.languageCode).format(this);
  }
}
