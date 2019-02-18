# gdg_ha_chat

Демонстрационное приложение, написанное на [Flutter](https://flutter.io/) для GDG Хабаровск.
Оно реализует функционал простенького чата, реализованного на Material компонентах, а в качестве
бекенда, использующего облачную БД [Firestore](https://firebase.google.com/docs/firestore/).

Приложение вдохновлено следующими уроками [Google Codelabs](https://codelabs.developers.google.com/):
- [Write Your First Flutter App, part 1](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/index.html?index=..%2F..index#0)
- [Write Your First Flutter App, part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/index.html?index=..%2F..index#0)
- [Building Beautiful UIs with Flutter](https://codelabs.developers.google.com/codelabs/flutter/index.html?index=..%2F..index#0)
- [Firebase for Flutter](https://codelabs.developers.google.com/codelabs/flutter-firebase/index.html?index=..%2F..index#0)

## Установка и запуск
Для установки и запуска приложения необходимо, чтоб было настроено окружение для работы с
[Flutter](https://flutter.io/docs/get-started/install). 

Приложение тестировалось только на устройствах Android!

Для установки и запуска приложения выполните следующие команды (пути до `git` и `flutter` должны быть
прописаны в `$PATH`):
```
git clone https://github.com/0x6368656174/gdg_ha_chat
cd gdg_ha_chat
flutter packages get
flutter run
```
