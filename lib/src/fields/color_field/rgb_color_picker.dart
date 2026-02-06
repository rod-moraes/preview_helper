import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'number_text_field.dart';
import 'opaque_color.dart';
import 'opaque_color_picker.dart';

/// Picker RGB (igual ao Widgetbook).
class RgbColorPicker extends StatefulWidget implements OpaqueColorPicker {
  const RgbColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  final OpaqueColor value;
  @override
  final ValueChanged<OpaqueColor> onChanged;

  @override
  State<RgbColorPicker> createState() => _RgbColorPickerState();
}

class _RgbColorPickerState extends State<RgbColorPicker> {
  late int red;
  late int green;
  late int blue;

  @override
  void initState() {
    super.initState();
    red = widget.value.red;
    green = widget.value.green;
    blue = widget.value.blue;
  }

  void onValuesChanged(int newRed, int newGreen, int newBlue) {
    setState(() {
      red = newRed;
      green = newGreen;
      blue = newBlue;
    });
    widget.onChanged(
      OpaqueColor.fromChannels(red: newRed, green: newGreen, blue: newBlue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: NumberTextField(
            value: red,
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
                replacementString: '$red',
              ),
            ],
            labelText: 'R',
            onChanged: (v) => onValuesChanged(v, green, blue),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: NumberTextField(
            value: green,
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
                replacementString: '$green',
              ),
            ],
            labelText: 'G',
            onChanged: (v) => onValuesChanged(red, v, blue),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: NumberTextField(
            value: blue,
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'),
                replacementString: '$blue',
              ),
            ],
            labelText: 'B',
            onChanged: (v) => onValuesChanged(red, green, v),
          ),
        ),
      ],
    );
  }
}
