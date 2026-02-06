import '../fields/boolean_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [bool] (Switch).
class BooleanPreviewKnob extends ValueNotifierPreview<bool> {
  BooleanPreviewKnob({required super.name, required super.value});

  @override
  BooleanPreviewField toField() => BooleanPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}

/// Knob **anulável** para [bool] (Switch).
class BooleanNullablePreviewKnob extends ValueNotifierPreviewNullable<bool> {
  BooleanNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
  });

  @override
  BooleanPreviewField toField() => BooleanPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}
