import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'value_notifier_preview.dart';

/// Editor de campo do diálogo de preview por tipo (bool, int, double, enum,
/// string). Widget único responsável por escolher e construir o controle.
/// Recebe [params] injetado (uso padrão quando [ValueNotifierPreviewNullable.editorBuilder]
/// é null ou retorna null).
class PreviewFieldEditor<T> extends StatelessWidget {
  const PreviewFieldEditor({super.key, required this.params});

  final PreviewEditorParams<T> params;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = params.currentValue;

    if (params.notifier.defaultValue is bool) {
      return _PreviewBoolEditor(
        fieldName: params.fieldName,
        value: (value as bool?) ?? false,
        onChanged: params.onValueChanged,
      );
    }

    if (params.notifier.defaultValue is double) {
      return _PreviewDoubleEditor(
        fieldName: params.fieldName,
        controller: params.textController,
        parseError: params.parseError,
        onChanged: params.onValueChanged,
        onParseErrorChanged: params.onParseErrorChanged,
      );
    }

    if (params.notifier.defaultValue is int) {
      return _PreviewIntEditor(
        fieldName: params.fieldName,
        controller: params.textController,
        parseError: params.parseError,
        onChanged: params.onValueChanged,
        onParseErrorChanged: params.onParseErrorChanged,
      );
    }
    if (params.notifier.defaultValue is String) {
      return _PreviewStringEditor(
        fieldName: params.fieldName,
        controller: params.textController,
        onChanged: params.onValueChanged,
      );
    }

    if (params.notifier.defaultValue is Enum) {
      final options = params.notifier.enumValues;
      if (options == null || options.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Enum sem opções. Passe enumValues no ValueNotifierPreviewNullable.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        );
      }
      return _PreviewEnumEditor(
        fieldName: params.fieldName,
        value: value,
        options: options,
        onChanged: params.onValueChanged,
      );
    }
    return const SizedBox.shrink();
  }
}

class _PreviewBoolEditor<T> extends StatelessWidget {
  const _PreviewBoolEditor({
    required this.fieldName,
    required this.value,
    required this.onChanged,
  });

  final String fieldName;
  final bool value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(child: Text(fieldName, style: theme.textTheme.titleMedium)),
        Switch(value: value, onChanged: (v) => onChanged(v as T)),
      ],
    );
  }
}

class _PreviewIntEditor<T> extends StatelessWidget {
  const _PreviewIntEditor({
    required this.fieldName,
    required this.controller,
    required this.parseError,
    required this.onChanged,
    required this.onParseErrorChanged,
  });

  final String fieldName;
  final TextEditingController controller;
  final bool parseError;
  final ValueChanged<T> onChanged;
  final ValueChanged<bool> onParseErrorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(fieldName, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[-0-9]')),
          ],
          decoration: InputDecoration(
            errorText: parseError ? 'Valor inteiro inválido' : null,
            border: const OutlineInputBorder(),
          ),
          onChanged: (text) {
            final parsed = int.tryParse(text);
            onParseErrorChanged(text.isNotEmpty && parsed == null);
            if (parsed != null) onChanged(parsed as T);
          },
        ),
      ],
    );
  }
}

class _PreviewDoubleEditor<T> extends StatelessWidget {
  const _PreviewDoubleEditor({
    required this.fieldName,
    required this.controller,
    required this.parseError,
    required this.onChanged,
    required this.onParseErrorChanged,
  });

  final String fieldName;
  final TextEditingController controller;
  final bool parseError;
  final ValueChanged<T> onChanged;
  final ValueChanged<bool> onParseErrorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(fieldName, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            errorText: parseError ? 'Valor numérico inválido' : null,
            border: const OutlineInputBorder(),
          ),
          onChanged: (text) {
            final parsed = double.tryParse(text.replaceFirst(',', '.'));
            onParseErrorChanged(text.isNotEmpty && parsed == null);
            if (parsed != null) onChanged(parsed as T);
          },
        ),
      ],
    );
  }
}

class _PreviewEnumEditor<T> extends StatelessWidget {
  const _PreviewEnumEditor({
    required this.fieldName,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String fieldName;
  final Object? value;
  final List<Object?> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(fieldName, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<Object?>(
          initialValue: value,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: options
              .map(
                (e) => DropdownMenuItem<Object?>(
                  value: e,
                  child: Text(e is Enum ? e.name : e.toString()),
                ),
              )
              .toList(),
          onChanged: (v) => onChanged(v as T),
        ),
      ],
    );
  }
}

class _PreviewStringEditor<T> extends StatelessWidget {
  const _PreviewStringEditor({
    required this.fieldName,
    required this.controller,
    required this.onChanged,
  });

  final String fieldName;
  final TextEditingController controller;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(fieldName, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          maxLines: 3,
          onChanged: (text) => onChanged(text as T),
        ),
      ],
    );
  }
}
