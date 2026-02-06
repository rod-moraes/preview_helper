import 'package:flutter/material.dart';

/// Parâmetros injetados para construir o editor de um campo do preview
/// (padrão ou customizado via [ValueNotifierPreviewNullable.editorBuilder]).
class PreviewEditorParams<T> {
  const PreviewEditorParams({
    required this.fieldName,
    required this.currentValue,
    required this.notifier,
    required this.textController,
    required this.parseError,
    required this.onValueChanged,
    required this.onParseErrorChanged,
  });

  final String fieldName;
  final T? currentValue;
  final ValueNotifierPreviewNullable<T> notifier;
  final TextEditingController textController;
  final bool parseError;
  final ValueChanged<T> onValueChanged;
  final ValueChanged<bool> onParseErrorChanged;

  /// Indica se o campo pode ser nulo (espelha [ValueNotifierPreviewNullable.nullable]).
  bool get nullable => notifier.nullable;
}

/// Assinatura do builder opcional de editor por tipo.
/// Se retornar `null`, o preview usa os editores padrão (bool, int, double,
/// enum, string).
typedef PreviewEditorBuilder =
    Widget? Function(BuildContext context, PreviewEditorParams params);

/// Base não anulável: use as classes concretas ([BooleanPreviewKnob], etc.).
abstract class ValueNotifierPreview<T extends Object>
    extends ValueNotifierPreviewNullable<T> {
  ValueNotifierPreview({
    required super.name,
    required T value,
    super.enumValues,
    super.editorBuilder,
  }) : super(value: value, defaultValue: value);
}

/// Modelo de um campo editável no preview (nome + valor reativo + opções
/// enum). Base abstrata: use as classes concretas ([StringPreviewKnob], etc.).
/// Cada uma implementa [toField]. Opcionalmente [editorBuilder].
abstract class ValueNotifierPreviewNullable<T> extends ValueNotifier<T?> {
  ValueNotifierPreviewNullable({
    required this.name,
    required T? value,
    this.enumValues,
    this.editorBuilder,
    required this.defaultValue,
  }) : super(value);

  final String name;

  final T defaultValue;

  final List<T>? enumValues;

  bool get nullable => this is! ValueNotifierPreview;

  /// Builder opcional do editor. Se null ou se retornar null, usa os
  /// editores padrão do preview.
  final PreviewEditorBuilder? editorBuilder;

  /// Retorna o [PreviewField] correspondente a esta classe. Implementado por cada knob.
  Object? toField();
}
