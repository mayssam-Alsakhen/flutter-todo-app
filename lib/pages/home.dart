import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/utils/todo_list.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  List Tasks= [
    ["flutter project", false],
    ["web project", false],
   ];

  void checkBoxChanged (int index){
    setState(() {
      Tasks[index][1] = !Tasks[index][1];
    });
  }

  void addTask(){
    setState(() {
        Tasks.add([controller.text, false]);
        controller.clear();
    });
  }
  void delete (int index){
    setState(() {
      Tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(title: Text("Nextask", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),centerTitle: true, backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: ListView.builder(itemCount: Tasks.length, itemBuilder: (BuildContext context, index){
        return TodoList(taskName:Tasks[index][0],
        taskCompleted: Tasks[index][1],
        onChanged: (value)=>{
          checkBoxChanged(index),
        },
          deleteTask: (context)=>{delete(index),},
        );
      }
      ),
      floatingActionButton: Row(
        children: [
           Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(height: 50,width: 300,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Add a new task",
                  filled: true,
                  fillColor: Colors.deepPurple.shade200 ,
                ),
              ),
            )
          )),
          FloatingActionButton(
            onPressed: (){
              addTask();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),

    );
  }
}
