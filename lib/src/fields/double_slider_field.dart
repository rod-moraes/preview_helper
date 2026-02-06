import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'num_slider_field.dart';

/// Campo [Slider] para [double], inspirado em [DoubleSliderField] do Widgetbook.
class DoubleSliderPreviewField extends NumSliderPreviewField<double> {
  DoubleSliderPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
    required super.min,
    required super.max,
    super.divisions,
    this.precision = 1,
  }) : super(
         codec: PreviewFieldCodec<double>(
           toParam: (v) =>
               precision != null ? v.toStringAsFixed(precision) : v.toString(),
           toValue: (p) => double.tryParse(p ?? ''),
         ),
       );

  final int? precision;

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    final currentValue = params.currentValue as double?;
    final value = (currentValue ?? defaultValue).clamp(minDouble, maxDouble);
    final label = precision != null
        ? value.toStringAsFixed(precision!)
        : value.toString();
    final minLabel = precision != null
        ? min.toStringAsFixed(precision!)
        : min.toString();
    final maxLabel = precision != null
        ? max.toStringAsFixed(precision!)
        : max.toString();
    final spacing =
        SliderTheme.of(context).overlayShape == SliderComponentShape.noThumb
        ? 16.0
        : 0.0;
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: spacing,
            children: [
              Expanded(
                child: Slider(
                  value: value,
                  min: minDouble,
                  max: maxDouble,
                  divisions: divisions,
                  label: label,
                  onChanged: (v) => params.onValueChanged(v),
                ),
              ),
              PreviewField.valueBadge(context, label),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  maxLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
