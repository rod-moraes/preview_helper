import '../fields/int_input_field.dart';
import '../value_notifier_preview.dart';

/// Knob para [int] (TextField numérico). Equivalente a [IntInputKnob] do Widgetbook.
class IntInputPreviewKnob extends ValueNotifierPreview<int> {
  IntInputPreviewKnob({required super.name, required super.value});

  @override
  IntInputPreviewField toField() => IntInputPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}

/// Knob **anulável** para [int] (TextField numérico).
class IntInputNullablePreviewKnob extends ValueNotifierPreviewNullable<int> {
  IntInputNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
  });

  @override
  IntInputPreviewField toField() => IntInputPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}
