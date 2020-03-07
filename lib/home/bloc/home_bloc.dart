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

    Map<dynamic, dynamic> raw = _remindersBox.toMap();
    List list = raw.values.toList();
    List<TodoRemainder> todos = new List<TodoRemainder>();

    for (var i = 0; i < list.length; i++) {
      todos.add(list[i]);
    }

    return todos;

    throw EmptyDatabase();
  }

  void _saveTodoReminder(TodoRemainder todoReminder) {

    var person = TodoRemainder(todoReminder.todoDescription, todoReminder.hour);
    _remindersBox.add(person);

  }

  void _removeTodoReminder(int removedAtIndex) {
    // TODO:delete item here
    _remindersBox.deleteAt(removedAtIndex);

  }
}

class DatabaseDoesNotExist implements Exception {}

class EmptyDatabase implements Exception {}
