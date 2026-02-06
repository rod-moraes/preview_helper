import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';

/// Builder de label para valores em dropdown/segmented (como [LabelBuilder] do Widgetbook).
typedef LabelBuilder<T> = String Function(T value);

/// Campo dropdown para enums/objetos, inspirado em [ObjectDropdownField] do Widgetbook.
class ObjectDropdownPreviewField<T> extends PreviewField<T> {
  ObjectDropdownPreviewField({
    required super.name,
    required super.initialValue,
    required super.defaultValue,
    required this.options,
    this.labelBuilder = defaultLabelBuilder,
  }) : super(
         codec: PreviewFieldCodec<T>(
           toParam: (v) => labelBuilder(v),
           toValue: (p) => options.cast<T?>().firstWhere(
             (e) => labelBuilder(e as T) == p,
             orElse: () => options.first,
           ),
         ),
       );

  static String defaultLabelBuilder(dynamic v) =>
      v is Enum ? v.name : v.toString();

  final List<T> options;
  final String Function(T value) labelBuilder;

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    final currentValue = params.currentValue as T?;
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: DropdownMenu<T>(
        expandedInsets: EdgeInsets.zero,
        trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
        initialSelection: currentValue,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: colorScheme.surfaceContainerLow,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
          ),
        ),
        onSelected: (v) {
          if (v != null) params.onValueChanged(v);
        },
        dropdownMenuEntries: options
            .map((e) => DropdownMenuEntry<T>(value: e, label: labelBuilder(e)))
            .toList(),
      ),
    );
  }
}
