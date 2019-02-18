import 'package:flutter/material.dart';

import 'package:gdg_ha_chat/blocs/blocs.dart';

import 'widgets/chat_list.dart';
import 'widgets/chat_form.dart';

/// Экран чата
///
/// Данный виджет делаем производным от [StatelessWidget], т.к. нам не надо
/// управлять состоянием виджета.
///
/// Так же в виджете определим BLoC [ChatBloc], который потом будет доступен
/// для всех детей данного виджета.
class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получим BLoC [AuthBloc] из контекста
    final AuthBloc authBloc = BlocProvider.of(context);
    // Создадим BLoC [ChatBloc]
    final chatBloc = new ChatBloc(authBloc);

    // Экран будет представлять из себя [Scaffold]
    return new Scaffold(
      // С заголовком
      appBar: new AppBar(
        // Заголовок будет содержать текст, с названием нашего чата
        title: new Text('GDG HA Chat'),
        // А так же действия
        actions: <Widget>[
          // Действием будет одно в виде кнопки с иконкой "Выйти"
          new IconButton(
            // При нажатии на кнопку
            onPressed: () async {
              // Вызовем из BLoC [AuthBloc] метод "выйти"
              await authBloc.signOut();
              // Перейдем на страницу "Авторизация"
              Navigator.pushReplacementNamed(context, '/sign_in');
            },
            // Укажем иконку "Выйти"
            icon: new Icon(Icons.exit_to_app),
          )
        ],
      ),
      // Тело блока будет содержать провайдер для BLoC [ChatBloc].
      // Все дети данного провайдера, смогу получить из контекста BLoC [ChatBloc].
      body: new BlocProvider(
          bloc: chatBloc,
          // Тело страницы будет в виде колонки
          child: new Column(
            // Содержащей
            children: <Widget>[
              // Виджет, который будет пытаться занять все свободное место.
              new Flexible(
                // Список сообщений чата
                child: new ChatList(),
              ),
              // Разделенный черточкой
              new Divider(height: 1.0),
              // С формой для отправки новых сообщений чата
              new ChatForm(),
            ],
          )),
    );
  }
}
