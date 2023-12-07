import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDo extends StatelessWidget {

  final String name;
  final bool taskDone;
  Function(bool?)? onChanged;
  Function(BuildContext)? taskDeleted;

  ToDo({super.key, required this.name, required this.taskDone, this.onChanged, required this.taskDeleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                onPressed: taskDeleted,
                backgroundColor: Colors.red,
                icon: Icons.delete,
            )
          ],


        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow[600],
            borderRadius: BorderRadius.circular(12)
          ),
          child:  Padding(
            padding: EdgeInsets.all(25.0),
            child: Row(
              children: [
                Checkbox(value: taskDone,
                    onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Text(name),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
