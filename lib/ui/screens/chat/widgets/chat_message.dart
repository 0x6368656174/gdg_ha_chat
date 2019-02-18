import 'package:flutter/material.dart';

import 'package:gdg_ha_chat/ui/widgets/widgets.dart';

/// Сообщение чата
///
/// Сообщение чата не будет менять само себя, поэтому можно сделать его от
/// [StatelessWidget]
class ChatMessage extends StatelessWidget {
  /// Создадим сообщение
  ///
  /// Сообщение обязательно должно содержать в себе текст [text], никнейм
  /// отправителя [nickname] и признак того, что это мы отправили данное
  /// сообщение [own]
  ChatMessage(
      {Key key,
      @required this.text,
      @required this.nickname,
      @required this.own})
      : assert(text != null),
        assert(nickname != null),
        assert(own != null),
        super(key: key);

  /// Никнейм отправителя
  final String nickname;

  /// Текст сообщения
  final String text;

  /// Признак того, что мы являемся его отправителем
  final bool own;

  @override
  Widget build(BuildContext context) {
    // Вернем виджет с отступом
    return new Padding(
      // В 8 единиц сверху
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      // Который будет содержать строку
      child: new Row(
        // В которой текст будет идти слева направо, если отправитель не мы,
        // и справа на лева, если отправитель мы
        textDirection: !own ? TextDirection.ltr : TextDirection.rtl,
        // По вертикали будет выравнена по верху
        crossAxisAlignment: CrossAxisAlignment.start,
        // И будет содержать
        children: <Widget>[
          // С отступом
          new Padding(
            // Если не мы отправитель
            padding: !own
                // То справа 16 единиц
                ? const EdgeInsets.only(right: 16.0)
                // Иначе слева 16 единиц
                : const EdgeInsets.only(left: 16.0),
            // Круглый аватар с картинкой
            child: new GravatarCircleAvatar(name: nickname),
          ),
          // Блок, который будет пытаться занять все свободное пространство
          Expanded(
            // С колонкой
            child: new Column(
              // Выравненной по горизонтали, если мы отправитель, то права,
              // иначе слева
              crossAxisAlignment:
                  !own ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              // Содержащей
              children: <Widget>[
                // Текст, содержащей отравителя
                new Text(nickname, style: Theme.of(context).textTheme.subhead),
                // Текст, содержащий сообщение
                new Container(
                  // С отступом сверху 5 единиц
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
