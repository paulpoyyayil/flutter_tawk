# flutter_tawk

[![pub package](https://img.shields.io/pub/v/flutter_tawk.svg)](https://pub.dartlang.org/packages/flutter_tawk)

<img src="https://i1.wp.com/www.tawk.to/wp-content/uploads/2020/04/tawk-sitelogo.png" width="48">

[Tawk](https://www.tawk.to) widget for Flutter.

## 🚀 Showcase

<p>
    <img src="https://raw.githubusercontent.com/ayoubamine/flutter_tawk/main/readme_resources/screenshot1.png" width="200" />
    <img src="https://raw.githubusercontent.com/ayoubamine/flutter_tawk/main/readme_resources/screenshot2.png" width="200" />
    <img src="https://raw.githubusercontent.com/ayoubamine/flutter_tawk/main/readme_resources/screenshot3.png" width="200" />
</p>

## Install

To use this package, add `flutter_tawk` as dependency in your pubspec.yaml file.

## Import

```dart
import 'package:flutter_tawk/flutter_tawk.dart';
```

## How To Use

```dart
Tawk(
    directChatLink: 'YOUR_DIRECT_CHAT_LINK',
    placeholder: Center(child: CircularProgressIndicator()),
)
```

## Customization

### Tawk

| Parameter      | Type          | Default                                      | Description                                    | Required |
| -------------- | ------------- | -------------------------------------------- | ---------------------------------------------- | -------- |
| directChatLink | `String`      | `null`                                       | Tawk direct chat link.                         | Yes      |
| placeholder    | `Widget`      | `Center(child: CircularProgressIndicator())` | Render your own loading widget.                | Yes      |


## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/ayoubamine/flutter_tawk/issues).  
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/ayoubamine/flutter_tawk/pulls).

## Changelog

[CHANGELOG](./CHANGELOG.md)

## License

[MIT License](./LICENSE)
