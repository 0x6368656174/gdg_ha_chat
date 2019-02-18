import 'package:flutter/material.dart';

/// Экран загрузки
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Экран будет представлять из себя простой [Scaffold]
    return Scaffold(
      // Содержащий посередине
      body: Center(
        // Колонку
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
            // Круглый индикатор прогресса
            new CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
