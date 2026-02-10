class NumUtils {
  double? toDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  String priceFormater(String price) {
    final digits = price.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 3) return digits;

    final parts = <String>[];
    for (int i = digits.length; i > 0; i -= 3) {
      final start = (i - 3) < 0 ? 0 : i - 3;
      parts.add(digits.substring(start, i));
    }

    return parts.reversed.join(',');
  }
}
