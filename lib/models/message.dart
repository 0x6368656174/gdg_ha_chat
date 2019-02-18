import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Модель сообщения
class Message {
  /// Никнейм отправителя
  final String nickname;

  /// Текс сообщения
  final String message;

  /// Время создания
  final Timestamp time;

  /// Ссылка на [DocumentReference] документа Firestore, содержащего сообщение
  final DocumentReference reference;

  /// Конструктор сообщения
  ///
  /// При создании сообщения из конструктора, поле [time] устанавливается
  /// автоматически в текущую дату и время.
  Message({@required this.nickname, @required this.message})
      : assert(nickname != null),
        assert(message != null),
        time = Timestamp.now(),
        reference = null;

  /// Конструктор сообщения из Map
  ///
  /// Обязательными полями должны быть:
  /// - [String] [nickname] - никнейм отравителя
  /// - [String] [message] - текст сообщения
  /// - [Timestamp] [time] - время создания сообщения
  Message.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nickname'] != null),
        assert(map['message'] != null),
        assert(map['time'] != null),
        nickname = map['nickname'],
        message = map['message'],
        time = map['time'];

  /// Создает сообщение из [DocumentSnapshot] Firestore.
  ///
  /// Поля документа Firestore должны быть идентичны полям, ожидаемым
  /// в методе [Message.formMap].
  Message.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  /// Возвращает Map с полями сообщения
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'message': message,
      'time': time,
    };
  }
}
