import 'package:flutter/material.dart';

/// Cor RGB sem canal alpha (igual ao Widgetbook).
class OpaqueColor {
  OpaqueColor(this.value) : assert(value >= 0 && value <= 0xffffff);

  OpaqueColor.fromChannels({
    required int red,
    required int green,
    required int blue,
  }) : value = (red << 16) | (green << 8) | blue;

  OpaqueColor.fromColor(Color color) : value = color.toARGB32() & 0xffffff;

  final int value;

  int get red => (0xff0000 & value) >> 16;
  int get green => (0x00ff00 & value) >> 8;
  int get blue => (0x0000ff & value) >> 0;

  Color toColor() => Color(value | 0xff000000);
}
