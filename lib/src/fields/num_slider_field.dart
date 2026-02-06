import 'package:flutter/material.dart';

import 'field.dart';

/// Base para campos que usam [Slider] para valores numéricos (inspirado em [NumSliderField] do Widgetbook).
abstract class NumSliderPreviewField<T extends num> extends PreviewField<T> {
  NumSliderPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
    required this.min,
    required this.max,
    this.divisions,
    required super.codec,
  }) : assert(
         initialValue == null || (initialValue >= min && initialValue <= max),
       );

  final T min;
  final T max;
  final int? divisions;

  double get minDouble => min.toDouble();
  double get maxDouble => max.toDouble();

  /// Tamanho do texto para o label do valor (igual a _getTextSize do Widgetbook).
  static Size textSize(String text, BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.size;
  }
}
