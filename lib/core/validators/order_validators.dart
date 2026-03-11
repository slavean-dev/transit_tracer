import 'package:flutter/material.dart';
import 'package:transit_tracer/generated/l10n.dart';

enum OrderValidationError {
  empty,
  toShort,
  invalidNumber,
  priceZero,
  priceTooLarge,
  selectWeight,
}

class OrderValidators {
  static OrderValidationError? description(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return OrderValidationError.empty;
    if (value.length < 5) return OrderValidationError.toShort;
    return null;
  }

  static OrderValidationError? price(String? v) {
    final value = (v ?? '').trim().replaceAll(',', '.');
    if (value.isEmpty) return OrderValidationError.empty;

    final num? parsed = num.tryParse(value);
    if (parsed == null) return OrderValidationError.invalidNumber;
    if (parsed <= 0) return OrderValidationError.priceZero;
    if (parsed > 1000000) return OrderValidationError.priceTooLarge;

    return null;
  }

  static OrderValidationError? weight<T>(T? v) {
    if (v == null) return OrderValidationError.selectWeight;
    return null;
  }
}

extension OrderValidationErrorX on OrderValidationError {
  String toText(BuildContext context) {
    final s = S.of(context);
    return switch (this) {
      OrderValidationError.empty => s.validationRequired,
      OrderValidationError.toShort => s.validationTooShort,
      OrderValidationError.invalidNumber => s.validationInvalidNumber,
      OrderValidationError.priceZero => s.validationPriceZero,
      OrderValidationError.priceTooLarge => s.validationPriceLimit,
      OrderValidationError.selectWeight => s.validationSelectWeight,
    };
  }
}
