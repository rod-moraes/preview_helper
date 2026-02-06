import '../fields/object_dropdown_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [T] em dropdown (enum/objetos).
class ObjectDropdownPreviewKnob<T extends Object>
    extends ValueNotifierPreview<T> {
  ObjectDropdownPreviewKnob({
    required super.name,
    required super.value,
    required this.options,
    this.labelBuilder,
  }) : super(enumValues: options);

  final List<T> options;
  final String Function(T value)? labelBuilder;

  @override
  ObjectDropdownPreviewField<T> toField() {
    final label = labelBuilder ?? _defaultLabel;
    return ObjectDropdownPreviewField<T>(
      name: name,
      initialValue: value,
      defaultValue: defaultValue,
      options: options,
      labelBuilder: label,
    );
  }

  static String _defaultLabel(dynamic v) => v is Enum ? v.name : v.toString();
}

/// Knob **anulável** para [T] em dropdown (enum/objetos).
class ObjectDropdownNullablePreviewKnob<T>
    extends ValueNotifierPreviewNullable<T> {
  ObjectDropdownNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
    required this.options,
    this.labelBuilder,
  }) : super(enumValues: options);

  final List<T> options;
  final String Function(T value)? labelBuilder;

  @override
  ObjectDropdownPreviewField<T> toField() {
    final label = labelBuilder ?? _defaultLabel;
    return ObjectDropdownPreviewField<T>(
      name: name,
      initialValue: value,
      defaultValue: defaultValue,
      options: options,
      labelBuilder: label,
    );
  }

  static String _defaultLabel(dynamic v) => v is Enum ? v.name : v.toString();
}
