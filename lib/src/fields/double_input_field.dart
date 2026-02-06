import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';

/// Campo numérico double, inspirado em [DoubleInputField] do Widgetbook.
class DoubleInputPreviewField extends PreviewField<double> {
  DoubleInputPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
  }) : super(
         codec: PreviewFieldCodec<double>(
           toParam: (v) => v.toString(),
           toValue: (p) => double.tryParse(p?.replaceFirst(',', '.') ?? ''),
         ),
       );

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: TextField(
        controller: params.textController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
        ],
        decoration: PreviewField.inputDecoration(
          context,
          hintText: 'Digite um número decimal',
          errorText: params.parseError ? 'Valor numérico inválido' : null,
        ),
        onChanged: (text) {
          final parsed = double.tryParse(text.replaceFirst(',', '.'));
          params.onParseErrorChanged(text.isNotEmpty && parsed == null);
          if (parsed != null) params.onValueChanged(parsed);
        },
      ),
    );
  }
}
