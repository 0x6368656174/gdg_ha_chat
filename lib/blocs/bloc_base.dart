/// Базовый класс для создания BLoC
abstract class BlocBase {
  /// Метод, который выполнится при удалении BLoC
  ///
  /// Это самое место, чтоб закрыть все [Stream], созданные в BLoC
  void dispose();
}
