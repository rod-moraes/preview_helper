/// Codec para codificar/decodificar valores de campo (inspirado em [FieldCodec] do Widgetbook).
class PreviewFieldCodec<T> {
  const PreviewFieldCodec({required this.toParam, required this.toValue});

  final String Function(T value) toParam;
  final T? Function(String? param) toValue;
}
