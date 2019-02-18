import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

/// BLoC для работы с Авторизацией
///
/// Содержит методы для "Входа" и "Выхода" из системы. А так же данные
/// о текущем пользователе.
class AuthBloc extends BlocBase {
  /// Имя текущего пользователя
  final _nickname = new BehaviorSubject<String>();

  /// Поток имени текущего пользователя
  ///
  /// Если имя пустое, значит пользователь не авторизован.
  Stream<String> get nicknameStream => _nickname.stream;

  /// Имя текущего пользователя
  ///
  /// Если имя пустое, значит пользователь не авторизован.
  String get nickname => _nickname.value;

  AuthBloc() {
    _trySignInWithLast();
  }

  /// Последнее использованное имя, для авторизации
  ///
  /// Данное имя можно использовать для автоматического заполнения
  /// данных форм авторизаций.
  Future<String> get lastNickname async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname') ?? '';
  }

  /// Пытается авторизоваться с последними сохраненными данными
  _trySignInWithLast() async {
    final nickname = await lastNickname;
    if (nickname != null && nickname.isNotEmpty) {
      _nickname.sink.add(nickname);
    } else {
      _nickname.sink.add('');
    }
  }

  /// Входит в систему с указанным именем [nickname]
  signIn(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
    _nickname.sink.add(nickname);
  }

  /// Выходит из системы
  signOut() async {
    _nickname.sink.add('');
  }

  @override
  void dispose() {
    _nickname.close();
  }
}
