import '../fields/string_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [String] (TextField).
class StringPreviewKnob extends ValueNotifierPreview<String> {
  StringPreviewKnob({
    required super.name,
    required super.value,
    this.maxLines = 3,
  });

  final int maxLines;

  @override
  StringPreviewField toField() => StringPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    maxLines: maxLines,
  );
}

/// Knob **anulável** para [String] (TextField).
class StringNullablePreviewKnob extends ValueNotifierPreviewNullable<String> {
  StringNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
    this.maxLines = 3,
  });

  final int maxLines;

  @override
  StringPreviewField toField() => StringPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
    maxLines: maxLines,
  );
}
