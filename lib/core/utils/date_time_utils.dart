import 'dart:ui';

import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String formatFullDate(Locale locale) {
    return DateFormat('d MMMM y', locale.languageCode).format(this);
  }
}
