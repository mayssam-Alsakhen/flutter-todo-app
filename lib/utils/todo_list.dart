import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
   TodoList({super.key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteTask});
final String taskName;
final bool taskCompleted;
final Function(bool?)? onChanged;
final Function(BuildContext)? deleteTask;
List<String> subject=[
  "Course",
  "CSCI 410",
  "CSCI 370",
  "CSCI 426",
  "CSCI 430"
];
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
      bottom: 0,
    ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15)),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(value: taskCompleted,
                    onChanged: onChanged,
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white
                  ),
                ),
                Text(taskName,
                  style: TextStyle(color: Colors.white, fontSize: 18,
                  decoration: taskCompleted? TextDecoration.lineThrough : TextDecoration.none,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      deleteTask!(context);
                    } , child: Icon(Icons.delete,)),
              ],
            ),
            DropdownMenu(
                textStyle: TextStyle(color: Colors.white),
                inputDecorationTheme: InputDecorationTheme(outlineBorder:BorderSide.none,),
                width: 150,
                initialSelection: subject[0],
                dropdownMenuEntries: subject.map<DropdownMenuEntry<String>>((String subject){
                  return DropdownMenuEntry(
                      value: subject, label: subject.toString());}).toList()
            ),
          ],
        ),

      ),
    );
  }
}
