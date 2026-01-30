import 'package:transit_tracer/features/orders/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/generated/l10n.dart';

class WeightRangeMapper {
  static String label(S s, WeightRange value) {
    switch (value) {
      case WeightRange.upTo500:
        return s.upTo500kg;
      case WeightRange.from500to1000:
        return s.from500To1000;
      case WeightRange.from1000to1500:
        return s.from1000To1500;
      case WeightRange.from1500to2000:
        return s.from1500to2000;
      case WeightRange.above2000:
        return s.above2000;
    }
  }
}
