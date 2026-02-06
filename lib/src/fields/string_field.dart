import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';

/// Campo de texto para [String], inspirado em [StringField] do Widgetbook.
class StringPreviewField extends PreviewField<String> {
  StringPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
    this.maxLines = 3,
  }) : super(
         codec: const PreviewFieldCodec(
           toParam: _identity,
           toValue: _identityNullable,
         ),
       );

  static String _identity(String v) => v;
  static String? _identityNullable(String? v) => v;

  final int maxLines;

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: TextFormField(
        controller: params.textController,
        maxLines: maxLines,
        decoration: PreviewField.inputDecoration(
          context,
          hintText: 'Digite um valor',
        ),
        onChanged: (text) => params.onValueChanged(text),
      ),
    );
  }
}
