import '../fields/object_segmented_field.dart';
import '../value_notifier_preview.dart';

/// Knob **não anulável** para [T] em SegmentedButton (enum/objetos).
class ObjectSegmentedPreviewKnob<T extends Object>
    extends ValueNotifierPreview<T> {
  ObjectSegmentedPreviewKnob({
    required super.name,
    required super.value,
    required this.options,
    this.labelBuilder,
  }) : super(enumValues: options);

  final List<T> options;
  final String Function(T value)? labelBuilder;

  @override
  ObjectSegmentedPreviewField<T> toField() {
    final label = labelBuilder ?? _defaultLabel;
    return ObjectSegmentedPreviewField<T>(
      name: name,
      initialValue: value,
      defaultValue: defaultValue,
      options: options,
      labelBuilder: label,
    );
  }

  static String _defaultLabel(dynamic v) => v is Enum ? v.name : v.toString();
}

/// Knob **anulável** para [T] em SegmentedButton (enum/objetos).
class ObjectSegmentedNullablePreviewKnob<T>
    extends ValueNotifierPreviewNullable<T> {
  ObjectSegmentedNullablePreviewKnob({
    required super.name,
    required super.value,
    required super.defaultValue,
    required this.options,
    this.labelBuilder,
  }) : super(enumValues: options);

  final List<T> options;
  final String Function(T value)? labelBuilder;

  @override
  ObjectSegmentedPreviewField<T> toField() {
    final label = labelBuilder ?? _defaultLabel;
    return ObjectSegmentedPreviewField<T>(
      name: name,
      initialValue: value,
      defaultValue: defaultValue,
      options: options,
      labelBuilder: label,
    );
  }

  static String _defaultLabel(dynamic v) => v is Enum ? v.name : v.toString();
}
