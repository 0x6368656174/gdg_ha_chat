import 'package:flutter/material.dart';

import 'package:gdg_ha_chat/blocs/blocs.dart';
import 'package:gdg_ha_chat/ui/routes.dart';

/// Приложение чата
class ChatApp extends StatelessWidget {
  /// BLoC [AuthBloc] будет отвечать за работу с Авторизацией
  final AuthBloc _authBloc = new AuthBloc();

  /// Данная переменная позволяет работать с навигацией не используя
  /// [Navigator]. Нам необходима она, т.к. мы хотим работать с навигацией
  /// до создания [MaterialApp].
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Подпишимся на первый возвращенный Авторизацией никнейм, отличный от null.
    // Дальше, если вернули какой-то не пустой никнейм, то считаем, что
    // уже авторизованны и переходим на страницу чата. Иначе откроем
    // страницу для авторизации.
    _authBloc.nicknameStream.firstWhere((nickname) => nickname != null).then(
        (nickname) => nickname.isNotEmpty
            ? navigatorKey.currentState.pushReplacementNamed('/chat')
            : navigatorKey.currentState.pushReplacementNamed('/sign_in'));

    // BLoC [AuthBloc] будет доступна для всего приложения
    return new BlocProvider(
      bloc: _authBloc,
      // Создадим Material приложение
      child: new MaterialApp(
        title: 'GDG HA Chat',
        initialRoute: '/',
        routes: routes,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
