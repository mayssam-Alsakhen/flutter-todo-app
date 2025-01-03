import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteTask, required this.course, required this.category});
  final String taskName;
  final bool taskCompleted;
  final String course;
  final String category;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  List<String> subject=[
    "Course",
    "CACI410",
    "CSCI370",
    "CSCI426",
    "CSCI430"
  ];
  List<String> categories = [
    "Category",
    "Pending",
    "Urgent",
    "Routine",
    "Research"
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
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  side: BorderSide(
                      color: Colors.white
                  ),
                ),
                Text(
                  taskName,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu(
                    textStyle: TextStyle(color: Colors.white),
                    inputDecorationTheme: InputDecorationTheme(outlineBorder:BorderSide.none,),
                    width: 120,
                    initialSelection:  subject.contains(course) ? course : "Course",
                    dropdownMenuEntries: subject.map<DropdownMenuEntry<String>>((String subject){
                      return DropdownMenuEntry(
                          value: subject, label: subject.toString());
                    }).toList()
                ),
                DropdownMenu(
                  textStyle: TextStyle(color: Colors.white),
                  inputDecorationTheme: InputDecorationTheme(outlineBorder: BorderSide.none),
                  width: 125,
                  initialSelection: categories.contains(category) ? category : "Category",
                  dropdownMenuEntries: categories.map<DropdownMenuEntry<String>>((String cat) {
                    return DropdownMenuEntry(value: cat, label: cat.toString());
                  }).toList(),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}