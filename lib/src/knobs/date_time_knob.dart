import '../fields/date_time_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [DateTime] (date/time picker).
class DateTimePreviewKnob extends ValueNotifierPreview<DateTime> {
  DateTimePreviewKnob({
    required super.name,
    required super.value,
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;

  @override
  DateTimePreviewField toField() => DateTimePreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    start: start,
    end: end,
  );
}

/// Knob **anulável** para [DateTime] (date/time picker).
class DateTimeNullablePreviewKnob
    extends ValueNotifierPreviewNullable<DateTime> {
  DateTimeNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;

  @override
  DateTimePreviewField toField() => DateTimePreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    start: start,
    end: end,
  );
}
