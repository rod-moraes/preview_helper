import 'package:flutter/material.dart';

import '../value_notifier_preview.dart';
import 'field_codec.dart';

export '../value_notifier_preview.dart' show PreviewEditorParams;

/// Base para campos editáveis do preview (inspirado em [Field] do Widgetbook).
/// Cada campo sabe construir seu widget de edição via [toWidget].
@optionalTypeArgs
abstract class PreviewField<T> {
  const PreviewField({
    required this.name,
    required this.initialValue,
    required this.defaultValue,
    required this.codec,
  });

  final String name;
  final T? initialValue;
  final T defaultValue;
  final PreviewFieldCodec<T> codec;

  /// Layout padrão para campos: barra de acento colorida à esquerda do label,
  /// tipografia moderna e espaçamento refinado.
  ///
  /// Quando [inline] é `true`, o [child] fica na mesma linha que o label
  /// (ideal para Switch, Checkbox etc.).
  static Widget fieldLayout(
    BuildContext context, {
    required String label,
    String? description,
    required Widget child,
    bool inline = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final labelStyle = theme.textTheme.labelLarge?.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    );
    final accentBar = Container(
      width: 3,
      height: 18,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );

    if (inline) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            accentBar,
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
            ),
            child,
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              accentBar,
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
            ],
          ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  /// [InputDecoration] padronizada para uso em todos os campos de texto.
  static InputDecoration inputDecoration(
    BuildContext context, {
    String? hintText,
    String? errorText,
    Widget? suffixIcon,
    Widget? suffix,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );
    return InputDecoration(
      hintText: hintText,
      errorText: errorText,
      suffixIcon: suffixIcon,
      suffix: suffix,
      isDense: true,
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: colorScheme.error, width: 1.5),
      ),
      counterText: '',
    );
  }

  /// Widget de badge para exibir valores numéricos de forma compacta
  /// (utilizado por campos de slider).
  static Widget valueBadge(BuildContext context, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }

  /// Constrói o widget de edição para o painel/diálogo do preview.
  /// Recebe [PreviewEditorParams<dynamic>] quando o diálogo é aberto com tipo
  /// genérico; cada implementação faz cast de [params.currentValue] e
  /// [params.notifier] para o [T] do campo.
  Widget toWidget(BuildContext context, PreviewEditorParams<dynamic> params);
}
