import 'package:flutter/material.dart';

import 'preview_edit_dialog.dart';
import 'value_notifier_preview.dart';

/// Envolve o conteúdo do preview com um FAB que abre o menu de campos
/// editáveis ([ValueNotifierPreviewNullable]). Cada item do menu abre um diálogo.
class PreviewCustom extends StatefulWidget {
  const PreviewCustom({
    super.key,
    required this.notifiers,
    required this.builder,
  });

  /// Lista de [ValueNotifierPreviewNullable] (ex.: [title, authorName, ...]).
  final List<ValueNotifierPreviewNullable<dynamic>> notifiers;

  /// Builder do conteúdo central do preview (injetado).
  final Widget Function(BuildContext context) builder;

  @override
  State<PreviewCustom> createState() => _PreviewCustomState();
}

class _PreviewCustomState extends State<PreviewCustom> {
  final GlobalKey _menuButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _attachListeners(widget.notifiers, _onNotifierChanged);
  }

  @override
  void didUpdateWidget(PreviewCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    _detachListeners(oldWidget.notifiers, _onNotifierChanged);
    _attachListeners(widget.notifiers, _onNotifierChanged);
  }

  @override
  void dispose() {
    _detachListeners(widget.notifiers, _onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() => setState(() {});

  void _attachListeners(
    List<ValueNotifierPreviewNullable<dynamic>> list,
    VoidCallback callback,
  ) {
    for (final notifier in list) {
      notifier.addListener(callback);
    }
  }

  void _detachListeners(
    List<ValueNotifierPreviewNullable<dynamic>> list,
    VoidCallback callback,
  ) {
    for (final notifier in list) {
      notifier.removeListener(callback);
    }
  }

  void _onMenuButtonTap() {
    final box = _menuButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !mounted) return;
    final size = box.size;
    final topLeft = box.localToGlobal(Offset.zero);
    final bottomRight = box.localToGlobal(Offset(size.width, size.height));
    final colorScheme = Theme.of(context).colorScheme;
    showMenu<void>(
      context: context,
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 6,
      constraints: const BoxConstraints(minWidth: 240, maxWidth: 320),
      position: RelativeRect.fromLTRB(
        topLeft.dx,
        topLeft.dy - 8,
        bottomRight.dx + 8,
        bottomRight.dy,
      ),
      items: _buildMenuItems(),
    );
  }

  List<PopupMenuEntry<void>> _buildMenuItems() {
    final items = <PopupMenuEntry<void>>[];
    for (var i = 0; i < widget.notifiers.length; i++) {
      final preview = widget.notifiers[i];
      if (i > 0) items.add(const PopupMenuDivider(height: 1));
      items.add(
        PopupMenuItem<void>(
          padding: EdgeInsets.zero,
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showEditDialog(preview);
            });
          },
          child: _PreviewMenuEntry(
            fieldName: preview.name,
            valueSummary: _valueSummary(preview.value),
            isNull: preview.value == null,
          ),
        ),
      );
    }
    return items;
  }

  static String _valueSummary(Object? value) {
    if (value == null) return 'null';
    if (value is String) return value.isEmpty ? '""' : value;
    if (value is bool) return value ? 'true' : 'false';
    if (value is num) return value.toString();
    if (value is Enum) return value.name;
    if (value is Color) {
      return '#${value.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    }
    if (value is Duration) return '${value.inMilliseconds} ms';
    if (value is DateTime) {
      String pad(int x) => x.toString().padLeft(2, '0');
      return '${value.year}-${pad(value.month)}-${pad(value.day)} ${pad(value.hour)}:${pad(value.minute)}';
    }
    return value.toString();
  }

  Future<void> _showEditDialog<T>(
    ValueNotifierPreviewNullable<T> notifier,
  ) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => PreviewEditDialog<T>(notifier: notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: widget.builder(context),
            ),
            Positioned(
              right: 16,
              bottom: 8,
              child: Material(
                key: _menuButtonKey,
                elevation: 6,
                shadowColor: colorScheme.shadow.withValues(alpha: 0.3),
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: _onMenuButtonTap,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      Icons.tune_rounded,
                      size: 26,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Conteúdo de um item do menu de campos do preview (nome + resumo do valor).
class _PreviewMenuEntry extends StatelessWidget {
  const _PreviewMenuEntry({
    required this.fieldName,
    required this.valueSummary,
    this.isNull = false,
  });

  final String fieldName;
  final String valueSummary;
  final bool isNull;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 28,
            decoration: BoxDecoration(
              color: isNull ? colorScheme.outlineVariant : colorScheme.primary,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  fieldName,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  valueSummary,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isNull
                        ? colorScheme.outline
                        : colorScheme.onSurfaceVariant,
                    fontStyle: isNull ? FontStyle.italic : null,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.edit_rounded,
            size: 16,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
