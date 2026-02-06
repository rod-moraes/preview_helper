import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:preview_helper/preview_helper.dart';

// ========== Enums auxiliares para os exemplos ==========

enum SizeOption { small, medium, large }

enum ThemeModeOption { light, dark, system }

// ========== Boolean ==========

@Preview(name: 'Boolean (não nulo)')
Widget booleanPreview() {
  final enabled = BooleanPreviewKnob(name: 'enabled', value: true);
  return PreviewCustom(
    notifiers: [enabled],
    builder: (context) => Center(
      child: SwitchListTile(
        title: const Text('Enabled'),
        value: enabled.value ?? true,
        onChanged: (v) => enabled.value = v,
      ),
    ),
  );
}

@Preview(name: 'Boolean (nulo)')
Widget booleanNullablePreview() {
  final enabled = BooleanNullablePreviewKnob(
    name: 'enabled',
    value: null,
    defaultValue: false,
  );
  return PreviewCustom(
    notifiers: [enabled],
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Valor: ${enabled.value ?? "null"}'),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Enabled'),
            value: enabled.value ?? false,
            onChanged: (v) => enabled.value = v,
          ),
        ],
      ),
    ),
  );
}

// ========== String ==========

@Preview(name: 'String (não nulo)')
Widget stringPreview() {
  final title = StringPreviewKnob(name: 'title', value: 'Hello World');
  return PreviewCustom(
    notifiers: [title],
    builder: (context) => Center(
      child: Text(
        title.value ?? '',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}

@Preview(name: 'String (nulo)')
Widget stringNullablePreview() {
  final title = StringNullablePreviewKnob(
    name: 'title',
    value: null,
    defaultValue: 'Texto padrão',
  );
  return PreviewCustom(
    notifiers: [title],
    builder: (context) => Center(
      child: Text(
        title.value ?? '(null)',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontStyle: title.value == null ? FontStyle.italic : null,
          color: title.value == null
              ? Theme.of(context).colorScheme.outline
              : null,
        ),
      ),
    ),
  );
}

// ========== Int Input ==========

@Preview(name: 'Int Input (não nulo)')
Widget intInputPreview() {
  final count = IntInputPreviewKnob(name: 'count', value: 42);
  return PreviewCustom(
    notifiers: [count],
    builder: (context) => Center(
      child: Text(
        'Count: ${count.value}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}

@Preview(name: 'Int Input (nulo)')
Widget intInputNullablePreview() {
  final count = IntInputNullablePreviewKnob(
    name: 'count',
    value: null,
    defaultValue: 0,
  );
  return PreviewCustom(
    notifiers: [count],
    builder: (context) => Center(
      child: Text(
        'Count: ${count.value ?? "null"}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}

// ========== Int Slider ==========

@Preview(name: 'Int Slider (não nulo)')
Widget intSliderPreview() {
  final volume = IntSliderPreviewKnob(
    name: 'volume',
    value: 50,
    min: 0,
    max: 100,
    divisions: 10,
  );
  return PreviewCustom(
    notifiers: [volume],
    builder: (context) => Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.volume_up, size: 32),
          const SizedBox(width: 8),
          Text(
            '${volume.value}%',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}

@Preview(name: 'Int Slider (nulo)')
Widget intSliderNullablePreview() {
  final volume = IntSliderNullablePreviewKnob(
    name: 'volume',
    value: null,
    defaultValue: 50,
    min: 0,
    max: 100,
    divisions: 10,
  );
  return PreviewCustom(
    notifiers: [volume],
    builder: (context) => Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            volume.value == null ? Icons.volume_off : Icons.volume_up,
            size: 32,
          ),
          const SizedBox(width: 8),
          Text(
            volume.value != null ? '${volume.value}%' : 'null',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}

// ========== Double Input ==========

@Preview(name: 'Double Input (não nulo)')
Widget doubleInputPreview() {
  final rate = DoubleInputPreviewKnob(name: 'rate', value: 3.14);
  return PreviewCustom(
    notifiers: [rate],
    builder: (context) => Center(
      child: Text(
        'Rate: ${rate.value}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}

@Preview(name: 'Double Input (nulo)')
Widget doubleInputNullablePreview() {
  final rate = DoubleInputNullablePreviewKnob(
    name: 'rate',
    value: null,
    defaultValue: 1.0,
  );
  return PreviewCustom(
    notifiers: [rate],
    builder: (context) => Center(
      child: Text(
        'Rate: ${rate.value ?? "null"}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}

// ========== Double Slider ==========

@Preview(name: 'Double Slider (não nulo)')
Widget doubleSliderPreview() {
  final opacity = DoubleSliderPreviewKnob(
    name: 'opacity',
    value: 0.8,
    min: 0,
    max: 1,
    divisions: 20,
    precision: 2,
  );
  return PreviewCustom(
    notifiers: [opacity],
    builder: (context) => Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: opacity.value ?? 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'Opacity: ${opacity.value}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

@Preview(name: 'Double Slider (nulo)')
Widget doubleSliderNullablePreview() {
  final opacity = DoubleSliderNullablePreviewKnob(
    name: 'opacity',
    value: null,
    defaultValue: 0.5,
    min: 0,
    max: 1,
    divisions: 20,
    precision: 2,
  );
  return PreviewCustom(
    notifiers: [opacity],
    builder: (context) => Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: opacity.value != null
              ? Colors.blue.withValues(alpha: opacity.value!)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            opacity.value != null ? 'Opacity: ${opacity.value}' : 'null',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

// ========== DateTime ==========

@Preview(name: 'DateTime (não nulo)')
Widget dateTimePreview() {
  final date = DateTimePreviewKnob(
    name: 'selected',
    value: DateTime(2025, 6, 15, 12, 30),
    start: DateTime(2020),
    end: DateTime(2030),
  );
  return PreviewCustom(
    notifiers: [date],
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_month, size: 48),
          const SizedBox(height: 8),
          Text('${date.value}', style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    ),
  );
}

@Preview(name: 'DateTime (nulo)')
Widget dateTimeNullablePreview() {
  final date = DateTimeNullablePreviewKnob(
    name: 'selected',
    value: null,
    defaultValue: DateTime(2025, 1, 1),
    start: DateTime(2020),
    end: DateTime(2030),
  );
  return PreviewCustom(
    notifiers: [date],
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            date.value == null ? Icons.event_busy : Icons.calendar_month,
            size: 48,
          ),
          const SizedBox(height: 8),
          Text(
            date.value != null ? '${date.value}' : 'Nenhuma data selecionada',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontStyle: date.value == null ? FontStyle.italic : null,
            ),
          ),
        ],
      ),
    ),
  );
}

// ========== Duration ==========

@Preview(name: 'Duration (não nulo)')
Widget durationPreview() {
  final duration = DurationPreviewKnob(
    name: 'delay',
    value: const Duration(seconds: 2),
  );
  return PreviewCustom(
    notifiers: [duration],
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer, size: 48),
          const SizedBox(height: 8),
          Text(
            '${duration.value?.inMilliseconds} ms',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}

@Preview(name: 'Duration (nulo)')
Widget durationNullablePreview() {
  final duration = DurationNullablePreviewKnob(
    name: 'delay',
    value: null,
    defaultValue: const Duration(seconds: 1),
  );
  return PreviewCustom(
    notifiers: [duration],
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            duration.value == null ? Icons.timer_off : Icons.timer,
            size: 48,
          ),
          const SizedBox(height: 8),
          Text(
            duration.value != null
                ? '${duration.value?.inMilliseconds} ms'
                : 'null',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    ),
  );
}

// ========== Color ==========

@Preview(name: 'Color (não nulo)')
Widget colorPreview() {
  final color = ColorPreviewKnob(name: 'color', value: Colors.blue);
  return PreviewCustom(
    notifiers: [color],
    builder: (context) => Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color.value,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: Text(
            '#${(color.value ?? Colors.blue).toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 4)],
            ),
          ),
        ),
      ),
    ),
  );
}

@Preview(name: 'Color (nulo)')
Widget colorNullablePreview() {
  final color = ColorNullablePreviewKnob(
    name: 'color',
    value: null,
    defaultValue: Colors.deepPurple,
  );
  return PreviewCustom(
    notifiers: [color],
    builder: (context) => Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color.value ?? Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: Text(
            color.value != null
                ? '#${color.value!.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}'
                : 'null',
            style: TextStyle(
              color: color.value != null ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              shadows: color.value != null ? [const Shadow(blurRadius: 4)] : [],
            ),
          ),
        ),
      ),
    ),
  );
}

// ========== Object Dropdown ==========

@Preview(name: 'Object Dropdown (não nulo)')
Widget objectDropdownPreview() {
  final size = ObjectDropdownPreviewKnob<SizeOption>(
    name: 'size',
    value: SizeOption.medium,
    options: SizeOption.values,
  );
  return PreviewCustom(
    notifiers: [size],
    builder: (context) {
      final factor = switch (size.value) {
        SizeOption.small => 0.5,
        SizeOption.large => 1.5,
        _ => 1.0,
      };
      return Center(
        child: Icon(Icons.star, size: 64 * factor, color: Colors.amber),
      );
    },
  );
}

@Preview(name: 'Object Dropdown (nulo)')
Widget objectDropdownNullablePreview() {
  final size = ObjectDropdownNullablePreviewKnob<SizeOption>(
    name: 'size',
    value: null,
    defaultValue: SizeOption.medium,
    options: SizeOption.values,
  );
  return PreviewCustom(
    notifiers: [size],
    builder: (context) {
      if (size.value == null) {
        return Center(
          child: Text(
            'Nenhum tamanho selecionado',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        );
      }
      final factor = switch (size.value!) {
        SizeOption.small => 0.5,
        SizeOption.large => 1.5,
        SizeOption.medium => 1.0,
      };
      return Center(
        child: Icon(Icons.star, size: 64 * factor, color: Colors.amber),
      );
    },
  );
}

// ========== Object Segmented ==========

@Preview(name: 'Object Segmented (não nulo)')
Widget objectSegmentedPreview() {
  final mode = ObjectSegmentedPreviewKnob<ThemeModeOption>(
    name: 'theme',
    value: ThemeModeOption.light,
    options: ThemeModeOption.values,
    labelBuilder: (v) => v.name,
  );
  return PreviewCustom(
    notifiers: [mode],
    builder: (context) {
      final icon = switch (mode.value) {
        ThemeModeOption.dark => Icons.dark_mode,
        ThemeModeOption.system => Icons.settings_brightness,
        _ => Icons.light_mode,
      };
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(
              'Theme: ${mode.value?.name}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    },
  );
}

@Preview(name: 'Object Segmented (nulo)')
Widget objectSegmentedNullablePreview() {
  final mode = ObjectSegmentedNullablePreviewKnob<ThemeModeOption>(
    name: 'theme',
    value: null,
    defaultValue: ThemeModeOption.system,
    options: ThemeModeOption.values,
    labelBuilder: (v) => v.name,
  );
  return PreviewCustom(
    notifiers: [mode],
    builder: (context) {
      if (mode.value == null) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.help_outline, size: 48, color: Colors.grey),
              const SizedBox(height: 8),
              Text(
                'Nenhum tema selecionado',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        );
      }
      final icon = switch (mode.value!) {
        ThemeModeOption.dark => Icons.dark_mode,
        ThemeModeOption.system => Icons.settings_brightness,
        ThemeModeOption.light => Icons.light_mode,
      };
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(
              'Theme: ${mode.value?.name}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    },
  );
}

// ========== Todos os Fields em um único preview ==========

enum _TestSize { xs, sm, md, lg }

enum _TestVariant { primary, secondary, outline }

@Preview(name: 'Todos os Fields (não nulos)')
Widget allFieldsPreview() {
  final boolField = BooleanPreviewKnob(name: 'Boolean', value: true);
  final stringField = StringPreviewKnob(
    name: 'String',
    value: 'Texto editável',
  );
  final stringSingleLine = StringPreviewKnob(
    name: 'String 1 linha',
    value: 'Uma linha',
    maxLines: 1,
  );
  final intInputField = IntInputPreviewKnob(name: 'Int Input', value: 42);
  final intSliderField = IntSliderPreviewKnob(
    name: 'Int Slider',
    value: 50,
    min: 0,
    max: 100,
    divisions: 10,
  );
  final doubleInputField = DoubleInputPreviewKnob(
    name: 'Double Input',
    value: 3.14,
  );
  final doubleSliderField = DoubleSliderPreviewKnob(
    name: 'Double Slider',
    value: 0.7,
    min: 0,
    max: 1,
    divisions: 20,
    precision: 2,
  );
  final dateTimeField = DateTimePreviewKnob(
    name: 'DateTime',
    value: DateTime(2025, 6, 15, 12, 30),
    start: DateTime(2020),
    end: DateTime(2030),
  );
  final durationField = DurationPreviewKnob(
    name: 'Duration',
    value: const Duration(seconds: 2),
  );
  final colorField = ColorPreviewKnob(name: 'Color', value: Colors.teal);
  final dropdownField = ObjectDropdownPreviewKnob<_TestSize>(
    name: 'Dropdown (Enum)',
    value: _TestSize.md,
    options: _TestSize.values,
  );
  final segmentedField = ObjectSegmentedPreviewKnob<_TestVariant>(
    name: 'Segmented (Enum)',
    value: _TestVariant.primary,
    options: _TestVariant.values,
    labelBuilder: (v) => v.name,
  );

  return PreviewCustom(
    notifiers: [
      boolField,
      stringField,
      stringSingleLine,
      intInputField,
      intSliderField,
      doubleInputField,
      doubleSliderField,
      dateTimeField,
      durationField,
      colorField,
      dropdownField,
      segmentedField,
    ],
    builder: (context) => ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Toque no FAB (ícone tune) para editar cada campo.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _FieldRow(label: 'Boolean', value: boolField.value.toString()),
        _FieldRow(label: 'String', value: stringField.value ?? ''),
        _FieldRow(
          label: 'String 1 linha',
          value: stringSingleLine.value?.toString() ?? '',
        ),
        _FieldRow(label: 'Int Input', value: intInputField.value.toString()),
        _FieldRow(label: 'Int Slider', value: intSliderField.value.toString()),
        _FieldRow(
          label: 'Double Input',
          value: doubleInputField.value.toString(),
        ),
        _FieldRow(
          label: 'Double Slider',
          value: doubleSliderField.value?.toString() ?? '',
        ),
        _FieldRow(
          label: 'DateTime',
          value: dateTimeField.value?.toString() ?? '',
        ),
        _FieldRow(
          label: 'Duration',
          value: '${durationField.value?.inMilliseconds} ms',
        ),
        _FieldRow(label: 'Color', value: colorField.value.toString()),
        _FieldRow(label: 'Dropdown', value: dropdownField.value?.name ?? ''),
        _FieldRow(label: 'Segmented', value: segmentedField.value?.name ?? ''),
        const SizedBox(height: 16),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: colorField.value,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    ),
  );
}

@Preview(name: 'Todos os Fields (nulos)')
Widget allFieldsNullablePreview() {
  final boolField = BooleanNullablePreviewKnob(
    name: 'Boolean',
    value: null,
    defaultValue: false,
  );
  final stringField = StringNullablePreviewKnob(
    name: 'String',
    value: null,
    defaultValue: 'default',
  );
  final intInputField = IntInputNullablePreviewKnob(
    name: 'Int Input',
    value: null,
    defaultValue: 0,
  );
  final intSliderField = IntSliderNullablePreviewKnob(
    name: 'Int Slider',
    value: null,
    defaultValue: 50,
    min: 0,
    max: 100,
    divisions: 10,
  );
  final doubleInputField = DoubleInputNullablePreviewKnob(
    name: 'Double Input',
    value: null,
    defaultValue: 0.0,
  );
  final doubleSliderField = DoubleSliderNullablePreviewKnob(
    name: 'Double Slider',
    value: null,
    defaultValue: 0.5,
    min: 0,
    max: 1,
    divisions: 20,
    precision: 2,
  );
  final dateTimeField = DateTimeNullablePreviewKnob(
    name: 'DateTime',
    value: null,
    defaultValue: DateTime(2025, 1, 1),
    start: DateTime(2020),
    end: DateTime(2030),
  );
  final durationField = DurationNullablePreviewKnob(
    name: 'Duration',
    value: null,
    defaultValue: const Duration(seconds: 1),
  );
  final colorField = ColorNullablePreviewKnob(
    name: 'Color',
    value: null,
    defaultValue: Colors.teal,
  );
  final dropdownField = ObjectDropdownNullablePreviewKnob<_TestSize>(
    name: 'Dropdown (Enum)',
    value: null,
    defaultValue: _TestSize.md,
    options: _TestSize.values,
  );
  final segmentedField = ObjectSegmentedNullablePreviewKnob<_TestVariant>(
    name: 'Segmented (Enum)',
    value: null,
    defaultValue: _TestVariant.primary,
    options: _TestVariant.values,
    labelBuilder: (v) => v.name,
  );

  return PreviewCustom(
    notifiers: [
      boolField,
      stringField,
      intInputField,
      intSliderField,
      doubleInputField,
      doubleSliderField,
      dateTimeField,
      durationField,
      colorField,
      dropdownField,
      segmentedField,
    ],
    builder: (context) => ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Todos começam null. Toque no FAB para editar.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _FieldRow(
          label: 'Boolean',
          value: boolField.value?.toString() ?? 'null',
        ),
        _FieldRow(label: 'String', value: stringField.value ?? 'null'),
        _FieldRow(
          label: 'Int Input',
          value: intInputField.value?.toString() ?? 'null',
        ),
        _FieldRow(
          label: 'Int Slider',
          value: intSliderField.value?.toString() ?? 'null',
        ),
        _FieldRow(
          label: 'Double Input',
          value: doubleInputField.value?.toString() ?? 'null',
        ),
        _FieldRow(
          label: 'Double Slider',
          value: doubleSliderField.value?.toString() ?? 'null',
        ),
        _FieldRow(
          label: 'DateTime',
          value: dateTimeField.value?.toString() ?? 'null',
        ),
        _FieldRow(
          label: 'Duration',
          value: durationField.value != null
              ? '${durationField.value?.inMilliseconds} ms'
              : 'null',
        ),
        _FieldRow(
          label: 'Color',
          value: colorField.value?.toString() ?? 'null',
        ),
        _FieldRow(
          label: 'Dropdown',
          value: dropdownField.value?.name ?? 'null',
        ),
        _FieldRow(
          label: 'Segmented',
          value: segmentedField.value?.name ?? 'null',
        ),
        const SizedBox(height: 16),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: colorField.value ?? Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: colorField.value == null
              ? const Center(child: Text('Sem cor'))
              : null,
        ),
      ],
    ),
  );
}

// ========== Widget auxiliar ==========

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isNull = value == 'null';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: isNull
                  ? TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.outline,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ========== Exemplo agregado (Design System Card) ==========

@Preview(name: 'Design System Card (todos os tipos)')
Widget designSystemCardPreview() {
  final title = StringPreviewKnob(name: 'title', value: 'Title');
  final description = StringPreviewKnob(
    name: 'description',
    value: 'Description text',
  );
  final count = IntInputPreviewKnob(name: 'count', value: 3);
  final rating = DoubleSliderPreviewKnob(
    name: 'rating',
    value: 4.5,
    min: 0,
    max: 5,
    precision: 1,
  );
  final enabled = BooleanPreviewKnob(name: 'enabled', value: true);
  final accent = ColorPreviewKnob(name: 'accent', value: Colors.deepPurple);

  return PreviewCustom(
    notifiers: [title, description, count, rating, enabled, accent],
    builder: (context) => DesignSystemCard(
      title: title.value ?? '',
      description: description.value ?? '',
      count: count.value ?? 0,
      rating: rating.value ?? 4.5,
      enabled: enabled.value ?? false,
      accentColor: accent.value ?? Colors.deepPurple,
    ),
  );
}

class DesignSystemCard extends StatelessWidget {
  const DesignSystemCard({
    super.key,
    required this.title,
    required this.description,
    required this.count,
    required this.rating,
    required this.enabled,
    required this.accentColor,
  });

  final String title;
  final String description;
  final int count;
  final double rating;
  final bool enabled;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            Row(
              children: [
                Chip(label: Text('Count: $count')),
                const SizedBox(width: 8),
                Chip(label: Text('Rating: $rating')),
              ],
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Enabled'),
              value: enabled,
              onChanged: (_) {},
            ),
            const SizedBox(height: 8),
            Container(
              height: 24,
              width: 80,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
