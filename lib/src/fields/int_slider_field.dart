import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'num_slider_field.dart';

/// Campo [Slider] para [int], inspirado em [IntSliderField] do Widgetbook.
class IntSliderPreviewField extends NumSliderPreviewField<int> {
  IntSliderPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
    required super.min,
    required super.max,
    super.divisions,
  }) : super(
         codec: PreviewFieldCodec<int>(
           toParam: (v) => v.toString(),
           toValue: (p) => double.tryParse(p ?? '')?.round(),
         ),
       );

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    final currentValue = params.currentValue as int?;
    final value = (currentValue ?? defaultValue).toDouble().clamp(
      minDouble,
      maxDouble,
    );
    final label = value.round().toString();
    final minLabel = min.toString();
    final maxLabel = max.toString();
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
                  onChanged: (v) => params.onValueChanged(v.round()),
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
