import 'dart:ui';

import '../fields/color_field.dart';
import '../value_notifier_preview.dart';

/// Knob para [Color] (hex + grid de cores). Equivalente a [ColorKnob] do Widgetbook.
class ColorPreviewKnob extends ValueNotifierPreview<Color> {
  ColorPreviewKnob({required super.name, required super.value});

  @override
  ColorPreviewField toField() => ColorPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}

/// Knob **anulável** para [Color].
class ColorNullablePreviewKnob extends ValueNotifierPreviewNullable<Color> {
  ColorNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
  });

  @override
  ColorPreviewField toField() => ColorPreviewField(
    name: name,
    initialValue: value,
    defaultValue: defaultValue,
  );
}
