import 'package:flutter/material.dart';

/// Форма авторизации
///
/// Тут вот есть хитрость. Кажется, что виджет не меняет своего состояния,
/// но это не так, т.к. в нем находится [Form], необходимо использовать
/// [StatefulWidget], иначе не будет работать.
class InputForm extends StatefulWidget {
  /// Никнейм, отображаемый при создании формы
  final String nickname;

  /// Функция, которая вызовется при отправки формы
  final void Function(String nickname) onSubmit;

  InputForm({Key key, this.nickname, this.onSubmit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _InputFormState();
}

/// Данные формы
class _AuthData {
  String nickname;
}

/// Стейт формы
class _InputFormState extends State<InputForm> {
  /// Ключ для работы с состоянием формы
  final _formKey = GlobalKey<FormState>();

  /// Данные формы
  final _AuthData _data = new _AuthData();

  @override
  Widget build(BuildContext context) {
    // Вернем форму
    return new Form(
      // Использующий заданный ключ
      key: _formKey,
      // С отступом
      child: Padding(
        // Слева и справа в 20 единиц
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        // Содержащую колонку
        child: new Column(
          // Растянутую по горизонтали
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Со следующими элементами
          children: <Widget>[
            // Поле ввода
            new TextFormField(
              // С начальным значением
              initialValue: widget.nickname,
              // Использующей декоратор с лайблом и текстом подсказки
              decoration: new InputDecoration(
                  labelText: 'Your nickname', hintText: 'Put your nickname'),
              // Использующее следующий валидатор
              validator: (value) {
                // Если не введено значение
                if (value.isEmpty) {
                  // То вернуть сообщение об ошибке
                  return 'Please enter some nickname';
                }
              },
              // Метод, который будет вызван при _formKey.currentState.save()
              onSaved: (String value) {
                // Сохраним никнейм в данные формы
                _data.nickname = value;
              },
            ),
            // Отступ
            new Padding(
              // Сверху 20 единиц
              padding: new EdgeInsets.only(top: 20.0),
              // Закрашенная кнопка
              child: new RaisedButton(
                // При нажатии на которую
                onPressed: () {
                  // Запустим валидацию формы
                  if (_formKey.currentState.validate()) {
                    // Если валидация прошла, то запустим сохранение формы
                    // Это вызовет выполнение метода onSaved для всех
                    // полей формы
                    _formKey.currentState.save();

                    // Если доступен обработчик отправки формы
                    if (widget.onSubmit != null) {
                      // То выполним его с никнеймом
                      widget.onSubmit(_data.nickname);
                    }
                  }
                },
                // Кнопка будет содержать текст
                child: new Text('JOIN'),
                // И она будет цвета 'primary'
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
