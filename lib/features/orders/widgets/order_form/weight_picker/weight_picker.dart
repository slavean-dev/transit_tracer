import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/presentation/mappers/weight_range_mapper.dart';

class WeightPicker extends StatelessWidget {
  const WeightPicker({
    super.key,
    required this.theme,
    required this.onChange,
    required this.onSaved,
    required this.validator,
  });

  final ThemeData theme;
  final ValueChanged<WeightRange?> onChange;
  final FormFieldSetter<WeightRange> onSaved;
  final FormFieldValidator<WeightRange> validator;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return DropdownButtonFormField<WeightRange>(
      style: theme.textTheme.bodyMedium,
      initialValue: null,
      decoration: InputDecoration(
        labelText: s.cargoWeightLabel,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      borderRadius: BorderRadius.circular(15),
      items: [
        DropdownMenuItem(
          value: WeightRange.upTo500,

          child: Text(WeightRangeMapper.label(s, WeightRange.upTo500)),
        ),
        DropdownMenuItem(
          value: WeightRange.from500to1000,
          child: Text(WeightRangeMapper.label(s, WeightRange.from500to1000)),
        ),
        DropdownMenuItem(
          value: WeightRange.from1000to1500,
          child: Text(WeightRangeMapper.label(s, WeightRange.from1000to1500)),
        ),
        DropdownMenuItem(
          value: WeightRange.from1500to2000,
          child: Text(WeightRangeMapper.label(s, WeightRange.from1500to2000)),
        ),
        DropdownMenuItem(
          value: WeightRange.above2000,
          child: Text(WeightRangeMapper.label(s, WeightRange.above2000)),
        ),
      ],
      onSaved: onSaved,
      onChanged: onChange,
      validator: validator,
    );
  }
}
