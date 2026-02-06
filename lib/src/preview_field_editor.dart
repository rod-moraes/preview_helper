import 'package:flutter/material.dart';

import 'fields/field_resolver.dart';
import 'fields/fields.dart';

/// Editor de campo do diálogo de preview por tipo (bool, int, double, enum,
/// string, slider, color, dateTime, duration, segmented). Usa o padrão Field
/// do Widgetbook: delega para [resolveFieldForPreview] que retorna o campo
/// concreto, e cada campo constrói seu widget via [PreviewField.toWidget].
///
/// [params] pode ser [PreviewEditorParams<dynamic>]; cada campo faz cast
/// internamente para o tipo correto.
class PreviewFieldEditor<T> extends StatelessWidget {
  const PreviewFieldEditor({super.key, required this.params});

  final PreviewEditorParams<T> params;

  @override
  Widget build(BuildContext context) {
    final field = resolveFieldForPreview(params.notifier);
    if (field == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Tipo não suportado ou enum sem opções. Passe enumValues no ValueNotifierPreviewNullable.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }
    return field.toWidget(context, params);
  }
}
