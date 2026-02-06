import '../value_notifier_preview.dart';
import 'field.dart';

/// Resolve o [PreviewField] a partir do knob: cada classe concreta implementa
/// [ValueNotifierPreviewNullable.toField] e retorna o campo com sua própria configuração.
PreviewField<dynamic>? resolveFieldForPreview(
  ValueNotifierPreviewNullable<dynamic> preview,
) {
  final field = preview.toField();
  return field == null ? null : field as PreviewField<dynamic>;
}
