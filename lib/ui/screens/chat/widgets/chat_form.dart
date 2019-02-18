import 'package:flutter/material.dart';

import 'package:gdg_ha_chat/blocs/blocs.dart';

/// Форма для отправки сообщений чата
/// Будет представлять из себя [StatefulWidget], т.к. в ней будет меняться
/// состояние кнопочки отправки.
class ChatForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ChatFormState();
}

/// Стейт формы отправки сообщений чата
/// В ней будем тут городить работу с [Form], т.к. нам это особе не нужно,
/// и обойдемся простым [TextEditingController], для управления полем ввода.
class _ChatFormState extends State<ChatForm> {
  /// Данный контроллер будет управлять полем ввода сообщений
  final TextEditingController _textController = new TextEditingController();

  /// Это свойство значит, что сообщение готово к отправке
  bool _isComposing = false;

  /// BLoC [ChatBloc], для управления чатом. Будем получать его из контекста,
  /// т.к. он определен в [Chat].
  ChatBloc _chatBloc;

  /// Данный метод вызывается один раз, при создании стейта.
  /// Это самое хорошее место для получения переменных, зависящих от контекста,
  /// например, BLoC [ChatBloc], который определен в [Chat].
  @override
  void initState() {
    super.initState();

    // Получим BLoC [ChatBloc] из контекста
    _chatBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    // Список будет представлять из себя контейнер
    return new Container(
      // С белым фоном
      decoration: new BoxDecoration(
        // Получим белым фон из текущей темы
        color: Theme.of(context).cardColor,
      ),
      // С определенной темой иконок
      child: new IconTheme(
        // Все иконки будут цвета "accent"
        data: new IconThemeData(color: Theme.of(context).accentColor),
        // С отступами
        child: new Padding(
            // Отступы будут по горизонтали слева и справа в 8 единиц
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // Форма будет в виде строки
            child: new Row(
              // Содержащей
              children: <Widget>[
                // Текстовое поле, которое будет пытаться занять все доступное
                // пространство
                new Flexible(
                  // Текстовое поле
                  child: new TextField(
                    // Управляемое указанным контроллером
                    controller: _textController,
                    // При отправке будем
                    onSubmitted: (String text) =>
                        //обрабатывать текст
                        _handleSubmitted(_chatBloc, _textController.text),
                    // При изменении будем
                    onChanged: (String text) {
                      // Менять стейт виджета
                      setState(() {
                        // В котором будем включать отправку кнопкой,
                        // если задан какой-то текст
                        _isComposing = text.length > 0;
                      });
                    },
                    // Добавим декоратор, который будет содержать
                    decoration: new InputDecoration.collapsed(
                        // Текст подсказки
                        hintText: 'Send a message'),
                  ),
                ),
                // Добавим отступы
                new Padding(
                  // Слева и справа по 4 единицы
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  // Добавим кнопку с иконкой
                  child: new IconButton(
                    // В которой будет иконка в иде значка "Отправить"
                    icon: new Icon(Icons.send),
                    // Проверим, что отправка разрешена
                    onPressed: _isComposing
                        // Если она разрешена, то добавим обработчик на отправку
                        ? () =>
                            _handleSubmitted(_chatBloc, _textController.text)
                        // Если не разрешена, то удали обработчик нажатия на кнопку.
                        // В этот момент кнопка стане не активной.
                        : null,
                  ),
                )
              ],
            )),
      ),
    );
  }

  /// Обработчик отправки
  /// Сбрасывает текущий текст поля ввода, и признак того, что можно отправлять
  /// сообщение. Отправляет текст [text] в виде нового сообщения в BLoC [ChatBloc].
  void _handleSubmitted(ChatBloc chatBloc, String text) async {
    // Отчистим поле ввода
    _textController.clear();
    // Меняем стейт виджета
    setState(() {
      // Указываем, что отправлять сообщения нельзя
      _isComposing = false;
    });

    // Отправляем новое сообщение в BLoC [ChatBloc].
    await chatBloc.sendMessage(text);
  }
}
