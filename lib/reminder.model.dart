import 'package:hive/hive.dart';

// part 'person.model.g.dart';



@HiveType()
class TodoRemainder{
  @HiveField(0)
  String hour;
  @HiveField(1)
  String todoDescription;

  TodoRemainder(this.hour, this.todoDescription);
}