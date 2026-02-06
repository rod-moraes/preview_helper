import '../fields/double_slider_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [double] com Slider.
class DoubleSliderPreviewKnob extends ValueNotifierPreview<double> {
  DoubleSliderPreviewKnob({
    required super.name,
    required super.value,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.precision = 1,
  });

  final double min;
  final double max;
  final int? divisions;
  final int precision;

  @override
  DoubleSliderPreviewField toField() => DoubleSliderPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    min: min,
    max: max,
    divisions: divisions,
    precision: precision,
  );
}

/// Knob **anulável** para [double] com Slider.
class DoubleSliderNullablePreviewKnob
    extends ValueNotifierPreviewNullable<double> {
  DoubleSliderNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.precision = 1,
  });

  final double min;
  final double max;
  final int? divisions;
  final int precision;

  @override
  DoubleSliderPreviewField toField() => DoubleSliderPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    min: min,
    max: max,
    divisions: divisions,
    precision: precision,
  );
}
