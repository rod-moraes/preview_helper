# Changelog

Todas as alterações notáveis deste projeto serão documentadas neste arquivo.

## 1.1.0

### Adicionado

- **12 tipos de knob** prontos para uso (não-nulo e nullable):
  - `BooleanPreviewKnob` / `BooleanNullablePreviewKnob`
  - `StringPreviewKnob` / `StringNullablePreviewKnob`
  - `IntInputPreviewKnob` / `IntInputNullablePreviewKnob`
  - `IntSliderPreviewKnob` / `IntSliderNullablePreviewKnob`
  - `DoubleInputPreviewKnob` / `DoubleInputNullablePreviewKnob`
  - `DoubleSliderPreviewKnob` / `DoubleSliderNullablePreviewKnob`
  - `DateTimePreviewKnob` / `DateTimeNullablePreviewKnob`
  - `DurationPreviewKnob` / `DurationNullablePreviewKnob`
  - `ColorPreviewKnob` / `ColorNullablePreviewKnob`
  - `ObjectDropdownPreviewKnob<T>` / `ObjectDropdownNullablePreviewKnob<T>`
  - `ObjectSegmentedPreviewKnob<T>` / `ObjectSegmentedNullablePreviewKnob<T>`
- **Fields visuais** para cada tipo com layout modernizado:
  - Barra de acento colorida no label de cada campo.
  - `InputDecoration` padronizado (outline arredondado, preenchimento, cores do tema).
  - Badge compacto de valor nos sliders com labels de min/max.
  - Boolean com layout inline (switch na mesma linha do label).
  - Segmented com `VisualDensity.compact` e bordas arredondadas.
  - Dropdown com `InputDecorationTheme` consistente.
- **Color picker** completo (HEX, RGB, HSL) com swatch e alpha.
- **Exemplo completo** em `example/` com previews para todos os 12 tipos (não-nulo e nullable).

### Melhorado

- **Menu popup** (`PreviewCustom`):
  - Usa cores do `ColorScheme` (não mais `Colors.white` hardcoded).
  - Shape arredondado, largura controlada (240–320), dividers entre itens.
  - Itens com barra de acento, ícone de edição e formatação de valor melhorada (Color, Duration, DateTime).
  - FAB com cor `primaryContainer` e bordas arredondadas.
- **Diálogo de edição** (`PreviewEditDialog`):
  - Migrado de `AlertDialog` para `Dialog` customizado com shape arredondado (raio 20).
  - Header com fundo `surfaceContainerHigh`, ícone em badge e nome da variável como título.
  - Botão NULL com ícone `block` em cor `error` (ação destrutiva clara).
  - Cancelar como `OutlinedButton`, Aplicar como `FilledButton` com ícone check.
  - Botão de fechar (X) no header.
- **README** reescrito com catálogo completo de knobs, tabela de parâmetros e exemplos atualizados.

## 1.0.1

- README atualizado: exemplo com `@Preview` e Design System Card, seção "Como fica na prática" com imagens do Flutter Widget Preview e do diálogo "Editar variável", API resumida e dicas de uso.

## 1.0.0

- Versão inicial: `PreviewCustom`, `ValueNotifierPreview`, `ValueNotifierPreviewNullable`, diálogo de edição e editores para bool, int, double, string e enum.
