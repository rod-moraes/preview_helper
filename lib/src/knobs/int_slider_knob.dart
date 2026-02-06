import '../fields/int_slider_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [int] com Slider.
class IntSliderPreviewKnob extends ValueNotifierPreview<int> {
  IntSliderPreviewKnob({
    required super.name,
    required super.value,
    this.min = 0,
    this.max = 100,
    this.divisions,
  });

  final int min;
  final int max;
  final int? divisions;

  @override
  IntSliderPreviewField toField() => IntSliderPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    min: min,
    max: max,
    divisions: divisions,
  );
}

/// Knob **anulável** para [int] com Slider.
class IntSliderNullablePreviewKnob extends ValueNotifierPreviewNullable<int> {
  IntSliderNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
    this.min = 0,
    this.max = 100,
    this.divisions,
  });

  final int min;
  final int max;
  final int? divisions;

  @override
  IntSliderPreviewField toField() => IntSliderPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    min: min,
    max: max,
    divisions: divisions,
  );
}
