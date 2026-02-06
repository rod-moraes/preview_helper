import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';

/// Campo numérico inteiro, inspirado em [IntInputField] do Widgetbook.
class IntInputPreviewField extends PreviewField<int> {
  IntInputPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
  }) : super(
         codec: PreviewFieldCodec<int>(
           toParam: (v) => v.toString(),
           toValue: (p) => int.tryParse(p ?? ''),
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
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*'))],
        decoration: PreviewField.inputDecoration(
          context,
          hintText: 'Digite um número inteiro',
          errorText: params.parseError ? 'Valor inteiro inválido' : null,
        ),
        onChanged: (text) {
          final parsed = int.tryParse(text);
          params.onParseErrorChanged(text.isNotEmpty && parsed == null);
          if (parsed != null) params.onValueChanged(parsed);
        },
      ),
    );
  }
}
