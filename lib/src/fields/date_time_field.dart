// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';

/// Campo para [DateTime] com date/time picker, inspirado em [DateTimeField] do Widgetbook.
class DateTimePreviewField extends PreviewField<DateTime> {
  DateTimePreviewField({
    required super.name,
    required super.initialValue,
    required super.defaultValue,
    required this.start,
    required this.end,
  }) : super(
         codec: PreviewFieldCodec<DateTime>(
           toParam: (v) => _toSimpleFormat(v),
           toValue: (p) => p == null ? null : DateTime.tryParse(p),
         ),
       );

  static String _toSimpleFormat(DateTime v) {
    String pad(int value) => value.toString().padLeft(2, '0');
    return '${v.year}-${pad(v.month)}-${pad(v.day)} ${pad(v.hour)}:${pad(v.minute)}';
  }

  final DateTime start;
  final DateTime end;

  Future<DateTime?> _showDateTimePicker(
    BuildContext context, [
    DateTime? value,
  ]) async {
    final initialDate = value ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: start,
      lastDate: end,
    );
    if (date == null) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params) {
    return PreviewField.fieldLayout(
      context,
      label: params.fieldName,
      child: TextField(
        controller: params.textController,
        keyboardType: TextInputType.datetime,
        decoration: PreviewField.inputDecoration(
          context,
          hintText: 'aaaa-mm-dd hh:mm',
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            tooltip: 'Selecionar data e hora',
            onPressed: () async {
              final dateTime = await _showDateTimePicker(
                context,
                params.currentValue as DateTime?,
              );
              if (context.mounted && dateTime != null) {
                params.onValueChanged(dateTime);
              }
            },
          ),
        ),
        onChanged: (text) {
          final dateTime = DateTime.tryParse(text);
          if (dateTime != null) params.onValueChanged(dateTime);
        },
      ),
    );
  }
}
