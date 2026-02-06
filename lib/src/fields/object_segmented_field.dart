import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'object_dropdown_field.dart';

/// Campo [SegmentedButton] para um único valor [T], inspirado em [ObjectSegmentedField] do Widgetbook.
class ObjectSegmentedPreviewField<T> extends PreviewField<T> {
  ObjectSegmentedPreviewField({
    required super.name,
    required super.initialValue,
    required super.defaultValue,
    required this.options,
    this.labelBuilder = ObjectDropdownPreviewField.defaultLabelBuilder,
  }) : super(
         codec: PreviewFieldCodec<T>(
           toParam: (v) => labelBuilder(v),
           toValue: (p) => options.cast<T?>().firstWhere(
             (e) => labelBuilder(e as T) == p,
             orElse: () => options.first,
           ),
         ),
       );

  final List<T> options;
  final String Function(T value) labelBuilder;

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    final selected = params.currentValue as T?;
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<T>(
          selected: selected != null ? {selected} : {},
          emptySelectionAllowed: selected == null,
          showSelectedIcon: false,
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          onSelectionChanged: (newValue) {
            if (newValue.isNotEmpty) {
              params.onValueChanged(newValue.first);
            }
          },
          segments: options
              .map(
                (value) => ButtonSegment<T>(
                  value: value,
                  label: Text(
                    labelBuilder(value),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
