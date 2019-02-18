import 'package:flutter/material.dart';
import 'package:gdg_ha_chat/blocs/blocs.dart';

import 'widgets/input_form.dart';

/// Экран авторизации
///
/// Т.к. экран авторизации не меняет своего состояния создадим его из
/// [StatelessWidget].
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получим из контекста BLoC [AuthBloc]
    AuthBloc authBloc = BlocProvider.of(context);

    // Вернем [Scaffold]
    return Scaffold(
      // Который будет содержать элементы выравненные по центру
      body: Center(
        // В виде колонки
        child: new Column(
          // Вертикально выравненную по центру
          mainAxisAlignment: MainAxisAlignment.center,
          // Со следующими виджетами
          children: <Widget>[
            // Картина с лого GDG
            new Image(
              // Лого будем брать из локальный assets, идущих с приложением
              image: new AssetImage('assets/google_developers_logo.png'),
              // Размер лого будет 200 единиц
              height: 200.0,
            ),
            // Билдер, который работает с [Future]
            // Он нам необходим, т.к. [authBlock.lastNickname] возвращает
            // [Future<String>].
            new FutureBuilder(
              // Который будет работать с [authBloc.lastNickname]
              future: authBloc.lastNickname,
              // При изменении результата будет выполняться следующий код
              builder: (context, snapshot) {
                // Если еще нет результата
                if (!snapshot.hasData) {
                  // То вернем круглый индикатор прогресса
                  return new CircularProgressIndicator();
                }

                // Вернем форму для авторизации
                return new InputForm(
                  // С никнеймом
                  nickname: snapshot.data,
                  // Когда, форма будет отравлена
                  onSubmit: (String nickname) async {
                    // Авторизуемся в [AuthBloc]
                    await authBloc.signIn(nickname);
                    // Откроем страницу чата
                    Navigator.pushReplacementNamed(context, '/chat');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
