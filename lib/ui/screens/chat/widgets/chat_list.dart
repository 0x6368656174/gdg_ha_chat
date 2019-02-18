import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:gdg_ha_chat/blocs/blocs.dart';
import 'package:gdg_ha_chat/models/models.dart';

import 'chat_message.dart';

/// Список сообщений.
///
/// Для своей работы использует два BLoC: [AuthBloc] для получения текущего
/// имени пользователя и [ChatBloc] для получения списка сообщений.
///
/// Т.к. и BLoC [AuthBloc] и BLoC [ChatBloc] возвращают нужные значения в
/// виде [Stream], то мы будем использовать [StreamBuilder] для работы с
/// потоками. Чтоб не делать два [StreamBuilder], мы объединим все асинхронные
/// данные, нужные для работы списка сообщений  при помощи метода
/// [Observable.combineLatest2] из библиотеки rxdart в один [Stream], который
/// будет возвращать подготовленный список сообщений [List<ChatMessage>].
class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получим BLoC [AuthBloc] из контекста
    final AuthBloc authBloc = BlocProvider.of(context);
    // Получим BLoC [ChatBloc] из контекста
    final ChatBloc chatBloc = BlocProvider.of(context);

    // Объединим два потока [authBloc.nicknameStream] и [chatBloc.messagesStream]
    // в один, который будет возвращать готовый для отображения список сообщений.
    final chatMessages = Observable.combineLatest2(
        authBloc.nicknameStream, chatBloc.messagesStream,
        (String nickname, List<Message> messages) {
      return messages.map((message) {
        return ChatMessage(
            text: message.message,
            nickname: message.nickname,
            own: message.nickname == nickname);
      }).toList();
    });

    // Вернем [StreamBuilder]
    return new StreamBuilder<List<ChatMessage>>(
      // Который будет использовать подготовленный список сообщений
      stream: chatMessages,
      // Для построения интерфейса
      builder: (context, snapshot) {
        // Если данные еще не получили
        if (!snapshot.hasData) {
          // То посередине
          return new Center(
            // Отобразим круглый индикатор загрузки
            child: new CircularProgressIndicator(),
          );
        }

        // И вернем ListView
        return new ListView.builder(
          // Который будет иметь 8 единиц отступа со всех сторон
          padding: new EdgeInsets.all(8.0),
          // Мотаться в обратном порядке, снизу вверх
          reverse: true,
          // Будет просто отображать сообщение из списка
          itemBuilder: (_, int index) => snapshot.data[index],
          // Длина будет равна длине списка
          itemCount: snapshot.data.length,
        );
      },
    );
  }
}
