import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdg_ha_chat/blocs/auth.dart';
import 'package:gdg_ha_chat/models/models.dart';

import 'bloc_base.dart';

/// BLoC для работы с Чатом
class ChatBloc extends BlocBase {
  /// BLoC для работы с Авторизацией
  final AuthBloc _authBloc;

  ChatBloc(this._authBloc) : assert(_authBloc != null);

  /// Поток сообщений
  ///
  /// Содержит в себе сообщения, созданные из документов, которые
  /// хранятся в коллекции 'chat` Firestore, отсортированные по дате
  /// создания в обратном порядке в количестве 1000 последних штук.
  Stream<List<Message>> get messagesStream => Firestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .limit(1000)
          .snapshots()
          .map((snapshot) {
        return snapshot.documents.map((document) {
          // Вернем сообщение, созданное из документа Firestore
          return new Message.fromSnapshot(document);
        }).toList();
      });

  /// Отравляет сообщение [message] от имени текущего пользователя
  Future<void> sendMessage(String message) async {
    // Создадим сообщение
    final messageObject = new Message(
      nickname: _authBloc.nickname,
      message: message,
    );

    // Сохраним его в коллекции 'chat' Firestore
    await Firestore.instance.collection('chat').add(messageObject.toMap());
  }

  @override
  void dispose() {}
}
