import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';

/// Campo para [Duration] (em ms), inspirado em [DurationField] do Widgetbook.
class DurationPreviewField extends PreviewField<Duration> {
  DurationPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
  }) : super(
         codec: PreviewFieldCodec<Duration>(
           toParam: (v) => v.inMilliseconds.toString(),
           toValue: (p) =>
               p == null ? null : Duration(milliseconds: int.tryParse(p) ?? 0),
         ),
       );

  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: TextField(
        controller: params.textController,
        keyboardType: TextInputType.number,
        decoration: PreviewField.inputDecoration(
          context,
          hintText: 'Duração em milissegundos',
          suffix: Text(
            'ms',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        onChanged: (text) {
          final ms = int.tryParse(text);
          if (ms != null) params.onValueChanged(Duration(milliseconds: ms));
        },
      ),
    );
  }
}
