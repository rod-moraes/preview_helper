import '../fields/duration_field.dart';
import '../value_notifier_preview.dart';

/// Knob para [Duration] (ms). Equivalente a [DurationKnob] do Widgetbook.
class DurationPreviewKnob extends ValueNotifierPreview<Duration> {
  DurationPreviewKnob({required super.name, required super.value});

  @override
  DurationPreviewField toField() => DurationPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}

/// Knob **anulável** para [Duration] (ms).
class DurationNullablePreviewKnob
    extends ValueNotifierPreviewNullable<Duration> {
  DurationNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
  });

  @override
  DurationPreviewField toField() => DurationPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}
