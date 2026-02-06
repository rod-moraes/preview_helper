import 'package:flutter/material.dart';

import 'color_field/color_picker.dart';
import 'color_field/color_space.dart';
import 'field.dart';
import 'field_codec.dart';

export 'color_field/color_space.dart';

/// Campo para [Color] no estilo Widgetbook: swatch + espaço (hex/rgb/hsl) + alpha + pickers.
class ColorPreviewField extends PreviewField<Color> {
  ColorPreviewField({
    required super.name,
    super.initialValue,
    required super.defaultValue,
    this.initialColorSpace = ColorSpace.hex,
  }) : super(
         codec: PreviewFieldCodec<Color>(
           toParam: (c) => c.toARGB32().toRadixString(16),
           toValue: (p) {
             if (p == null) return null;
             if (p == '0') return Colors.transparent;
             return Color(int.parse(p.length == 6 ? '00$p' : p, radix: 16));
           },
         ),
       );

  final ColorSpace initialColorSpace;

  static const defaultColor = Colors.white;

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    final color = (params.currentValue as Color?) ?? defaultValue;
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: ColorPicker(
        colorSpace: initialColorSpace,
        value: color,
        onChanged: (value) => params.onValueChanged(value),
      ),
    );
  }
}
