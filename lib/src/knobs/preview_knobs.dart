import 'dart:ui';

import 'boolean_knob.dart';
import 'color_knob.dart';
import 'date_time_knob.dart';
import 'double_input_knob.dart';
import 'double_slider_knob.dart';
import 'duration_knob.dart';
import 'int_input_knob.dart';
import 'int_slider_knob.dart';
import 'object_dropdown_knob.dart';
import 'object_segmented_knob.dart';
import 'string_knob.dart';

/// Fábrica de knobs via métodos estáticos. Cada método retorna a classe concreta do knob.
///
/// Exemplo:
/// ```dart
/// final enabled = PreviewKnobs.boolean('enabled', true);
/// final volume = PreviewKnobs.intSlider('volume', 50, min: 0, max: 100);
/// ```
class PreviewKnobs {
  PreviewKnobs._();

  static BooleanPreviewKnob boolean(String name, bool value) {
    return BooleanPreviewKnob(name: name, value: value);
  }

  static BooleanNullablePreviewKnob booleanNullable(
    String name, {
    bool? value,
    required bool defaultValue,
  }) {
    return BooleanNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
    );
  }

  static StringPreviewKnob string(
    String name,
    String value, {
    int maxLines = 3,
  }) {
    return StringPreviewKnob(name: name, value: value, maxLines: maxLines);
  }

  static StringNullablePreviewKnob stringNullable(
    String name, {
    String? value,
    required String defaultValue,
    int maxLines = 3,
  }) {
    return StringNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
      maxLines: maxLines,
    );
  }

  static IntInputPreviewKnob intInput(String name, int value) {
    return IntInputPreviewKnob(name: name, value: value);
  }

  static IntInputNullablePreviewKnob intInputNullable(
    String name, {
    int? value,
    required int defaultValue,
  }) {
    return IntInputNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
    );
  }

  static IntSliderPreviewKnob intSlider(
    String name,
    int value, {
    int min = 0,
    int max = 100,
    int? divisions,
  }) {
    return IntSliderPreviewKnob(
      name: name,
      value: value,
      min: min,
      max: max,
      divisions: divisions,
    );
  }

  static IntSliderNullablePreviewKnob intSliderNullable(
    String name, {
    int? value,
    required int defaultValue,
    int min = 0,
    int max = 100,
    int? divisions,
  }) {
    return IntSliderNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
      min: min,
      max: max,
      divisions: divisions,
    );
  }

  static DoubleInputPreviewKnob doubleInput(String name, double value) {
    return DoubleInputPreviewKnob(name: name, value: value);
  }

  static DoubleInputNullablePreviewKnob doubleInputNullable(
    String name, {
    double? value,
    required double defaultValue,
  }) {
    return DoubleInputNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
    );
  }

  static DoubleSliderPreviewKnob doubleSlider(
    String name,
    double value, {
    double min = 0,
    double max = 1,
    int? divisions,
    int precision = 1,
  }) {
    return DoubleSliderPreviewKnob(
      name: name,
      value: value,
      min: min,
      max: max,
      divisions: divisions,
      precision: precision,
    );
  }

  static DoubleSliderNullablePreviewKnob doubleSliderNullable(
    String name, {
    double? value,
    required double defaultValue,
    double min = 0,
    double max = 1,
    int? divisions,
    int precision = 1,
  }) {
    return DoubleSliderNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
      min: min,
      max: max,
      divisions: divisions,
      precision: precision,
    );
  }

  static DateTimePreviewKnob dateTime(
    String name,
    DateTime value, {
    required DateTime start,
    required DateTime end,
  }) {
    return DateTimePreviewKnob(
      name: name,
      value: value,
      start: start,
      end: end,
    );
  }

  static DateTimeNullablePreviewKnob dateTimeNullable(
    String name, {
    DateTime? value,
    required DateTime defaultValue,
    required DateTime start,
    required DateTime end,
  }) {
    return DateTimeNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
      start: start,
      end: end,
    );
  }

  static DurationPreviewKnob duration(String name, Duration value) {
    return DurationPreviewKnob(name: name, value: value);
  }

  static DurationNullablePreviewKnob durationNullable(
    String name, {
    Duration? value,
    required Duration defaultValue,
  }) {
    return DurationNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
    );
  }

  static ColorPreviewKnob color(String name, Color value) {
    return ColorPreviewKnob(name: name, value: value);
  }

  static ColorNullablePreviewKnob colorNullable(
    String name, {
    Color? value,
    required Color defaultValue,
  }) {
    return ColorNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
    );
  }

  static ObjectDropdownPreviewKnob<T> dropdown<T extends Object>(
    String name,
    T value, {
    required List<T> options,
    String Function(T)? labelBuilder,
  }) {
    return ObjectDropdownPreviewKnob(
      name: name,
      value: value,
      options: options,
      labelBuilder: labelBuilder,
    );
  }

  static ObjectDropdownNullablePreviewKnob<T> dropdownNullable<T>(
    String name, {
    T? value,
    required T defaultValue,
    required List<T> options,
    String Function(T)? labelBuilder,
  }) {
    return ObjectDropdownNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
      options: options,
      labelBuilder: labelBuilder,
    );
  }

  static ObjectSegmentedPreviewKnob<T> segmented<T extends Object>(
    String name,
    T value, {
    required List<T> options,
    String Function(T)? labelBuilder,
  }) {
    return ObjectSegmentedPreviewKnob(
      name: name,
      value: value,
      options: options,
      labelBuilder: labelBuilder,
    );
  }

  static ObjectSegmentedNullablePreviewKnob<T> segmentedNullable<T>(
    String name, {
    T? value,
    required T defaultValue,
    required List<T> options,
    String Function(T)? labelBuilder,
  }) {
    return ObjectSegmentedNullablePreviewKnob(
      name: name,
      value: value,
      defaultValue: defaultValue,
      options: options,
      labelBuilder: labelBuilder,
    );
  }
}
