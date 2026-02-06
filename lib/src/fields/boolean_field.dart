import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';

/// Campo booleano (Switch), inspirado em [BooleanField] do Widgetbook.
class BooleanPreviewField extends PreviewField<bool> {
  BooleanPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
  }) : super(
         codec: PreviewFieldCodec<bool>(
           toParam: (v) => v.toString(),
           toValue: (p) => p == null ? null : p == 'true',
         ),
       );

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    final currentValue = params.currentValue as bool?;
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      inline: true,
      child: Switch(
        value: currentValue ?? defaultValue,
        onChanged: (v) => params.onValueChanged(v),
      ),
    );
  }
}
