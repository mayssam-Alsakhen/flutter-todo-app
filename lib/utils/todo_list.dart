import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
   TodoList({super.key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteTask});
final String taskName;
final bool taskCompleted;
final Function(bool?)? onChanged;
final Function(BuildContext)? deleteTask;
List<String> subject=[
  "",
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
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu(
                  width: 200,
                  initialSelection: subject[0],
                    dropdownMenuEntries: subject.map<DropdownMenuEntry<String>>((String subject){
                      return DropdownMenuEntry(value: subject, label: subject.toString());}).toList()),
                ElevatedButton(onPressed: (){
                  deleteTask!(context);
                } , child: const Icon(Icons.delete),),
              ],
            )
          ],
        ),
      ),
    );;
  }
}
