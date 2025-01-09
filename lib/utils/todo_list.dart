import 'package:flutter/material.dart';
import 'dart:convert' as convert ;
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  TodoList({super.key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteTask, required this.course, required this.category, required this.categories});
  final String taskName;
  final bool taskCompleted;
  final String course;
  final String category;
  final List<String> categories;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> subject=[
    "Course",
    "CACI410",
    "CSCI370",
    "CSCI426",
    "CSCI430"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
      bottom: 0,
    ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15)),
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: widget.taskCompleted,
                      onChanged: widget.onChanged,
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      side: BorderSide(
                          color: Colors.white
                      ),
                    ),
                    Text(
                      widget.taskName,
                      style: TextStyle(color: Colors.white, fontSize: 18,
                        decoration: widget.taskCompleted? TextDecoration.lineThrough : TextDecoration.none,
                        decorationColor: Colors.white,
                        decorationThickness: 2,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          widget.deleteTask!(context);
                        } , child: Icon(Icons.delete,)),
                  ],
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownMenu(
                        textStyle: TextStyle(color: Colors.white),
                        inputDecorationTheme: InputDecorationTheme(outlineBorder:BorderSide.none,),
                        width: 120,
                        initialSelection:  subject.contains(widget.course) ? widget.course : "Course",
                        dropdownMenuEntries: subject.map<DropdownMenuEntry<String>>((String subject){
                          return DropdownMenuEntry(
                              value: subject, label: subject.toString());
                        }).toList()
                    ),
                    DropdownMenu(
                      textStyle: TextStyle(color: Colors.white),
                      inputDecorationTheme: InputDecorationTheme(outlineBorder: BorderSide.none),
                      width: 125,
                      initialSelection:widget.categories.contains(widget.category) ? widget.category : "Category",
                      dropdownMenuEntries: widget.categories.map<DropdownMenuEntry<String>>((String cat) {
                        return DropdownMenuEntry(value: cat, label: cat.toString());
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}