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
    _textController = TextEditingController(text: _initialText());
  }

  String _initialText() {
    final v = _currentValue;
    if (v == null) return '';
    if (v is Duration) return v.inMilliseconds.toString();
    if (v is DateTime) {
      String pad(int x) => x.toString().padLeft(2, '0');
      return '${v.year}-${pad(v.month)}-${pad(v.day)} ${pad(v.hour)}:${pad(v.minute)}';
    }
    return v.toString();
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
    onValueChanged: (value) => setState(() {
      _currentValue = value;
      _textController.text = _initialText();
    }),
    onParseErrorChanged: (error) => setState(() => _parseError = error),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final customEditor = widget.notifier.editorBuilder?.call(
      context,
      _editorParams,
    );

    final editorWidget =
        customEditor ?? PreviewFieldEditor(params: _editorParams);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──
            Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      size: 20,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.notifier.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Editar variável',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.08,
                      ),
                    ),
                    tooltip: 'Fechar',
                  ),
                ],
              ),
            ),

            // ── Content ──
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: editorWidget,
              ),
            ),

            // ── Actions ──
            Divider(height: 1, color: colorScheme.outlineVariant),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Row(
                children: [
                  if (widget.notifier.nullable)
                    TextButton.icon(
                      onPressed: _applyNull,
                      icon: Icon(
                        Icons.block_rounded,
                        size: 18,
                        color: colorScheme.error,
                      ),
                      label: Text(
                        'NULL',
                        style: TextStyle(color: colorScheme.error),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.error,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorScheme.outlineVariant),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton.icon(
                    onPressed: _parseError ? null : _apply,
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text('Aplicar'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
