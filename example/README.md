# preview_helper — Exemplo

Projeto de exemplo que demonstra **todos os tipos de knob** do pacote `preview_helper`, em versão não-nula e nullable.

## Previews disponíveis

Cada tipo de knob possui dois previews: um com valor inicial e outro começando como `null`.

| Tipo             | Preview não-nulo            | Preview nullable        |
| ---------------- | --------------------------- | ----------------------- |
| `bool`           | Boolean (não nulo)          | Boolean (nulo)          |
| `String`         | String (não nulo)           | String (nulo)           |
| `int` input      | Int Input (não nulo)        | Int Input (nulo)        |
| `int` slider     | Int Slider (não nulo)       | Int Slider (nulo)       |
| `double` input   | Double Input (não nulo)     | Double Input (nulo)     |
| `double` slider  | Double Slider (não nulo)    | Double Slider (nulo)    |
| `DateTime`       | DateTime (não nulo)         | DateTime (nulo)         |
| `Duration`       | Duration (não nulo)         | Duration (nulo)         |
| `Color`          | Color (não nulo)            | Color (nulo)            |
| `Enum` dropdown  | Object Dropdown (não nulo)  | Object Dropdown (nulo)  |
| `Enum` segmented | Object Segmented (não nulo) | Object Segmented (nulo) |

Além dos individuais, há três previews agregados:

- **Todos os Fields (não nulos)** — todos os tipos com valores iniciais.
- **Todos os Fields (nulos)** — todos os tipos começando `null`.
- **Design System Card** — exemplo composto com vários knobs aplicados a um card.

## Como rodar

```bash
cd example
flutter pub get
flutter run
```

Ou use o **Flutter Widget Preview** do seu editor para visualizar cada `@Preview` diretamente.

## Estrutura

```
example/
  lib/
    main.dart      # Todos os previews (22 individuais + 3 agregados)
  pubspec.yaml
```
