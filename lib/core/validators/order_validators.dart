class OrderValidators {
  static String? description(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Description is required';
    if (value.length < 5) return 'Description is too short';
    return null;
  }

  static String? price(String? v) {
    final value = (v ?? '').trim().replaceAll(',', '.');
    if (value.isEmpty) return 'Price is required';

    final num? parsed = num.tryParse(value);
    if (parsed == null) return 'Enter a valid number';
    if (parsed <= 0) return 'Price must be greater than 0';
    if (parsed > 1000000) return 'Price is too large';

    return null;
  }

  static String? weight<T>(T? v) {
    if (v == null) return 'Select cargo weight';
    return null;
  }
}
