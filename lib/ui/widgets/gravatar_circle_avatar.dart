import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

/// Круглый аватар, использующий изображения из https://www.gravatar.com
///
/// Аватар будет отображать сначала первую букву из переданного имени пользователя
/// [name], после чего загрузит из https://www.gravatar.com картинку для
/// пользователя и отобразит ее.
///
/// Данный виджет произведен от [StatefulWidget], т.к. они меняет
/// свое состояние, когда загружается картинка аватара.
class GravatarCircleAvatar extends StatefulWidget {
  /// Имя
  final String name;

  /// Для получения картинки нужно передать имя пользователя [name]
  GravatarCircleAvatar({Key key, @required this.name})
      : assert(name != null),
        super(key: key);

  @override
  _GravatarCircleAvatarState createState() => new _GravatarCircleAvatarState();
}

/// Стейт круглого аватара
class _GravatarCircleAvatarState extends State<GravatarCircleAvatar> {
  /// Изображение
  NetworkImage _image;

  /// Признак того, что изображение еще не загружено
  bool _checkLoading = true;

  /// Данный метод вызовется при создании стейта
  @override
  void initState() {
    super.initState();

    _init();
  }

  /// Данный метод будет вызываться при обновлении данных виджета
  /// В нашем случае мы будем контролировать изменение [name] виджета,
  /// чтоб получить новую картинку
  @override
  void didUpdateWidget(GravatarCircleAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.name != widget.name) {
      _init();
    }
  }

  /// Инициализирует виджет
  ///
  /// Создаст новую [NetworkImage], и подпишется на окончание ее загрузки,
  /// чтоб после окончания загрузки отобразить ее.
  _init() {
    // Подготовим MD5 хеш имени пользователя [name], используя библиотеку
    // crypto
    final nameMd5 = md5.convert(utf8.encode(widget.name));
    // Создадим [NetworkImage]
    _image = new NetworkImage(
        // Для получения изображения аватара передадим MD5 хеш пользователя
        "https://www.gravatar.com/avatar/$nameMd5?s=128&d=retro&r=x&f=y");
    // Изменим стейт
    setState(() {
      // Установим признак того, что картинка еще не загрузилась
      _checkLoading = true;
    });

    // Добавим обработчик события [NetworkImage]
    _image.resolve(new ImageConfiguration()).addListener((_, __) {
      // Когда картинка загрузилась
      if (mounted) {
        // Изменим статус
        setState(() {
          // Установим признак того, что картинка загрузилась
          _checkLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Если картинка НЕ загрузилась
    return _checkLoading == true
        // То вернем круглый аватар
        ? new CircleAvatar(
            // С текстом, содержащим 1 буку имени
            child: new Text(widget.name[0].toLowerCase()),
          )
        // Иначе вернем круглый аватар
        : new CircleAvatar(
            // С картинкой
            backgroundImage: _image,
          );
  }
}
