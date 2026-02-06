import '../fields/double_input_field.dart';
import '../value_notifier_preview.dart';

/// Knob para [double] (TextField). Equivalente a [DoubleInputKnob] do Widgetbook.
class DoubleInputPreviewKnob extends ValueNotifierPreview<double> {
  DoubleInputPreviewKnob({required super.name, required super.value});

  @override
  DoubleInputPreviewField toField() => DoubleInputPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}

/// Knob **anulável** para [double] (TextField).
class DoubleInputNullablePreviewKnob
    extends ValueNotifierPreviewNullable<double> {
  DoubleInputNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
  });

  @override
  DoubleInputPreviewField toField() => DoubleInputPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}
