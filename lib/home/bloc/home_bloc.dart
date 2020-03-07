import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tarea_dos/models/todo_remainder.dart';

import '../../models/todo_remainder.dart';
import '../../models/todo_remainder.dart';

part 'home_event.dart';
part 'home_state.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // TODO: inicializar la box
  Box _remindersBox;

  @override
  HomeState get initialState => HomeInitialState();
  HomeBloc() {
    // referencia a la box
    _remindersBox = Hive.box("reminders");
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnLoadRemindersEvent) {
      try {
        List<TodoRemainder> _existingReminders = _loadReminders();
        yield LoadedRemindersState(todosList: _existingReminders);
      } on DatabaseDoesNotExist catch (_) {
        yield NoRemindersState();
      } on EmptyDatabase catch (_) {
        yield NoRemindersState();
      }
    }
    if (event is OnAddElementEvent) {
      _saveTodoReminder(event.todoReminder);
      yield NewReminderState(todo: event.todoReminder);
    }
    if (event is OnReminderAddedEvent) {
      yield AwaitingEventsState();
    }
    if (event is OnRemoveElementEvent) {
      _removeTodoReminder(event.removedAtIndex);
    }
  }

  List<TodoRemainder> _loadReminders() {
    // ver si existen datos TodoRemainder en la box y sacarlos como Lista (no es necesario hacer get ni put)
    // debe haber un adapter para que la BD pueda detectar el objeto
    // List<TodoRemainder> todoRemainders = new List<TodoRemainder>();
    // TodoRemainder todo =
    //     new TodoRemainder(hour: "adsf", todoDescription: "asdf");
    // todoRemainders.add(todo);
    // return todoRemainders;

    throw EmptyDatabase();
  }

  void _saveTodoReminder(TodoRemainder todoReminder) {
    // print(todoReminder.hour);
    // TodoRemainder todo =
    //     new TodoRemainder(hour: "adsf", todoDescription: "asdf");
    // _remindersBox.add(todo);
    // print(_remindersBox.getAt(0)); // Dave - 22
//     var person = TodoRemainder()
//   ..name = 'Dave'
//   ..age = 22;
// _remindersBox.add(person);

// print(_remindersBox.getAt(0)); // Dave - 22
// TodoRemainder todo =
//         new TodoRemainder(hour: "adsf", todoDescription: "asdf");
        var person = TodoRemainder(todoReminder.todoDescription, todoReminder.hour);
_remindersBox.add(person);
print(_remindersBox.getAt(2).hour);
    // TODO:add item here
  }

  void _removeTodoReminder(int removedAtIndex) {
    // TODO:delete item here
  }
}

class DatabaseDoesNotExist implements Exception {}

class EmptyDatabase implements Exception {}
