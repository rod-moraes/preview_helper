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
    showMenu<void>(
      context: context,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      position: RelativeRect.fromLTRB(
        topLeft.dx,
        topLeft.dy - 8,
        bottomRight.dx + 8,
        bottomRight.dy,
      ),
      items: _buildMenuItems(),
    );
  }

  List<PopupMenuItem<void>> _buildMenuItems() {
    return widget.notifiers
        .map(
          (preview) => PopupMenuItem<void>(
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showEditDialog(preview);
              });
            },
            child: _PreviewMenuEntry(
              fieldName: preview.name,
              valueSummary: _valueSummary(preview.value),
            ),
          ),
        )
        .toList();
  }

  static String _valueSummary(Object? value) {
    if (value == null) return 'null';
    if (value is String) return value.isEmpty ? '""' : value;
    if (value is bool) return value ? 'true' : 'false';
    if (value is num) return value.toString();
    if (value is Enum) return value.name;
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
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: widget.builder(context),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Material(
                key: _menuButtonKey,
                elevation: 4,
                borderRadius: BorderRadius.circular(28),
                child: InkWell(
                  onTap: _onMenuButtonTap,
                  borderRadius: BorderRadius.circular(28),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.tune, size: 28),
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
  });

  final String fieldName;
  final String valueSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          fieldName,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Valor: $valueSummary',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
