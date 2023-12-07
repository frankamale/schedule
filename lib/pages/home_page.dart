
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:schedule/data/database.dart';
import 'package:schedule/utils/dialog_box.dart';

import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ToDoDatabase db = ToDoDatabase();
  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get('TODO')==null){
      db.initData();
    }else{
      db.loadData();
    }

    super.initState();
  }


  void onSave(){
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();

    });
    db.update();

    Navigator.of(context).pop();
  }


  void tapped(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.update();
  }

  void taskDeleted(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.update();
  }
  void createNewTask(){
    showDialog(
        context: context,
        builder:(context){
          return DialogBox(
            controller: _controller,
            onSave: onSave,
            onCancel: Navigator.of(context).pop,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: const Text('Todo List', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,fontSize: 35
        ),),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[600],
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index){
          return ToDo(
            name: db.todoList[index][0],
            taskDone: db.todoList[index][1],
            onChanged: (value)=> tapped(value, index),
            taskDeleted: (context) => taskDeleted(index),
          );
        },
      ),


    );

  }

}
