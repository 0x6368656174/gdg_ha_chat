import 'package:flutter/material.dart';

import 'bloc_base.dart';

/// Возвращает тип объекта
Type _typeOf<T>() => T;

/// Провайдер для получения BLoC из контекста
///
/// Юзаем [StatefulWidget], т.к. нам нужен [State.dispose].
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  /// Виджет, который должен быть отображен в качестве ребенка
  final Widget child;

  /// BLoC, за который отвечает провайдер
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  /// Возвращает BLoC, за который отвечает провайдер из контекста [context]
  static T of<T extends BlocBase>(BuildContext context) {
    // Получим тип
    final type = _typeOf<_BlocProviderInherited<T>>();
    // Получим виджет, отвечающий за провайдер из контекста, указанного типа
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    // Если нашли провайдер, то вернем BLoC, за который он отвечает
    return provider?.bloc;
  }
}

/// Стейт провайдера BLoC
class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  /// Когда, удалим провайдер
  @override
  void dispose() {
    // Выполним метод удаления для BLoC
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Вернем наследуемый виджет провайдера BLoC
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

/// Наследуемый виджет провайдера BLoC
///
/// [InheritedWidget] нужен, чтоб можно было получить его из контекста,
/// юзая [context.ancestorInheritedElementForWidgetOfExactType]
class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
