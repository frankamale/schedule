import 'package:hive/hive.dart';

class ToDoDatabase{


  List todoList = [];

  final _myBox = Hive.box('myBox');

  void initData(){
    todoList = [
      ['Do exercise', false],
      ['Go to work', false]
    ];
  }

  void loadData(){
  todoList = _myBox.get("TODO");
  }

  void update(){
    _myBox.put('TODO', todoList);
  }
}