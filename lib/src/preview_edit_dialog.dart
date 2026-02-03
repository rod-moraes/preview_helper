import 'package:flutter/material.dart';

import 'preview_field_editor.dart';
import 'value_notifier_preview.dart';

/// Diálogo para editar o valor de um [ValueNotifierPreviewNullable].
/// Usa [ValueNotifierPreviewNullable.editorBuilder] se definido e não null;
/// caso contrário usa o editor padrão [PreviewFieldEditor].
class PreviewEditDialog<T> extends StatefulWidget {
  const PreviewEditDialog({super.key, required this.notifier});

  final ValueNotifierPreviewNullable<T> notifier;

  @override
  State<PreviewEditDialog<T>> createState() => _PreviewEditDialogState<T>();
}

class _PreviewEditDialogState<T> extends State<PreviewEditDialog<T>> {
  late T? _currentValue;
  late TextEditingController _textController;
  bool _parseError = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.notifier.value;
    _textController = TextEditingController(
      text: _currentValue?.toString() ?? "",
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _apply() {
    if (_parseError) return;
    widget.notifier.value = _currentValue;
    if (mounted) Navigator.of(context).pop();
  }

  void _applyNull() {
    widget.notifier.value = widget.notifier.value is T
        ? null
        : widget.notifier.value;
    if (mounted) Navigator.of(context).pop();
  }

  PreviewEditorParams<T> get _editorParams => PreviewEditorParams<T>(
    fieldName: widget.notifier.name,
    currentValue: _currentValue,
    notifier: widget.notifier,
    textController: _textController,
    parseError: _parseError,
    onValueChanged: (value) => setState(() => _currentValue = value),
    onParseErrorChanged: (error) => setState(() => _parseError = error),
  );

  @override
  Widget build(BuildContext context) {
    final customEditor = widget.notifier.editorBuilder?.call(
      context,
      _editorParams,
    );

    final editorWidget =
        customEditor ?? PreviewFieldEditor(params: _editorParams);

    return AlertDialog(
      title: const Text('Editar variável'),
      content: SingleChildScrollView(
        child: SizedBox(width: double.maxFinite, child: editorWidget),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.notifier.nullable)
              FilledButton(
                onPressed: _applyNull,
                child: const Text('Atribuir NULL'),
              ),
            Spacer(),

            Row(
              children: [
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: _parseError ? null : _apply,
                  child: const Text('Aplicar'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
