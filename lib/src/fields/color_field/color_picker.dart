import 'dart:async';

import 'package:flutter/material.dart';

import 'color_picker_dialog.dart';
import 'color_space.dart';
import 'number_text_field.dart';
import 'opaque_color.dart';
import 'opaque_color_picker.dart';

/// Picker de cor completo (igual ao Widgetbook: swatch + espaço + alpha + campos).
class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.value,
    required this.colorSpace,
    required this.onChanged,
  });

  final Color value;
  final ColorSpace colorSpace;
  final ValueChanged<Color> onChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Timer? _debounce;
  late int alpha;
  late ColorSpace colorSpace;
  late OpaqueColor opaqueColor;
  late Key pickerKey;

  @override
  void initState() {
    super.initState();
    alpha = (widget.value.a * 255).toInt();
    colorSpace = widget.colorSpace;
    opaqueColor = OpaqueColor.fromColor(widget.value);
    pickerKey = ObjectKey(widget.value);
  }

  @override
  void didUpdateWidget(covariant ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      alpha = (widget.value.a * 255).toInt();
      opaqueColor = OpaqueColor.fromColor(widget.value);
      pickerKey = ObjectKey(widget.value);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onChange(int newAlpha, OpaqueColor newColor, {bool debounce = false}) {
    setState(() {
      alpha = newAlpha;
      opaqueColor = newColor;
    });
    _debounce?.cancel();
    if (!debounce) {
      widget.onChanged(newColor.toColor().withAlpha(newAlpha));
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      widget.onChanged(newColor.toColor().withAlpha(newAlpha));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (ctx) => Center(
                        child: ColorPickerDialog(
                          initialColor: opaqueColor.toColor().withAlpha(alpha),
                          onChanged: (color) {
                            pickerKey = ObjectKey(color);
                            setState(() {
                              opaqueColor = OpaqueColor.fromColor(color);
                              alpha = (color.a * 255).round();
                            });
                            onChange(alpha, opaqueColor, debounce: true);
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(46),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.square,
                      color: opaqueColor.toColor().withAlpha(alpha),
                    ),
                  ),
                );
              },
            ),
            DropdownMenu<ColorSpace>(
              width: 100,
              initialSelection: colorSpace,
              onSelected: (value) {
                if (value != null) setState(() => colorSpace = value);
              },
              dropdownMenuEntries: ColorSpace.values
                  .map(
                    (e) => DropdownMenuEntry(
                      value: e,
                      label: e.name.toUpperCase(),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              width: 80,
              child: NumberTextField.percentage(
                key: pickerKey,
                value: ((alpha / 255) * 100).round(),
                onChanged: (value) {
                  final newValue = (value / 100 * 255).round();
                  setState(() => alpha = newValue);
                  onChange(newValue, opaqueColor);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        OpaqueColorPicker.fromColorSpace(
          colorSpace,
          key: pickerKey,
          value: opaqueColor,
          onChanged: (value) {
            setState(() => opaqueColor = value);
            onChange(alpha, value);
          },
        ),
      ],
    );
  }
}
