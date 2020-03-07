import 'package:hive/hive.dart';

part 'todo_remainder.g.dart';

@HiveType(typeId: 0)
class TodoRemainder{
  @HiveField(0)
  String hour;
  @HiveField(1)
  String todoDescription;
  TodoRemainder(this.todoDescription, this.hour);
}

