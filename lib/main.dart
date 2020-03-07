import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tarea_dos/home/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/todo_remainder.dart';

void main() async {
  // TODO: inicializar hive y agregar el adapter
  WidgetsFlutterBinding.ensureInitialized();
  // acceso al local storage
  final _local_storage = await path_provider.getApplicationDocumentsDirectory();
  // inicializar hive
  Hive.init(_local_storage.path);
  // abrir una caja
Hive.registerAdapter(TodoRemainderAdapter());
  await Hive.openBox("reminders");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}
